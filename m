Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA0C433EF
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 20:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhLLUPt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 15:15:49 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:40953 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbhLLUPo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 15:15:44 -0500
Received: by mail-ed1-f42.google.com with SMTP id r25so45463820edq.7
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 12:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=MZEXgffkAJ7CxHWLDywcdl6Gg23Z4e/9RsaCbNksFb8=;
        b=CUnrd3ZixXoN5pMuSGnryTGAEihxzKRV24x23Oa7ZZgZblLb1/HdnO2r5wbyV/DJjN
         msM69HvhQIOax/Y3IKT6LYLHNJc4hkqQceuBNgeXVkJnNtr+g9iyWZ31DIaihetzs06q
         UNJGDbkdfGUvNaJzU6x04Ww6UzTZDP/p74EXgP4Ty0iFHIzyY7WR42ZhHAsnzEZkKMVT
         4xtZgWGV/D9YSO+ogScRYIl6Co/VvGxHkMsPDsf4PJYP/VZZXd7AwLqkiRIrephBVA6P
         HWIvIcSu+sTxSbm3Rgb8dDKVYFJiBRpzdxVoJhkQfnRz+G84ZiBZTg+kImPXjIEerlct
         O8Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MZEXgffkAJ7CxHWLDywcdl6Gg23Z4e/9RsaCbNksFb8=;
        b=Txm3Z08FzKComcL3HOxbognZvEjoZuQUwFcaeCVAdYnDlhjxc3KcYM50ycU5eZ3eGf
         HHJHEQV1QaDrh44sLjB9ZswH2LqjQw1juoeyy3AL8RsMYj/x0HtZF4cxf5w8ZgJyEBs+
         Yp68KNUe1rw++0yNjD6ua5Zt4KayU9aRZYYJHU6d6pAg3cSsqU/sd5FAuKvQuCxKnga+
         5f7vZt0DK5uYLp173clxNy8rZEqvXk5SS5L+j60KHXwFJAcylSFTBux9VYpoNkTqSFWm
         7P71LWwoBzLQc3p92XxTjN7qPvrxjs5+PlXCTVaMlENvm8BAkuUwjD6eyqQM/17x4J7H
         EDdA==
X-Gm-Message-State: AOAM531cnFoYo4XwKLNtt85ulB/Zt/vBz7tIrKK3ywLag5rFWGCnWcTT
        ET5EWXswOldZouzmNk8PrXA=
X-Google-Smtp-Source: ABdhPJxSfMkfYLUIgx0ewDXwPAeiPCGbMmBOcRjCDze72nes2v7OC0VcSLuloVHyJ8RDEhazOY8Urw==
X-Received: by 2002:aa7:d748:: with SMTP id a8mr57925032eds.21.1639340083519;
        Sun, 12 Dec 2021 12:14:43 -0800 (PST)
Received: from szeder.dev (78-131-17-148.pool.digikabel.hu. [78.131.17.148])
        by smtp.gmail.com with ESMTPSA id dy4sm5110897edb.92.2021.12.12.12.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 12:14:43 -0800 (PST)
Date:   Sun, 12 Dec 2021 21:14:41 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
Message-ID: <20211212201441.GB3400@szeder.dev>
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
 <20211212163207.GA3400@szeder.dev>
 <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 12, 2021 at 06:06:31PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Sun, Dec 12 2021, SZEDER Gábor wrote:
