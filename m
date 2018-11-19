Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52CA1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbeKTEka (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 23:40:30 -0500
Received: from mout.web.de ([212.227.15.14]:49517 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730083AbeKTEka (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 23:40:30 -0500
Received: from [192.168.178.36] ([79.237.241.17]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MEVkf-1gE1O43huL-00FnTr; Mon, 19
 Nov 2018 19:15:45 +0100
Subject: Re: [PATCH/RFC v1 1/1] Use size_t instead of unsigned long
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
References: <20181117151139.22994-1-tboegi@web.de>
 <c09938cf-7631-ef89-d8fc-d952f9b121c8@gmail.com>
 <xmqqwopadkf9.fsf@gitster-ct.c.googlers.com>
 <f0c0e2e8-717d-9973-5533-8b806474e119@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0e38e87d-0b8a-054d-1ae0-37a225845e3b@web.de>
Date:   Mon, 19 Nov 2018 19:15:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <f0c0e2e8-717d-9973-5533-8b806474e119@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+A387DGWEXH9qVhCTCFMbHRi48/swYfHrg/GXHFlvox1F77/LeB
 jNgWAY3b7TvI7sZyzcfAWXjOfoKjO4ae/8g1YpwjhrB+tZPxcGNaBC542kjx4loHAgV09ft
 +PscRRz7IlEij8k1tdiIOO4gy10mDLk3c9KZOmvHFRvHjmfCJ5rnWF9U3JDnyq4nyWk4mns
 TMMl8fmlgvRw56dHXA3GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2FqLj8FRx1M=:dbNUO0Df4IHQsp5qvB5OzD
 jHuAj8Q0A0875Y/x9eRN7iccWM1KyFMwSIMlZOyGq6zT/5Da11dHeqXxtfeNTbJq2fZ0Dzo5U
 qPszExzFJJpt4paoz3L6bEJllvExbpUTYRVQmgZPk7FgXi+w5b9PoVEOdTNoy1pqbWymtyWUV
 fjTA7AWCFTUXUHNI/Wl3Om1oEToW/fi4bJJlWFJVG/O/ZFfTWy3v5qxoIoAvwaBvx27/mqPCZ
 J+c3XXtkxxzM8DWphfVNYezNctMcNVxykO4KFCgDnt3LRm7bzdh0UxosU3e40T0B2ki/FQYsy
 c5SuFb5ysT+/3ZeHQ9+Yfava/iLMcjiFvJhebmfjiosgvgQF86PxbQSeOXC/InXZUwd37+w/o
 /XUOFEADOOpd7B+Pb+Yla8Yc/j6hn4uYdhFyyw7koH7owNYFTLi+k+V+Y7WtBLH7Tv24vPrJy
 dpioTyaHDAkvc5i8cshs0sYPrT0d1o0qC8YU/OQfSzTghfLgeqoJYFOPj8xEZ1ynkZj5Oznkh
 wArq1Ne0XJ92UP6nRMZKIs+6jBnCE/7zW4w7IBLRjdfJk+jwI5OXt5Qy6rvNzI4YeX9IgUz/s
 q52KrIpugO1Zl36BAjSeCztUuk/ffAF3eRhe0Vs8mGcsjgvoBGZd5fWgdUmtbs5SpQnPxFJGv
 AuvdavPcTzU65eh1vgZfx3Vc/EYtAnnPjeGyRlrq5yAxZfWN2VfaHQt4VjU4MiaoN+5hH3QNj
 4ZmdVhLzc125V4eRaIk4snuzH+/VuZQBm+soJP81G+WQspXOTT327/vGVq8lrGrwIGWFT/pzY
 9cYFLIExshS9vAIzRHZubzuzmvvhC1SfPOjP+XhZKOWgqA7QhdZ51UVOov3aR9S4jVjrb7xpy
 QIf8C2EV9j3xxEWaZs9xwW1gO1P+1LAh9xUKCKnK+wVE+JrvY4FhkWPj0Iie0y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.11.2018 um 06:33 schrieb Torsten Bögershausen:
> The archive-tar.c is actually a good example, why a step-by-step update
> is not ideal (the code would not work any more on Win64).
> 
> If we look here:
> 
> static int stream_blocked(const struct object_id *oid)
> {
> 	struct git_istream *st;
> 	enum object_type type;
> 	size_t sz;
> 	char buf[BLOCKSIZE];
> 	ssize_t readlen;
> 
> 	st = open_istream(oid, &type, &sz, NULL);
>                                       ^^^^^
> 	if (!st)
> 		return error(_("cannot stream blob %s"), oid_to_hex(oid));
> 	for (;;) {
> 
> The sz variable must follow whatever open_istream() uses, so if we start
> with archive-tar.c, we must use either size_t or ulong, whatever
> open_istream() needs. Otherwise things will break:
> archive-tar.c uses ulong, open_istream() size_t, but we are passing pointers
> around, and here &ulong != &size_t
> 
> If we only update open_istream(), but not archive-tar.c, then
> things are not better:
> &size_t != &ulong.
> 
> I don't have a good idea how to split the patch.

sz is not actually used later in that function; this change can
be done independently of any other ulong/size_t conversion in that
file.

Hmm, looking at that call I wonder why open_istream() doesn't return
type and size in the struct git_istream.  To make it match
read_object_file(), I suppose.  Perhaps it's an opportunity to
improve its interface?

René
