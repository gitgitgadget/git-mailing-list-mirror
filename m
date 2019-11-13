Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88BCB1F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 00:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfKMAHz (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 19:07:55 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41092 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMAHz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 19:07:55 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so243114wrm.8
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 16:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lQHROV5mFzQa7CDYohoOfJ5mzTH/1yF9LbG9j8iTbsw=;
        b=lDmd1qmfy52SFaY1+EKh1bg4P5p6EBpNjLfBp5MPQWpO0A3TeBJ6bFBNcMFvuV13B5
         CQNNiRxKg/LyFH0dTNe+NfGhR9n1HBOgQE9W4q8pv0c4n/tScDpsWfmf1Fh2Kbkk3JR0
         3DdM+y3js/J5Uqh4VhTJW6HWxjviH+RnL/DbzvBw0hn5H8IElzb3OL8Af2iB/yJ3w/PS
         IFue3OPr2YqiggyR41hOmAc6OImeVRxiJMVDjJN3Zs3kRs3p2vCCNUl+5cIiseY86Jtd
         6qG0HxhxmMsqq38Ujcm/WgHfO7TLQX+gSUVn7UWXgABy0toXczv3Z7wLbpOkejKNgQJ0
         flbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lQHROV5mFzQa7CDYohoOfJ5mzTH/1yF9LbG9j8iTbsw=;
        b=T2eFNALQ02rRy7QW3PVmFDDTXrpelHT5+hzxfZ9X+yE6SM/sXx1zoPan4q53VLGM77
         REbwcsJhg+Nf8rNqd/1vjmt1Gp1etZwK6dxI9huYd23wCvP8eI0L+ZXtPOPjVsjAtNeb
         BaNZ1dgWjIlk5N2zJyP5p+N/KEoMYQJgizv2JdwSVzhqYLnwLfZ899S3WRpP1wfQeRds
         7LiinkEPirlFI5XSS2J5bYhf7pJPBqb2Nq3NYrgWI1Su98BAsE1ko4QuqWA6WqRglmWa
         zazLEwXI3adLlCG9V1AwMjA5DktrjkMKNhwnPm64MfUslqvlco13hQPZb0PDOpjdUoMC
         /4KQ==
X-Gm-Message-State: APjAAAVeol/bGaKkeyF/Ua8Q6dGBDImBTN7HiavrcxM+MogVgDNthQa4
        fxRUga1gJ3z0sraFb2qn5N8=
X-Google-Smtp-Source: APXvYqwRrBXkzIpWTTAK7E0/WwTjPqKNFG6OBZNVnQOKnkuT8sC+HypSLQrWAAF6tN+Dzl4/EYDB4w==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr8587wrk.93.1573603670889;
        Tue, 12 Nov 2019 16:07:50 -0800 (PST)
Received: from szeder.dev (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id w18sm613083wrl.2.2019.11.12.16.07.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 16:07:49 -0800 (PST)
Date:   Wed, 13 Nov 2019 01:07:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: do people find t5504.8 flaky?
Message-ID: <20191113000747.GQ4348@szeder.dev>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
 <20190423030254.GA19604@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190423030254.GA19604@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 11:02:54PM -0400, Jeff King wrote:
> On Tue, Apr 23, 2019 at 11:45:17AM +0900, Junio C Hamano wrote:
> 
> > I have been seeing occasional failures of t5504-fetch-receive-strict
> > test on the cc/replace-graft-peel-tags topic, but it seems that the
> > fork point of that topic from the mainline already fails the same
> > step #8, only less frequently.
> > 
> > The push is rejected as expected, but the remote side that receives
> > the "push" fails and the local side does not leave an expected
> > output we expect when the test fails.

I've seen it fail a few times on Travis CI, but it's rare, much rarer
than our "avarage" flaky test failures.

The subsequent test t5504.9 is flaky as well: the two tests are
essentially the same, they only differ in the configuration variable
that enables the fsck checks.

> No, I haven't seen it fail, nor does running with --stress turn up
> anything.

I can reproduce the failure fairly quickly with '-r 1,8 --stress' (and
nr of jobs = 4x cores).

FWIW, I enabled GIT_TRACE_PACKET and the relevant part of the failure
looks like this [1]:

  + test_must_fail env GIT_TRACE_PACKET=/home/szeder/src/git/t/trash directory.t5504-fetch-receive-strict.stress-8/trace-packet git push --porcelain dst master:refs/heads/test
  remote: fatal: object of unexpected type        
  error: remote unpack failed: unpack-objects abnormal exit
  error: failed to push some refs to 'dst'
  + cat trace-packet
  packet: receive-pack> 0000000000000000000000000000000000000000 capabilities^{}\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.24.0.1.g52e0cf1d06
  packet: receive-pack> 0000
  packet:         push< 0000000000000000000000000000000000000000 capabilities^{}\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.24.0.1.g52e0cf1d06
  packet:         push< 0000
  packet:         push> 0000000000000000000000000000000000000000 a7943252b7679bec6b9679dbc7863c08610ac2bc refs/heads/test\0 report-status side-band-64k quiet agent=git/2.24.0.1.g52e0cf1d06
  packet:         push> 0000
  packet: receive-pack< 0000000000000000000000000000000000000000 a7943252b7679bec6b9679dbc7863c08610ac2bc refs/heads/test\0 report-status side-band-64k quiet agent=git/2.24.0.1.g52e0cf1d06
  packet: receive-pack< 0000
  packet:     sideband< \2fatal: object of unexpected type
  packet: receive-pack> unpack unpack-objects abnormal exit
  packet: receive-pack> ng refs/heads/test unpacker error
  packet: receive-pack> 0000
  packet:     sideband< \10028unpack unpack-objects abnormal exit0026ng refs/heads/test unpacker error0000
  packet: receive-pack> 0000
  packet:     sideband< 0000
  packet:         push< unpack unpack-objects abnormal exit
  + test_cmp exp act
  --- exp 2019-11-12 23:40:33.131679990 +0000
  +++ act 2019-11-12 23:40:33.203680114 +0000
  @@ -1,2 +0,0 @@
  -To dst
  -!      refs/heads/master:refs/heads/test       [remote rejected] (unpacker error)
  error: last command exited with $?=1
  not ok 8 - push with receive.fsckobjects

Note that 'sideband< 0000' is not the last packet.

For comparison, here is the packet trace from a successful test run:

  + cat trace-packet
  packet: receive-pack> 0000000000000000000000000000000000000000 capabilities^{}\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.24.0.1.g52e0cf1d06
  packet: receive-pack> 0000
  packet:         push< 0000000000000000000000000000000000000000 capabilities^{}\0report-status delete-refs side-band-64k quiet atomic ofs-delta agent=git/2.24.0.1.g52e0cf1d06
  packet:         push< 0000
  packet:         push> 0000000000000000000000000000000000000000 38af865a0f3f0170ef7a18edcb3088d3f7961b21 refs/heads/test\0 report-status side-band-64k quiet agent=git/2.24.0.1.g52e0cf1d06
  packet:         push> 0000
  packet: receive-pack< 0000000000000000000000000000000000000000 38af865a0f3f0170ef7a18edcb3088d3f7961b21 refs/heads/test\0 report-status side-band-64k quiet agent=git/2.24.0.1.g52e0cf1d06
  packet: receive-pack< 0000
  packet:     sideband< \2fatal: object of unexpected type
  packet: receive-pack> unpack unpack-objects abnormal exit
  packet: receive-pack> ng refs/heads/test unpacker error
  packet: receive-pack> 0000
  packet:     sideband< \10028unpack unpack-objects abnormal exit0026ng refs/heads/test unpacker error0000
  packet:         push< unpack unpack-objects abnormal exit
  packet:         push< ng refs/heads/test unpacker error
  packet:         push< 0000
  packet: receive-pack> 0000
  packet:     sideband< 0000

Note that 'sideband< 0000' is the final packet.

Whether this confirms Peff's theories below, I don't know; sideband
always makes me dizzy :)

FWIW, I could reproduce the failure on ef7e93d908 (do not override
receive-pack errors, 2012-02-13) as well, i.e. on the commit that
started checking 'git push's output.

Hope it helps.


[1] Note the lack of a dozen or so '-x' trace lines from
    'test_must_fail' and 'test_cmp' ;)  Current WIP patch at:

    https://github.com/szeder/git/commit/52e0cf1d0695c107142e36905dfdbaceacdacf8c

> But looking at the test I would not be at all surprised if we
> have races around error hangups. I believe that index-pack will die
> unceremoniously as soon as something fails to pass its fsck check.
> 
> The client will keep sending data, and may hit a SIGPIPE (or the network
> equivalent), depending on how much slack there is in the buffers,
> whether we hit the problem as a base object or after we receive
> everything and start resolving deltas, etc.
> 
> I think after seeing a fatal error we probably ought to consider pumping
> the rest of the bytes from the client to /dev/null. That's wasteful, but
> it's the only clean way to get a message back, I think. It would also
> give us the opportunity to complain about other objects, too, if there
> are multiple (it might make sense to abort before resolving deltas,
> though; at that point we have all of the data and that phase is very CPU
> intensive).
> 
> -Peff
