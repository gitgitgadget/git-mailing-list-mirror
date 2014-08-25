From: tsuna <tsunanet@gmail.com>
Subject: Re: [PATCH] Undefine strlcpy if needed.
Date: Sun, 24 Aug 2014 18:54:11 -0700
Message-ID: <CAFKYj4cDJhiVfdmzZ5KnNASBEp9bkj0asxANPv43QcMQP06z9A@mail.gmail.com>
References: <1408854741-13956-1-git-send-email-tsunanet@gmail.com>
 <1408854930-14322-1-git-send-email-tsunanet@gmail.com> <53F9C818.8020607@ramsay1.demon.co.uk>
 <CAFKYj4dQhGgpS9Vf=5qoku49jEkR0ko7TuBNu4sQAJyiD7y+cg@mail.gmail.com>
 <53FA1050.2060309@ramsay1.demon.co.uk> <53FA41E2.9060907@web.de>
 <CAFKYj4eD8CXzafSC5LWpmaen=d6uw7yn0gZXFLG7VGLQwZdUWA@mail.gmail.com> <53FA8438.5070107@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 25 03:54:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLjUS-00028T-DO
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 03:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753631AbaHYByc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Aug 2014 21:54:32 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34258 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbaHYByc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Aug 2014 21:54:32 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so9842974obc.22
        for <git@vger.kernel.org>; Sun, 24 Aug 2014 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=xxN4FOl2APKE9sR2yi9DzIgxJ4HCj1Qrg2oDIVIwiHk=;
        b=bM4cAA1PoetIwprLg2G0V7N0uzXR2cQvUHgV23tdj38fKsnK6nZpfA6lv+dhhLrBqm
         wqI6OTvAd+RM1b9sYbiob9XU4IuY/6sxdSrE3+FTJHubHySnz7K8ujJ3fwXSt4s+WdfH
         vwyV/KzI/bETWUbyi8gEZjZcKwdjU1kciUxzYNCDBGQRw8pK2neRMOk4gMB2kotfP8WL
         hy6ildmPV6vIsetNVBIBjmwDZ71uW/+HxERXipEhn2oe+Y/7BJPpRm5jhImJmrgIBW3w
         lXvv+p4nUymuySB+FNgTvwJmhmQdZb/UnIgsjlXj+KcrU9dI6TLC05sQj+bfzml7ceYl
         uVlg==
X-Received: by 10.182.191.7 with SMTP id gu7mr18190245obc.14.1408931671630;
 Sun, 24 Aug 2014 18:54:31 -0700 (PDT)
Received: by 10.182.188.37 with HTTP; Sun, 24 Aug 2014 18:54:11 -0700 (PDT)
In-Reply-To: <53FA8438.5070107@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255818>

On Sun, Aug 24, 2014 at 5:32 PM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
> Again, I don't have access to an OS X system, so I don't know
> which package provides libintl/gettext, but it seems to be missing
> on your system.

Probably yeah, those libraries don=E2=80=99t seem to be provided in sta=
ndard
with OS X or OS X=E2=80=99s development tools, so maybe the Makefile sh=
ould
also default to having NO_GETTEXT=3DYesPlease when on OS X.

> You can avoid the build failure, without running configure, by
> setting NO_GETTEXT=3DYesPlease in your config.mak file.
>
>>
>>
>> I need to run configure first:
>>
>> $ make configure
>>     GEN configure
>> $ ./configure
>> configure: Setting lib to 'lib' (the default)
>> [=E2=80=A6]
>
> So, presumably, configure has set NO_GETEXT=3DYesPlease in your
> config.mak.autogen file.

Yes it did.

I don=E2=80=99t mind running configure, but so far Git has compiled fin=
e
without doing it.  Should we fix the default values of NO_STRLCPY /
NO_GETEXT on OS X?

--=20
Benoit "tsuna" Sigoure
