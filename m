Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D13F1F954
	for <e@80x24.org>; Wed, 22 Aug 2018 20:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeHWABR (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 20:01:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44538 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726588AbeHWABR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 20:01:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id v16-v6so2661476wro.11
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 13:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=QpiebfZEnRcuB6rtvP7A751LPrx/KaFRU6kLG49wNYI=;
        b=TkiNKLiiv81endSznuiN1LuDItfO8/KSdi8lQQAh2M6jrzocCQdM6SGHyJvoAXhkd9
         2GS2GRetTwB7FPwrjJNLP+cd31OOKyUe1Os2ytfHQoCSCS8sFJJZeOsR9Vc/O3hw6nv9
         pXrv/EMWujuDPpm2QT4vngbgzOHGL78r7l50ByN/wBJb/iPWZncqmSmigSecaWeP6uT6
         DLAC3QBxhaY4+/mWmyCA1k3lc2Yx3Bmw6yBbx9eMP1ge10nb4BEM2RI8otKiGvl1zwMF
         akyoI45xZRLrg8/6WKHjp1rxFR22xaxbsfgaeR8c7OyR9ON1ZOJ/6IcNQ8hKwr+R6xfM
         UruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=QpiebfZEnRcuB6rtvP7A751LPrx/KaFRU6kLG49wNYI=;
        b=uPmSVqDOiKPhZstUdAxBJDNLG8xaQVTwjywx/QeW5rLfwYRTjdTbFwxwjkaT9ahQJH
         CJZr9Mu1RDcZ7MMsdgLqO/YDjvQW/JZ+tXV4Zew7Q6Q3IYinQcuv5P0A1u6MT6qeNvt+
         PLL+HP2p5Wz1U8kdBlC6HtvKVwhLhSi6Roupv+Q0WtU/QK2XPHIXoAXGWY4R0N0sZIBs
         YoMdi6IEYzTmMEPN38YkF2pqrsqHz4p19KUAR6iX3roSvrVLpNl0PevpT915vPNBZDbS
         PaNIKimgz7k/ekILI44LNnNIANdA11aQaL7157iK/loMf5Er14FxgSSXI2xpGLDRIZJJ
         Hkgw==
X-Gm-Message-State: APzg51B8BWtE8CZCKSGqV0YDO0jru+6hwtT0PbfA8Qno3cmPuB1OzF7X
        KPL8vZhtUu0fWD5yxsKAElU=
X-Google-Smtp-Source: ANB0VdbdP7AeCsOPyoE/+KV63LfIPhWo9fWDGgMEeeCXK0+m6esKkJZgDwhaQ/P7q0SIC8V+xt03VQ==
X-Received: by 2002:a5d:674d:: with SMTP id l13-v6mr846628wrw.197.1534970093177;
        Wed, 22 Aug 2018 13:34:53 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id t70-v6sm3280163wmt.30.2018.08.22.13.34.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Aug 2018 13:34:52 -0700 (PDT)
Date:   Wed, 22 Aug 2018 21:34:51 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 10/11] rerere: teach rerere to handle nested conflicts
Message-ID: <20180822203451.GG13316@hank.intra.tgummerer.com>
References: <20180714214443.7184-1-t.gummerer@gmail.com>
 <20180805172037.12530-1-t.gummerer@gmail.com>
 <20180805172037.12530-11-t.gummerer@gmail.com>
 <CACBZZX6xvsZ4K86b53ura6zENs2p0SBjwYYG=h0TNem3wnEbuQ@mail.gmail.com>
 <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsh365qt0.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/22, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > But why not add this to the git-rerere manpage? These technical docs
> > get way less exposure, and in this case we're not describing some
> > interna implementation detail, which the technical docs are for, but
> > something that's user-visible, let's put that in  the user-visiblee
> > docs.
> 
> I actually consider that the documentation describes low-level
> internal implementation detail, which the end users do not care nor
> need to know in order to make use of "rerere".  How would it help
> the end-users to know that the common ancestor portion of diff3
> style conflict does not participate in conflict identification,
> sides of conflicts sometimes get swapped for easier indexing of
> conflicts, or conflict shapes are hashed via SHA-1 to determine
> which subdirectory of $GIT_DIR/rr-cache/ to use to store it, etc.?

Agreed, I don't think this would be very helpful for users.

> By the way, I just noticed that what the last section (i.e. nested
> conflicts) says is completely bogus.  Nested conflicts are handled
> by lengthening markers for conflict in inner-merge and paying
> attention only to the outermost merge.  The only case where the
> conflict markers can appear in the way depicted in the section is
> when the contents from branches being merged had these conflict
> marker looking strings from the beginning---that's "doctor it hurts
> when I do this---don't do it then" situation.  The section may
> describe correctly what the code happens to do when it gets thrown
> such a garbage at, but I do not think it is a useful piece of
> information about a designed behaviour.

Hmm, it does describe what happens in the code, which is what this
patch implements.  Maybe we should rephrase the title here?

Or are you suggesting dropping this patch (and the next one)
completely, as we don't want to try and handle the case where this
kind of garbage is thrown at 'rerere'?  I don't think it would make
sense to drop this documentation without dropping the patch itself, as
it does document how rerere handles this case.  Without this bit of
documentation (but with the code in this patch), the technical
'rerere' documentation feels incomplete to me.
