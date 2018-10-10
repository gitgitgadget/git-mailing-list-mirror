Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F13D1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 16:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJKAOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 20:14:54 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40171 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbeJKAOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 20:14:54 -0400
Received: by mail-pl1-f193.google.com with SMTP id 1-v6so2807785plv.7
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/fDiBsOVI6aqqygkLTdj99b2A3Q+c9UtnK0tv6x2XgI=;
        b=qJrjg1jRl7uOXczPZRRxASkQ6vZJXGzzf6Bop091yNQK7xoNiHeHrLDn2y5NihJNP6
         7pld56Gw0zkKZYOUSF5j9XKrpu08yYzx/70IL1PYnd/Ryff1M+7svl+Fn25VT0fRcg57
         GoW4IJ019Fr2EhiUQ/tPlms61+zXyMR7IR4My6+ZPYP2e/eZz0xDFig1HVgrxQiu75xo
         3RByYPo7O4149cH6H5FLED/ubymwkklQgoLOFnpvmy0X8GYjLRJaCzhAT8dKKXjT48yH
         lAiJ5fNwYTvs7Ae4BA1DgTuWeK9A96+Oj60ZT07PVRaA0wv5QxMKe3Tg7x2zOgLNcVv7
         eXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/fDiBsOVI6aqqygkLTdj99b2A3Q+c9UtnK0tv6x2XgI=;
        b=IhOPZdmxZis7AFijLTyGhPvKLUudQ7MH1vAXE8Lt3peYmGttLreYzBgAUp9+RPWOGu
         l43CiIBo8OWtCwx3AiQ2I+TFP+JkKgfLuHtGcDG8i1nki8UJkesruLu0kMCs0TBQYtb+
         mx/A2ZA3P5C8ZrBlN1ydmIaGK2NPZXvCJQTEzruccbxND32GR79XUsY2JOzd2RmiuBH+
         Kw/f330U7RiZwBvZIt9sE7TL/2KS/dPc6DIVURPJ8D+fyTFxpjcNA9ylTI7me94n5urN
         bwne/NqvQol3aMtT5k/TqbWsbayKg9VNdvG5RQJ+1c1o5FOLUfgY4lAAfIjw5RNRckBD
         2GIA==
X-Gm-Message-State: ABuFfohZ1cP+CCyyszdAqMOO1sg1ljxZ7wu+M+j6nzLKJ6pWmvgMEKUW
        0HS7orjSrTypwEmZWKoYizMW1sD5
X-Google-Smtp-Source: ACcGV60ZFDgjDqgMdQDNF5+2f1uZPSIm9xtwn/xXBiBpEPJPKLimY0ZdeAXPDzxfpibsgvmAaGgQ8A==
X-Received: by 2002:a17:902:16a4:: with SMTP id h33-v6mr26100248plh.3.1539190314515;
        Wed, 10 Oct 2018 09:51:54 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id q24-v6sm22280551pff.83.2018.10.10.09.51.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 09:51:53 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:51:52 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Langhoff <martin.langhoff@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, e@80x24.org,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: git svn clone/fetch hits issues with gc --auto
Message-ID: <20181010165152.GA180779@aiede.svl.corp.google.com>
References: <CACPiFCJZ83sqE7Gaj2pa12APkBF5tau-C6t4_GrXBWDwcMnJHg@mail.gmail.com>
 <CACPiFCKQq--xrMf1nF=1MmC+eESE_aKms3yogoRwCY=YxcOWXA@mail.gmail.com>
 <20181009234502.oxzfwirjcew2sxrm@dcvr>
 <xmqqd0sims6s.fsf@gitster-ct.c.googlers.com>
 <CACPiFCL0oTjN+-aYgKEDtKC0gYwkv6RLMwakdJV85PJ5XQej6g@mail.gmail.com>
 <878t36f3ed.fsf@evledraar.gmail.com>
 <CACPiFCKMF2di=waQ5reRtjUFEjuE6DkxxLcN-YnF-SqgE_m=_Q@mail.gmail.com>
 <875zyaf2f1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875zyaf2f1.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ævar Arnfjörð Bjarmason wrote:

> I'm just saying it's hard in this case to remove one piece without the
> whole Jenga tower collapsing, and it's probably a good idea in some of
> these cases to pester the user about what he wants, but probably not via
> gc --auto emitting the same warning every time, e.g. in one of these
> threads I suggested maybe "git status" should emit this.

I have to say, I don't have a lot of sympathy for this.

I've been running with the patches I sent before for a while now, and
the behavior that they create is great.  I think we can make further
refinements on top.  To put it another way, I haven't actually
experienced any bad knock-on effects, and I think other feature
requests can be addressed separately.

I do have sympathy for some wishes for changes to "git gc --auto"
behavior (I think it should be synchronous regardless of config and
the asynchrony should move to being requested explicitly through a
command line option by the callers within Git) but I don't understand
why this holds up a change that IMHO is wholly positive for users.

To put it another way, I am getting the feeling that the objections to
that series were theoretical, while the practical benefits of the
patch are pretty immediate and real.  I'm happy to help anyone who
wants to polish it but time has shown no one is working on that, so...

Thanks,
Jonathan
