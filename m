Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C61F20248
	for <e@80x24.org>; Wed, 27 Mar 2019 09:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfC0JCa (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 05:02:30 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54609 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfC0JC3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 05:02:29 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so24176989itj.4
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 02:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=08jM69aB+aibWwb9AwVbRE0TCvzNK60OPpM4C8m6hpk=;
        b=ZUlj1tXGopztlfuqMeB150FEByxCryXYGTUfmPK/XesYXBzzCXjv2X4VqazQnWzQqZ
         rRR0U6f9UXFLO4khAwOrVlkCkVtdkI36T9qU3UMFQ17asdGKaZzl3CS8+3t8iHX+E0uC
         k91Aalr43Yscnsq565ngihEeGSKNQDUPXE7nRCtj4JN31fG17n0SpcEdd7du8LyugqAD
         XxQigOTUMFBr6C5rM0HyAbrepF9UAYHfB2P/NaKafLEMtXP6uAYLDawUc2q2cohrxLM0
         wUIDuY9+0RMNSsO1lgIlb3/XgCtuFGbW8quhnPAQItSzxHknht82P1P7o8p8T2+eDM0V
         sS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=08jM69aB+aibWwb9AwVbRE0TCvzNK60OPpM4C8m6hpk=;
        b=caAyUtUoOD2il27a83wa5xA5w9dwikhY+SGi95oELzJA30bJeR5K0l8ZbUqEa1eJEU
         c6lTIRnjZXQRWyesanU5KDN/liujwDh+Fef+3pfUWewTmAPOoQtTRnjnrjVrQTAeB6YY
         1NATxHDBH3K29u/wsr6VteRrgDyRxUkJIdNYeygyKZsX3BrCfsPWTRD1xLcSIkxbSNab
         w9spDfkSRzZcMo4jIhhydowY5/JL6BTBUEpAC2yzVGZE2ekbJVrrtcuhwb3e1SS9eQDF
         DBPOyIe/63F5s+4IFQ29Yj3u9lkcV4X1kqw9JAz/09EsrqxEAdKpw5PDI+wlme/j1e1t
         cBpA==
X-Gm-Message-State: APjAAAWW+I/rBqJ3CAOBvNaTo5lcfPgaBH+jtWMYqXKxH3+yJmNL/uaK
        9Y6YtoWueFsNztODhgJF0YAv8uX+uQ1Sp7LhaL/boA==
X-Google-Smtp-Source: APXvYqxsNb79VC7W77C2W3cqPuXdgjz/Bq0jXyCRsrJhxF9vkO2IuFQCgnX2KapmqdZIp2rORPOmkHBF6DAbcNoNXH4=
X-Received: by 2002:a02:1c49:: with SMTP id c70mr19041643jac.92.1553677348737;
 Wed, 27 Mar 2019 02:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190324235020.49706-1-michael@platin.gs> <xmqq5zs7oexn.fsf@gitster-ct.c.googlers.com>
 <CAJDYR9RWUmXzh9Pn3qGBXAxNf70-SMKUCB3wwXVYKRTKOy8F_g@mail.gmail.com>
 <b077afed-d143-506e-977e-6edf2492f75f@google.com> <CAJDYR9R77_+gfOgLXX_Az8iODNRyDTHAT8BAubZeptEWJViYqA@mail.gmail.com>
 <20190325233516.GB23728@sigill.intra.peff.net> <CA+P7+xo-AHmB+Wv0Z+dpgshhmqSLEb41T-JP+NKJD8DAFARA5w@mail.gmail.com>
 <CAJDYR9RVz6ZKQ-vdC8O3LYZnGeBcGHCRtL0m6UoRrKDBsUoFOw@mail.gmail.com>
 <CACsJy8D8yBK9p9Rgy+wk8cMfPLG7qanvGA-LcmmHmjbaMnvBLQ@mail.gmail.com> <CAJDYR9T40xaSpmL_e00WWXzxEm_j0pcTqBhvr=5mu-fTpKodmQ@mail.gmail.com>
In-Reply-To: <CAJDYR9T40xaSpmL_e00WWXzxEm_j0pcTqBhvr=5mu-fTpKodmQ@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 27 Mar 2019 16:02:02 +0700
Message-ID: <CACsJy8D-Nwyh0tXsOiqBUnkKVm5TQcVaszdLX1FMr7vDfQ8krg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Fuzzy blame
To:     Michael Platings <michael@platin.gs>
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Barret Rhoden <brho@google.com>,
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

On Wed, Mar 27, 2019 at 3:26 PM Michael Platings <michael@platin.gs> wrote:
>
> > Another good place to keep these revs is git-notes,
> > which probably could result in faster lookups too and can be made
> > visible in git-log.
>
> Oh wow, I really like this. A major concern I had about the revisions
> file was that you don't know what a revision ID will be until it's
> upstream. If you can specify *in the commit message itself* what
> options should apply to git blame for that revision then that problem
> is solved. And if you change your mind later, or want to ignore a
> pre-existing revision then git-notes solves that problem.
>
> So I'm thinking you just have a commit message like this:
> "
> Make all function names snake_case
> git-blame-ignore: fuzzy
> "
> And users who have blame.ignoreRevs set will have the -F/--fuzzy
> option applied to that commit.

Yeah some trailer in the commit itself is also good if you know in
advance it should be treated differently. I think we have
git-interpret-trailers to help extract these info.

> > But that's in addition to --ignoreRevsFile, not replacing it.
>
> I disagree. ignoreRevsFile has the major problem that the file will
> need updating every time you rebase a commit to be ignored, and you'll
> need to remember to edit it for cherry picks. Let's not have that
> option as I think it will add unhelpful complexity.

OK I was just trying to say I did not object any current suggestions
(because I didn't know much in the first place). I'll just leave this
for other people to discuss :)
-- 
Duy
