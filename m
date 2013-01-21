From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PULL] Module fixes, and a virtio block fix.
Date: Sun, 20 Jan 2013 17:45:33 -0800
Message-ID: <CA+55aFy1nW859yaGP17epRX8A+TaJ8APvb0-Ww1zw91dCAOhoQ@mail.gmail.com>
References: <87zk03wg7r.fsf@rustcorp.com.au> <CA+55aFwzdcv0LXovZobha=EH=L6DapJt+ODP0nq=TWWAqCxLYQ@mail.gmail.com>
 <87fw1vwcao.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: LKML <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>,
	Prarit Bhargava <prarit@redhat.com>,
	Sasha Levin <sasha.levin@oracle.com>
To: Rusty Russell <rusty@rustcorp.com.au>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 21 02:46:22 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Tx6Sr-0002Lg-52
	for glk-linux-kernel-3@plane.gmane.org; Mon, 21 Jan 2013 02:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626Ab3AUBpz (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 20 Jan 2013 20:45:55 -0500
Received: from mail-vc0-f176.google.com ([209.85.220.176]:55925 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab3AUBpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jan 2013 20:45:54 -0500
Received: by mail-vc0-f176.google.com with SMTP id fy27so849349vcb.21
        for <multiple recipients>; Sun, 20 Jan 2013 17:45:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        bh=AccBNCboFEr1aQO1WG8JbGtyUc1ihALXDwCt2eCTM5w=;
        b=xz7gSXJa10ilP8P2Yag//IU9bD3H+9jBVncOEQ+rLM8SiVIMypoygKkXmwtbl18ukJ
         Ab9gvrMtCH4lzKo8n2TDkdJnMSF2gvaZEM6NYRGE0CjDuil2mVdx85McVGM0DCyRH/Fu
         Vw8PnbTlR2njnwJa2dk7WtfssDtF5riZIbNRQfNLS6j5cuUYSIedc1yx+4pZHJhJja9J
         dRpAsELiKd/Jzh8wfDA/E0nOZs0p6Fcp6uZpzx/q287m1Q2XQX7Xe1UmthgE53Zt/56F
         mBusUh6TgkpslaAjjyVHPXKHbQRy9d0cMYkzzxz0z1/iYB1bc/GQdYkXtR2nMULsl8La
         XcYg==
X-Received: by 10.52.240.228 with SMTP id wd4mr2738289vdc.102.1358732753132;
 Sun, 20 Jan 2013 17:45:53 -0800 (PST)
Received: by 10.220.249.199 with HTTP; Sun, 20 Jan 2013 17:45:33 -0800 (PST)
In-Reply-To: <87fw1vwcao.fsf@rustcorp.com.au>
X-Google-Sender-Auth: -A1zmeG7ioQAwkgxJZYs89ETsME
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214069>

On Sun, Jan 20, 2013 at 5:32 PM, Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> Due to the delay on git.kernel.org, git request-pull fails.  It *looks*
> like it succeeds, except the warning, but (as we learned last time I
> screwed up), it doesn't put the branchname because it can't know.

I think this should be fixed in modern git versions.

And it sure as hell knows the proper tag name, since you *gave* it the
name and it used it for generating the actual contents. The fact that
some versions then screw that up and re-write the tag-name to
something randomly matching that isn't a tag was just a bug.

> For want of a better solution, I'll now resort to sending pull requests
> with the anti-social gitolite URL in it, like so:

That's even worse, fwiw. It means that the pull request address makes
no sense to anybody who doesn't have a kernel.org address, and then
I'm forced to just edit things by hand instead to not pollute the
kernel changelog history with crap.

Junio, didn't "git request-pull" get fixed so that it *warns* about
missing tagnames/branches, but never actually corrupts the pull
request? Or did it just get "fixed" to be a hard error instead of
corrupting things? Because this is annoying.

                Linus
