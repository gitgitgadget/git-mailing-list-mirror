From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] pathspec: remove check_path_for_gitlink
Date: Thu, 5 May 2016 16:32:18 -0700
Message-ID: <CAGZ79kbmW5U+uFCnBhz4r2-ciGsWSwXHU5Va2r-MEca=iacfgQ@mail.gmail.com>
References: <1462487497-28394-1-git-send-email-sbeller@google.com>
	<xmqqbn4k85lm.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY65Fo4+_a1B8J0h7PymGWUSoAdb1eb5YVfG55=30oPEg@mail.gmail.com>
	<xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 01:39:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aySs6-0004bp-Sk
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 01:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbcEEXju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 19:39:50 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36327 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755416AbcEEXjt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 19:39:49 -0400
Received: by mail-io0-f173.google.com with SMTP id u185so115042670iod.3
        for <git@vger.kernel.org>; Thu, 05 May 2016 16:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=lHx83yeCF9jd0k1eDCTdZ621oLDsZOSRk+9Qy8GRksg=;
        b=hbUPqraDraSg5WoBxv46VKPxXWoua4EkG1csiceymeGDSkAFuPsLf4+CcSgCZ9/HfX
         16EguZq1HqP4tVpRycVwMBhgdYy3bAeiNVC0O7PkmJ4VImS36NcIQYy63lJW6cMTu2xI
         UJOEn1Ec6pR/tY5UhICXxrek03UP3fdccmPoDKnw856wx1uyH/sBiudVyUSE+NZ0T9Kf
         hWpO9Ya4w6eGYMLEb9YNRwPdJSbnDxtL4PggJRe6Cu5mvv9yOkxUv6ClNhZXSX9XzIK5
         lpBYZHkgZtydN4JLGQ72XctkUGWHSZ9uk9tnx66LAjV5CoNNx8DL4WaqnpXMCbKzDide
         LCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=lHx83yeCF9jd0k1eDCTdZ621oLDsZOSRk+9Qy8GRksg=;
        b=czubU2Md9C/p/XwZcvk5jmYdMvCiiL2z9t/DdiVGBj4kuptpzG9K+kI45G4CI8rHtU
         Ee4MKNQS+q08XkA+P5G3NrnwtyU7oqTfobnyJ0fAlN8NvYtsCmms0Ien/fI31h5Bnhs/
         DC6o5EqCQldigdohWwNRED1uQenyN+SWbEuxlx5Sp71xjFpDomHg688xbLKO8fiCCbTK
         EWFqkpOW66d/O43Ym9yEqhwymEKjYTn0lK0ApG+psBhQqK7wCjp9bQhjZEGNJP0cAKND
         AP5JAxO/dmL5rzSlG/I+bPlKhfAZbsX6lutqVYYT/Hpo4EDDaAbBQTpHFfoXbJR/fvfY
         HJhg==
X-Gm-Message-State: AOPr4FUOnNSXhI8STpcR2yiHeJVkH7xnGGgAZgRXbvZqQ38W2kaQ53FoYj/pnQWBrnwNr3HQr4FWJ1YwDwblz5j/
X-Received: by 10.107.174.205 with SMTP id n74mr20176316ioo.96.1462491138354;
 Thu, 05 May 2016 16:32:18 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 5 May 2016 16:32:18 -0700 (PDT)
In-Reply-To: <xmqqy47o6q71.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293728>

On Thu, May 5, 2016 at 4:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> I wonder if the patches mentioned have something to do with the "git
>>> add deep/in/the/tree" that fails to notice deep/in/ is an unrelated
>>> repository in some way?
>>
>> Which is considered a feature now. Maybe we should add tests for that?
>>
>> http://debuggable.com/posts/git-fake-submodules:4b563ee4-f3cc-4061-967e-0e48cbdd56cb
>
> That is a bug, plain and simple.  Duy any ideas where we went wrong?

That was my first reaction as well. However after a while of thought I actually
like that bug. Consider the possibilities how gitk/git-gui or other subsystems
can be developed. When accepting a patch for that you can either apply the
patch in the outer or inner repository, depending on what the sender used.

I am not so sure if it is a bug plain and simple, but devolved into a
"feature" now.

>
> I think we already have code to avoid adding beyond symlinks.
> "git add deep/in/the/tree" should refuse if deep/in is a symbolic
> link (and happens to point at a directory that has the/tree in it).
> We used not to catch that long time ago, but I think we fixed it.
>
> The logic and the places to do the checks for "no, that thing may be
> a directory but is an unrelated repository" should be the same.
