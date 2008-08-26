From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] bash completion: Hide more plumbing commands
Date: Tue, 26 Aug 2008 10:38:45 -0700 (PDT)
Message-ID: <m3y72jr80w.fsf@localhost.localdomain>
References: <20080826171012.GO10360@machine.or.cz>
	<20080826171144.21328.82727.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, andi@firstfloor.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:41:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY2Xi-00076l-Lq
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 19:41:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759129AbYHZRix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759124AbYHZRiv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 13:38:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:9417 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759230AbYHZRis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 13:38:48 -0400
Received: by nf-out-0910.google.com with SMTP id d3so974910nfc.21
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=w3plT5/Zdcnyp2pz5yLAX+VrMFZN8+oMXicqW+Is5jk=;
        b=KIAGXEnVlt4prQPBFyoGNO4V+sejHyrRRjHxJAcuUH4nadeRgzc4fB1tG0/HjYmxP4
         +fCirTbLkx2ixOknYB3XG29t1rEEgnU8ce+lTDet8/R2e7HDXo/lKH72n8w5y0cwUhI6
         zeMqiss695M8CxdOwOQPhrb0s8Ot8OqdsLQ4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=F2fYs9pYy/NOe6CxMfnHqeus0xqSZbHSIOvW7SXphd8pZMbeGwU0pWFT2TZb7ZTvpQ
         sTZmH5SVFU6AzubPzUn0D4jNdjqOuDbzBaqgu8I4ThxxnPgF69NNF8OjCnTXr34K/CUu
         U5Dd7Sbf7nTWG00lOvVyBrJj7yRGFcKZMoVU8=
Received: by 10.210.16.10 with SMTP id 10mr8723238ebp.150.1219772326360;
        Tue, 26 Aug 2008 10:38:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.254.77])
        by mx.google.com with ESMTPS id 23sm6621578eya.7.2008.08.26.10.38.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Aug 2008 10:38:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7QHch3X005332;
	Tue, 26 Aug 2008 19:38:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7QHcdJb005329;
	Tue, 26 Aug 2008 19:38:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080826171144.21328.82727.stgit@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93781>

Petr Baudis <pasky@suse.cz> writes:

> git <tab><tab> still shows way too many commands, some of them
> are clearly plumbing. This patch hides the plumbing commands
> liberally (that is, in special cases, users still might want to
> call one of the hidden commands, a *normal* workflow should never
> involve these, though - and if it does, we have a UI problem anyway).
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
> 
>  contrib/completion/git-completion.bash |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 89858c2..773d64b 100755
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -386,7 +386,9 @@ __git_porcelain_commands ()
>  		cat-file)         : plumbing;;
>  		check-attr)       : plumbing;;
>  		check-ref-format) : plumbing;;
> +		checkout-index)   : plumbing;;

Clearly plumbing.

>  		commit-tree)      : plumbing;;
> +		count-objects)    : plumbing;;

Plumbing (hyphenated name is a very good hint), but useful to decide
when to repack. I'm partially to leaving it, as I use it from time to
time from CLI.

>  		cvsexportcommit)  : export;;
>  		cvsimport)        : import;;
>  		cvsserver)        : daemon;;
> @@ -395,6 +397,7 @@ __git_porcelain_commands ()
>  		diff-index)       : plumbing;;
>  		diff-tree)        : plumbing;;
>  		fast-import)      : import;;
> +		fast-export)      : export;;

Good catch. BTW. both fast-import and fast-export are plumbing, in a
sense that I don't see how they can be used from command line
(well...)

>  		fsck-objects)     : plumbing;;
>  		fetch-pack)       : plumbing;;
>  		fmt-merge-msg)    : plumbing;;
> @@ -404,6 +407,10 @@ __git_porcelain_commands ()
>  		index-pack)       : plumbing;;
>  		init-db)          : deprecated;;
>  		local-fetch)      : plumbing;;
> +		lost-found)       : deprecated;;

True.

> +		ls-files)         : plumbing;;

IIRC it doesn't have porcelain equivalent.

> +		ls-remote)        : plumbing;;

"git remote show" is porcelain equivalent.

> +		ls-tree)          : plumbing;;

"git show" can be used instead.

>  		mailinfo)         : plumbing;;
>  		mailsplit)        : plumbing;;
>  		merge-*)          : plumbing;;
> @@ -428,6 +435,7 @@ __git_porcelain_commands ()
>  		runstatus)        : plumbing;;
>  		sh-setup)         : internal;;
>  		shell)            : daemon;;
> +		show-ref)         : plumbing;;

Clearly plumbing.

>  		send-pack)        : plumbing;;
>  		show-index)       : plumbing;;
>  		ssh-*)            : transport;;

-- 
Jakub Narebski
Poland
ShadeHawk on #git
