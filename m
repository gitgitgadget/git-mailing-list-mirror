Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 365FE1F404
	for <e@80x24.org>; Tue, 13 Feb 2018 04:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933416AbeBMEsn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Feb 2018 23:48:43 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33815 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933025AbeBMEsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Feb 2018 23:48:42 -0500
Received: by mail-qt0-f172.google.com with SMTP id d14so2318948qtg.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2018 20:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=1g+KiQHKef9QjjvmzY/H3QbT/2FEJURDTPueI105afg=;
        b=diYguhhTEL+vvwkcIlF2u3HanKeF42JmSfmTG26B4IS9nsR7NyWll4P6IIgvCQztXH
         nFSfdSOxl5A5Kk4UEzxiObYKsscMQMInYGVUidlmeRYjqH5+sxYOIi5KlgQ89FWYWyCW
         7F/a1ksH6KpMxTa05LR3QzHRpAhE0lY2UVxkwEqCxkYLql50EJsCSR3RRp2ng/9IkuQs
         fZO1hnZvsVcTsGRNP4wVBttCSjTF0vFM/uHrD7Z6S0rNW6tLEJTli1iLGUmZEHblj+05
         Mena4E0OBF73WKycoIvWHCOgn8KMYtUQKjCijjUSWbqJOpdfmkpZRnR9z5Mkf8LNsBaQ
         3dpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=1g+KiQHKef9QjjvmzY/H3QbT/2FEJURDTPueI105afg=;
        b=LTWDWF/bQeYmsZN1i4xktWF6AcJIzRRr/r2Ej4K2jXs5TS44fj4trXZurcXc4uvo3B
         GKqP46KD89IsD4mSDHJvWVemvnrq3C4itLF27rsAR0y1afQ7ROZXgC8h+ekXHpMr7+oI
         54z5sTGSUOqVxoo47zev4FjXodvauvtfJz1zds9A9inQpEh3kBEL5lRZCvtcq2+FNsl0
         J2Fo5Feg5fbpKdfCKuXrWKVGUMHu9Hi+OOhSDDDdq5v1nT/tOybhFIti0KkF1CN7lL8e
         dLL6BmtnAwLSjZDNJloruzQTxd/BbhFrR1/0IMlV0u30u+AN3jQigqkm9K3muHEd5YCx
         J9pA==
X-Gm-Message-State: APf1xPAkKAC1/J2Zh24WBz5YW0lkeULEApaQt0VqhOx74WPjeY1XtAlN
        8G+IdtV2epT1acJfKfYErAv1bJsyokYXdHO6Aqo=
X-Google-Smtp-Source: AH8x227Yd+HqSdvcQRr1UyeDRZFMrv0EaLAc7WKG42heipTW31iivBdqD5B3ozl0usf+NN+HztRT2NjlU6OpMgQo5Oc=
X-Received: by 10.200.51.100 with SMTP id u33mr17091772qta.127.1518497321752;
 Mon, 12 Feb 2018 20:48:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Mon, 12 Feb 2018 20:48:41 -0800 (PST)
In-Reply-To: <CAPig+cTLQ6h+stLLns-837hP0nNOpE3vwu8_ZeO2GoAaDs7buw@mail.gmail.com>
References: <20180210010132.33629-1-lars.schneider@autodesk.com>
 <20180212031526.40039-1-sunshine@sunshineco.com> <20180212031526.40039-3-sunshine@sunshineco.com>
 <C2FFE6FB-4B3C-4246-9BCA-272EC874FA8B@gmail.com> <CAPig+cTLQ6h+stLLns-837hP0nNOpE3vwu8_ZeO2GoAaDs7buw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Feb 2018 23:48:41 -0500
X-Google-Sender-Auth: bzeFxavpTOP9B-UF4q-LpXvL0cM
Message-ID: <CAPig+cT+SkmFKBFc3rbh7SMk10dU8E-y4s+WR10GPNtGk+7S7g@mail.gmail.com>
Subject: Re: [PATCH 2/2] worktree: add: change to new worktree directory
 before running hook
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 11:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> So, either approach works: removing GIT_DIR or using "worktree add"'s
> existing GIT_DIR and GIT_WORK_TREE. I favor the latter since it is
> consistent with how "worktree add" invokes other command already and,
> especially, because it also addresses the issue Junio raised of
> user-defined GIT_DIR/GIT_WORK_TREE potentially polluting the hook's
> environment.

Just to be clear: Regardless of which fix is used, we still want to
chdir() to the new worktree to guarantee that the directory in which
the 'post-checkout' hook is run is predictable.

In the re-roll, I'm going with the latter approach of re-using
builtin/worktree.c's existing GIT_DIR/GIT_WORK_TREE which it already
exports to other commands it invokes.
