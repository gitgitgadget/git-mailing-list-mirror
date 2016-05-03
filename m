From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 11:05:09 -0700
Message-ID: <CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
 <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
 <CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
 <CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com> <CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jan Keromnes <janx@linux.com>, Jeff King <peff@peff.net>,
	=?UTF-8?Q?Erik_Elfstr=C3=B6m?= <erik.elfstrom@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:05:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axehR-00041J-Td
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934019AbcECSFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:05:30 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33539 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932270AbcECSF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:05:29 -0400
Received: by mail-yw0-f193.google.com with SMTP id y6so2572283ywe.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 11:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=89TchOLHGZJQufXYbl8Q/EQd0LUkyz8jLGyZSK5nUmI=;
        b=usqkxb0F9B26GEk4Nb9urUN4IJ5N/TPCwZHJz89gq0ROZ+QaMCIQqM6c1d843bStpX
         Nz6VmL0HNDNSll1ii3jB5kaK7wOd59nspBGVYGkEoEOAGHAiFE8MmCAK0lgCSfrad8d1
         h0ubRAc7W3mJywYTf6VVXsqmzTBf0zX/bdDQVLTLV9JKhAFpDa10jvNAnUC0rwkTAyP3
         CmPUaI1mm1TH20q+luSPWRRVOYHnSPrIgoubWd+LbdQWGlx1aTBkk4qnR/forF6rd2lG
         6R40TAJCZTy0p55TQCtOHNM/3iE7GqHf3cghvI6gEBF56LM4DwCfWM9ZwFeXPegvF0eL
         bLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=89TchOLHGZJQufXYbl8Q/EQd0LUkyz8jLGyZSK5nUmI=;
        b=JNa0HJQqM7ZaGxjEaYDPIqK+0bFHjmNlMPloF+Sdv8/2LPlq3F9Mus7nYvAttqacHn
         JgdYh+jFwea6W5dYKxMmQ301499yu5vTLTQ1D6WLdvljehXi4AnYo5CaIp7pqbQgvCpH
         TzO7X/3s6bWFuR8k5MB+Kwe4CCxH2pT9XduKsvBWecG7PGsckodIzk/mxvq0UbvY+Hfm
         ESOb5yHmpZcCGY7y0/Uu39YErLd1Nyr9fucAbxx/UjHqv30ekQCM7SJJn3ZZxxpGEVPz
         ho7nlVEbf0GlOobFC9MCDHFE1hWy6w1QZoUhwIPpf99a8yHzk2a2bUqh6gPygkmJNIFz
         /UcA==
X-Gm-Message-State: AOPr4FWr5HlwJIY46yI2M9jahXUJN1tUmV3V6gaVbJJiT5gYgyTKVcumD1lhIPEl3iK9Oh8XYGokRZAB2eo2xw==
X-Received: by 10.37.111.215 with SMTP id k206mr1972367ybc.47.1462298728722;
 Tue, 03 May 2016 11:05:28 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Tue, 3 May 2016 11:05:09 -0700 (PDT)
In-Reply-To: <CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
X-Google-Sender-Auth: XtVLe3BFIi5SXdSuZ3qNwdmc_bU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293428>

On Tue, May 3, 2016 at 11:02 AM, Stefan Beller <sbeller@google.com> wrote:
>
> So I wonder if is_nonbare_repository_dir() is the culprit here.
> (We do a chmod 0 on the .git before the `git clean` in the test to confuse Git)

Ask if the test is run as root; if so, then mark the test to require
SANITY prerequisite.
