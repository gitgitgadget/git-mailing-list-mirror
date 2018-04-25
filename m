Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430DD1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756018AbeDYRnG (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 13:43:06 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:41489 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755062AbeDYRnD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 13:43:03 -0400
Received: by mail-pf0-f180.google.com with SMTP id v63so6258293pfk.8
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=SpZiAVwX+gTLIMj02DU8WbeVMu7DcTATShMU8lsNFk0=;
        b=Tbo991lErJnnEaKWKj3BY6p9VElLCsRUy/6qTunFsZF8gt9fom6GrCNn1Ng7N2Sh6+
         I4wUiCufNsor1dTpwbwl0+z9Vk62igH7ljyw5IlUb5d/LfxYNeKW/sXsWJMjECM+xsxF
         FWw2Z05Qh7erCbEY02H2UzoJHTiy5JmzgkivjVnqEJgYlRy9LEArBNs/D6ZuXA9wbTOS
         UQWtQ2SJu5knydCussfRf9bXrkZVE7ngxV33BW5iFzYSW87wb2bo7BYuuu1zWkG2qmHD
         Ze+dujhSvUJ0xW7BHykhUs42PguB7vAuAF/9ZlyXznrmsM8Ps6nyPILJVZjboDSRYCik
         IE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=SpZiAVwX+gTLIMj02DU8WbeVMu7DcTATShMU8lsNFk0=;
        b=ChfyUci8FRP584TKpEpDumOX52pTj7l+AcM5sxYijehKZcj6lfAZQubkqApCVKabTI
         0gU6es/bgti/UC+O1mGBd7IaqN+ppjquW6ORrFAwUnAAQDAXPFyziCXqPc0c2H6mIhFZ
         kEdIWz59nL3Iz49VsFiGUvgl/dHfM4cRQR5UGiJiYnI5wP5nUN6Y4IkDO99r6N6rSrjI
         CZr0pmkXMkisuVjO4TVYawgU2ysDne/6OoOT2FQG6/5VxwnRri5PdeD8QPV2FOouvGFJ
         dXPYp2RamYa2msCUAAjWZN/xndD9GiwTmBU/m5SRWi0XI4xwzdiwOVelCsXZrFNNinvI
         9fGA==
X-Gm-Message-State: ALQs6tAPeqgu+Jysjw5rXlulheLfWhFcCg00JVYvHXbzpa9vrdQz0qqy
        Fb+AfXb3Tw0tP6trjkzBh5MtHy5oyOs=
X-Google-Smtp-Source: AIpwx4/1bIg9mJ78K/lj+JpaEPQL4bC+unTNfv+SuDdW91sr59Mogcg0a/rEoORJHwZXk0+xCkIKsg==
X-Received: by 10.98.236.220 with SMTP id e89mr29031796pfm.33.1524678182720;
        Wed, 25 Apr 2018 10:43:02 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id m66sm39741922pfb.82.2018.04.25.10.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Apr 2018 10:43:01 -0700 (PDT)
Date:   Wed, 25 Apr 2018 10:43:00 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Hesse <mail@eworm.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2018, #03; Wed, 25)
Message-ID: <20180425174300.GA49485@google.com>
References: <xmqqmuxr4r6n.fsf@gitster-ct.c.googlers.com>
 <87zi1rd14k.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zi1rd14k.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/25, Ævar Arnfjörð Bjarmason wrote:
> > * bw/protocol-v2 (2018-03-15) 35 commits
> >   (merged to 'next' on 2018-04-11 at 23ee234a2c)
> >  + remote-curl: don't request v2 when pushing
> >  + remote-curl: implement stateless-connect command
> >  + http: eliminate "# service" line when using protocol v2
> >  + http: don't always add Git-Protocol header
> >  + http: allow providing extra headers for http requests
> >  + remote-curl: store the protocol version the server responded with
> >  + remote-curl: create copy of the service name
> >  + pkt-line: add packet_buf_write_len function
> >  + transport-helper: introduce stateless-connect
> >  + transport-helper: refactor process_connect_service
> >  + transport-helper: remove name parameter
> >  + connect: don't request v2 when pushing
> >  + connect: refactor git_connect to only get the protocol version once
> >  + fetch-pack: support shallow requests
> >  + fetch-pack: perform a fetch using v2
> >  + upload-pack: introduce fetch server command
> >  + push: pass ref prefixes when pushing
> >  + fetch: pass ref prefixes when fetching
> >  + ls-remote: pass ref prefixes when requesting a remote's refs
> >  + transport: convert transport_get_remote_refs to take a list of ref prefixes
> >  + transport: convert get_refs_list to take a list of ref prefixes
> >  + connect: request remote refs using v2
> >  + ls-refs: introduce ls-refs server command
> >  + serve: introduce git-serve
> >  + test-pkt-line: introduce a packet-line test helper
> >  + protocol: introduce enum protocol_version value protocol_v2
> >  + transport: store protocol version
> >  + connect: discover protocol version outside of get_remote_heads
> >  + connect: convert get_remote_heads to use struct packet_reader
> >  + transport: use get_refs_via_connect to get refs
> >  + upload-pack: factor out processing lines
> >  + upload-pack: convert to a builtin
> >  + pkt-line: add delim packet support
> >  + pkt-line: allow peeking a packet line without consuming it
> >  + pkt-line: introduce packet_read_with_status
> >  (this branch is used by bw/server-options.)
> >
> >  The beginning of the next-gen transfer protocol.
> >
> >  Will cook in 'next'.
> 
> With a month & 10 days of no updates & this looking stable it would be
> great to have it in master sooner than later to build on top of it in
> the 2.18 window.

I personally think that this series is ready to graduate to master but I
mentioned to Junio off-list that it might be a good idea to wait until
it has undergone a little more stress testing.  We've been in the
process of trying to get this rolled out to our internal server but due
to a few roadblocks and people being out of the office its taken a bit
longer than I would have liked to get it up and running.  I'm hoping in
another few days/a week I'll have some more data on live traffic.  At
that point I think I'll be more convinced that it will be safe to merge it.

I may be overly cautions but I'm hoping that we can get this right
without needing to do another protocol version bump for a very long
time.  Technically using v2 is hidden behind an "experimental" config
flag so we should still be able to tweak it after the fact if we
absolutely needed to, but I'd like to avoid that if necessary.

-- 
Brandon Williams
