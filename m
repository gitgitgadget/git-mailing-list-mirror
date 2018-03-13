Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4F901F404
	for <e@80x24.org>; Tue, 13 Mar 2018 23:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeCMXEL (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 19:04:11 -0400
Received: from mail-ua0-f171.google.com ([209.85.217.171]:42492 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbeCMXEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 19:04:10 -0400
Received: by mail-ua0-f171.google.com with SMTP id b23so878177uak.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9f48zz+36G3mzR/Dl8lb0wFsdNjcqq43D3DSKJZJoOg=;
        b=OYaK5RkwwbvP76jKVAi4whOqUH8aSyGkOdpfP7QAu6q1ImJI6KDx04vj131RIFgEwZ
         JS7fRsT1uSIJF2G2IZaDIzlpWstTERRxK7ELO4kUsOxWGvy2ma44Lnk0HhWvBEBIOdP+
         DUok3p+jDoCjyzKhfUeaHAdZslc6WoBZEc94nbn0qmjDnKcAUFXoJAqsLXW24csJC3PE
         uJueVa1Tkw5NQIkw5ZJhcsLHu53rBhAk5CJKoz0l/L6NxLbyC4Nu+FIW5OwgVBMinJMU
         JEz1emyB246buc2LM3ha2OEkW59lMmID9IBJ0fz33AFNHp1lmman6I9/5Kl4M/YlYVRb
         jEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9f48zz+36G3mzR/Dl8lb0wFsdNjcqq43D3DSKJZJoOg=;
        b=pSWTbHaUcYJ588UA8lUNOCEYb19/XdJW/jh0hqTQ1n0SgMfC4iiqAF+mQoPZFl5V4g
         /UE64OUnNzp/YsWIEt83SyGgWcL/eSN5v4pC61w0UhRaQ8W/5onx+Onvyz6CFVZ2PYaF
         /t1W+cfTv3vocMZWTlEpHsgBV8vozcE5E617wWfLJFj9XUEYGSNHNYy6It5xvOocO1cz
         BkE0KI7Sx3bVk5SPQ53mOGKOsIK3jL3XxA96ZaJyNfryC96gzLYQF90zD9mbtbD7NqZF
         5pqkvw/MxMU0pT9hsSdWcxlYaheUglRFkO9Shrh9XJAmyi2H0DG3QGP0sRTwAH6POP8T
         wwSA==
X-Gm-Message-State: AElRT7F1KFZ8TCVRFag6rnAyl8ukwm2hA4KIRfniBnJo2XL4R+wNliHU
        Q1rUxY+Fp3PC6T7PgaY9KkZGUBwLAcIVk/k93/4=
X-Google-Smtp-Source: AG47ELuX3ZVo06dMukcDMxtKcIDJXZE/AHwL1Uzkv9CvDuN4ebCGbD7D35vc2aJ2Dt5OdPL5fvHgoqir5r8NXy6sJ+E=
X-Received: by 10.176.94.23 with SMTP id z23mr1919603uag.112.1520982249905;
 Tue, 13 Mar 2018 16:04:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.3.241 with HTTP; Tue, 13 Mar 2018 16:04:09 -0700 (PDT)
In-Reply-To: <xmqq7eqf1tc9.fsf@gitster-ct.c.googlers.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
 <20180312184734.GA58506@aiede.svl.corp.google.com> <CABPp-BEdh+UOCpFn5Y1_RydR==dDHWTeNtBub+pPjH_06Ub28w@mail.gmail.com>
 <CAPc5daVu8vv9RdGON8JiXEO3ycDVqQ38ySzZc-cpo+AQcAKXjA@mail.gmail.com>
 <CABPp-BF-LnGPx6vKzCNaFNi_fkxK-CpenatOVa2fvJRZHd0hZw@mail.gmail.com>
 <xmqqbmfr1uj3.fsf@gitster-ct.c.googlers.com> <CABPp-BGXdBJSi5EUyeom0PcgRXvwNy4EBA71MP3FZK9xsw-jdA@mail.gmail.com>
 <xmqq7eqf1tc9.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 13 Mar 2018 16:04:09 -0700
Message-ID: <CABPp-BEBvywrCAeLAe-LQ9XOJ=sKG0-vYJRrXYoHZebUM-kd7A@mail.gmail.com>
Subject: Re: Opinions on changing add/add conflict resolution?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 13, 2018 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> However, my question here about what to write to the working tree for
>> a rename/rename(2to1) conflict in one particular corner case still
>> remains.
>
> Hmph, is it a bad idea to model this after what recursive merge
> strategy does?  I think what is written out from that codepath to
> the working tree has the nested conflict markers (with a bit of
> tweak to the marker length, IIRC) in it.

Oh, that's cool; I didn't know that.  It looks like that was
introduced in commit d694a17986 ("ll-merge: use a longer conflict
marker for internal merge", 2016-04-14).  That seems like a good idea;
I'll go with that.  Thanks.
