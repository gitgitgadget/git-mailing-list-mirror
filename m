Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 617D71F744
	for <e@80x24.org>; Tue, 21 Jun 2016 06:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbcFUGiw (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 02:38:52 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:37051 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbcFUGiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 02:38:51 -0400
Received: by mail-it0-f44.google.com with SMTP id f6so7179445ith.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 23:37:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+UybmM21/N0k9xI9xI4UA3ZKbU4z5o4vR49dasmFyDk=;
        b=OJbTP3xdYxfhQFL3Eq8fRZAraRNllt/T0BtXiWqlF8NaZ5FBLyHQzWPIlqgyWOmdGn
         q/Ysk3FJEUFrb83KjBdr0lj0I67ReJuP+xJkHUK+FiUKE4SxbAd2HSbIq90kTu3Zbdsn
         37+kdwMQ6qX1RTpmFiUEKR5s/WeBLqeOTv77AaDnRw3Quaa8MtnhGk4NcjQ0LBdjBTR9
         DitpVAMZ3xe4E+X5ikHRMmY/KS7e5l2ZSrlrpqBzD69FR2YDYT5zLmzwpwxjgYMXt+n7
         6Kygr3A3v7xLPH/W7esFJNERJ4U9fuHLfXJuyOMjwoZHEv3kuXlhSV1DtbfLqC1YXYRs
         RGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+UybmM21/N0k9xI9xI4UA3ZKbU4z5o4vR49dasmFyDk=;
        b=Rot5oB0lkklJdVK4gqqi5UEbBF/X0ew9TMkHd6UxguZZX3O4+ioSQpt+AY/bHtl0mz
         zWWoAV9WU300w/uvAa1gdtTfUpNkakB3HOEIVUwxRijTTxudifux4Ha9Qt+fWZ19MnUn
         6ZWs3ppFvDxCeTZi2vhAzhNM6Vxb9Z5+JlJYW19uzKnSCOnmKqlPNGGcYwhWpm0fyHIJ
         pmC3FtHHJzZyO07j2gHlbluWavyhU3nZY7dEU7MgFCf17pHlnHKO7QLZCcfR0CTkGJwT
         Yy7nIzlimbPxKyi4wAO/ZzIorLxEmbzhxzM44G/6mjelpAB3kU0eILxfS3PMSvmYfZSk
         mDjg==
X-Gm-Message-State: ALyK8tJB5M/VkMMDnygRz9Cxx+dEMPYUJwVkUrfd6eNdV5yqqJLoQpWE0+K1hsZtFtpHasKxsW2JpuD3jWKtVA==
X-Received: by 10.36.125.74 with SMTP id b71mr2920859itc.2.1466491070759; Mon,
 20 Jun 2016 23:37:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.175.104 with HTTP; Mon, 20 Jun 2016 23:37:50 -0700 (PDT)
In-Reply-To: <20160620222112.GB6431@sigill.intra.peff.net>
References: <CAM+g_NswH8fd8aFPEHfSLYnZWptNU2GX=xTWpehzjTJfJM_GfQ@mail.gmail.com>
 <CAGZ79kZL-ZY_0hZx9uA-ObPvMiD+EWvJYQa+OfCeQe2RLOPECA@mail.gmail.com>
 <CAM+g_NtNAWpLkbErL5-BUyH_3X4rYGfZwO0o-Hfu8zyam8pw7Q@mail.gmail.com>
 <20160620193928.GA3631@sigill.intra.peff.net> <20160620194648.GB3631@sigill.intra.peff.net>
 <20160620200011.GC3631@sigill.intra.peff.net> <20160620210901.GE3631@sigill.intra.peff.net>
 <xmqqy45zse7o.fsf@gitster.mtv.corp.google.com> <20160620222112.GB6431@sigill.intra.peff.net>
From:	Norbert Kiesel <nkiesel@gmail.com>
Date:	Mon, 20 Jun 2016 23:37:50 -0700
Message-ID: <CAM+g_NtGWRCqaNz1DauZRReem0YPC6CaunHSwfhnB5LpvdGGcQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] fix local_tzoffset with far-in-future dates
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

There are more strange things happening with dates.  One example is
that `git commit --date=@4102444799` produces a commit with the
correct author date "Thu Dec 31 15:59:59 2099 -0800" (for my local
timezone which is Americas/Los_Angeles), while `git commit
--date=@4102444800` produces a commit with "now" as author date, as
does any other larger number. `date --date=@4102444800` results in
"Thu Dec 31 16:00:00 PST 2099". So seems 2100-01-01T00:00:00Z is a
hard limit for git when using this format.

On Mon, Jun 20, 2016 at 3:21 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 20, 2016 at 03:11:23PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > I still don't know how that screwed-up timestamp got _into_
>> > a commit, so perhaps there is another bug lurking.  I couldn't convince
>> > git to parse anything beyond 2100, and committing with
>> > GIT_AUTHOR_DATE='@5758122296 +0000' works just fine.
>>
>> Interesting.  The weirdest I could come up with was with
>>
>>     GIT_AUTHOR_DATE='@5758122296 -9999
>>
>> which gets turned into the same timestamp but with -10039 timezone
>> (simply because 99 minutes is an hour and 39 minutes).
>
> Yeah, as weird as that is, I think it's reasonable. We _could_ turn
> nonsense timezones into "+0000". That doesn't necessarily help the user
> much, but at least it's less bizarre than making a 46-year timezone
> offset.
>
> I also looked for other uses of tm_to_time_t without checking for an
> error return. Most of them do check. The exception is datestamp(), but
> is calling it on the output of localtime(time()), which should generally
> be sensible.
>
> -Peff
