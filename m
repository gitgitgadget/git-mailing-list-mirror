Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EF4B1F51A
	for <e@80x24.org>; Mon, 14 May 2018 17:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753067AbeENRb2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 13:31:28 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:35929 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeENRb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 13:31:27 -0400
Received: by mail-ot0-f196.google.com with SMTP id m11-v6so15230175otf.3
        for <git@vger.kernel.org>; Mon, 14 May 2018 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=okx8q+tEA4Bg/gI/OtYFmQAqt+FNrn4cNNfO7XyMIpU=;
        b=pEQo3QAqV556+VW/X/UB9C6oMB62N9TtZB/Jh4bMQ7KPf2jeE3LxTN2/9emR2b/1ji
         Adi68IjgaD2+cmC2pex1xv2skPoSrOQPwJHYc+IFEYhCI1lk50r24XtA7qN8JerMJGF3
         GlyZu7Pgg3soc4crA1lrdpdVb051S/yMPZ/86Vjr9rs910pTKZk4eVxMMG8iVzuvN+G6
         Sn/9H0FBvefDaGM2aTkJu2QjYMQf+g6j78sTMytG/SaADRPB7z6HkaJB2Q4K95wY2diH
         /BxUtGBReSy/R5hNk25Dhq+Pkn58LqWzTvK7h1OgTZ4/jJuyWWRm0H29edtjSrZ3Depj
         6PWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=okx8q+tEA4Bg/gI/OtYFmQAqt+FNrn4cNNfO7XyMIpU=;
        b=WRIITxbh7+0d8Q8zdenoiLtWuCRZEMcNzQt+LV77wWjUVTQJpBiHTW7/wmzTvOtPVB
         k+8NWgY8mnf2kmPcuSyZbGELiphxH3MfsBUMwQwDpR3FDYGe1KPy3yDH5UdkmiOVJ0jZ
         GmjfVEASCV0llSssQumwAS/6+faYrr2N8rF6Oosi3GLg8KnMbtVPUzy+aZrQjv5Qapwg
         0Yuwygh08WJTbSPqb7Rc24gM5jf1zB2xi7Uv1hBYsgOBDy6Cndj49+Hi955SiQQeUKXl
         O2C1zInYnty2c+6ZMwnLs2sz95Y8Q2/czVbo7KxdyavcoNc58n6lAehY4aUuO3+U+q6n
         VNMA==
X-Gm-Message-State: ALKqPwcZ6fdc1M2McxeKX2OqJF3Efo1hMe0yjFn+g4xBOgJVq0f0nM+N
        2VFXQr0ukwlz6A6BcCac9J9zDzpoZ3p9e7hasEU=
X-Google-Smtp-Source: AB8JxZpYMQDjR+9q7P8m68mMhcFIX+jGiMpswY5wFpcqBV4gmdyaWsbXbvisez2cqVK5j8/YDaflpOYoH+C0aM5QcR0=
X-Received: by 2002:a9d:2fa6:: with SMTP id r35-v6mr8386178otb.356.1526319086913;
 Mon, 14 May 2018 10:31:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Mon, 14 May 2018 10:30:56 -0700 (PDT)
In-Reply-To: <20180514160738.GA19821@duynguyen.home>
References: <20180512080028.29611-1-pclouds@gmail.com> <20180513055208.17952-1-pclouds@gmail.com>
 <20180513055208.17952-15-pclouds@gmail.com> <xmqqy3gmbrnm.fsf@gitster-ct.c.googlers.com>
 <20180514160738.GA19821@duynguyen.home>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 14 May 2018 19:30:56 +0200
Message-ID: <CACsJy8DhUw6L7j3Pkqji_K0WMjFZxs315emmvdyNQJJN4VTwgw@mail.gmail.com>
Subject: Re: [PATCH v2 14/14] commit.h: delete 'util' field in struct commit
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 6:07 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, May 14, 2018 at 04:52:29PM +0900, Junio C Hamano wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>>
>> > diff --git a/commit.h b/commit.h
>> > index 838f6a6b26..70371e111e 100644
>> > --- a/commit.h
>> > +++ b/commit.h
>> > @@ -18,12 +18,16 @@ struct commit_list {
>> >
>> >  struct commit {
>> >     struct object object;
>> > -   void *util;
>> >     unsigned int index;
>> >     timestamp_t date;
>> >     struct commit_list *parents;
>> >     struct tree *tree;
>> >     uint32_t graph_pos;
>> > +   /*
>> > +    * Do not add more fields here unless it's _very_ often
>> > +    * used. Use commit-slab to associate more data with a commit
>> > +    * instead.
>> > +    */
>> >  };
>>
>> That's a logical consequence and a natural endgame of this
>> pleasent-to-read series.  THanks.
>>
>> Unfortunately we are gaining more and more stuff in "struct commit"
>> with recent topics, and we may want to see if we can evict some of
>> them out to shrink it again.
>
> Sigh.. ds/lazy-load-trees already enters 'next' so a fixup patch is
> something like this.

Sorry I take this patch back. I didn't realize it was a rename and the
old field named 'tree' was already there (I vaguely recalled some
"tree" in this struct but didn't stop to think about it). Moving
graph_pos out is an option, but only 32-bit arch gains from it (64-bit
arch will have 4 bytes padding anyway) so probably not worth the
effort. "generation" field should probably be moved out though.
--=20
Duy
