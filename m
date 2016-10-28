Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31C4D2035F
	for <e@80x24.org>; Fri, 28 Oct 2016 17:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756400AbcJ1RiF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 13:38:05 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36321 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbcJ1RiE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 13:38:04 -0400
Received: by mail-oi0-f68.google.com with SMTP id e12so1439129oib.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2016 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=lddYxeSehf3pqSik5Z0Q46wQqxrWqV1J3hXmeJ03Rc4=;
        b=NI7mDa1G50Rb2s60x5SXCNavxpmSAHEQorP/QzjDDNf2EW/5veFQel8yUllOdpEV+5
         tzKnmZcKbRWsGEp6PUeFa+1IzMq7Fm0pkp8oXQPp39nzSBVh9l1OU2VgJQZRsi6CJyyO
         bbOJMKmN5QDkofBX2cLvQJcF2MD+oqvuoCrELQ8wOfxiiSCE6sQsH3E1t7GnMcMgZSsQ
         dd3bIrSl0JplWtFiCmStkM0HJjHpTgtu4aVzmBEltfvRIonQkUTpYb+SKw/GC7H0A1G2
         MjsT9ZXPuJ9WcetIL5I54elNSdSfq8v40UdzRBNfi+JAYZbaJKpsg0BD6Rr6otqcdLU1
         OXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=lddYxeSehf3pqSik5Z0Q46wQqxrWqV1J3hXmeJ03Rc4=;
        b=NP90nZ831e93cY1ClJiZYHItnnimqLX5j2sezT7Ah+idZX/Xzj7FCRXFXhS8cTNbY9
         UOS3Zde0SOrWVtLwwO+uaxXJiVB4EWnzQqZzzMPY/GaHi/W1onnvZ1pSXzx7FNuYR7pS
         uRDBCt4inhv+QKozYrYzQkYVraAALQgjalTTJe6KSus4JiUSnxoVH6TXYrTUfA9K8bWO
         dzG56oSjmH8brdz5RuMKi6h7M1yoaVN7qAcSC9tpmJjbPe7VE/2N0j7GVF9mGLzLlMxW
         m2YdiqavWhkMheARpQqU5n+yqz7bQIGNJRxyGzU5okt4ClshwcfcSb8yacY2q8+sbjrg
         0PhQ==
X-Gm-Message-State: ABUngvce1VeHVPjpsSApJnLn9RfD0tO0rodYmxjve0U7YBbmQMdaK+LGFEaj/sGTGB6hf6wqmTLSZ1RUpDvAWg==
X-Received: by 10.202.58.2 with SMTP id h2mr15140113oia.115.1477676284086;
 Fri, 28 Oct 2016 10:38:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.142.104 with HTTP; Fri, 28 Oct 2016 10:38:03 -0700 (PDT)
In-Reply-To: <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com> <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net> <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net> <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
 <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net> <xmqqd1imbymi.fsf@gitster.mtv.corp.google.com>
 <20161027102419.dbzigj7wtr355ofh@sigill.intra.peff.net> <CA+55aFwfhFqV74s_O=GucycY9U19ysiACDqX=mK4Gf=eQ0coxQ@mail.gmail.com>
 <xmqqoa254czs.fsf@gitster.mtv.corp.google.com> <CA+55aFxTHF4BRfcrCiV1D26-be+_rPhwAV+Vq8Roz-NMpPBadg@mail.gmail.com>
 <CA+55aFxdy4maom8byH0FoBBMWx+sQB8J7uWvHOxswjiaAhSjVg@mail.gmail.com>
 <xmqqfunh4b63.fsf@gitster.mtv.corp.google.com> <CA+55aFw83E+zOd+z5h-CA-3NhrLjVr-anL6pubrSWttYx3zu8g@mail.gmail.com>
 <xmqqa8dp46wx.fsf@gitster.mtv.corp.google.com> <xmqq60od42s0.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1610281306320.3264@virtualbox> <CA+55aFw93vkraxBvFCXFSYJqn836tXW+OCOFuToN+HaxTcJ7cg@mail.gmail.com>
 <xmqqshrg1ksv.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2016 10:38:03 -0700
X-Google-Sender-Auth: g0OVAqAEVUMr2_Xaiy6GxlmSy28
Message-ID: <CA+55aFwUEzfvWVSZfhBi85QaKWSo-gVMOk1BJFrR0ZsdCRHRsg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with O_CLOEXEC
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 28, 2016 at 9:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Excuse me, but care to elaborate a bit more?

It just seems entirely pointless to change the games with O_xyz.

> Setting FD_CLOEXEC with fcntl(2) may be racy, but in what way
> it is broken to open(2) with O_CLOEXEC?

Apparently windows doesn't even support it, at least not mingw. So
you'll have to have some supprt for just explicitly closing things at
execve anyway. And if you do that for windows, then what's the point
of using O_CLOEXEC on Linux, and having two totally different paths
that will just mean maintenance headache.

In contrast, O_NOATIME isn't a maintenance problem, since it's purely
an optimization and has no semantic difference, so it not existing on
some platform is immaterial.

End result: leave O_NOATIME as it is (working), and just forget about O_CLOEXEC.

I have no actual idea about mingw support for this, but Johannes'
email certainly implies it's painful on Windows. Some googling also
shows people doing things like

  #ifdef O_CLOEXEC
          flags |= O_CLOEXEC;
  #endif

or

  #ifndef O_CLOEXEC
  #define O_CLOEXEC 0
  #endif

so O_CLOEXEC definitely isn't considered portable. Do you really want
to rely on it?

              Linus
