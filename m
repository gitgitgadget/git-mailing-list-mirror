From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Fri, 7 Aug 2009 01:17:59 +0200
Message-ID: <20090806231759.GC12924@vidovic>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org> <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 01:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZCE1-0003LE-8O
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 01:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858AbZHFXSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 19:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756798AbZHFXSG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 19:18:06 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:46714 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432AbZHFXSF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 19:18:05 -0400
Received: by ewy10 with SMTP id 10so1187496ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 16:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=irmSPOzbNN7I1GBLPXoFHN6ue9NaZvtL1jEqcdq1qLM=;
        b=pKrGajwEPgbU/ST/oE0k3bDfNuZ012Xm8kG9sGzXWsBPhlYaGOp5+k8XqFbe5L678e
         MG9mfDfryHiJf9y6jW1isdYaxHPf2XyP8LqjRjG06mUqoZg6Ml6oCWnNUueNFAiugr1n
         lTun2Z25S8NiyIQnkNQV774CVwBXO+SzWJYSU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=O6JZjhLyWUZG6ZQu/5zAwTB1AiNNLO6TxPvYn4mqS5magMxqu6wHv52tIakWmR3VIK
         VEB5xzioESdYK8LtfL9/MQGd2ifYMVLjDs77WDTtr40LPpffU9RqWc3VJ7R0nH/3g0dD
         X8gR7IoxVSfreeiBmfPS4L0th6Wsev9fv+N3g=
Received: by 10.210.115.15 with SMTP id n15mr137319ebc.2.1249600682792;
        Thu, 06 Aug 2009 16:18:02 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 10sm1192153eyd.37.2009.08.06.16.18.01
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 16:18:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125137>

The 06/08/09, Brandon Casey wrote:

> I think we should at least do this to fall back to mbox format:
> 
> diff --git a/git-am.sh b/git-am.sh
> index d64d997..94fa9c9 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -187,6 +187,7 @@ check_patch_format () {
>  				patch_format=stgit
>  				;;
>  			*)
> +				patch_format=mbox
>  				;;
>  			esac
>  			;;

This is even better that all my crap. But I think we should squash
this:

---
 git-am.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 94fa9c9..e8ec8d7 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -254,9 +254,6 @@ split_patches () {
                this=
                msgnum=
                ;;
-       *)
-               clean_abort "Patch format $patch_format is not supported."
-               ;;
        esac
 }


-- 
Nicolas Sebrecht
