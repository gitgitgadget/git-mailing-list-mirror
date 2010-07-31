From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] checkout: add a test for creating a new branch with 
	regexp as a starting point
Date: Sat, 31 Jul 2010 00:44:00 +0000
Message-ID: <AANLkTin11hHryAbJiOkiBH5TfpPbKREJK-ekWkd4fDhw@mail.gmail.com>
References: <AANLkTimeQA2_fQ_f2pQchbo1coj3=mV9TRPnbET8SQ4F@mail.gmail.com>
	<20100731001919.GB24129@wo.int.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Sat Jul 31 02:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Of0BO-0006tK-Eu
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 02:44:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011Ab0GaAoE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Jul 2010 20:44:04 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33734 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703Ab0GaAoC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jul 2010 20:44:02 -0400
Received: by iwn7 with SMTP id 7so1838246iwn.19
        for <git@vger.kernel.org>; Fri, 30 Jul 2010 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=n+RGE7c45HrMdRMxLcMRa1SAfZe2hLYMJKLyldINN9Y=;
        b=QU+mNoNiAncmuG+5HSnerch5qp2K/0L4CLHHDIqvZ9t6JVd4gApwgofScl+wzzttfi
         m6bNSS598N7vWSfgj5J6jn8HPk4PAGYeNnXGFgkg8ZBg3VIQmuH1F4+nAKVEJayHPlk1
         4i/XAL8HXsz8tRBj/FwyFPh1xYsUwTFWTYuQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=R9wITeTBGxRj19zJhrJKw6bCIB7S+QSid7CgmMZDl/FUxXmg69uKZalMTUIOBJqlTz
         fOk2YmaVUhKaAVaQFFN4MsQpCJJzHp8E7gDWlCO11yPpfdAvt8PT1SWztd/gUWKsVSqE
         zcFuWECIzJd91ebLFEoPgL8+LRkA3qBGErYQI=
Received: by 10.231.30.131 with SMTP id u3mr2367679ibc.189.1280537041244; Fri, 
	30 Jul 2010 17:44:01 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Fri, 30 Jul 2010 17:44:00 -0700 (PDT)
In-Reply-To: <20100731001919.GB24129@wo.int.altlinux.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152276>

On Sat, Jul 31, 2010 at 00:19, Dmitry V. Levin <ldv@altlinux.org> wrote=
:
> Reported-by: Ivan Zakharyaschev <imz@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
> =C2=A0t/t2018-checkout-branch.sh | =C2=A0 13 +++++++++++++
> =C2=A01 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/t/t2018-checkout-branch.sh b/t/t2018-checkout-branch.sh
> index 1caffea..4d26b2a 100755
> --- a/t/t2018-checkout-branch.sh
> +++ b/t/t2018-checkout-branch.sh
> @@ -118,7 +118,20 @@ test_expect_success 'checkout -b to an existing =
branch fails' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_must_fail do_checkout branch2 $HEAD2
> =C2=A0'
>
> +test_expect_failure 'checkout -b new_branch :/regexp' '
> + =C2=A0 =C2=A0 =C2=A0 # clean up from previous test
> + =C2=A0 =C2=A0 =C2=A0 git reset --hard &&
> +
> + =C2=A0 =C2=A0 =C2=A0 do_checkout old_regexp_branch branch1 &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit first '' '' '' &&
> + =C2=A0 =C2=A0 =C2=A0 test_commit second '' '' '' &&

Should note in the commit message or a comment that this test needs to
not create a tag, in case someone wonders down the line what the '' ''
'' ASCII art is all about :)

Looks good otherwise, thanks for patching test_commit.