> 
> > On Fri, Dec 10, 2021 at 11:07:55AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> In the preceding commit the use of "test_untraceable=UnfortunatelyYes"
> >> was removed from "t1510-repo-setup.sh" in favor of more narrow
> >> redirections of the output of specific commands (and not entire
> >> sub-shells or functions).
> >> 
> >> This is in line with the fixes in the series that introduced the
> >> "test_untraceable" facility. See 571e472dc43 (Merge branch
> >> 'sg/test-x', 2018-03-14) for the series as a whole, and
> >> e.g. 91538d0cde9 (t5570-git-daemon: don't check the stderr of a
> >> subshell, 2018-02-24) for a commit that's in line with the changes in
> >> the preceding commit.
> >> 
> >> We've thus solved the TODO item noted when "test_untraceable" was
> >> added to "t1510-repo-setup.sh" in 58275069288 (t1510-repo-setup: mark
> >> as untraceable with '-x', 2018-02-24).
> >> 
> >> So let's remove the feature entirely. Not only is it currently unused,
> >> but it actively encourages an anti-pattern in our tests. We should be
> >> testing the output of specific commands, not entire subshells or
> >> functions.
> >> 
> >> That the "-x" output had to be disabled as a result is only one
> >> symptom, but even under bash those tests will be harder to debug as
> >> the subsequent check of the redirected file will be far removed from
> >> the command that emitted the output.
> >> 
> >> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> >> ---
> >>  t/README      |  3 ---
> >>  t/test-lib.sh | 66 ++++++---------------------------------------------
> >>  2 files changed, 7 insertions(+), 62 deletions(-)
> >> 
> >> diff --git a/t/README b/t/README
> >> index 29f72354bf1..3d30bbff34a 100644
> >> --- a/t/README
> >> +++ b/t/README
> >> @@ -86,9 +86,6 @@ appropriately before running "make". Short options can be bundled, i.e.
> >>  -x::
> >>  	Turn on shell tracing (i.e., `set -x`) during the tests
> >>  	themselves. Implies `--verbose`.
> >> -	Ignored in test scripts that set the variable 'test_untraceable'
> >> -	to a non-empty value, unless it's run with a Bash version
> >> -	supporting BASH_XTRACEFD, i.e. v4.1 or later.
> >>  
> >>  -d::
> >>  --debug::
> >> diff --git a/t/test-lib.sh b/t/test-lib.sh
> >> index 57efcc5e97a..b008716917b 100644
> >> --- a/t/test-lib.sh
> >> +++ b/t/test-lib.sh
> >> @@ -381,29 +381,6 @@ then
> >>  	exit
> >>  fi
> >>  
> >> -if test -n "$trace" && test -n "$test_untraceable"
> >> -then
> >> -	# '-x' tracing requested, but this test script can't be reliably
> >> -	# traced, unless it is run with a Bash version supporting
> >> -	# BASH_XTRACEFD (introduced in Bash v4.1).
> >> -	#
> >> -	# Perform this version check _after_ the test script was
> >> -	# potentially re-executed with $TEST_SHELL_PATH for '--tee' or
> >> -	# '--verbose-log', so the right shell is checked and the
> >> -	# warning is issued only once.
> >> -	if test -n "$BASH_VERSION" && eval '
> >> -	     test ${BASH_VERSINFO[0]} -gt 4 || {
> >> -	       test ${BASH_VERSINFO[0]} -eq 4 &&
> >> -	       test ${BASH_VERSINFO[1]} -ge 1
> >> -	     }
> >> -	   '
> >> -	then
> >> -		: Executed by a Bash version supporting BASH_XTRACEFD.  Good.
> >> -	else
> >> -		echo >&2 "warning: ignoring -x; '$0' is untraceable without BASH_XTRACEFD"
> >> -		trace=
> >> -	fi
> >> -fi
> >>  if test -n "$trace" && test -z "$verbose_log"
> >>  then
> >>  	verbose=t
> >> @@ -650,19 +627,6 @@ else
> >>  	exec 4>/dev/null 3>/dev/null
> >>  fi
> >>  
> >> -# Send any "-x" output directly to stderr to avoid polluting tests
> >> -# which capture stderr. We can do this unconditionally since it
> >> -# has no effect if tracing isn't turned on.
> >> -#
> >> -# Note that this sets up the trace fd as soon as we assign the variable, so it
> >> -# must come after the creation of descriptor 4 above. Likewise, we must never
> >> -# unset this, as it has the side effect of closing descriptor 4, which we
> >> -# use to show verbose tests to the user.
> >> -#
> >> -# Note also that we don't need or want to export it. The tracing is local to
> >> -# this shell, and we would not want to influence any shells we exec.
> >> -BASH_XTRACEFD=4
> >
> > Please do not remove BASH_XTRACEFD.  And especially not like this,
> > without even mentioning it in the commit message.
> 
> I can re-roll with an amended commit message that explicitly mentions
> it

It should rather be a separate patch...

>, but that doesn't address your "please do not remove",
> 
> Do you see reason to keep it at the end-state fo this series? E.g. a
> counter-argument to
> https://lore.kernel.org/git/211210.86pmq4daxm.gmgdl@evledraar.gmail.com/?

I don't see any argument pertinent to BASH_XTRACEFD in general in that
email, of in favor of its removal in particular, and there are no
valid arguments for its removal in earlier emails in this thread
either.

