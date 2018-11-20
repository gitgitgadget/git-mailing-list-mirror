Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 176E71F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 00:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbeKTKoP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 05:44:15 -0500
Received: from mail-yb1-f177.google.com ([209.85.219.177]:42870 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbeKTKoP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 05:44:15 -0500
Received: by mail-yb1-f177.google.com with SMTP id o204-v6so48145yba.9
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 16:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hbOFLI6q/46SQ0J3g0Tidbd+SzztjLAGt+6bQpJaEoE=;
        b=BhhraPYI3XY2tDI8Ww0E0daDCSRBULWKZ3O+zcbxmSQ6nxy0fP2PRXmaYfZOozS4rk
         gcMoL5aLq2n+FTx3wKjJmeK/mVGwrc91i9f3OsVfcAfndY/kMm92ctWkcqCLVrtKK0ZB
         TXJy0On6JuNXfu3H5fQwvideErMhfQG5yE8Ib/ZR6o62EyldcP9yCeD/LYXgv80ODrad
         3Fxqm43oNQ1o2MsjQdEkdIYJPvZ8AjCD3dUbfammEkQyoqrNlMMP2lifDESWDXPzhvAZ
         twckYRbdE9wXzknFAY8iYfs3A7sKp+wjoS1i+BHJg1xHwMPlX1Pn1H41wVL8vzER9Pzh
         Ibdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hbOFLI6q/46SQ0J3g0Tidbd+SzztjLAGt+6bQpJaEoE=;
        b=Eh7b6VdtLzG1Kcu3Yz9Vz3wtDy9EpAgyXlKQdCAROc8wNme/aygEpCP1oeHfWLBA/I
         jKclM2Inehrul2j8L103BR5IarAxup8ufokBlv29PJoQKiPPfAWC9rjJzMgXgh9FDBHm
         B38vlYXdH6gEWJJhNGyjJMdWaqqKWkzYW4IXPmiaxv8/27mDKfPdMTcfRG1Pp57C95sJ
         y2IMHEBAUj80X6kRSgQoRFvm9CHOwOVgOcM5jdKB1wIBOjUo3VctOUIVb907sBeqAgJu
         16M/8ujOkV8kiAbAIuQsEVdD5RXHXmBSxbnvxpY64ZDnKAOEDXYoSudtYxEMTD/WnTk9
         C5Qw==
X-Gm-Message-State: AA+aEWZ/DhbhEIy0WkqpbICB2hA7Ce9l9wUZLEQJluiENymRI2ingAu/
        R6vEz2SiBXcRuW0MOXBclbtEHNo1P5c/D0DKSmk=
X-Google-Smtp-Source: AFSGD/XtUzhv7KqPep922wPoZt7PJxc60AwWcutdgr6S9Ht4bvPevaWlBQfJ/iqvWfANR+y7ZEAg4y7indjLHTTq32o=
X-Received: by 2002:a25:2ccb:: with SMTP id s194-v6mr11640766ybs.415.1542673078292;
 Mon, 19 Nov 2018 16:17:58 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181118154124.GA21680@tor.lan>
 <CAAXzdLXSJU5bC_D1Q_gCWqKG7mcdcAvRkiYzano-VsrRRxazDQ@mail.gmail.com>
 <20181118171525.GA25854@tor.lan> <xmqqsgzydj6n.fsf@gitster-ct.c.googlers.com>
 <005801d47fad$345d5a70$9d180f50$@nexbridge.com> <xmqqbm6leo7g.fsf@gitster-ct.c.googlers.com>
 <bddb9e06-2688-c459-9467-a3f0978866f9@web.de>
In-Reply-To: <bddb9e06-2688-c459-9467-a3f0978866f9@web.de>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Mon, 19 Nov 2018 18:17:50 -0600
Message-ID: <CAAXzdLXCEeZdkCXT+-0n=Fn7_=Nz5cm+6xr0w-cd6B1om028uA@mail.gmail.com>
Subject: Re: Cygwin Git with Windows paths
To:     tboegi@web.de
Cc:     gitster@pobox.com, rsbecker@nexbridge.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 11:21 PM Torsten B=C3=B6gershausen wrote:
> If nothing works,
> it may help to add some fprintf(stderr,...) in the functions used
> by 05b458c104708141d2f:
>
> strip_last_component(),
> get_next_component()
> real_path_internal()

I didnt see any "real_path_internal" in the current codebase - however i ad=
ded
some "printf" to the other 2 and got this:

$ git clone git://github.com/benhoyt/goawk 'C:\cygwin64\tmp\goawk'
get_next_component, next, []
get_next_component, remaining, [C:\cygwin64\tmp\goawk]
Cloning into 'C:\cygwin64\tmp\goawk'...
get_next_component, next, []
get_next_component, remaining, [C:\cygwin64\tmp\goawk/.git]
fatal: Invalid path '/usr/local/cache/git/C:\cygwin64\tmp\goawk': No such f=
ile
or directory
