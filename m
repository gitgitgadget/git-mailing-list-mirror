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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AC1C1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387820AbfIDS4F (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 14:56:05 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40339 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387735AbfIDS4F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 14:56:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id i128so14534742vsc.7
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 11:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5lgjnSiKAv/REU1CRShap6Znl0znonW4Xqqqm9WL5k0=;
        b=TQmDGBSfEXcK3LV4kT2M58MAjQcwxT3oMPcDd9kyXcPenGI8ylZ7LdsCB95j/q5Xf8
         EKYKLFg4BMEWa3/KVEiLZIn8XJjte87Ek/nMu7HyBgD2ZrgJbHCpJVKO5qAYWDK3uDko
         bMke/8Hzetix0DLUotVaq4sdinP+9k8Xb+e7NTqhiGS8gi6S0YOcX4101ceXMENvY0fr
         4X4YLSYSFBmzhrtrzAFGBZC2Y95MjSkeGQgyogx98uPTBCD4GYFlT2IRH8Zdd2KqPZnL
         7nQV/zJgcNb9iRJGUvKAk68MIpqZw11LZDDTCCgijFG7olv0jPJw2HcqVpJ/OKoWjuom
         UxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5lgjnSiKAv/REU1CRShap6Znl0znonW4Xqqqm9WL5k0=;
        b=hiqGRmimjzU4Gg09WDXjKCYub83JLPB7bq4r7M4FSLAtj0XiI+9a8zFNBFOeKqXFcb
         n8VgoLeSMVy7dZxduyR5IYG81Pjjz3Wjb4zozbLEx8Hyv/JWoqa4jMIv9oQl9iLkSe0Y
         ok/e/+5BkUJYgLd3+KPDeK5MnTFpbt4/Gc5NSnFr3vgcSGe9qEA1NGKo/IMk2bfeOxlr
         mRZYFY//RTS0nhoQt1NB7D/JNwH+N8f7HXdc3KZAP9N5cekobyhMVhILvvzwQz/tydQp
         sOdcpWRdcM3Sgl87/g8J9gYHNb/NMGvsYUARDN2aQ5VfB3cWUPY3+6GhlGQ09st/2RZG
         G4iw==
X-Gm-Message-State: APjAAAU+6qW0hJCT8DqxXoDuo8w41tC8WelJSN/pMWlmLOCdveqLiLoQ
        papHX9w6dVG3VzqRtziTATizZuK+50FouKDdom8=
X-Google-Smtp-Source: APXvYqxgITe5kpesm/SI7bpLc04AALWqNA8nIK5cFmGkSAQ09+Fhq+4OdZPH+ESYm4QUBHmHq4EhhuY31Ep1iJYMECk=
X-Received: by 2002:a05:6102:143:: with SMTP id a3mr21470353vsr.63.1567623364027;
 Wed, 04 Sep 2019 11:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAGr--=JFVK6JoribkFQHpf-JRutO9XfKcFh9_adV3T2gYjvYcQ@mail.gmail.com>
 <20190904173642.2hkrqm5klatw33w7@yadavpratyush.com>
In-Reply-To: <20190904173642.2hkrqm5klatw33w7@yadavpratyush.com>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Wed, 4 Sep 2019 20:55:52 +0200
Message-ID: <CAKPyHN0+Wj8YtGF6Ke45o1f3kLuE+9KU6cYUMhyqCdDXSqj-PQ@mail.gmail.com>
Subject: Re: [PATCH] Add hotkey to toggle "Amend Last Commit" radio selector
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 4, 2019 at 7:36 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 04/09/19 07:58AM, Birger Skogeng Pedersen wrote:
> > Hi Pratyush,
> >
> >
> > So how does this work? Should I email the patch that Bert has created?
> > Or is it okay that it just remains on Github. (Considering the git
> > mail archives)
>
> I think it would be a good idea to send it on the list once before we go
> ahead with it.  This way other people who are interested can take a
> look.  They might not necessarily pay enough attention to the threads to
> notice the GitHub link.  And there is, as you mentioned, the added
> benefit of having it on the mailing list archives.

I'm finally able to send patches around again. Though I find the idea
from Johannes appealing to convert this to a check button. Are you
with this?

Bert

>
> --
> Regards,
> Pratyush Yadav
