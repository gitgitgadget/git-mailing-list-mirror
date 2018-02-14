Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05A2A1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966364AbeBNB06 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:26:58 -0500
Received: from mail-wr0-f170.google.com ([209.85.128.170]:34328 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966298AbeBNB05 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:26:57 -0500
Received: by mail-wr0-f170.google.com with SMTP id m5so8370406wrg.1
        for <git@vger.kernel.org>; Tue, 13 Feb 2018 17:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=mg0OWKO/WGXmViE2o7caC6S0o8n0Yd18p3/LUYiB5us=;
        b=ek0mCFhHjjEzFrne+Rg+Mbmuxxr/VHc8EJ+aMWfr+n2vA+pFG2TxMY6FayK3yS1hiX
         Wl3TRgjvdwB/EbsfQEBUcQ0+56apJKsB+Jbk1eL0/bhb8g3rmDY/xDsgZ/TKKtZfoDFo
         Q+fBnujPc77AjZNBO9kSmDOkbzp9HKl+RqPpCjf6LSRcik3jF80cINpyILwrsgZFH0E/
         4dCuT71m+x/ZUBp++Chhcfj2O+2PttxA/hlNV43IeDo8A/+g2K8ggEyn0XCk/oU7xqnK
         RjXG4dNdMmxXUXJbLx2BlMqZkBYQ4pGK/1LlceajamPl4DpL+LwoQb9qadpTK8SzGEcA
         FWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=mg0OWKO/WGXmViE2o7caC6S0o8n0Yd18p3/LUYiB5us=;
        b=l9ilbNmggm/9zxDMJh035kc/In9P0YM+gdtXb2tKi+fs2LBGfecI82fdITlINWjtcv
         kwDQkLoKL3Te6LLk0gAEwwxO8y+4raqaIeBVH0qtWTz+xWCaIEr6XrJgR7Tqwht1doDH
         Z61AP3NFOKcLBn57psieDRPTPqpxJnorfdIxdHvPI2sedl0GIP2MoyvCr9m9KhDag7fE
         Pk82BREclHAHgD2qFjDkv1tuM6fWRGL6RNpdMDq0+lOdTNTEsg5Ru7OxBjpEQz/bpQH5
         NvMzQ2ju9LzVRn+531G7uCxLNyEwcr88Qlj6DnRip0QQu1+ypVfzUYgmB0c6bGKhbl6V
         BzNA==
X-Gm-Message-State: APf1xPDb/wtB014mLzMp4l1n0YTl6x65bPzDLmkC9YjBKC06uSWcsDom
        iTb2L0cvQvU5qqXaT0Fth94=
X-Google-Smtp-Source: AH8x224BOEbWgU8WgO2P3qhqvfEuzaIfzoroowJBaeA0ivF/Gpzm0/ge9WTZqFJbGx0nlYID3+2+oA==
X-Received: by 10.223.186.15 with SMTP id o15mr3000324wrg.101.1518571615608;
        Tue, 13 Feb 2018 17:26:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z78sm8007016wrc.53.2018.02.13.17.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Feb 2018 17:26:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 003/194] object-store: move packed_git and packed_git_mru to object store
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235508.216277-4-sbeller@google.com>
        <xmqqsha9vmqt.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kacD5Bevw==v3fbyWmz0FiDDM5ypkYuxHxbXJM62FX40w@mail.gmail.com>
        <xmqqsha5sywh.fsf@gitster-ct.c.googlers.com>
        <212094a6-f1bd-c4cd-01f9-e819a701cfac@web.de>
        <xmqqbmgtswuq.fsf@gitster-ct.c.googlers.com>
        <8b8f6e8c-9077-793b-81d7-8769eee31e66@web.de>
Date:   Tue, 13 Feb 2018 17:26:53 -0800
In-Reply-To: <8b8f6e8c-9077-793b-81d7-8769eee31e66@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 13 Feb 2018 19:52:33 +0100")
Message-ID: <xmqqeflopdia.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> A short semantic patch with a limited time of usefulness and possible
> side-effects can easily be included in a commit message, of course..

Yeah, I think that is Jonathan's favourite approach as well, and I
do not have problem with that.  This transition spatch is unlike the
"avoid strbuf_addf when we do not have to use it" one, in that there
is a definite cut-over where the old way becomes an invalid C code
and compilers can help us spot unconverted places (as opposed to a
valid but unwanted way that can come into the codebase after one
round of code cleaning is done, which is a useful thing to catch
with the "make coccicheck" target).

