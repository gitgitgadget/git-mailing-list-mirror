From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git checkout -t -B
Date: Mon, 27 Aug 2012 19:20:28 +0700
Message-ID: <CACsJy8A=GooUesw0hJ7AiDO7M3v1Ybbox8+rwWJfn6urJQUUFw@mail.gmail.com>
References: <CAHtLG6QgnvG6eYEChojY_jB25QWqxis6brbst2ff5FixFLAXAw@mail.gmail.com>
 <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 14:21:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5yJX-0002h6-TM
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 14:21:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab2H0MVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Aug 2012 08:21:00 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50388 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751319Ab2H0MU7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Aug 2012 08:20:59 -0400
Received: by ialo24 with SMTP id o24so8012842ial.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=2ZJfK5VYdSOFlcrGP5RinpiJ7d6HLrT8E30YhUcpT2I=;
        b=ebehw217bMZBi0WqJwpxqIK+KBxczXgSqcUYA9E/YrouqGwjiQT2pl64PJFCe3MYj5
         Q00nWNGeLJAkxBe7EnW7+8s8uYBCc2HC/io7B+TVneTNesOMg7KBhoxNcRwm2MJUHYC3
         36Xd0o42sNm2ratBtA31L/14B9l6NzqNIn0npCI4yHtmx8uNZq6ZgXt1TIDfuy1xco+m
         eXCwPdK8AYy0LsEIZWo7YhQ3SKELuWhBNCq9P6m1Sdoobv1kU8MKGJf1vDKoMnhI9zBD
         YJRqO0o1ACrMxQrl2t5bwlux3twQWK4xxRcOnLIYp4c8aZo4G6KpmLtzvQx3blfwE2ol
         yxvQ==
Received: by 10.43.45.200 with SMTP id ul8mr10735993icb.36.1346070059148; Mon,
 27 Aug 2012 05:20:59 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Mon, 27 Aug 2012 05:20:28 -0700 (PDT)
In-Reply-To: <7v8vd1v6q2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204332>

On Mon, Aug 27, 2012 at 1:38 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =E4=B9=99=E9=85=B8=E9=8B=B0 <ch3cooli@gmail.com> writes:
>
>> git checkout -t -B origin/abcde
>> works
>>
>> but
>> git checkout -B -t origin/abcde
>> does not.
>>
>> Could you document the order of parameters or fix the behaviour?
>
> It is crystal clear that -b/-B/--orphan must be followed by the name
> of the branch you are creating from the SYNOPSIS section of the
> documentation.

Yet it's not very clear from the error message:

    fatal: git checkout: updating paths is incompatible with switching =
branches.
    Did you intend to checkout 'origin/abcde' which can not be
resolved as commit?

I wonder if we should reject -t as a value of -[Bb] by adding new
parseopt flag to reject values starting with '-'. In this case, branch
names can't start with '-'. There may be cases where we accept option
value starting with '-', but I suspect the other way is dominant.
--=20
Duy
