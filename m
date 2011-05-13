From: Christian Couder <christian.couder@gmail.com>
Subject: Re: AAARGH bisection is hard (Re: [2.6.39 regression] X locks up hard
 right after logging in)
Date: Fri, 13 May 2011 10:20:54 +0200
Message-ID: <BANLkTikMeyRTOB9q4PEAYWnZRZfk3wg=kQ@mail.gmail.com>
References: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Shuang He <shuang.he@intel.com>
To: Andrew Lutomirski <luto@mit.edu>
X-From: linux-kernel-owner@vger.kernel.org Fri May 13 10:21:10 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1QKncU-0004th-5D
	for glk-linux-kernel-3@lo.gmane.org; Fri, 13 May 2011 10:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab1EMIVA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 13 May 2011 04:21:00 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42923 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757894Ab1EMIU5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2011 04:20:57 -0400
Received: by gyd10 with SMTP id 10so805220gyd.19
        for <multiple recipients>; Fri, 13 May 2011 01:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2FP9Vtqn53rQjhWbJuE3EF86vB1xumZI6zBhZ3901OE=;
        b=QipYSr2hrVKsh3dmAMDo2K37ZoArsVon2V1P6wlq8EORYV5VA9OI2PdU4vpMjyQg2o
         6Ty4KQJylw2AUHSKFhO4lgawne6jPkOUjLYXs3cd3MujAy5hZ9wzfRF+6fgZ6mN11fa0
         1keOPwCzTxToAgnyO/rhz9acgLHGRYw8UiUcY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PCCDxU2Y5uua4fa+efNnNuvrwN9zqPSI2gLsb69lH3H28wcDW2iql//raZgB/Uoy0H
         Uw8kftTmA2FBLdTp2VNUxKOeFd5YVy9FFJJF3FKC/TtTuAXW9dzc50JOzC2uJHUhwipQ
         GoAs0GjO8UEyh00mBGnq5s9MupXbnJueiuXSo=
Received: by 10.146.26.23 with SMTP id 23mr982264yaz.33.1305274854780; Fri, 13
 May 2011 01:20:54 -0700 (PDT)
Received: by 10.147.167.5 with HTTP; Fri, 13 May 2011 01:20:54 -0700 (PDT)
In-Reply-To: <BANLkTi=kb_m-CfrpnD8qQTVYLGaDdgy_tg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173508>

On Thu, May 12, 2011 at 7:15 PM, Andrew Lutomirski <luto@mit.edu> wrote=
:
>
> OK, this sucks. =A0In the course of bisecting this, I've hit two othe=
r
> apparently unrelated bugs that prevent my from testing large numbers
> of kernels. =A0Do I have two questions:
>
> 1. Anyone have any ideas from looking at the log?
>
> It looks like most of what's left is network code, so cc netdev.
>
> 2. =A0The !&$#@ bisection is skipping all over the place. =A0I've see=
n
> 2.6.37 versions and all manner of -rc's out of order. =A0Linus, and
> other people who like pontificating about git bisection: is there any
> way to get the bisection to follow Linus' tree? =A0I think that if
> bisect could be persuaded to consider only changes that are reached b=
y
> following only the *first* merge parent all the way from the bad
> revision to the good revision, then the bisection would build version=
s
> that were at least good enough for Linus to pull and might have fewer
> bisection-killing bugs.
>
> (This isn't a new idea [1], and git rev-list --bisect --first-parent
> isn't so bad except that it doesn't bisect.)

Did you forget to put the reference [1] in your email? Was it this one
you were thinking about:

http://thread.gmane.org/gmane.comp.version-control.git/165433/

?

Thanks,
Christian.
