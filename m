Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 213391FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 05:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752848AbdBHFN2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 00:13:28 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33257 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbdBHFN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 00:13:27 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so10789441pfg.0
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 21:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2V+RM4/BcJOODzlRquguE0Zr06LfV/LbaUaiotqbdCA=;
        b=p2N2jwWirSoWIY5H3HnHflvR0hxyhK4znsLGoizxoXFijK+RDuFN2F+CDK2KbRTRGV
         mwjo/gvknFrSJvrIzAOlDgjsUU08fFxKhZu44DV1OQw6JmL6jcEjSXpbUGfmvCICHrnS
         VmCweFtbSmh2kwGWR58ZiWLcpVrI14F+y2L9ASLgkxlkn/GCSUuArVg7HAb2D3RoFYOS
         hjoKmc9KUBl9LAmoIXGGYYcWGGyLJjzNf8XQlVwqS7SYdu8IlT/d2Ru/ojcDVoejebZe
         x4Bhj1DpyVpJAjA6mf7rMSBlA+8eK7pMOgRw9dJPi0ZE6w7aaEGEcvu7iqeF8M6/bca4
         /6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version;
        bh=2V+RM4/BcJOODzlRquguE0Zr06LfV/LbaUaiotqbdCA=;
        b=Jat27pjC+AYkemBZFxawlTNrluFWKCuTsWmgkb3NDQDSx/fBLNKeejNOxdWcPSo6Xc
         jrqjNo26+cueFvE15cXmI0tyZQngMUAfq36XHbnpnInyXGOcvk1xu+BDbNmiq1HIVM61
         L4UXCpaWtzK1X0bhpBnMCykZkIZBoWHVrH3W5v71ifFmsGp7HHuGg/Ld+6GG8e/bVm2a
         jIs+md5FJIgMSiBCPe1q5s6o4ZyCLeTrL+vn23qlFwzGTSPSb88xclZmvYi1hsL26p4Q
         kWrU9p2ChAIWEZ2vUsp+TEQmQsJhEa9ol168Ss5zAOJdaDTIoTODgNBfC48N78wvklPc
         pyZg==
X-Gm-Message-State: AIkVDXJwObWz0XZaI1uINycyBPGtFU4+IgBV/v7+A0SBb9HE05Rtnpct/EzNRYwVpr18xA==
X-Received: by 10.99.166.17 with SMTP id t17mr25135657pge.196.1486530777071;
        Tue, 07 Feb 2017 21:12:57 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id e90sm15712471pfl.32.2017.02.07.21.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 21:12:56 -0800 (PST)
Date:   Tue, 7 Feb 2017 21:12:55 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
In-Reply-To: <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.20.1702072112160.25002@i7.lan>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com> <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com> <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com> <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com> <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com> <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Tue, 7 Feb 2017, Junio C Hamano wrote:
> > +		// Special case alias for '!'
> 
> /* style? */

Will fix.

> I somehow do not think this is correct.  I expect
> 
> 	cd t && git grep -e foo -- :^perf/
> 
> to look into things in 't' except for things in 't/perf', but the
> above will grab hits from ../Documentation/ etc.  We need to pay
> attention to PATHSPEC_PREFER_CWD bit in the flags word, I think.

Ok, that's easy enough.

Two-patch series to follow.

              Linus
