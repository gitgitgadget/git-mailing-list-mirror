From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/git-pull: clarify configuration
Date: Tue, 9 Nov 2010 21:48:46 -0600
Message-ID: <20101110034846.GB2401@burratino>
References: <1289336209-28222-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 10 04:49:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG1gP-0002Gz-SJ
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 04:49:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752574Ab0KJDtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 22:49:08 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37048 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0KJDtG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 22:49:06 -0500
Received: by gxk23 with SMTP id 23so96396gxk.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 19:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=URWsvMlsQdcU8JkVDjyvUKmRwBjFT3p9QC4oMTmNFak=;
        b=TQomq1k/XDGmzosQtHw3E3VL9VM3oyzeMQZBSf4yvRklDm/6kl4yR7vXXlVpmt1vPz
         HA4zE2AlLrXvLmw0dbCbJhkrg3o2JkUnmfdhrYTF0Fxx/235cYSYVAvSkh0Zu2YVB8D+
         StGETphL/MziobFN5rSF78A6eYQDAI+aa6xQo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cmcdyqBOCP/oru7E4TXrZk5N2J2QnTfOGKwzlmp4FHyCz/ZIlU0qu7cRN0Z1G5ekFF
         vIkhnsSWB2HY1WEGlGeQ7APxAK/GMP4nPWjMCUbZwK9CWC5ex7ciE7icOkOmdVreeVN+
         csLLWgW8KX1ZKJRvKy1UX34qI+yDIbWb+2R38=
Received: by 10.100.241.4 with SMTP id o4mr4358962anh.163.1289360944488;
        Tue, 09 Nov 2010 19:49:04 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 13sm224817anq.30.2010.11.09.19.49.02
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 19:49:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289336209-28222-1-git-send-email-martin.von.zweigbergk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161127>

Martin von Zweigbergk wrote:

> The sentence about 'branch.<name>.rebase' refers to the first sentence
> in the paragraph. Clarify by moving it right after that sentence.

Sane.

> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -92,12 +92,11 @@ include::merge-options.txt[]
>  :git-pull: 1
>  
>  --rebase::
> -	Instead of a merge, perform a rebase after fetching.  If
> -	there is a remote ref for the upstream branch, and this branch
> -	was rebased since last fetched, the rebase uses that information
> -	to avoid rebasing non-local changes. To make this the default
> -	for branch `<name>`, set configuration `branch.<name>.rebase`
> -	to `true`.
> +	Instead of a merge, perform a rebase after fetching. To make this
> +	the default for branch `<name>`, set configuration
> +	`branch.<name>.rebase` to `true`.

Grammatically, the narrator first gives an order to the git program
("perform a rebase") and then to the person configuring it ("set the
configuration").  Maybe it would be clearer to focus on what the
program does in this case?

	Instead of merging, rebase the current branch on top of the
	upstream branch after fetching.  If there is a remote-tracking
	branch corresponding to the upstream branch and the upstream
	branch was rebased since last fetched, the rebase uses that
	information to avoid rebasing non-local changes.

	The default behavior is to merge rather than rebasing, but it
	can be overridden per branch with the `branch.<name>.rebase`
	configuration item (see git-config(1)).
