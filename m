From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] apply: fix adding new files on i-t-a entries
Date: Tue, 29 Dec 2015 21:02:54 +0700
Message-ID: <CACsJy8Ad5uihFqVBR4rLA4at_fBDx-yRx1VP1d-uR+4Uug6M9g@mail.gmail.com>
References: <1451181092-26054-1-git-send-email-pclouds@gmail.com>
 <1451181092-26054-4-git-send-email-pclouds@gmail.com> <xmqqpoxr9szy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:03:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDus5-0007yW-PB
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 15:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752695AbbL2OD0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 09:03:26 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:34032 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752690AbbL2ODZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 09:03:25 -0500
Received: by mail-lf0-f50.google.com with SMTP id y184so212454328lfc.1
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 06:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=NOcdTtCyYCb3CuJA0n4sviyvFpD7UTIYFkodPXnUHyI=;
        b=RnvlmBLAfko3ue6m7MmEAL+sTlfc/+o4PAEOHqX7H9kCWsA9bC38XyxdelSNrhvXzJ
         CVWZPb3pme5pXIS3c3Q8QeRq9dBqGsrcVieDzdPKaAdKt6+sy25sKPIEgk+3RBk9FAo1
         XtWNiaSqMz8NjeY52zF2JJByGFwdumBDzOwZkKTxgbyeWo8QqUJxOphGLrgU5c0APV9P
         3yVAb8x8Al2/4hiIUMuq2Azh3RvEjdTN7t1ANdxtoD6M8qNWiTAR6I05S0dGjLkh4g6V
         UZjoTjhZbsk462TCwrL7HXSjpQJB/fY+89uqV+q5rNYZRBO2TXBYTN2zdR62VSqaKH/Q
         tBOQ==
X-Received: by 10.25.18.143 with SMTP id 15mr13338531lfs.3.1451397803621; Tue,
 29 Dec 2015 06:03:23 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 29 Dec 2015 06:02:54 -0800 (PST)
In-Reply-To: <xmqqpoxr9szy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283132>

On Mon, Dec 28, 2015 at 10:01 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Suppose that you came up with some contents to register at path F in
>> your working tree, told Git about your intention with "add -N F", an=
d
>> then tried to apply a patch that wants to _create_ F:
>>
>> Without this patch, we would say "F already exists so a patch to
>> create is incompatible with our current state".
>>
>> With this patch, i-t-a entries are ignored and we do not say that, b=
ut
>> instead we'll hopefully trigger "does it exist in the working tree"
>> check, unless you are running under "--cached".
>>
>> Which means that this change will not lead to data loss in the
>> "untracked" file F in the working tree that was merely added to the
>> index with i-t-a bit.
>>
>> (commit message mostly from Junio)
>
> Hmm, I do not quite recall.

=46or reference ;)

https://www.mail-archive.com/git@vger.kernel.org/msg76461.html

> The above looks under-explained anyway;
> ...

Not enough energy to go through this. Will do later and post new
proposed commit message.
--=20
Duy
