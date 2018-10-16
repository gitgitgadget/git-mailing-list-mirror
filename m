Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FD91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 08:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeJPQp5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 12:45:57 -0400
Received: from mout.gmx.net ([212.227.17.21]:53923 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbeJPQp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 12:45:57 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8axL-1fQAG60aLj-00wGnB; Tue, 16
 Oct 2018 10:51:09 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8axL-1fQAG60aLj-00wGnB; Tue, 16
 Oct 2018 10:51:09 +0200
Date:   Tue, 16 Oct 2018 10:51:11 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     gitgitgadget@gmail.com, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
In-Reply-To: <CAPig+cQp1jpcQGjvMkCAypQZO_95R5yQDT8Fm=Du2pBOe4Pgbw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810161049100.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com> <CAPig+cQp1jpcQGjvMkCAypQZO_95R5yQDT8Fm=Du2pBOe4Pgbw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:maFBOjdNywHC7pIDoGwaJjGKFkos2RDd0eYJlzKzFAx3TVP1dsL
 PoO2YinIuWpcy3N6fYbKYs5qnUdYj5U5DuLrQcZvnWrDE8FtXbzVnECt0o8j/DmZQGisiVn
 epTW7PvmVM77is1uzMH3sB+Dzn4y7a9f+m9N7kYNF31T5Z7nL9AExJElCPcPK+3vEklcW25
 14iNbEDstJIw4YgVUY13Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4TureG9TJyE=:kIwjteqhjBKbI+Qm6u8jpo
 21ijUD9GkRUtUZCYlQNMQ5R9ujZM5WnZ4Ml57mVFzMsjM60XJHhsXY74MvfZ8ZQARgNkRv2UO
 dBRnZ3szRS28CTU9uSC1rcaJkmTdypcdWq5IKpfaQ2L1qUfN2BGBt0mPzMOfPDMoXQIzn6aMG
 S2EaPJx5NDI6c8MHxwuuFBGTsqUDn7Zy0U46Fp0zdgYaJHc6y0eUnsZIwHMIoAu/m95mf3q2y
 uV77isqMX07mIBU+4981DK1hIUJ/ZVjxmxRuMcYnQW/zVvJLpJqhl/IsFJPmWoS0/9PQFYPxL
 Au472dJn+qTqZwP845MsAHMpObTk3yh3e2CM3De2l9JI1Uf1f3IXz6ArURoCrz6S6AtT/WnOY
 +ZwIwW9J+za43PRHHh+gapvL7U8yuTDCFxe43yKI0hkXln/WyveMwCsvWIJxW+5SlPYaomEtD
 zPGX0K9FNCAGZlrZt3zecfjuGYq3LItkgBiEX/3BpoxAPsf+3pSdg7AfVvJZYjCJXv0jIAdxE
 u8TpmsruNziFsKOJwAoTMdopWhSLBqgckxbrN+OG/BmOnzQgoTlX2Qqfv5LBh1WUEGUJN0fcv
 SGIhYvSUcefbFVx7RZdT02M2NtQd1SQKE/ZS2ovXXzVGzoDfTNp6196ZP24Tz9najP17X/27q
 WyaHV2TPXEJAkAvJ7oFG65dwOu4ACG0V4SqvVH2Wq3R1V1ffc9eaPIkMG04I/gcDIrVc4pVmE
 xY0qFLBo15Il/QgIHt8wZI6nMFJVxqtMY3niOD3fYpwAM953VZkjhEcSo1jDGqUXuNwHHAaEb
 Cz+zDrxvoxosKqMLItSbsQ9GVA/mmK/XlVnJNGO8bCzPVJygQk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Mon, 15 Oct 2018, Eric Sunshine wrote:

> On Mon, Oct 15, 2018 at 6:12 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > This should be more reliable than the current method, and prepares the
> > test suite for a consistent way to clean up before re-running the tests
> > with different options.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
> > @@ -134,6 +134,7 @@ check_sub_test_lib_test_err () {
> > +cat >/dev/null <<\DDD
> >  test_expect_success 'pretend we have a fully passing test suite' "
> >         run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
> >         for i in 1 2 3
> > @@ -820,6 +821,7 @@ test_expect_success 'tests clean up even on failures' "
> >         > 1..2
> >         EOF
> >  "
> > +DDD
> 
> Is this "DDD" here-doc leftover debugging goop?

Oy, oy, oy. This is definitely a left-over from debugging (as you can
imagine, it is pretty slow to run t0000-init.sh on Windows, and if I add a
test case, the development cycle is much faster with the trick you see
aboive). This left-over even made it into Git for Windows' `master`
branch! (Which is the reason I missed it before contributing v2).

Will fix,
Dscho
