Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0132B1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 15:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbeJOWsF (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 18:48:05 -0400
Received: from mout.gmx.net ([212.227.15.18]:45537 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbeJOWsF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 18:48:05 -0400
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MeP5b-1g0sDZ1VnD-00QESC; Mon, 15
 Oct 2018 17:02:22 +0200
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MeP5b-1g0sDZ1VnD-00QESC; Mon, 15
 Oct 2018 17:02:22 +0200
Date:   Mon, 15 Oct 2018 17:02:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Luke Diamand <luke@diamand.org>
cc:     gitgitgadget@gmail.com, Git Users <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/13] git-p4: use `test_atexit` to kill the daemon
In-Reply-To: <CAE5ih79cNkVVQOkaeJifSqkcp=HGmRb3a=jJC=g08iV8dYRyXg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1810151657080.4546@tvgsbejvaqbjf.bet>
References: <pull.31.git.gitgitgadget@gmail.com> <pull.31.v2.git.gitgitgadget@gmail.com> <3e2193a73de0b68d5a38f1792642c828f4aed1db.1539598316.git.gitgitgadget@gmail.com> <CAE5ih79cNkVVQOkaeJifSqkcp=HGmRb3a=jJC=g08iV8dYRyXg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uYYPYh/Ue0kNLNAufTfVfTHvMlGbwNXxHZMv000XckCcOGIvROw
 UqYaH1CPjblkY7WZObKIkO9BhZdCn0Ku5Z7MKB77WJHZfLGwaX16MAUk4dLdIif2FgQ1OmL
 kcFEBIJyM2u87iY7tKEZ5hA746dghci6qZBp/Q99F0a7wMZmqKWv6cm0yk2lXdpiwnu5Ghv
 m8H+b24bdoVMdU+hq9cSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LVP6QyszNA4=:0qFRfiAqQmdCmKV21lobz5
 3+FYJkyXdY7ekQAh6KCQaH5h8h6NITkGqHHdMWXd0m/3u/UpToYXLu68euSesNlju/lAWCzjo
 3xPOFm/HReLb+/vmlwaaMWgvXML9CoHdlRPbH2hhBRy5d+P/O1kMhtKuIXANxPXpERGATSty7
 z6T2aY8G078NIKoIwetkWsscmwHP3f0O0XPqQqqNGX+8QAhTn7nN3ecXnzuWxOm34XnlY0R7w
 R68TAh0VczNjpDKxGqWRwzTCUf99w6jghaJKmyFiXq0ADL3jihnNFT4H8UdcJwQrXvN6+XlBx
 BdaboPerEl3lna+8k/K611TfvzLKtuVjTeTH8ab0GcBEGn92DCeU6wxlkdcjG229iXALunjI9
 PL9vTzhG9hy4exx+TkUdodn9ezYsdw+ai+hYvDc/sV6t/yfEkaR0gZkAzimFroAOWYCB3HENn
 kLTtaQ1tP2GLC2Smz4XC/PjdCDd0oSRk1Rzw9Ujet824YkYVIfabyOvqTHbX39SVRWdJOtnWl
 p7h9lt/cgp8rln33qmJA7CcQp7T1TboYNGNingtSSIgDcERt5zF4ZQrEdBTbAWmi9MgpILiz/
 80gmVJwvL/RH1moJI6rJDaF1jhX88w2tqv6278dhfSBqoPtRQwwnUUGCB9/1royXZZO4l16O1
 7uvyPagSzLcFyC0IJ2JtRewNuKscqRVgUMUTXnStrNhOm6GTyo5INc0lRZtwF9TvMeXIWnd+X
 b8M8Tul8xiMAwgI5qnS3x4VBeKed8b6N8lPyPiE26RMWYPEN/t0EbyZkevPlannE/S/nuL1TA
 g7f8wdOC4ZIPGlsUIrdk/wg1YYhNkCurwBeM9f7DZ6GXxiv5ME=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Luke,

On Mon, 15 Oct 2018, Luke Diamand wrote:

> On Mon, 15 Oct 2018 at 11:12, Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > This should be more reliable than the current method, and prepares the
> > test suite for a consistent way to clean up before re-running the tests
> > with different options.
> >
> 
> I'm finding that it's leaving p4d processes lying around.

That's a bummer!

> e.g.
> 
> $ ./t9820-git-p4-editor-handling.sh
> <passes>
> $ ./t9820-git-p4-editor-handling.sh
> <fails>

Since I do not currently have a setup with p4d installed, can you run that
with `sh -x ...` and see whether this code path is hit?

 test_done () {
        GIT_EXIT_OK=t

+       test -n "$immediate" || test_atexit_handler
+
        if test -n "$write_junit_xml" && test -n "$junit_xml_path"
        then

> And also
> 
> $ ./t9800-git-p4-basic.sh
> <starts running tests, but I get bored easily>
> Ctrl-C

Oh, you're right. I think I need to do something in this line:

	trap 'exit $?' INT

in t/test-lib.sh, something like

	trap 'exit_code=$?; test_atexit_handler; exit $exit_code' INT

would you agree? (And: could you test?)

Thanks,
Dscho

> $ ./t9800-git-p4-basic.sh
> <fails>
> 
> $ ps | grep p4d
> 21392 pts/1    00:00:00 p4d  <<<<<
> 
> 
> Luke
> 
