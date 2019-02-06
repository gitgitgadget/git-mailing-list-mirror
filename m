Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2194A1F453
	for <e@80x24.org>; Wed,  6 Feb 2019 11:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBFLLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Feb 2019 06:11:23 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:35120 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726914AbfBFLLX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Feb 2019 06:11:23 -0500
Received: by mail-wr1-f51.google.com with SMTP id z18so6314333wrh.2
        for <git@vger.kernel.org>; Wed, 06 Feb 2019 03:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UOwGZsWUL3hOPLJoTdMSuBxPrM+hkrP5R4YbsaHvNrU=;
        b=IucVO4Nt7UOu92/0/OdIgCKoyaO8RzzrV5KKVxKvcE4552vFtkYbhEMxugAP0STfk5
         04cb6guPXgC/KuAzbzrtwHYw29x2TvnF8h4LrLNYRxtnjl9JUUeJv+tZU+Av8D1Pl4Gz
         R1CfaWfqHxTwC7DQHlIA5FIyML9E/gKdRJ8ld3l0Z3kzs7zcTibNUnbAvQx1g09tuX3f
         oIGmC79kinP9+exn1lVMgsZ/lhk/w7VvRSdgBdoUmQxbiaDAN/pA8EDDSgZLHN6C2X9W
         oV23MzupNfBzI04pFDsO4X4B33R3XrVKi160Xhrpa6KKAqZLaDEcuxjlyJjfc6NkDAJj
         ZlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOwGZsWUL3hOPLJoTdMSuBxPrM+hkrP5R4YbsaHvNrU=;
        b=oyce6qJe5E4mrIMpyj/dWKQXwMpiSR3Q0JAQkN2jOJhktj6TKoNLzClONhmCUpH6/7
         sgWC6OYvuXKrbJtqflAzcxSCCsTFtFvIkw6bZQ92kwUOREaNVdO9WZzLigOvZSmUDP9b
         lfzlenriqKF6Hi+4mjLcA1aC67bqu11kxyhgdGP3JTm3hlQ3UZFZiKj7+o9OOEn6YPIq
         gqX/hCQiw5TKtuaDhiHvSOSNePyPBG4AAx85E9+M/Ad4/XuMr0Dn/wewbVlgQ7kOnXB0
         mhME/1/s00c02ccFYw5PvlhPHB8ZDO0ZTkc3gAXlKA9jN1r0EBYQX13rwYbmWq4L3qmE
         cDOg==
X-Gm-Message-State: AHQUAubZ2kax3UR4bF+UKr6ClkkmTQGC91thSQlZ7sV8NFu7R/InGmrI
        FqSd/79pePQvJr+eNfQChFM=
X-Google-Smtp-Source: AHgI3IZwfJtne0i6kHI2XNgIDJSEdFDhvGVss9OD5AFuxR5zkE4zFuSxEGtjsPFk4uqz3vCAATkYSA==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr7348098wrw.311.1549451474599;
        Wed, 06 Feb 2019 03:11:14 -0800 (PST)
Received: from szeder.dev (x4dbda645.dyn.telefonica.de. [77.189.166.69])
        by smtp.gmail.com with ESMTPSA id b18sm21248581wrw.83.2019.02.06.03.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 03:11:13 -0800 (PST)
Date:   Wed, 6 Feb 2019 12:11:11 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Luke Diamand <luke@diamand.org>, git@vger.kernel.org
Subject: Re: Weird (seemingly flakey) p4 breakage in t9833
Message-ID: <20190206111111.GK10587@szeder.dev>
References: <nycvar.QRO.7.76.6.1902061004110.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1902061004110.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 06, 2019 at 11:33:21AM +0100, Johannes Schindelin wrote:
> Hi Luke,
> 
> in a private Azure Pipeline (sorry...) I noticed an intermittent problem
> in the p4 tests on osx-gcc.
> 
> I would point you to a public log, but the Azure Pipelines support *just*
> made it to next, so I *just* set up a public one targeting anything else
> than my `vsts-ci` branch, at
> https://dev.azure.com/gitgitgadget/git/_build/index?definitionId=6. And
> those builds do not show that problem, so it must be a flakey test.
> 
> But maybe you can spot anything familiar from the log?
> 
> -- snip --
> [...]
> ++ P4TICKETS='/Users/vsts/agent/2.146.0/work/1/s/t/trash
> directory.t9833-errors/cli/tickets'
> ++ P4USER=short_expiry_user
> ++ echo password
> ++ p4 login
> Enter password: 
> User short_expiry_user logged in.
> Perforce db files in '.' will be created if missing...
> ++ cd '/Users/vsts/agent/2.146.0/work/1/s/t/trash
> directory.t9833-errors/git'
> ++ git p4 sync
> ++ true
> +++ time_in_seconds
> +++ cd /
> +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> ++ test 1549411312 -gt 1549411605
> ++ sleep 1
> Perforce db files in '.' will be created if missing...
> failure accessing depot: perforce ticket expires in 1 seconds
> Performing incremental import into refs/remotes/p4/master git branch
> Depot paths: //depot/
> error: last command exited with $?=1
> ++ true
> +++ time_in_seconds
> +++ cd /
> +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> ++ test 1549411314 -gt 1549411605
> ++ sleep 1
> not ok 6 - git operation with expired ticket
> #	
> #		P4TICKETS="$cli/tickets" &&
> #		P4USER=short_expiry_user &&
> #		echo "password" | p4 login &&
> #		(
> #			cd "$git" &&
> #			git p4 sync &&
> #			sleep 5 &&
> #			test_must_fail git p4 sync 2>errmsg &&
> #			grep "failure accessing depot" errmsg
> #		)
> #	
> -- snap --

I saw this on Travis CI a couple of times, and looked into it, though
I have no idea how p4 is supposed to work...  anyway, my theory is:

The previous test 'create group with short ticket expiry' creates a
"ticket" with 3 seconds expiration time, to be used in this failing
one.  This timeout might be just a bit too short when running the test
under high load, and it takes long enough to reach the first 'git p4
sync', so long that the timeout is (almost?) up, and then 'git p4'
errors out.

I'm not sure what the proper solution would be (assuming that my
theory is right, that is): increasing the ticket timeout to a "must be
surely long enough" value would require longer 'sleep' in this test,
which is not good.  I wonder why that failing 'git p4 sync' is
necessary in the first place, and whether it's really necessary to
test ticket expiration, but then again: I have no idea how p4 works.

On a related note, I think it would be better if these two tests were
squashed into one, so we would get the whole picture.

> BTW I find it very odd to see a `sleep 1` in the trace but not in the
> snippet (there is only a `sleep 5` instead, which I fail to see in the
> trace). Odd?

Intentional.  p4d seems to be prone to hang, to circumvent this
start_p4d() from 'lib-git-p4.sh' starts a watchdog process in the
background to kill it after a long-enough timeout is up.  These three
lines in the log:

> +++ /usr/bin/python -c 'import time; print(int(time.time()))'
> ++ test 1549411312 -gt 1549411605
> ++ sleep 1

come from that background process.

A couple of cleanup patches on top of your 'test_atexit' will
eventually get rid of it...  once I get around to clean them up :)
