Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53E0E1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 23:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfBOXgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 18:36:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36046 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbfBOXgS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 18:36:18 -0500
Received: by mail-wr1-f66.google.com with SMTP id o17so12017764wrw.3
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 15:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vpN7ro8S7iq4VKim1DCe+QXCaGpM6VSOQtNE5hrUB5M=;
        b=mWCXEGnG0vNcAFQEZ7zvrCaHwue2Wx8fqBsNZiAZ4VyAVPcZkw4kP2J3FwNG1VGoIF
         oBqiKylEvlOuJVIjwnaLRqV5hN85qubDfQrg+CA3thjGpUIgvJR1ygBnAvCjgwssK7K3
         OK7HBsn1kJPKwowxRuUKg6k+w1LQyeVsBLky13woiLK0xSFauT1dEbfjQHYiQBrL+lGE
         1aIf/iu7IKCJyikK78bNLL6MT0QFV70PqTuwHmtGNTmxdl4hEgpwrZtWiXFJg6FQDUGC
         E30Mzk3pNiuAYWqpalEg+a9ZCyR+FkLd9OVlAJiLGwQKDFOT0HVzQdJ9hC58tjcQ+K94
         aqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vpN7ro8S7iq4VKim1DCe+QXCaGpM6VSOQtNE5hrUB5M=;
        b=W5u8Z0KP09KbeQ5zQf0AWx3qI1MHubUKlbAJp61LaiDZyN2G4aB3sxWWh+i8mv/kUt
         NqBzIC41y1NR9U4W2sZRirjWq/dc8R/HuS9Hg+7pK13C6UdiJUVo5JeNbr0B9/U0civ3
         0KGbhuTySCfPr3ZCHo5trztq+Oq/+RCiR6i22k7kv2+ADEPftrrmRQjJt0BIrizIyG1E
         VytIMkJB3AlDW/gxB9Xw5jKPKw9wetghF3jt3GNsHmtIn5ky0Ptqwx+lqV20MsK7IUd4
         SJYwSvoLCVRe7k7HNgm1aXCvTBOL50XEPbmib93aQvMft2gExPDL+we5MveFWmzn65P2
         0/zg==
X-Gm-Message-State: AHQUAub7gHBWou3qKieJSzttqMHN0JyaA8PUnadCJYgDy9+CpP9+S+Gc
        OjntoB+QtVhTbD+7I74wnaM=
X-Google-Smtp-Source: AHgI3Ia/GcQNDbkAjE5688N3/dEXAV4d/CPCMIZRxCO+p4YARp7I2LBS8Ls6eYY+ATfm6Y7F07u0kg==
X-Received: by 2002:adf:cc83:: with SMTP id p3mr8414568wrj.292.1550273776209;
        Fri, 15 Feb 2019 15:36:16 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v6sm11111415wrd.88.2019.02.15.15.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 15:36:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH v5 1/8] technical doc: add a design doc for the evolve command
References: <20190215043105.163688-1-sxenos@google.com>
        <xmqqlg2g6hcv.fsf@gitster-ct.c.googlers.com>
        <CAPL8ZiseLQgemzr-U2yFM815Ty+Di_cGznZ_hNAcf3sMy5mXEg@mail.gmail.com>
Date:   Fri, 15 Feb 2019 15:36:15 -0800
In-Reply-To: <CAPL8ZiseLQgemzr-U2yFM815Ty+Di_cGznZ_hNAcf3sMy5mXEg@mail.gmail.com>
        (Stefan Xenos's message of "Fri, 15 Feb 2019 14:18:49 -0800")
Message-ID: <xmqqmumw4ob4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

>> saw a few comments that say "needs further work".
>
> Could you clarify where you saw those comments? Were they something I
> wrote ...

Yeah, e.g.

       /* TODO: This causes a crash. It sets one of the atom_value handlers to
        * something invalid, which causes a crash later when we all
        * show_ref_array_item. Figure out why this happens and put back the sorting.
        *ref_array_sort(sorting, &array); */

was what caught my attention in the previous and this version.  As I
said, it is OK if the code is not completely finished.  It's an
iterative process.

By the way, our multi-line comments have opening /* and closing */
on their own lines.

Thanks.

