Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B768C1F4C1
	for <e@80x24.org>; Fri, 18 Oct 2019 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502341AbfJRQDr (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 12:03:47 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:43838 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390108AbfJRQDr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 12:03:47 -0400
Received: by mail-qk1-f178.google.com with SMTP id a194so1671292qkg.10
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 09:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLp1+uce/82spUwz58lSU9bq+f/LyVwG+zR5ofSPevQ=;
        b=MT7j6VuXBKW/1H3pnSmpNBezwuw1A1g0KfcJDbq4dCocf/Cyf8WYpn4uYIeG7sWAil
         o3jHr3UpG1mEBwip0Ums+C4OSVhlsJHzMgsy2tVFXN949jG7td009fg0pZi19Jl30Lac
         +PtPwdfcXsLohUSjTqcbAezqomPiE3Wjf8AL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=zLp1+uce/82spUwz58lSU9bq+f/LyVwG+zR5ofSPevQ=;
        b=NlU3ltZwtR5p78PZkFH0cItKRZdWVQh8vy/lJAFFwVUyohy+8PRuaTyGAOlzit+v7C
         Oh3SeyK+hjoffuyj5tdFGWsnw18f3iZIf3PsG9Ucrf1g3cS1Py2+pJg4sKmfzUEJKa8w
         2yzO7QxTbTnkX/Vfpqj2H2kUkw/vLspmgiRupxhwbxOgyhrm0xuRFykFblbUJ1TRlLdp
         9LGd8SNfbn1HIvrH4xD5RlQYMgRLQkuxJjsCY+vmKK8XJyACWILgGcmZP0I7HlldgKT+
         HNKMUbafvTHlOYFOrJSEOyuscBwlhFTQpn03nhWDg1U5MekI4aCknboyCoGWjMglk0Fl
         Z+Jg==
X-Gm-Message-State: APjAAAW9o4Uy8HEDRgAqqoT+whSo3eGPt0eFhhxbutm53EYtdDSdPZRP
        EUI0unFJI4YXZO9Qv+iA30d1cA==
X-Google-Smtp-Source: APXvYqxaSFFnCUWDXGSs/4g30alrIcbHoxKHK9VsIwer424Fky63UM5YEWt1Eu3QeIBy1+SXbU8W8w==
X-Received: by 2002:a37:a8d3:: with SMTP id r202mr8948996qke.405.1571414626275;
        Fri, 18 Oct 2019 09:03:46 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id g33sm2747388qtd.12.2019.10.18.09.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 09:03:45 -0700 (PDT)
Date:   Fri, 18 Oct 2019 12:03:43 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191018160343.GB25456@chatter.i7.local>
Mail-Followup-To: Santiago Torres Arias <santiago@nyu.edu>,
        Vegard Nossum <vegard.nossum@oracle.com>, Willy Tarreau <w@1wt.eu>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <56664222-6c29-09dc-ef78-7b380b113c4a@oracle.com>
 <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191018155408.dk4tsjrne42ufpvv@LykOS.localdomain>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 11:54:09AM -0400, Santiago Torres Arias wrote:
>> Seeing how large this signature is, I have to admit that I am partial to
>> Konstantin's suggestion of using minisign. This seems like something
>> that could be added to git as an alternative to gpg without too much
>> trouble, I think.
>
>I wonder how big the pgp payload would be with ed25519 as the underlying
>algorithm. AFAICT, the payload of a minisign signature vs a signature
>packet have almost the same fields...

It's smaller, but it's not a one-liner. Here's a comparison using 
ED25519 keys of the same length:

minisign:

RWQ4kF9UdFgeSt3LqnS3WnrLlx2EnuIFW7euw5JnLUHY/79ipftmj7A2ug7FiR2WmnFNoSacWr7llBuyInVmRL/VRovj1LFtvA0=

pgp:

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQR2vl2yUnHhSB5njDW2xBzjVmSZbAUCXaniFAAKCRC2xBzjVmSZ
bHA5AP46sSPFJfL2tbXwswvj0v2DjLAQ9doxl9bfj9iPZu+3qwEAw5qAMbjw9teL
L7+NbJ0WVniDWTgt+5ruQ2V9vyfYxAc=
=B/St
-----END PGP SIGNATURE-----

-K
