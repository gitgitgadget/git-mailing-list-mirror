Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE05E209B4
	for <e@80x24.org>; Tue, 13 Dec 2016 21:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754130AbcLMViF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 16:38:05 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:33081 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754092AbcLMViB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 16:38:01 -0500
Received: by mail-pg0-f44.google.com with SMTP id 3so40998pgd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 13:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzOdAfuOoCmcgjjai4ilH1Ywv+V7pL/FD1Uy6/U8vas=;
        b=YpWl8Ap8yI0HIBBBd2PSbskySyhCtAlRzOcLu1tTVp7mK+GQ7reMe1S47L8yzu4cJY
         LvwoNgVNA4jP3uJ+xsbOfwPzVn5K3tKPe8IVbHM6bqwXc/39xLJ31jvEqNrwU976YBJ5
         /PNcqPIAYtxpJ5vX4cXubGu2sZ17SlSuMlXq9vvQEtXQJus6m3MvWVE3Jgq2/0rNXA6o
         2x5DQVC4T9XQT3nNqPwoQMJZlxF3z/E0E0Y6RVoCBs3ccuDPL2+Jv4K+o6GDx+f6A2oL
         YnP4VThJsPEiCVIVf6qNPg81/28UQQvDyhpGkpVDEgY9y/nQ4lKPtEifC4W0fVaC8/x7
         1tag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzOdAfuOoCmcgjjai4ilH1Ywv+V7pL/FD1Uy6/U8vas=;
        b=WBJUZIOX27BJ1iCwBZfj2xakMCwRCC9o28nIqMbXq4mXkQQqB7gMn9ZMiw5+5qIyGy
         s0y0stzHPytOy7MuzWaqhCBo43GoCcpaUZgz0a4xrTBAgiJek0a39s9oqRKWsbWmC6Bn
         +yIBXemMiCFYZ0W9qAYoicUGqX9GnlzPf4lttnTizUppAfrwX8FJvwp46DhzNPCEe7R7
         0xvgq7z/y8pGBibTMnCCko0ZTz/YOmbcLsWkj1wGPl0A0yNY1I/Ei1r2iRHyhWK5pKiE
         +mHlQYlg0BRp6rIKgFpgwGMctNdpRRTrSQtEsLneYGk2mxsqxZlO/EI6B+lX6qRm74wI
         6ShA==
X-Gm-Message-State: AKaTC00E9UlJX7Nok2gqMio1QGurkVb/PxcSIbhSnlVJjpe3Apv+vprR7F6hteKqzCK2xx4G
X-Received: by 10.99.139.199 with SMTP id j190mr180317924pge.115.1481665028986;
        Tue, 13 Dec 2016 13:37:08 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:e076:1f78:6a8d:c0a])
        by smtp.gmail.com with ESMTPSA id p68sm82185311pfd.11.2016.12.13.13.37.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Dec 2016 13:37:07 -0800 (PST)
Date:   Tue, 13 Dec 2016 13:37:06 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
Message-ID: <20161213213706.GA4121@google.com>
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1612131839220.3147@virtualbox>
 <xmqqeg1b39yi.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeg1b39yi.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > ok 13 - grep tree and more pathspecs
> >
> > expecting success: 
> > 	git init parent &&
> > 	test_when_finished "rm -rf parent" &&
> > 	echo "foobar" >"parent/fi:le" &&
> > 	git -C parent add "fi:le" &&
> > 	git -C parent commit -m "add fi:le" &&
> > ...
> > 	test_cmp expect actual
> >
> > ++ git init parent
> > Initialized empty Git repository in C:/git-sdk-64/usr/src/git/wip3/t/trash
> > directory.t7814-grep-recurse-submodules/parent/.git/
> > ++ test_when_finished 'rm -rf parent'
> > ++ test 0 = 0
> > ++ test_cleanup='{ rm -rf parent
> > 		} && (exit "$eval_ret"); eval_ret=$?; :'
> > ++ echo foobar
> > ++ git -C parent add fi:le
> > fatal: pathspec 'fi:le' did not match any files
> 
> I think !MINGW prereq is missing?

Yes the !MINGW prereq is missing on this one test since the test uses a
filename with a ":" which isn't supported on windows.  I have that
change made in my local grep branch but I haven't sent out a reroll of
the series yet due to the underlying race-condition that existed (due to
the way realpath was being calculated).  I'll send out a reroll of the
series once the discussion on bw/realpath-wo-chdir has concluded (as
the grep series is now dependent on it).

-- 
Brandon Williams
