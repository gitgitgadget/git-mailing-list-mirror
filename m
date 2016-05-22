From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH 2/2] bisect--helper: `bisect_voc` shell function in C
Date: Mon, 23 May 2016 01:19:56 +0530
Message-ID: <CAFZEwPN0fydOiKZ4ZShivuNDpU=VAKe=wwimPSi-Yae0JA4Ukw@mail.gmail.com>
References: <1463169737-12701-1-git-send-email-pranit.bauva@gmail.com>
	<1463169737-12701-2-git-send-email-pranit.bauva@gmail.com>
	<alpine.DEB.2.20.1605160838540.3303@virtualbox>
	<CAFZEwPMFBmHUaX+Y8Fpd4BnJiB8N_XBOX30hRsSvb3tm8-MX5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 22 21:50:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ZO0-0001Ar-LK
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 21:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbcEVTt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 15:49:58 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:36233 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752491AbcEVTt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 15:49:57 -0400
Received: by mail-yw0-f176.google.com with SMTP id x189so153623716ywe.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4j+SGKkVsFun93HjVvMbYnfnpcPointDPEb/5n5tko8=;
        b=KGAhktKbuSoBp0YzkiEEi9a59FtSdWMooM0u9ePEL1h090ZPWktWOdnt9/3sMmXt9C
         /X0HzkM0DV6zrhPAwJ8pH2p4nKKBFaFKKVdxmD/AqQAAZegkC3cs6/v2dHXEm8F4FEwM
         EuIChPyoRKZOD+Z2jjuxxjXyfNei1g91QPQgEPamtQ7QRZMqpNzhU1p5yuqHcf5gpZ85
         baOWb3O2KlFRmyBwctEElduarYrsbB6JMi0KEkZ09CCsnziiZIqTx7k03y5c9zBitbL/
         qhiFfLt1SGo85JLEEiwPHiYANHtnAkRHrTdStfD2FvUxVvqXvmZfHBtqzLrWWhdOdSUu
         HNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4j+SGKkVsFun93HjVvMbYnfnpcPointDPEb/5n5tko8=;
        b=Cvm6y5rzx2Bvsv7vgloIMMj5hkihZap0faGXrgtIFw0irn+h/xM6VSzMsgv4h4DZCo
         oZX4UAHRzKiAwjXRySOrdc+Ic15cDSFfpw/YFlfl+jpB/Cfb3M07NUvpeYW1m0ViGglV
         61UhvaV2cq9wFJ/BJqpf28xowW9AhxRim2JONYkahml0SQu4wjzC1B1rLjE4xIwZZ3XE
         m7lrNt7CTDXmD0VvRVt8LCOFjgRR1Cwo8WkgADreI8i2TlyatjlXCPUQv5NBa1TYbk4Y
         w8QVRuFjdnVei0z4h+WFWHe4dpqEpynTA47RM/ojsJlt1vxgnYjAsQEAP8qY5Y69ahew
         b0kA==
X-Gm-Message-State: AOPr4FWQ/MvCvc3AO9unBzKyDTiH5TP1lIFSYPz48ehJS+T0rCSuTMv9N6f8AnEOo7GIIdGDVvWZ306Ez534Fg==
X-Received: by 10.129.164.145 with SMTP id b139mr8758218ywh.171.1463946596834;
 Sun, 22 May 2016 12:49:56 -0700 (PDT)
Received: by 10.13.219.213 with HTTP; Sun, 22 May 2016 12:49:56 -0700 (PDT)
In-Reply-To: <CAFZEwPMFBmHUaX+Y8Fpd4BnJiB8N_XBOX30hRsSvb3tm8-MX5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295289>

Hey Matthieu,
Sorry for the late reply. Somehow your email didn't receive my
mailbox. I got to see this mail when I was going through the gmane
archives.

Matthieu Moy <Matthieu.Moy <at> grenoble-inp.fr> writes:
  Pranit Bauva <pranit.bauva <at> gmail.com> writes:

>> +int bisect_voc(const char *term)
>> +{
>> + if (!strcmp(term, "bad"))
>> + printf("bad|new\n");
>> + if (!strcmp(term, "good"))
>> + printf("good|old\n");
>
> If you meant to use this as a helper command, then the implementation is
> right, but you're not doing that.

> If you write the function because one day you'll be calling it from C,
> then:

> 1) First, I'd wait for this "one day" to happen. In general, write code
>    when you need it, don't write it ahead of time. Currently, you have
>    dead and untested code (I know, *you* have tested it, but it's still
>    "untested" as far as git.git is concerned). Dead code may bother
>    people reading the code (one would not understand why it's there),
>    and untested code means it may break later without anyone noticing.
>

I think this function can wait then. I will include this patch when
its really required. I wanted to convert this function ASAP because it
was a really tiny one and an easy one.

> 2) Second, you'd need to return the string, not print it. You'll
>    typically use it like this:

>     printf(_("You need to give me at least one %s and one %s"),
>            bisect_voc(BISECT_BAD), bisect_voc(BISECT_GOOD));

>   which gives one more argument for 1): once you have a use-case, you
>   can design the API properly, and not blindly guess that you're going
>   to need printf. Actually, writting these 2 example lines, I also
>   noticed that the parameters could/should be an enum type rather than
>   a string, it makes the code both more efficient and clearer.
>

Okay I get it. It would be much more efficient to return a enum
because its difficult to parse text output into a C program. I hadn't
looked further into the function. Thanks for pointing it out early!

I will wait before re-rolling this patch and will do it when I convert
bisect_state().

Regards,
Pranit Bauva
