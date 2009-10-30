From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 22:56:20 +0100
Message-ID: <4AEB6104.3080005@kdbg.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zSV-0003w6-8d
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932927AbZJ3V4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932903AbZJ3V4Y
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:56:24 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:10640 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932776AbZJ3V4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:56:24 -0400
Received: from [77.117.168.120] (77.117.168.120.wireless.dyn.drei.com [77.117.168.120])
	by bsmtp.bon.at (Postfix) with ESMTP id 18C28CDF8C;
	Fri, 30 Oct 2009 22:56:25 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131761>

Erick Mattos schrieb:
> @@ -61,13 +62,16 @@ OPTIONS
>  -C <commit>::
>  --reuse-message=<commit>::
>  	Take an existing commit object, and reuse the log message
> -	and the authorship information (including the timestamp)
> -	when creating the commit.
> +	and the authorship information when creating the commit.
> +	By default, timestamp is taken from specified commit unless
> +	option --new-timestamp is included.
>  
>  -c <commit>::
>  --reedit-message=<commit>::
>  	Like '-C', but with '-c' the editor is invoked, so that
>  	the user can further edit the commit message.
> +	By default, timestamp is recalculated and not taken from
> +	specified commit unless option --old-timestamp is included.
>  
>  -F <file>::
>  --file=<file>::
> @@ -134,6 +138,8 @@ OPTIONS
>  	current tip -- if it was a merge, it will have the parents of
>  	the current tip as parents -- so the current top commit is
>  	discarded.
> +	By default, timestamp is taken from latest commit unless option
> +	--new-timestamp is included.

I don't like this a lot. Currently, we consistently (and predictably!) 
reuse the timestamp when the author information is reused. Therefore, I 
think it should be sufficient to introduce only --new-timestamp.

-- Hannes
