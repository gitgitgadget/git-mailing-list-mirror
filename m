From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 17:45:58 -0700
Message-ID: <CA+55aFw5AWz4m64Akz-xzuzbmqiWVpLQU_twoeWq3kkgfSjMWQ@mail.gmail.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	<CAGZ79kaGp==-On6HBf5X+jr+0d6mWmHQbsPSBQoRG0S=cqddQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:46:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzbA-0007JD-Ei
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934066AbcCPAqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:46:01 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:38329 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932337AbcCPAp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:45:59 -0400
Received: by mail-ig0-f179.google.com with SMTP id ig19so29490318igb.1
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 17:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=l+hHS7JzN6kbCHE9rfEOfFTb/04eGPrMg/sfz2wvLc4=;
        b=BEsuvZR5zIL8orU2v6Yp8DNo4EX4ZTI4L1/oIWFQqPydxFxWnERIQ1S+miC0OvVHxc
         yuQwrMK92i+aC/pGuS95Vklu9pzyPyzhymg4bY3gXFeGHGRqxACsKyVUB2S2vl9OK4hw
         c+jvgqVwIgPGevfZBG/kVyppi+VZKfNZweq+fQ1p30T/qbznAA+/yItfb8eMjBrnN01a
         UQPzYkAqgMoq5KZr5VH+Up7dI8K3eE4dsmjkwszk+L2r8E52e8VTsXDCiFcwqvgjlsWc
         BmGDsp+VAWLn4sPob2RjhIuFQaVHrDmkFjlGCdgQiQyaw9Hu/t6WGDAgL0pDDaqpKhm+
         8fgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=l+hHS7JzN6kbCHE9rfEOfFTb/04eGPrMg/sfz2wvLc4=;
        b=FUsKTVFDdvtviIDxY4ICbOyvP5lCRaBtHqDea0zqSgUePRjRNVsUm1AzR5hYa/n4D4
         XNrOWF4i+bZs64+yTXGQeOagfwF7wNtdm4GrIztq65Dnh5aJWUUO/Hp016cLlAbxxLq/
         NBN0M3cgxaLdV6ZhWgLINZV8sUzginCQ4TxnE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=l+hHS7JzN6kbCHE9rfEOfFTb/04eGPrMg/sfz2wvLc4=;
        b=gktAEaMJq4S8OMj8rZzbia9QpupohunK1Q+PgxGwE9eqLa/l1Boa65le25ePCKs+44
         doeAx1HU9+2Q38ZFb4m1NAmPKcHZBBiKlhX1WNyPsYQ8Inp1zLyHjgg42cKuDUTlewqb
         32IS97eiOpXmcL3AUmuyhwiHacqCyCHYJT1WpwRKfTGrvWo2VzcC4a6/JkpmfnlnQssF
         50rGibmV25X5xpcf/ZMv1CzBSnX6Rq0DhjhbA0TK52DlpYbNO9h33lXFNetzwkquHheg
         wea4HYk5d/ty4D24QYFiNF5cMBsP/mpBaDnHqwceCI1GSgOh5p6p9rVVJuJhUR6hJDMW
         aUYg==
X-Gm-Message-State: AD7BkJJDDsPLI6v1r3xfjOY5fNglGt8NDhByIXjeiYNEy4jDwbvQ1i68C3LMWc1C+uivb1EW2oEzfNi2+QVxnQ==
X-Received: by 10.51.17.38 with SMTP id gb6mr1564618igd.45.1458089158169; Tue,
 15 Mar 2016 17:45:58 -0700 (PDT)
Received: by 10.36.93.202 with HTTP; Tue, 15 Mar 2016 17:45:58 -0700 (PDT)
In-Reply-To: <CAGZ79kaGp==-On6HBf5X+jr+0d6mWmHQbsPSBQoRG0S=cqddQA@mail.gmail.com>
X-Google-Sender-Auth: k9lMCMv9PBqWaIErWh4xMaOO3PA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288933>

On Tue, Mar 15, 2016 at 5:23 PM, Stefan Beller <sbeller@google.com> wrote:
>
> Could you point at some example to better understand the problem?

So in the kernel repo, I just randomly looked for tabs that show this
problem, and take for example commit
ff9a9b4c4334b53b52ee9279f30bd5dd92ea9bdd.

You can see how the original lined up, by doing

    git show --pretty=email ff9a9b4c4334

because the email format doesn't indent the commit message. But if you do just

    git show ff9a9b4c4334

and get the usual indentation, you'll see things not line up at all.

In case you don't want to bother with the kernel repo, here's what it
looks like:

email format:

--- snip snip 8< ---
A microbenchmark calling an invalid syscall number 10 million
times in a row speeds up an additional 30% over the numbers
with just the previous patches, for a total speedup of about
40% over 4.4 and 4.5-rc1.

Run times for the microbenchmark:

 4.4                            3.8 seconds
 4.5-rc1                        3.7 seconds
 4.5-rc1 + first patch          3.3 seconds
 4.5-rc1 + first 3 patches      3.1 seconds
 4.5-rc1 + all patches          2.3 seconds

A non-NOHZ_FULL cpu (not the housekeeping CPU):

 all kernels                    1.86 seconds
--- snip snip 8< ---

Normal "git show" format:

--- snip snip 8< ---
    A microbenchmark calling an invalid syscall number 10 million
    times in a row speeds up an additional 30% over the numbers
    with just the previous patches, for a total speedup of about
    40% over 4.4 and 4.5-rc1.

    Run times for the microbenchmark:

     4.4                                3.8 seconds
     4.5-rc1                    3.7 seconds
     4.5-rc1 + first patch              3.3 seconds
     4.5-rc1 + first 3 patches  3.1 seconds
     4.5-rc1 + all patches              2.3 seconds

    A non-NOHZ_FULL cpu (not the housekeeping CPU):

     all kernels                        1.86 seconds
--- snip snip 8< ---

which hopefully clarifies.

In the above case, it really isn't very annoying. It's just slightly
ugly. In some other cases, it can get quite hard to see what's up, but
the ones that come through me I actually tend to try to edit, so many
of them have been corrected.

For other examples (again, in the kernel), look at 19b2c30d3cce, or
0dc8c730c98a.

                Linus
