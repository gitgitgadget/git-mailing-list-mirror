Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66B5C1F461
	for <e@80x24.org>; Mon,  1 Jul 2019 13:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbfGANXq (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 09:23:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41102 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfGANXq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 09:23:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id c11so10907500qkk.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8e/RRY+a5gGf72wgUoIdFt0rbdwcPWbHOvwEEUq7b0=;
        b=pCfnLO+U2P6AxVIX1RBJHUHqtExFlflxmNas/RwgRLgn/cgb8CkcAKunhIiD2xRFed
         PsJbz8d6iDvxQULBL7/PH6rnGko5TOR59uI/rxJGY71p+3qa9V5RypQILTyJOVIr4AUl
         cOgZgMppSmE1kqOi5iS+vP26kgdXKutsyBpl1szeNKM8sfr/HVPQHjNIJhq6HRN4KppC
         Frw1UbiCczLo+AHFgPtooLSnAnpHNWcspH4EC5T9kb5m7Q6XUYuL2hEzDNxZ84KBYS5+
         7pIBk73G1Hnzoyxfe9Z2E7167OiDfUgUlpDxi4C2O9nHU6ArHQ54eOeTAn4X94PW3IEw
         kVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8e/RRY+a5gGf72wgUoIdFt0rbdwcPWbHOvwEEUq7b0=;
        b=nBi4JQ+q51YNe+/6hAqub1hkJdsjm7WZ5gAj0+WyN0IbXNud1KBdEP+0CPhW8FZiIH
         Pg4p/i/W3Z8ajLuY1qn2VdWcZD3L8MRR+8X3DrUmhb6YK64IzSGNTG3u6yT+H8A1+b+f
         9d5afNPGm3WjzBmFnE4Olh2GbG93jHAAvBeq8IX8uy+L+nGDMx2Ftgy0MpWngp8WJNy1
         HkI16XBUqx3I8sGILIPTLlym4LGxg5qmslHiYSRzIMlV2BtuO9tozIZ5SAhGWMehwgIH
         eM0twV9E+VjEBerELq9Zben3uu2XIgwjROcUzOeb5S+gJ9G0TWUJUh7eK1je83SNze+t
         WYaA==
X-Gm-Message-State: APjAAAUag1NQjMPHD39l0yNhQ6zut90PuxzMvW/9JLPtksu8GMQrbmQM
        R0Noto6gknkKCh65SQapYpo=
X-Google-Smtp-Source: APXvYqzArF3yIH9y4BeA/eR0iXFOSKl9q7WDsLMLZVTFVD0hIysQfENQFnzN4cI0DAX6SmUKDcKsCQ==
X-Received: by 2002:ae9:c106:: with SMTP id z6mr21142397qki.285.1561987425186;
        Mon, 01 Jul 2019 06:23:45 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:8d39:716e:a6fa:35c4? ([2001:4898:a800:1012:3e6d:716e:a6fa:35c4])
        by smtp.gmail.com with ESMTPSA id z8sm4626263qki.23.2019.07.01.06.23.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:23:44 -0700 (PDT)
Subject: Re: [PATCH 1/2] object-store.h: move for_each_alternate_ref() from
 transport.h
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>
References: <20190701131713.GA25349@sigill.intra.peff.net>
 <20190701131740.GA2584@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <877673cb-5b2b-6e65-9a03-a16de043990d@gmail.com>
Date:   Mon, 1 Jul 2019 09:23:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190701131740.GA2584@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/1/2019 9:17 AM, Jeff King wrote:
> There's nothing inherently transport-related about enumerating the
> alternate ref tips. The code has lived in transport.[ch] because the
> only use so far had been advertising available tips during transport.
> But it could be used for more, and a future patch will teach rev-list to
> access these refs.
> 
> Let's move it alongside the other alt-odb code, declaring it in
> object-store.h with the implementation in sha1-file.c.

Thanks!

> This lets us drop the inclusion of transport.h from receive-pack, which
> perhaps shows how it was misplaced (though receive-pack is about
> transporting objects, transport.h is mostly about the client side).

That's an interesting de-coupling. Thanks for looking into reorganizing
the code. This series looks good to me.

-Stolee
