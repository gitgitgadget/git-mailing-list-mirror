From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Running git on ARM systems
Date: Wed, 29 Feb 2012 21:31:48 -0800
Message-ID: <CAKbGBLj5EcQ=DLqhTO9FPKJGyP-tw=HyGYEgAv_7vz_0erSDMA@mail.gmail.com>
References: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 06:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2ycW-00072d-MC
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 06:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751856Ab2CAFbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Mar 2012 00:31:51 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39553 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360Ab2CAFbu convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 1 Mar 2012 00:31:50 -0500
Received: by lahj13 with SMTP id j13so286426lah.19
        for <git@vger.kernel.org>; Wed, 29 Feb 2012 21:31:49 -0800 (PST)
Received-SPF: pass (google.com: domain of steven@uplinklabs.net designates 10.152.148.2 as permitted sender) client-ip=10.152.148.2;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of steven@uplinklabs.net designates 10.152.148.2 as permitted sender) smtp.mail=steven@uplinklabs.net
Received: from mr.google.com ([10.152.148.2])
        by 10.152.148.2 with SMTP id to2mr3103783lab.39.1330579909067 (num_hops = 1);
        Wed, 29 Feb 2012 21:31:49 -0800 (PST)
Received: by 10.152.148.2 with SMTP id to2mr2558438lab.39.1330579908967; Wed,
 29 Feb 2012 21:31:48 -0800 (PST)
Received: by 10.112.18.168 with HTTP; Wed, 29 Feb 2012 21:31:48 -0800 (PST)
In-Reply-To: <CAH5451=ngnGxpSd4+8xg1PwTSPOJ0napS+Y9KNVE_82a+n+GQQ@mail.gmail.com>
X-Gm-Message-State: ALoCoQmdlPLkt460NJ6rw2Z/wk0k9waANUfvAmvC/U7BEpgcIF1Nimw9R8DBa683I8teuMD/LBi+
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191897>

I've been using git on three different ARM boxes (TrimSlice,
PandaBoard, i.MX53 Quick Start Board). It works okay, if a bit slow.
Even on a small repository (< 1MB), git is a bit laggy, but that's
true of most everything on those devices. It would be nice if they had
decent SATA controllers so I could attach some small SSDs or something
instead of relying on MicroSD or SD. I think you'll find the biggest
problem you will run into is memory usage when repacking or garbage
collecting, but you probably wouldn't really want to anyway (and if
you do, move the whole .git dir to something that can handle a proper
repack).

I've never used the ARM11 processor though. My experience has been
with the ARM7 and ARM9, where I was -extremely- memory constrained
(4MB of RAM if I recall) and couldn't really build anything on the
device itself, as well as the Cortex-A8 and Cortex-A9 -- which was a
huge leap compared to the ARM7/ARM9, particularly since the newer
devices have a couple orders of magnitude more memory.

Would be curious to see how one of the Raspberry Pi devices does
running my incomplete and silly microbenchmarking tool
(https://github.com/tycho/cpu-test-arm)... Perhaps I'll order one when
they're back in stock. :)

Is there anything specific you wanted to know about git on such devices=
?

- Steven

On Wed, Feb 29, 2012 at 9:11 PM, Andrew Ardill <andrew.ardill@gmail.com=
> wrote:
>
> Hi everyone,
>
> You may have heard of the Raspberry Pi [1], a fully programmable
> computer the size of a credit card for $25-$35. It will run a linux
> (debian/fedora/arch) distribution on a 700 MHz ARM1176JZF-S core
> (ARM11 family) [2].
>
> My one of these is on order, and the first thing I intend to do is
> install and test git. Has anyone had any experience running git on
> ARM, or know if there are any potential issues? I will also try
> compiling on the device itself, and was wondering if there is anythin=
g
> I will need to do especially for that architecture. I have done a
> preliminary google search and nothing striking came up, so any help
> would be appreciated!
>
> This device was designed to try and get kids into programming, and if
> we are going to teach them how to hack we should give them the best
> tools available. Hopefully git works out of the box, but if not it
> would be great to get it up and running before the education launch
> (probably later this year).
>
> Regards,
>
> Andrew Ardill
>
> [1] http://raspberrypi.org/
> [2] http://en.wikipedia.org/wiki/Raspberry_Pi#Specifications
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
