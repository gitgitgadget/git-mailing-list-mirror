From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Dec 2015, #03; Thu, 10)
Date: Thu, 10 Dec 2015 15:25:46 -0800
Message-ID: <CAGZ79kaA6Lo1W-SudX6v5styyGrX-igGC7i=u5AYOvFYK0DOGA@mail.gmail.com>
References: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 00:25:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Aau-0004Vc-37
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 00:25:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752067AbbLJXZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 18:25:48 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35891 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbbLJXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 18:25:47 -0500
Received: by mail-ig0-f181.google.com with SMTP id ph11so27045072igc.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 15:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FpSf3SvCe4NDw5eoCRKL9yx8kjf1CDoKwNpkjRxVTeI=;
        b=SpXXZCDL2EysSlMRvX/ovaTFfuPHa3zhJdnaW7TlNOo/j9LMbHv5BsrFysCMhPCZgi
         0xyKQ9p9GZnTCT5XQkUrT/+bv9gDmEswiceMA15fcq4p8+8W6GZE73TegfzEmMjQ1XGm
         LG6KQl+Wn4GddWVBh4qA7OT9jxu79IHJ43FaLu9wupOBvrpI3MZdYpQ37/G4vKCKOSFJ
         oTF9VYW7gPDSB4dB7usvbEWJHVjLQAp2o9AYC7OjywLM8578ruAGYXp16ljSCZdTYSDO
         2+/TwjI6bG7NSDNSX0sYGRdKtyoaOjvftihGVtPZari07G9VKe7fQPRVyuuzZogXNvAQ
         5W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FpSf3SvCe4NDw5eoCRKL9yx8kjf1CDoKwNpkjRxVTeI=;
        b=X7y225Xm4n2RsdaogGak8g/JflwhUeNe3epTAQ98ouoxzMR4wGxbSolXCAzmUgx1vJ
         ig2snFtDFEx0o54lGZz0Sqm8drObHG0OrqwkOsMgoQZhVPkxU+ITH5KoSNS1SSokTetv
         iTlhbnhj50sPtelxaX5XXrbHRhi/sr6Xzi4b4p1mHH/ZcrmWUvGyLeNdCOY/w0h7SSsS
         TqqgiFJtrZmvJcT644qiaE6I7ljZYrG+hxSSPCClCnziMTYXKql3E+KjQBfXLCpPxDhd
         haCvpMgIeDDdOx2jE4RgTWdGyPUBaEWi2gDZDXdZ4/g2gY3YrG5lBZjGG5Evsjbal2S3
         Jb4Q==
X-Gm-Message-State: ALoCoQm+T9iTP/93rUCojNzD+t3B1khwE3ahHcxX8Wpd2Fnq5N6Sgx2hnUDICqxaNX7CPUmxTaeP3uFQ+5xYo4ZoLSJJA8FVEM/Z87S/KrHlJ+UuypGd0s4=
X-Received: by 10.50.109.136 with SMTP id hs8mr1725442igb.93.1449789946781;
 Thu, 10 Dec 2015 15:25:46 -0800 (PST)
Received: by 10.107.19.26 with HTTP; Thu, 10 Dec 2015 15:25:46 -0800 (PST)
In-Reply-To: <xmqqmvthhqgf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282239>

On Thu, Dec 10, 2015 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> * sb/submodule-parallel-update (2015-11-20) 27 commits
...
>
>  Waiting for sb/submodule-parallel-fetch to stabilize.
>
>  It would be the cleanest to rebuild sb/submodule-parallel-fetch on
>  top of 2.7.0 once it ships and then build this directly on top;
>  that way, we do not have to have merges in this topic that
>  distracting (besides, some part of the other topic can be updated
>  in-place instead of this follow-up topic tweaking them as past
>  mistakes and inflexibilities).
>
>  I picked up v4 from the list, but it needs review.




>
> * sb/submodule-parallel-fetch (2015-11-24) 17 commits
>   (merged to 'next' on 2015-12-04 at 2c5ea47)
>  + run-command: detect finished children by closed pipe rather than waitpid
>   (merged to 'next' on 2015-11-20 at 89fc723)
>  + strbuf: update documentation for strbuf_read_once()
>  + run-command: remove set_nonblocking()
>   (merged to 'next' on 2015-10-23 at 8f04bbd)
>  + run-command: fix missing output from late callbacks
>  + test-run-command: increase test coverage
>  + test-run-command: test for gracefully aborting
>  + run-command: initialize the shutdown flag
>  + run-command: clear leftover state from child_process structure
>  + run-command: fix early shutdown
>   (merged to 'next' on 2015-10-15 at df63590)
>  + submodules: allow parallel fetching, add tests and documentation
>  + fetch_populated_submodules: use new parallel job processing
>  + run-command: add an asynchronous parallel child processor
>  + sigchain: add command to pop all common signals
>  + strbuf: add strbuf_read_once to read without blocking
>  + xread_nonblock: add functionality to read from fds without blocking
>  + xread: poll on non blocking fds
>  + submodule.c: write "Fetching submodule <foo>" to stderr
>  (this branch is tangled with sb/submodule-parallel-update.)
>
>  Add a framework to spawn a group of processes in parallel, and use
>  it to run "git fetch --recurse-submodules" in parallel.
>
>  Waiting for review.

What kind of review do you wait for?
Each patch had lots of discussion, both submodule people (Jens)
and Windows people (various) seem to be happy with this.

I assume you plan on merging this after 2.7 settled and then we can
also get the above sb/submodule-parallel-update going again.
