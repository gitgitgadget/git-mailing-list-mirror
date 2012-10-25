From: Anand Kumria <akumria@acm.org>
Subject: Re: Is git mktag supposed to accept git cat-file input?
Date: Thu, 25 Oct 2012 01:58:38 +0100
Message-ID: <CAM1C4Gn6tr_bxG1De+kZecpJ7kLg7_hOO7q-aa7HwFkr9od6_Q@mail.gmail.com>
References: <CAM1C4GneOnyBQyJRbhtuYNDsc4NxXgFcfHrQpziLpp_AY0TjbA@mail.gmail.com>
 <CA+sFfMdaaTwc82-J6a=wdjDzAFq6z8PS2rjSZ=tuyweOzuf4Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 02:59:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRBn9-0005L8-TQ
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 02:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936Ab2JYA7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2012 20:59:10 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:48359 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757302Ab2JYA7J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2012 20:59:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so750424pad.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 17:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=NDon55Ug3VbVqlBTccMiMPRolKTvcqwDrNcAbFqDWgo=;
        b=ZDUwUQx7Zlq5uRAzj4y7qjVC8qK/Z1luzfG8SjJUOb5BWykuJSy4s8KGBWHo46LCqK
         ryqXb4QWUeGHZcXT8Fad1rhUyI6oKxcOVbK1/tgF6leANvDPGg0oJ60IMt8gpG3uVLiO
         yqGLOgP1/vYfyfOwcSe4SZWpL5k4v0V0TXQN2kunTSOB8q8SkP1dp/4mt6H1tn3EulxK
         1IXmLd0gOI1qELjVsFgDld7LAooEMdPavtipHGPb0Om/bENdq6+VafN+7DdZ++auty4l
         7VKR57PO3Z9rEA15J4fgL7Ic0wgSRCX8+oBuSUMI5/AERd0u2yhWkX1m45Sbo3T8vlVe
         IYZQ==
Received: by 10.66.88.197 with SMTP id bi5mr48314205pab.58.1351126749121; Wed,
 24 Oct 2012 17:59:09 -0700 (PDT)
Received: by 10.66.189.166 with HTTP; Wed, 24 Oct 2012 17:58:38 -0700 (PDT)
In-Reply-To: <CA+sFfMdaaTwc82-J6a=wdjDzAFq6z8PS2rjSZ=tuyweOzuf4Kg@mail.gmail.com>
X-Google-Sender-Auth: tzGVTMm1sb91J9Z-S55ozrTLFrg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208331>

Ahh, unix time. Of course.

Thanks Brandon.

On 25 October 2012 01:18, Brandon Casey <drafnel@gmail.com> wrote:
> On Wed, Oct 24, 2012 at 4:39 PM, Anand Kumria <akumria@acm.org> wrote=
:
>> Hi,
>>
>> I am doing some experimenting with git-mktag, and was looking into t=
he
>> format it expects on input.
>>
>> Should this sequence of commands work?
>
> Yes, with a slight tweak...
>
>> kalki:[/tmp/gittest]% git tag -m "tag-test" tag-test
>> kalki:[/tmp/gittest]% git cat-file -p e619
>
> '-p' means pretty-print, i.e. produce a human-readable format.  mktag
> supports the raw format.  So you should invoke it like this:
>
>       $ git cat-file tag e619
>
> which should produce something like:
>
>    object c0ae36fee730f7034b1f76c1490fe6f46f7ecad5
>    type commit
>    tag tag-test
>    tagger Anand Kumria <akumria@acm.org> 1351121552 +0100
>
>    tag-test
>
> and is the format expected by mktag.
>
> -Brandon
>



--=20
=E2=80=9CDon=E2=80=99t be sad because it=E2=80=99s over. Smile because =
it happened.=E2=80=9D =E2=80=93 Dr. Seuss
