Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D4A20248
	for <e@80x24.org>; Tue, 26 Mar 2019 20:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfCZU07 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 16:26:59 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40944 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731824AbfCZU07 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 16:26:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id x12so16252675qts.7
        for <git@vger.kernel.org>; Tue, 26 Mar 2019 13:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platin-gs.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUsSU8XAx/C61w+WZGK/TDSTKm9q/86W1rDXInhss/0=;
        b=ad80YDxZQcjKWbxfWZsFsQ76z5t2DQm14BL73RylZ7yZkldmid2AODATvLm30J8PDQ
         yEw1tKPLuwrWjQKD+xaDiUFDz1GBN3C9I6IoUxmVxzX4xKEhOq6E2bFo+Fl8Yr7vGv2G
         7hZd0AYXyCyhJmiEU9JBU9YV2AWEmMm6KyXTFCAvUHb6itHuKS362qhuZhf0Ncmf1j5Y
         V6bM15j6odqpMkarCHLaF7lHpxDQHOVuzYf4zjbSvDcPDhuboaG0nmhkuiTWCFnUw/e0
         MvKw5D4C1DH4ZxbfJyolz+Dm+uDCb5shge3a69Z4Zb57TDIl1060hbpXD1tyLGls5x65
         PWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUsSU8XAx/C61w+WZGK/TDSTKm9q/86W1rDXInhss/0=;
        b=GSol8bV1MxHgFybDBbPKE/KW4rHJT061+XqyQindXKUm89rW/IVC2nhX35FKO9IVj/
         2lmklF/n7jFvcmLO6MbCFplSAZbVNWoE6XY6DGiYKVw9jZrfctQ5/MRI7zcMbCjAWef8
         TZlzw0sAM1yYKP1fasg7ZiYlVUQEB9PdW4q/pX3eJcsnFnlQeSyB+JBVTLZDHRKFmdtJ
         oaZBX8iMVE6XksdECyKYGhwuMK+WeYv4ec63qixlIugCgyoo42rncZhx28F0BRJs4HSL
         /sIgZtYUGmtMIVDUB6yOr19N5yLUAB5b8aVN0a+PyU5wZ1n5/WqOVaNgQM8TxKBSCNpz
         BNxQ==
X-Gm-Message-State: APjAAAXlgPxTsF8dbRmqJMRageoaTN8knuE1jRuyyXKUq/JVM8OBqksa
        vBE6eaqd+N3n3uKFrqi0r7KihNcR82rxszrVpjM=
X-Google-Smtp-Source: APXvYqzIRMtgZNLWpec731FmonfJgXzmAlX5h38YFN2TRsZofG08ddX3I5XyAtJ45y4vW7MsHzN90H/YyeQYfSciyzQ=
X-Received: by 2002:ac8:f5c:: with SMTP id l28mr26960805qtk.249.1553632018100;
 Tue, 26 Mar 2019 13:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <20190325233516.GB23728@sigill.intra.peff.net> <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
In-Reply-To: <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
From:   Michael Platings <michael@platin.gs>
Date:   Tue, 26 Mar 2019 20:26:46 +0000
Message-ID: <CAJDYR9RVz6ZKQ-vdC8O3LYZnGeBcGHCRtL0m6UoRrKDBsUoFOw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Jeff King <peff@peff.net>, Barret Rhoden <brho@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Obviously this isn't as automated as saying "ignore commit X, it's just
> variable renaming". But it also eliminates the need to a priori figure
> out all such X that affect the lines you care about. You get an answer,
> your human mind says "nope, that's not interesting", and you press a
> button to dig further.

Hi Peff, for the use case you describe of someone stumbling across a
renaming commit, your approach is clearly better. However the use case
Barret & I are facing is of deliberately choosing to make a large
refactoring/renaming commit, and not wanting everyone else working on
the project to have to press that extra button every time they run git
blame.

I think it's really important that we make this dead easy for everyone
to use. The ultimate in ease of use would be for git blame to
automatically pick up ignore settings without the user having to even
know that it's happening. But that breaks the principle of least
astonishment. The next simplest thing I can think of is to add a
configuration option blame.ignoreRevs which would have the same
effect, except the user has to opt in.
Barret has implemented blame.ignoreRevsFile, but I think the world
will be a more consistent and happier place if we dictate the location
that the revisions are loaded from, in the same way as .gitignore.
Deciding what that location should be is one of those bikeshed
arguments which is perhaps why Barret dodged it :)

-Michael
