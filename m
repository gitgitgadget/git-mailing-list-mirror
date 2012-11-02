From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Fri, 2 Nov 2012 20:20:28 +0100
Message-ID: <CAMP44s0DyiH+ac-xnfmJ3+JSib+y8GYZZymM83HUjKi5CuqARg@mail.gmail.com>
References: <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info>
	<CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com>
	<alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info>
	<CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
	<5090EFCA.7070606@drmicha.warpmail.net>
	<CAMP44s2a7fmxFmdn0CAcVtX8NxVtPdBKH9RY+i_Og53jb1Ju5Q@mail.gmail.com>
	<509149D9.3070606@drmicha.warpmail.net>
	<CAMP44s2PDZwTW55NDho9DyB2XZmsG0-KH4e78grJ2OFRVZkfjg@mail.gmail.com>
	<20121102144618.GA11170@sigill.intra.peff.net>
	<CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 20:20:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUMnL-0006Fh-GC
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 20:20:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243Ab2KBTUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 15:20:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37952 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754505Ab2KBTU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 15:20:29 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3929628obb.19
        for <git@vger.kernel.org>; Fri, 02 Nov 2012 12:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uUscxhWdFqw3CDWBNHEWqYV+p4Fs4k/bT4XMGcMRzn4=;
        b=vx9BQCILyfXXM8wdqVyoRh3NuImriCeaMntMuIPDc+3sNf1mT1LO0mSW3nSgiLHo9g
         +iPCZSHUJdYHqTH7/u9sSuVpqAW/VNXuBHEm2F2lGr1WHEcdqSP+PttOkORpF4hpbSJ0
         FvXM1r6CmbSs4ZzvWSwlZzZSVYAYIKXWHhFQcr6Av0ixG1yvxONNeuXusvXyiWH+cs8P
         Kyo71P5XxKPSmvZeyynN0pltMB3vpVL6Gjs+yQVFgoSo3Qqp5lRPYIAx8DBNetuKJoxm
         7Vc3oYKYtOsRUzxXK2RjvSjxP5jNqLOY5qryBLOott3QhjXsqrJvQL6yM4GfUx+FFrDK
         3AuQ==
Received: by 10.182.10.6 with SMTP id e6mr2191785obb.16.1351884028634; Fri, 02
 Nov 2012 12:20:28 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Fri, 2 Nov 2012 12:20:28 -0700 (PDT)
In-Reply-To: <CAMP44s0N3k4b9SoKpkR=2-zSBb41tKW37tYhuxFfbooiLu59Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208968>

On Fri, Nov 2, 2012 at 7:39 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:

> As a rule, I don't see much value in writing a framework that works
> only for one case, that smells more like over-engineering. If we had
> two cases (hg and bzr), then we might be able to know with a modicum
> of certainty what such a framework should have. So I would prefer to
> have two standalone remote-helpers, and _then_ do a framework to
> simplify both, but not before. But that's my personal opinion.
>
> Now that I have free time, I might be able to spend time writing such
> a proof-of-concept remote-bzr, and a simple framework. But I would be
> concentrated on remote-hg.

Actually, there's no point in that; there's already a git-remote-bzr:

http://bazaar.launchpad.net/~bzr-git/bzr-git/trunk/view/head:/git-remote-bzr

So, what do we need a python framework for?

Cheers.

-- 
Felipe Contreras
