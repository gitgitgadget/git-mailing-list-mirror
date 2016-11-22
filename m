Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61931FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755528AbcKVSfD (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:35:03 -0500
Received: from mail-yw0-f177.google.com ([209.85.161.177]:35016 "EHLO
        mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753147AbcKVSfD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:35:03 -0500
Received: by mail-yw0-f177.google.com with SMTP id i145so21994742ywg.2
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YoXQt+SNes2ImC0tRvo3zkJJ/WN0KcuToZH4qKgot8A=;
        b=yqykUjAllOWteSPtwExEwpK3lVxyw8DeP71yeeMn1WzFZb+hfOWyEUUN0WY2NVcezO
         7yHgEpMUhDczryEdklaNbcaxYuhdRj21VIqO82EiD+m70uflVxNJhQvOh/H2wFifyxVe
         A+a8KAAjuV1fUQyaq2qHdNMk2ftD4M+/HrEd4ITbQMzGDCz9MjVyOIXdDanhwrPVjlmF
         qrEUYe1E3sUk8Qand+w4s8CcFnVSzTqVY3fUvkzLJdsIFrITbz6ft4KdyC8QanQK3oxP
         05xxqJTVa2DSOMrC8+cUhjtHzYiOwR642tDKj03AFhUVpIlxew5aL+qi4uxAxuePlbfl
         lkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YoXQt+SNes2ImC0tRvo3zkJJ/WN0KcuToZH4qKgot8A=;
        b=QO42RJzYLKZYX9xWg2N5rk7duq2HvL9mSYF6b8auNQ7CVppPm2sVGDKR4MHuO5lZoI
         dXyou4rZDb4Da8VMjpZfoFSVGmbmWN9dFrgai3a3hPynJGljoaA9d26l+Eq6KGqHj/4T
         YpJLsd/buwCERorLf0KZO5GNW98gOj236eIkJZlVVKqLBwJlfMU9y0UsjEDnHXQWo8Ph
         TCS3xGdvNjzdU/CBmkqRMFIWr6xGDWNqnFjnmRnRiK4WObLovsJfsqh+ufUBAu7OhNjF
         1SWZX+hDa0t8ZTPv6EJgPYyNC71sXiJbf+2W4r6eYzphM6Y8meNFhSKio2H7poMubVIo
         438Q==
X-Gm-Message-State: AKaTC00rspwvDH6daMsQY3KEEbvm6ftWkUclL+t01XbKX475jZQtCES7RhHj0Eyk0BRpbXxg1ZN15kMsG95SPg==
X-Received: by 10.13.200.134 with SMTP id k128mr21684660ywd.72.1479839702423;
 Tue, 22 Nov 2016 10:35:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 22 Nov 2016 10:34:32 -0800 (PST)
In-Reply-To: <xmqq4m32kqet.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com>
 <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com> <20d067ef-9e2c-0d1f-f81a-06c154e95e4f@gmail.com>
 <CAOLa=ZRf+vPOPK=ovP7JmJ52qdgwuqkpGH4UfP=+caQeyu9Ucw@mail.gmail.com> <xmqq4m32kqet.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 23 Nov 2016 00:04:32 +0530
Message-ID: <CAOLa=ZSx=FbBTB1BGMFS4ppp=u-C=TAHBSzwn9-Ex-7ZZj20bA@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 20, 2016 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We could have lstrip and rstrip as you suggested and perhaps make it work
>> together too. But I see this going off the scope of this series. Maybe
>> I'll follow up
>> with another series introducing these features. Since we can currently
>> make do with
>> 'strip=2' I'll drop this patch from v8 of this series and pursue this
>> idea after this.
>
> My primary point was that if we know we want to add "rstrip" later
> and still decide not to add it right now, it is OK, but we will
> regret it if we named the one we are going to add right now "strip".
> That will mean that future users, when "rstrip" is introduced, will
> end up having to choose between "strip" and "rstrip" (as opposed to
> "lstrip" and "rstrip"), wondering why left-variant is more important
> and named without left/right prefix.
>

That's a good point actually, I'll try and implement both and re-roll.

-- 
Regards,
Karthik Nayak
