From: Dario Rodriguez <soft.d4rio@gmail.com>
Subject: Re: Revert a single commit in a single file
Date: Fri, 25 Feb 2011 21:27:06 -0300
Message-ID: <AANLkTi=y3CTu65WGKt=NEQLCAvSo=8TmU8BX5WVXCfyW@mail.gmail.com>
References: <AANLkTikpdGfAAUMu_7DfA-GRUv7gKn5Yc9RnJwo2iKoM@mail.gmail.com>
 <7v8vx4aqun.fsf@alter.siamese.dyndns.org> <AANLkTinzhd_nL265e7DZA4xEnXqDn-5m=9GPS7JsFY-S@mail.gmail.com>
 <7vei6vao0p.fsf@alter.siamese.dyndns.org> <AANLkTim2AYWqb4Q13Lk6BDC=TQtzFX9+595b2SsDpsnu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 26 01:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt80T-0003k3-1g
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 01:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076Ab1BZA11 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 19:27:27 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63026 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932977Ab1BZA11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 19:27:27 -0500
Received: by gyh20 with SMTP id 20so919179gyh.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 16:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=fLvL/rjRuQrE2tWtnk1UVibdiA7s3p7tcge85n5hIUU=;
        b=wMcLJzZ1TduqE6TllNCbnewdLgGnSgSLdZuUgSzxcQROa/PTu+Mr44BcmA1ZOpgzzp
         kjipFp4qa8HWc21+S4cLDxeTTiRfCZHvFBUwpQwcs5JWCT5BvbIBiCPKlAfFziuy+KRg
         eQ/76gNDYt2wLiiFhdnSWS2jEmV+mbXT95gzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Xm0j/U5KsiW3ZNHK33siGYfW8TQ1jzQUuAGs3hbz3uJbF1zs48GpN/3X8G5QjDtDRj
         SlW1ygZmTJ+06HGI+j9d45qcgyryd5f1s8cxQE7ooiYHtsBpf/YVwfVaaXiZjus9dusp
         EHAJMCbgM+dU5kbTQzmK9B3K6/nwtH/0Cdids=
Received: by 10.236.110.12 with SMTP id t12mr5413733yhg.6.1298680046171; Fri,
 25 Feb 2011 16:27:26 -0800 (PST)
Received: by 10.236.110.43 with HTTP; Fri, 25 Feb 2011 16:27:06 -0800 (PST)
In-Reply-To: <AANLkTim2AYWqb4Q13Lk6BDC=TQtzFX9+595b2SsDpsnu@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167950>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
> We could have with <path>:
>
>     Revert "some commit"
>
>     This partially reverts commit <sha1>. Only the path <path> has
>     been reverted, which is X out of Y files changed in the original
>     commit.

Perhaps you want to do something like:

     git revert <commit> <path1> <path2> ...

In such case the text "Only de path <path>..." makes no sense. I think
something like:

     Partial Revert (x/y) "some commit"

     This partially reverts commit <sha1>

=2E..whould be a better choice. Summaries will show that 'x' of the 'y'
files committed in <sha1> have been reverted.

Cheers
