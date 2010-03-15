From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-filter-branch.txt: mention absolute path for scripts
 in --tree-filter
Date: Mon, 15 Mar 2010 10:30:30 +0100
Message-ID: <4B9DFE36.3010707@viscovery.net>
References: <87vdcy7zyu.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 10:30:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr6dE-0002Zk-2M
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 10:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756645Ab0COJaf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 05:30:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:40591 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756329Ab0COJae (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 05:30:34 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nr6d4-00022V-O7; Mon, 15 Mar 2010 10:30:31 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 782C61660F;
	Mon, 15 Mar 2010 10:30:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <87vdcy7zyu.fsf@jondo.cante.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142198>

Jari Aalto schrieb:
> Signed-off-by: Jari Aalto <jari.aalto@cante.net>
> ---
>  Documentation/git-filter-branch.txt |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 020028c..01bd0ad 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -91,6 +91,9 @@ OPTIONS
>  	is then used as-is (new files are auto-added, disappeared files
>  	are auto-removed - neither .gitignore files nor any other ignore
>  	rules *HAVE ANY EFFECT*!).
> ++
> +In case the <command> is a shell script, provide an absolute path.
> +An example: --tree-filter 'sh /path/to/filter.sh'

Your choice of words is ambiguous: The --tree-filter is not the name of a
shell script, but rather the shell script itself; the example you gave is
just a shell script that happens to run only a shell on a file whose name
must be specified as an absolute path.

But doesn't the recommendation to use absolute paths apply not only to
--tree-filters, but

- to all filters;

- to all references to external files that the filters make.

I'm saying "recommendation" because git-filter-branch does not switch
directory ad lib., so theoretically, it would be possible to use relative
paths, even though the base of the relative paths would be non-obvious
because it is from inside a temporary directory named ".git-rewrite/t"
that is allocated next to .git.

-- Hannes
