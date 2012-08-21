From: Egon Elbre <egonelbre@gmail.com>
Subject: Re: Having an invalid HEAD file causes git not to recognize the repository
Date: Tue, 21 Aug 2012 11:07:22 +0300
Message-ID: <CANtNKfr1SMvpOrjowk+ewk2aiwiZCUzRwuw4wHFjQ3N-BmGikg@mail.gmail.com>
References: <CANtNKfp+9HpvWkAO0vrm84oMiJNvjFg9T-UtNQko+ABHhEWj6w@mail.gmail.com>
	<20120821072403.GD3238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 10:08:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3jVc-0002Hy-9v
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 10:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab2HUIIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 04:08:14 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56922 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754047Ab2HUIHZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 04:07:25 -0400
Received: by lagy9 with SMTP id y9so3746763lag.19
        for <git@vger.kernel.org>; Tue, 21 Aug 2012 01:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ciHA/l/tNAfhgAc0hpr/kQrK8xQld7NxdF/XRZtQPKg=;
        b=09Gf2PNHVSHpSG9PA4l8OPpD8AQUWghjNYI6erf9iGMu8qsC6c4F4mYqgC9g2hyeo4
         n2RZ0BvkGGWZw987T+rEn5wG1q6VhJdd4Gfl4N2O6H5F9NwpuUdFL+eVLl/SXdtu5YwU
         27OkOg7zUjMdIwBmxOAmGiGBoomC84n4jCYLmblouApjho5eEVF404ZYVIjuNBm8xHVQ
         XCS5JsQMyFiqYn7sAbvP19b1aaYxwkMRIi/41eLyO2G6cq4SCA+TuAT7t2Lu6FzdiDzM
         hCwKk7i7rBhLmI1xX9/8GsOxqiEflahEP+ByJrnCIQqI5M2OFZhFBIdKr4Es6T6Kn+Vs
         ju6w==
Received: by 10.152.110.80 with SMTP id hy16mr6582652lab.8.1345536442062; Tue,
 21 Aug 2012 01:07:22 -0700 (PDT)
Received: by 10.152.129.133 with HTTP; Tue, 21 Aug 2012 01:07:22 -0700 (PDT)
In-Reply-To: <20120821072403.GD3238@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203952>

On Tue, Aug 21, 2012 at 10:24 AM, Jeff King <peff@peff.net> wrote:
>
>> I ran into this problem when I had a BSOD during a rebase (ignore that
>> I'm having to use Windows). This meant that only half of the hash got
>> written into HEAD and all git commands I tried failed.
>
> That generally shouldn't happen, as we write new ref content to a
> temporary file and then rename it into place atomically. I wonder if
> there is a problem with the atomicity there (we do not fsync after
> close, which some filesystems might want), or if it was simply
> filesystem corruption related to your BSOD.
>

It's a truecrypt drive and I had to run diskcheck on the drive
(because of bad unmounting). In essence the file could have been
invalid and just restored it to some invalid usable state. Also it
might be truecrypt atomicity problem.

+egon
