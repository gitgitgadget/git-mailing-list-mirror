From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3] submodule deinit: require '--all' instead of '.' for
 all submodules
Date: Wed, 4 May 2016 14:47:22 -0700
Message-ID: <CAGZ79kbLRDoAm5BaQ-OQ_OA19HBmhK3r6TWLiK1WMGGcTBVgtQ@mail.gmail.com>
References: <1462321992-15153-1-git-send-email-sbeller@google.com>
	<1462324785-26389-1-git-send-email-sbeller@google.com>
	<xmqqlh3pft91.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbdnKMxrp_rQp7k-G6mveNYxES4XB-+2jh2e4+_RwPeyQ@mail.gmail.com>
	<xmqqzis5ebxk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 23:47:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay4dl-0005qT-VJ
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 23:47:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754370AbcEDVrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 17:47:25 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36575 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196AbcEDVrX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 17:47:23 -0400
Received: by mail-io0-f173.google.com with SMTP id u185so77989330iod.3
        for <git@vger.kernel.org>; Wed, 04 May 2016 14:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8FPqCK5HOgVyjsm4PuhKOYl3lXDsPQkNyVP9IM0//fE=;
        b=FBk/x1YZnv50biQOe1G7JLxvqtxi7MCbtitIh4DUJ5W40dgsZH4UET7Ex54ScGfJG8
         uBb9AKf93g7FUAh4msRKNdxch9jxwy/he8noIkaUDQF7cIaUTtZJCiZopSV26zSMEUmU
         Ri4pdvx37a7uPsTkX+yX9pHtlkt0JzQZMT5Sk5+0A4Y+IeePfpsmdWs3QyhULBksp/4c
         CflY1jbb2IRbB1h38dT+4M6GrhafSgamGzmMbjl2Xwfybcs8HbQCOWTz1p1nGXVZ9tqg
         qA2BwLsCNAPWKq3TX4f02Y7jjqAgtULxw0Wt1kb8uhY6Lf91QOhxqmqTLtddBKCekkmx
         cb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8FPqCK5HOgVyjsm4PuhKOYl3lXDsPQkNyVP9IM0//fE=;
        b=lPJKvtnEYaMCRJuSgCwnKIPl3K6/ZsWYkC2klckX+shL3vpvV9SmTAvWfLB1KFxvyC
         JK3ZmQgW/Lamhd4Ul6Q7EQ9aGlM0OFxwLcfKTxNzGrPjxu1EwQZxTpH4gjfRsE9JV2x/
         Hy/xJzLMqWhRBte0BnRDb+ONwm30k65QxxdzoV+qadLOVRFZjB8rfd4deSVi/keEpSUd
         tV8ltboggr945k1mgwVHiS73c53UIY0h69G1S7G9Sw4k1NXahotRgJzgk7x3VH96Dnef
         zl3miZWZS7ro+QcpBchdetSgROb9bXR52EV6jhUHRWHFiPKVEOLT7nPT2rHMdlL7O1/A
         HpKg==
X-Gm-Message-State: AOPr4FVJql4nk0oNKmaEdQjudvBCeJ4OhV3YTfIGHyHFuDwee5uVnYhiqUDHqsyoqhTMrIYAQHF5nVGSSzO/oOlS
X-Received: by 10.107.174.205 with SMTP id n74mr13303710ioo.96.1462398442895;
 Wed, 04 May 2016 14:47:22 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 14:47:22 -0700 (PDT)
In-Reply-To: <xmqqzis5ebxk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293600>

On Wed, May 4, 2016 at 2:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> (e.g. work tree for working tree?)
>
> This was probably primarily my fault, not just because I've written
> more than my share of documentation (compared to the code that
> touched), but I was deliberately writing "work tree" when both "work
> tree" and "working tree" terms meant the same thing.  Compared to
> the length of the timeperiod, the newcomer who is now known as
> "worktree" has only lived a very short period of time, so it is not
> surprising to see remaining "work tree" in our documentation set.

Sure.

>
> I think some attempts like 06cdac5a (git-reset.txt: use "working
> tree" consistently, 2010-09-15) were made to clean things up even
> before "worktree" started to mean an entirely different thing, and
> we shouldn't make things worse by adding mentions of "work tree"
> when we mean "working tree".

Ok. I'll see if I can send a similar patch like that.
