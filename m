From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: patch-2.7.3 no longer applies relative symbolic link patches
Date: Mon, 26 Jan 2015 17:15:50 -0500
Message-ID: <CA+5PVA7Hb1ppHFYA4wHC+uEyULk4m_7eX2FRNuisi1uOTagBEw@mail.gmail.com>
References: <CA+5PVA7rVy6Li_1haj1QmGG0D6avLB5Xej=2YGt6K-11kKHR5A@mail.gmail.com>
	<CA+5PVA4bs6CYU8MHn1JqBjnb-5wYJT2Tjqa65=v2uSPL8c7dYw@mail.gmail.com>
	<CA+55aFxbY21vBbPs5qCFPT1HSBbaeS+Z2Fr9So1r3rXrMWe_ZQ@mail.gmail.com>
	<CA+5PVA5RdtLyRiYerG=u--bRZQ87qU0EGf7kGPMiQs9_KB3hRw@mail.gmail.com>
	<CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	"Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
	twaugh@redhat.com, Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Mon Jan 26 23:16:02 2015
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1YFrws-0004Xn-IR
	for glk-linux-kernel-3@plane.gmane.org; Mon, 26 Jan 2015 23:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756894AbbAZWPx (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 26 Jan 2015 17:15:53 -0500
Received: from mail-ob0-f171.google.com ([209.85.214.171]:47693 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbbAZWPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2015 17:15:50 -0500
Received: by mail-ob0-f171.google.com with SMTP id va2so10376017obc.2;
        Mon, 26 Jan 2015 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=KtL5sEXbSeQxA66ioYefI9njonwaOHq8Ipfix40RxPY=;
        b=TrXM4TuIoJHVZLXWTyFmOSrI0qqPW73mYomqN9BGrjN3d7HdpIMw0YJoyeFE2X8ANs
         mOdu5pAENbnwug0gkPVImDwVXy8GYxLkT4J26u6mq1GrgVMrIRJsXRhC69kIDgxJzcFX
         9Np/DGWhq5+oYCFLScDPGRpz65cp6rRRURemJ5VHbJkVvZ1wY4KoyIL6VyzWyzmFWONc
         GT3CcIRjp1VqEIq39NCnLaVYk/29K8TTY/gOuE3EWbi2vS849MzQiJrYttNvlMErywEq
         WLFVuIUiPqQUdAbaYCtPbqnZ7MlH+XKfbAyFPR6qFshzY10Y+48GCcP0W9ElSK3SdkfW
         g9og==
X-Received: by 10.202.2.73 with SMTP id 70mr13356720oic.69.1422310550463; Mon,
 26 Jan 2015 14:15:50 -0800 (PST)
Received: by 10.76.50.70 with HTTP; Mon, 26 Jan 2015 14:15:50 -0800 (PST)
In-Reply-To: <CA+55aFwa1-pudNus+r=5EghpGkm33h--GZNND5UHt=ZKvP15Xw@mail.gmail.com>
X-Google-Sender-Auth: aNhxF0IqDGpWxjmYmWgx6ztJWjE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263051>

On Mon, Jan 26, 2015 at 4:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jan 26, 2015 at 1:07 PM, Josh Boyer <jwboyer@fedoraproject.org> wrote:
>>
>> Or did I miss a way that git-apply can take a git patch and apply it
>> to a tree that isn't a git repo?
>
> Exactly. "git apply" works as a straight "patch" replacement outside
> of a git repository. It doesn't actually need a git tree to work.

Ah.  I had somehow missed that entirely.  Good to know for future reference.

> (Of course, "git apply" is _not_ a "patch" replacement in the general
> sense. It only applies context diffs - preferentially git style ones -
>  so no old-style patches etc need apply. And it's not
> replacement-compatible in a syntax sense either, in that while many of
> the options are the same, not all are etc etc).

Sure.  Though for the Fedora kernel builds, we tend to use git
formatted patches only anyway.  I might play around with this and see
how it works as the normal way to apply things.

josh
