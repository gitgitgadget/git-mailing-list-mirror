From: Jeff Sipek <jeffpc@josefsipek.net>
Subject: Re: [GUILT 2/5] doc: guilt.xml depends on cmds.txt.
Date: Fri, 23 Jan 2015 09:23:05 -0500
Message-ID: <20150123142304.GB101465@meili.jeffnet.31bits.net>
References: <1422019499-2012-1-git-send-email-cederp@opera.com>
 <1422019499-2012-3-git-send-email-cederp@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Per Cederqvist <cederp@opera.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 15:23:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEf91-000287-5m
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 15:23:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755597AbbAWOX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 09:23:26 -0500
Received: from josefsipek.net ([71.174.113.7]:1600 "EHLO josefsipek.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbbAWOXH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 09:23:07 -0500
Received: from meili.jeffnet.31bits.net (unknown [172.31.0.119])
	by josefsipek.net (Postfix) with ESMTPSA id A314255654;
	Fri, 23 Jan 2015 09:23:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1422019499-2012-3-git-send-email-cederp@opera.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262932>

Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>

On Fri, Jan 23, 2015 at 02:24:56PM +0100, Per Cederqvist wrote:
> Specify an explicit dependency, to stop make from trying to generate
> guilt.xml if cmds.txt could not be created.  The asciidoc will fail
> and produce an error message that might hide the original error
> message.
> 
> The added dependency causes make to not remove the guilt.xml file.
> Add *.xml to .gitignore.
> 
> Signed-off-by: Per Cederqvist <cederp@opera.com>
> ---
>  Documentation/.gitignore | 3 +++
>  Documentation/Makefile   | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/.gitignore b/Documentation/.gitignore
> index c4f0588..9b8d4da 100644
> --- a/Documentation/.gitignore
> +++ b/Documentation/.gitignore
> @@ -11,3 +11,6 @@ version.txt
>  
>  # Generated file dependency list
>  doc.dep
> +
> +# Intermediate generated files
> +*.xml
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index ec3c9e8..2574125 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -60,6 +60,8 @@ cmds.txt: cmd-list.sh $(MAN1_TXT)
>  
>  guilt.7 guilt.html: guilt.txt footer.txt version.txt
>  
> +guilt.xml: cmds.txt
> +
>  clean:
>  	rm -f *.xml *.html *.1 *.7 doc.dep
>  	rm -f cmds.txt
> -- 
> 2.1.0
> 

-- 
The obvious mathematical breakthrough would be development of an easy way to
factor large prime numbers.
		- Bill Gates, The Road Ahead, pg. 265
