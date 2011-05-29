From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 9/9] t3703, t4208: add test cases for magic pathspec
Date: Sun, 29 May 2011 20:29:23 +0200
Message-ID: <BANLkTimQ7H7SLbA=mREOSK_bQVN5Yo1oiQ@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
	<1305006678-4051-1-git-send-email-gitster@pobox.com>
	<1305006678-4051-10-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 29 20:29:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQkjy-0000Sk-8y
	for gcvg-git-2@lo.gmane.org; Sun, 29 May 2011 20:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755741Ab1E2S3Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2011 14:29:25 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37764 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab1E2S3Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2011 14:29:24 -0400
Received: by fxm17 with SMTP id 17so2113595fxm.19
        for <git@vger.kernel.org>; Sun, 29 May 2011 11:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OD1PbriqbIWwB5FckPQSFJEUIjUHGQwmDpTgcU6lvL0=;
        b=nSgvy3/YV4lJiHgAZleplgR5o7dl4l+TPr1V1fO7ypPiU0h7mpq+wmp1jm2egzh29i
         kjwpczsfs1UmEMMftVPhWkTln1qGVFNC+ImgkglIqBvaAvvXiVPnuAqOh00RQL8w4R+C
         bMukHOBdShd9xO27OAfK805fbU3xZLJMtZnBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F/Hwk8k9yoD+HazJdAxlffC5J+l8wUYxRlZRmmrNCsws4hirgIHoHXFwhoP4TEQJa5
         5SWlSFfgdfNhBfL2OJyFB3Gzs0p4kGRxwB8mGBLCegcTASahA1EYRvUEX5x73eTULrMb
         f4CmAFkiti/f0dW/b3J9Taua4Tglb070eYlqE=
Received: by 10.223.24.213 with SMTP id w21mr4632012fab.113.1306693763595;
 Sun, 29 May 2011 11:29:23 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sun, 29 May 2011 11:29:23 -0700 (PDT)
In-Reply-To: <1305006678-4051-10-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174698>

On Tue, May 10, 2011 at 07:51, Junio C Hamano <gitster@pobox.com> wrote=
:

> +test_expect_success 'add :/' "
> + =C2=A0 =C2=A0 =C2=A0 cat >expected <<-EOF &&
> + =C2=A0 =C2=A0 =C2=A0 add 'anothersub/foo'
> + =C2=A0 =C2=A0 =C2=A0 add 'expected'
> + =C2=A0 =C2=A0 =C2=A0 add 'sub/actual'
> + =C2=A0 =C2=A0 =C2=A0 add 'sub/foo'
> + =C2=A0 =C2=A0 =C2=A0 EOF
> + =C2=A0 =C2=A0 =C2=A0 (cd sub && git add -n :/ >actual) &&
> + =C2=A0 =C2=A0 =C2=A0 test_cmp expected sub/actual
> +"

This needs to use test_i18ncmp.
