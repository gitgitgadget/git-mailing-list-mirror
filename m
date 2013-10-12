From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Sat, 12 Oct 2013 01:21:28 -0500
Message-ID: <CAMP44s1i3bxGtvMS38j3Tk5gKAZEHSKf5MBF2qJ_ReBApA1u7Q@mail.gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
	<1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
	<522E3C6A.3070409@bbn.com>
	<CAMP44s1OyST3S1HEdS38WPsjq6w9SekuwT4DRUgVvduATox9tw@mail.gmail.com>
	<20130910022152.GA17154@sigill.intra.peff.net>
	<CAMP44s1FfQ-1pAK8T1cmiZk4i17HnpvzPwuZrzHiiXSmGzbrRw@mail.gmail.com>
	<vpqmwnljdmn.fsf@anie.imag.fr>
	<52589027a4851_5dc4c2be742754f@nysa.mail>
	<20131012005035.GA27939@sigill.intra.peff.net>
	<CAMP44s2y0UZ9uS8xtG2WDD=k5pHSG+K+_WM2dj-DVaUDy4djdA@mail.gmail.com>
	<20131012012515.GA1778@sigill.intra.peff.net>
	<CAMP44s3669E7JyEjP_ErYt7JN2eHv0mX4+p_=ZP4_LDatnw2vg@mail.gmail.com>
	<5258D2D3.9030704@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>,
	John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Sat Oct 12 08:21:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUsa3-0006b8-9W
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 08:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab3JLGVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 02:21:31 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:32863 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393Ab3JLGV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 02:21:29 -0400
Received: by mail-la0-f42.google.com with SMTP id ep20so4238978lab.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2013 23:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PSMovsFmiNtpRH/BIGfOfg5T0eW43Yo0hD1uFDNyo+s=;
        b=O/F+ZewvuFOKCn6jobt5NnyIh78EkA8Zq2VL6EjRYcMpo2OG2pzDL5lkUO039fu3GA
         5Kfu/ocuAtNOw3jH6+UiZ+RPZWzJ/Jxl8ehGSSW8kFY/SjS4oW8JqJvFEUyD8xuDc8DK
         sFERG3/yw25gV8mLQKJRCgTUGV+/CwJEN1VQ6fMdMrEVW859iVDLsa063vEvM8bBPMMA
         JlxoHgJyBDDZaIJlF4DcecyVjVP7qLFPK/xjn+J1NE6RLxif1Lv31pvKXDLW2m3uV4B4
         J296+4bIrvjryKT+R3vxeMnT4NVf4HnJnfh+OpO/EyVm7mZVTvSPVlypJ7mMjO6WGgB9
         pbOg==
X-Received: by 10.152.28.7 with SMTP id x7mr858893lag.26.1381558888117; Fri,
 11 Oct 2013 23:21:28 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Fri, 11 Oct 2013 23:21:28 -0700 (PDT)
In-Reply-To: <5258D2D3.9030704@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235944>

On Fri, Oct 11, 2013 at 11:40 PM, Richard Hansen <rhansen@bbn.com> wrote:
> On 2013-10-11 22:08, Felipe Contreras wrote:
>> I'm fine with 'echo "warning: foo" >&2', but still, if you really
>> cared about consistency, there would be a warn() function
>
> So add one!  It's only one simple line:
>
>     warning() { printf %s\\n "warning: $*" >&2; }

It probably should be

warning () {
  printf 'warning: %s\n' "$*" >&2
}

But why don't _you_ do it? I have enough patches being ignored to add
more to the list, specially for something I care nothing about.

> So much discussion for something so trivial...

Trivial things are what cause more discussion.

-- 
Felipe Contreras
