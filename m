From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/: work around one-shot variable assignment with 
	test_must_fail
Date: Tue, 20 Jul 2010 23:45:11 +0000
Message-ID: <AANLkTim9hFDUoS-RsPTyaElQW4iC5_3HH66aJ9R-DiQJ@mail.gmail.com>
References: <8HvhdiflWJtex2eC6n_6Q38YcvRRYhnh0scnq4s56M4wdwT_YlAiOw@cipher.nrlssc.navy.mil>
	<iU5XdZGtMeaspoCqSJIp6Y--60TPVkZUrm3SdW86dsTZkNYZWqbSppLBrMXyL1rVqqYtHm94ACo@cipher.nrlssc.navy.mil>
	<AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, erick.mattos@gmail.com, jrnieder@gmail.com,
	jaredhance@gmail.com, drafnel@gmail.com
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jul 21 01:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObMUx-00022q-UF
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 01:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183Ab0GTXpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Jul 2010 19:45:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38691 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932853Ab0GTXpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jul 2010 19:45:12 -0400
Received: by fxm14 with SMTP id 14so3201667fxm.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=4OKCTSgq6JSWu2gIHUJeKuuNapyrIdEOJ7HhJ7QWF+o=;
        b=eTGCBQ5tl1br2mm2Vd+AxBHHwlqfIbAhSl5YFQuYeKgD3HWf0m2tPrIu94vc630SJm
         GX7JpIlnADbkxFqaWmLK34jzvnskrDv9KIzvjg6u4E80Ey3N3fzOq1RGYhQqpk4o9by8
         f3QMHa5HLL5jDRrZcstBk7aVUpg73TkpNdiY0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PZPMPyhEzpHfq6WGRc+lO7geVLNRO7JW+mUcp7uPXbUX8UTTQ7zXroE2yPEh4ZueGU
         6SKjiM3ERd4Nvo1OsccYf3GvkMs1lV72T2hHyS9lldGyUcrbncp2uLsagT5m4n425Q8v
         56DaUnqZK/LmEBJXT5KIA3NMn1LhqimFnCE6c=
Received: by 10.223.115.200 with SMTP id j8mr1992938faq.107.1279669511295; 
	Tue, 20 Jul 2010 16:45:11 -0700 (PDT)
Received: by 10.223.119.17 with HTTP; Tue, 20 Jul 2010 16:45:11 -0700 (PDT)
In-Reply-To: <AANLkTilzC8iMikfBieS_pcChP7_F4hA6bT1ydWHD4etP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151377>

On Tue, Jul 20, 2010 at 23:44, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
> On Tue, Jul 20, 2010 at 21:55, Brandon Casey <casey@nrlssc.navy.mil> =
wrote:
>
>> - =C2=A0 =C2=A0 =C2=A0 test_must_fail PAGER=3D git reflog show delta=
 &&
>> + =C2=A0 =C2=A0 =C2=A0 (
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PAGER=3D &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 export PAGER &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_must_fail gi=
t reflog show delta
>> + =C2=A0 =C2=A0 =C2=A0 ) &&
>
> You must use "export PAGER;", not "export PAGER &&". export doesn't
> return zero on all systems when exporting, see previous changes in
> this regard in t/.

Actually, see the t/README docs which explicitly mention this. Yay docs=
=2E
