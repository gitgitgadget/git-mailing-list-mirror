Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC39D1F404
	for <e@80x24.org>; Wed, 21 Mar 2018 22:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753975AbeCUWnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:43:53 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:44342 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeCUWnw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:43:52 -0400
Received: by mail-pg0-f53.google.com with SMTP id v26so1232pge.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sJZsT6NKJqmm6vvQ4feV3N6LSyfcYLrZZvvulgKT1XI=;
        b=Av1rlwp9sniZvIMqaxE74d67J9MKHicRVz5vIP46qisjpZxVEoDZkMcNShdjegy3By
         BG/jebrAQLwW86ClxEe+tl7n/qZsJMtvIz1xdv9PbUMxZSA33jIWMLyDasPoNkwPVvH/
         NyLgKK01cbbB0G2i0NBfya8/XHnMIppCwFtnXBVyS1iqgW3KUQbnP/wXq88m07kDMPBF
         qqx/h7F0k16a4I8z6OfuyEWi4ziYLgu0cFcefMRNPrx5IXxLzilyvlAWUiVYFEVOyTlz
         nshHOzxK9UDtJID7T2l8S9byz1MGm+5VWLe3uvuYBeSuZMeLY/xm+qqQ46shm/Ukd/7z
         Kz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sJZsT6NKJqmm6vvQ4feV3N6LSyfcYLrZZvvulgKT1XI=;
        b=VFUQ/+1aX5fox8bB9Zz+U4RYj+dqxeY3iaNtAHgrOUBCp82EmDUqL7HCD5i1Oi5xuj
         aMUmMAsjqirhiS4UD4AXkcZfkhz0TYC6XsGlh/h8vhYXyIP1eTpjENVBYBm3nKjqHOqP
         5s0t+wKceljO5n1a1seNbbwVGMDYyBIW3q0j3H2d8eegas6u9yizvig9/1LQAcGHEvsF
         Awec6tcTPtb3pZMTOb798bYaVNN2zEXvGMBUWbj2rrVd6O2ecMo8fCYvlvCdvQaNzSz7
         yfHAntoqAJLRIXhA9SHKkLhk+lgm1uecou4Mcq5GQjUKu1YjLK38ZPiqk0hDKTLp6CIm
         4l0Q==
X-Gm-Message-State: AElRT7FHhC2BbZXkjZMkeazYYnia91USfXFSzRRAKDEOId+ufRrHJU6U
        Yfbu0P4KRpVk6Leov/avJqlkQg==
X-Google-Smtp-Source: AG47ELu4Nkioki4d++0vYWpbGl3TSy6+bFBeXte0MA+I4OnnrZv3eONSxB+bHI8wb4OjDsa4ynh5gw==
X-Received: by 10.101.82.69 with SMTP id q5mr15986277pgp.259.1521672231592;
        Wed, 21 Mar 2018 15:43:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q66sm7619164pfk.95.2018.03.21.15.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:43:50 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:43:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/44] reroll nd/remove-ignore-env.. sb/object-store and
 sb/packfiles..
Message-ID: <20180321224350.GD202156@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-1-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> On Sat, Mar 3, 2018 at 9:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Thu, Mar 1, 2018 at 2:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Stefan Beller <sbeller@google.com> writes:
> >>
> >>> On Wed, Feb 28, 2018 at 9:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
> >>>> Duy Nguyen <pclouds@gmail.com> writes:
> >>>>
> >>>>> Looking at the full-series diff though, it makes me wonder if we
> >>>>> should keep prepare_packed_git() private (i.e. how we initialize the
> >>>>> object store, packfile included, is a private matter). How about
> >>>>> something like this on top?
> >>>>
> >>>> Yup, that looks cleaner.
> >>>
> >>> I agree that it looks cleaner. So we plan on just putting
> >>> it on top of that series?
> >>
> >> We tend to avoid "oops, that was wrong and here is a band aid on
> >> top" for things that are still mushy, so it would be preferrable to
> >> get it fixed inline, especially if there are more changes to the
> >> other parts of the series coming.
> >
> > I agree with this. Stefan, if you're getting bored with rerolling
> > refactor patches, I can update this series and send out v2.
> 
> Since Stefan is traveling, I take this opportunity to reroll it.
> Unfortunately, I think the fix should go in 46cd557bd9 (object-store:
> move packed_git and packed_git_mru to object store - 2018-02-23) where
> we start removing the global "packed_git". But that's in
> sb/object-store, so.. I'm rerolling all three
> 
> 01/44 - 05/44: nd/remove-ignore-env-field
> 
>   This series is moved up top. After this the patch that touch
>   alternate-db in sha1_file.c looks natural because no env is involved
>   anymore
> 
>   I also take this opportunity to introduce a new patch 01/44 to avoid
>   struct initialization that makes it hard to read and update. Later
>   patches are also simplified thanks to this.
> 
> 06/44 - 32/44: sb/object-store
> 
>   06/44 is updated to introduce raw_object_store_init() instead of
>   RAW_OBJECT_STORE_INIT macro. This function is now used to initialize
>   both main repo and submodule ones.
> 
>   10/44 (moving "packed_git") also introduces two new access wrapper
>   get_packed_git() and get_packed_git_mru()
> 
> 33/44 - 44/44: sb/packfiles-in-repository
> 
>   The only thing new here is 44/44 which makes prepare_packed_git()
>   internal. get_packed_git() and get_packed_git_mru() introduced
>   earlier will call prepare_packed_git() automatically.
> 
> The whole thing is also available at
> 
> https://github.com/pclouds/git/tree/ignore-env-object-store-packfiles
> 
> And interdiff of all three, compared to what is currently in 'pu'.
> Looks pretty good in my opinon:

The only major issue I could find is with patch 40 and must be fixed
before this can be merged.  The rest of the series looks good.

-- 
Brandon Williams
