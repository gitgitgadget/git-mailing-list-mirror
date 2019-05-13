Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824311F461
	for <e@80x24.org>; Mon, 13 May 2019 13:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfEMN3l (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 09:29:41 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43936 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbfEMN3l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 09:29:41 -0400
Received: by mail-ua1-f65.google.com with SMTP id u4so1345673uau.10
        for <git@vger.kernel.org>; Mon, 13 May 2019 06:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JYINq3iRbdyNjuT6/PI3zHUwlNln5kFdv6pGUg2+L5Y=;
        b=auQPNuZgr2vWQVYv6miKX/xjPndiyzK4mlJO2lJI7gD42alkvCeoo91BSzfvNyXWMD
         AgL/L22G7KZicM/0upDwwnpKCV7Vj6qFMkuYCVrGr8K88WOJeRmtYHnJktseC0V1WBYH
         IVBeg+BamkFSft7gnGzQHTHd+y0YEVEkCMSuTYoQjvBbCNP119zHrJES/gT62u13mK4E
         +EhNGqp7NUL2g12lJ+XH6ZpuT5l7PaYf23b/PVb52gRQfNe8xLoxxfY3LSIaiVCRLWyT
         RFN0n2f7IhMhRv2FLyIGV2rctfbpbnLwUa9d78OhsOA44Rb7W+F5fxPmutyPRq2goQTH
         fPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JYINq3iRbdyNjuT6/PI3zHUwlNln5kFdv6pGUg2+L5Y=;
        b=bf4KQEZcTbKfQX6KpH7ysG8j1s1ge6JvV6mpd8ThN4zxyGcY5kcusPKhCNpAumd1uJ
         8fzyFoI7p4qqNpMcjq+59dx5vtzbiItjpBeRPs5ameXUSwOu1qNMgneP0+f3y23rqrV4
         iO97+AYyTHxbyT5CuwMOBztN2VyrdII97LCPYqKqwnnAIL6pQZPsjaP6DNkPIjlmYj/O
         74wNasmfL3RNHOwZXlKV4R+VZ2BL5+SiQoJ87pNKXhGz39ATxODgbGboOD8han+QAfu9
         jCiHvJ8DweAR6SDbjiLbU0cqfnE4VeTMISNvsb2Ah6F62sJszhIlK2i+cHPVGOLOZNx9
         U+rw==
X-Gm-Message-State: APjAAAUHnGHllcq4AmsF9E6NYyP6sj0ZpGl4Aytp665c4Vp6Py7LiZ1e
        DiIyZC23iAJblZPhBlAvaMfgnk2nDGMjBIh/E80=
X-Google-Smtp-Source: APXvYqzqFILqopHl/ONbefQ89ch1Q7zYaKbAvuakn6CS324HBSexwq+LtCTxC+9c17V1nKJBV81vZ3Xeu5/0QYkUqyk=
X-Received: by 2002:ab0:3058:: with SMTP id x24mr10386852ual.95.1557754180073;
 Mon, 13 May 2019 06:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com> <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
 <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1905131219490.44@tvgsbejvaqbjf.bet> <20190513125635.tntxhjbar2eold2i@tb-raspi4>
In-Reply-To: <20190513125635.tntxhjbar2eold2i@tb-raspi4>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 May 2019 06:29:28 -0700
Message-ID: <CABPp-BGbq3EJfpw-NykHM5TJdkpmqmttHYWonBP5kydV9PwTBg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 5:56 AM Torsten B=C3=B6gershausen <tboegi@web.de> w=
rote:
>
> On Mon, May 13, 2019 at 12:23:29PM +0200, Johannes Schindelin wrote:
> > Hi Elijah,
> >
> > On Sat, 11 May 2019, Elijah Newren wrote:
> >
> > > [...] the craziness is based on how Windows behaves; it seems insane =
to
> > > me that Windows decides to munge user data (in the form of the comman=
d
> > > line provided), so much so that it makes me wonder if I really
> > > understood Hannes' and Dscho's explanations of what it is doing.
> >
> > It is not the user data that is munged by *Windows*, but by *Git for
> > Windows*. The user data on Windows is encoded in UTF-16 (or some slight
> > variant thereof). Git *cannot* handle UTF-16. Git's test suite *cannot*
> > handle UTF-16. So we convert. That's all there is to it.
> >
> > Ciao,
> > Dscho
> >
> > P.S.: Of course it is not *all* there is to it. There is also a current
> > code page which depends on the current user's current locale. We can
> > definitely not rely on that, as Git has no idea about this and would qu=
ite
> > positively produce incorrect output because of it. So we really just us=
e
> > the `*W()` functions of the Win32 API (i.e. the ones accepting wide
> > Unicode characters and strings, i.e. UTF-16). I don't think we can do
> > better than that.
>
> We can actuall feed valid UTF-8 into a test case.
> (Remember that shell scripts need this octal numbering, see
> t/t0050)

Sure, but that's not useful here.  I need to feed both valid and
invalid ISO-8859-7 (or anything *other* than UTF-8) into a test case,
in order to verify how git handles reencoding from something other
than utf-8.  I did something like what you proposed originally, but
since it wasn't utf-8 it caused test failures on Windows.

Elijah
