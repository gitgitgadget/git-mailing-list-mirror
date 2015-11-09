From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4] Add git-grep threads param
Date: Mon, 9 Nov 2015 11:11:08 -0800
Message-ID: <CA+55aFwV7c6=4mXPuB0c21rK3TSVWEw9JT-kiu35RuMzuHxoVg@mail.gmail.com>
References: <1445980944-24000-1-git-send-email-vleschuk@accesssoftek.com>
	<xmqqvb9jc81q.fsf@gitster.mtv.corp.google.com>
	<20151104064021.GB16605@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA15@mail.accesssoftek.com>
	<20151109155538.GC27224@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA17@mail.accesssoftek.com>
	<20151109165343.GA29179@sigill.intra.peff.net>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA18@mail.accesssoftek.com>
	<CA+55aFzHic5AN05QkbERFszRC=i3aDDGy9yhXEjgzZjwzFVBLQ@mail.gmail.com>
	<6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA19@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Victor Leschuk <vleschuk@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"john@keeping.me.uk" <john@keeping.me.uk>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:11:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvrqZ-00085I-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 20:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbbKITLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 14:11:10 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34403 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672AbbKITLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 14:11:09 -0500
Received: by iody8 with SMTP id y8so195923202iod.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 11:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EJi+EkA/zQfL/MmCbLwu8zdxpAWc68gbxZGe7Xo+dqI=;
        b=mV/HEI9sz9X0IThLtNX3KlgSEQwmduLs6Jt5B/M8QLu9q6OeFbszrI0jaM6ZYgVBdO
         hXa9Y5OobeA1lRyyeRuiffLB2J0D1jfjXam+d8ws2elAVJR2ybVgsueMpx7YRa/9JYqc
         o6H3fc6XVb6aFEnrQIScwg0kcrUAs0s48ulpvxJ0kW2pud8zDq6Gei6QDlw7ilozqrD4
         Vlwkh1wGPcl9edTpmzQSemMlpssNDnmeRXV0t1hKJTSGPwQrkmxQyyExFb4pFjtXqUWD
         oMEsnNFgxIzYYtYFHTlfoB09zd1Fcwvl/ZFHLn/qopsPUIoot4W9EiVN3gmoxCHIju+w
         XArg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EJi+EkA/zQfL/MmCbLwu8zdxpAWc68gbxZGe7Xo+dqI=;
        b=UnYtUdF5Cw7Vpc4zgjqEt/Fp7n2EjUZjEmw4mKvk5Dc4OZU/UZpF7Zlf437QqoGsjM
         m3gAygOKD9fmQc09wiz7Xb3xwaBX0CRi+6Be/bNdrSA8oKc4mEeqfAHXeGUM0VTbkW/F
         bf4/Sd/IkGoJpeR6ee0sXD0kAcFfCvJaVTYlk=
X-Received: by 10.107.131.88 with SMTP id f85mr51961iod.89.1447096268669; Mon,
 09 Nov 2015 11:11:08 -0800 (PST)
Received: by 10.36.33.81 with HTTP; Mon, 9 Nov 2015 11:11:08 -0800 (PST)
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDABA19@mail.accesssoftek.com>
X-Google-Sender-Auth: b9fvv_sioLdqGUEhA8J2ZjbLYBI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281077>

On Mon, Nov 9, 2015 at 10:32 AM, Victor Leschuk
<vleschuk@accesssoftek.com> wrote:
> On Mon, Nov 9, 2015 at 9:28 AM, Victor Leschuk
>>   num_threads = online_cpus() <= 1 ? 0 : GREP_NUM_THREADS_DEFAULT;
>
> Actually I have never said the nCPUs played main role in it. T

The pseudo-code you sent disagrees. Not that "online_cpus() <= 1" is
likely to ever be really an issue on any development platform from the
last decade.

However, I do have to admit that that "online_cpus()" check goes back
a long time, so I guess I can't really blame you.

At least in the index preloading, I was very conscious of the IO
issues. It doesn't actually make a big difference on traditional disks
(seek times dominate, and concurrent IO often doesn't help at all),
but the reason I keep on bringing up NFS is that back when I used CVS
(oh, the horrors), I *also* worked at a company that did everything
over NFS.  CPU ended up almost never being the limiting factor for any
SCM operation.

So I don't have a very good idea of *what* we should use for automatic
thread detection, but I'm pretty sure online_cpu's should not be it.
Except, like Jeff mentioned, for pack formation (which does tend to be
all about CPU).

Sadly, detecting what kind of filesystem you are on and how well
cached it is, is really pretty hard. Even when you have OS-specific
knowledge, and can look up the *type* of the filesystem, what often
matters more is things like "is the filesystem on a rotational media
or using flash?" etc.

In the meantime I'd argue for just getting rid of the online_cpu's
check, because

 (a) I think it's actively misleading

 (b) the threaded grep probably doesn't hurt much even on a single
CPU, and the _potential_ upside from IO could easily dwarf the cost.

 (c) do developers actually have single-core machines any more?

But if somebody can come up with a smarter model, that would certainly
be good too. The IO advantages really don't tend to be there for
rotational media, but for both flash and network filesystems, threaded
IO can be a huge deal.

                  Linus
