Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F091B1F453
	for <e@80x24.org>; Wed, 17 Oct 2018 13:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeJQV2X (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 17:28:23 -0400
Received: from resqmta-po-12v.sys.comcast.net ([96.114.154.171]:36514 "EHLO
        resqmta-po-12v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727337AbeJQV2X (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Oct 2018 17:28:23 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Oct 2018 17:28:22 EDT
Received: from resomta-po-16v.sys.comcast.net ([96.114.154.240])
        by resqmta-po-12v.sys.comcast.net with ESMTP
        id Clb7gmbRcKkHICloNgoudW; Wed, 17 Oct 2018 13:24:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1539782671;
        bh=zgGWcO+yr4Iqj6fWHd5oLCAngt0Oj/Hvp6j6Gxu343o=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=h6VjHTGLLbuHZ9IfOKq03KyaYqmQ0dJxOjOfIVzyp4Agh++zeMVMQWiiAlHI+1bQR
         aoM40LycMbeSe3Nj/NCSfdPnh4JRbx/3XQr8Fj8ChgXyEl4fPowLr5+GndGb6yy/Z5
         0VYWI4qH6UyyjkZoUp40q/UK84xR8sjR1rOeJssXprg3o/vJ9Ac9114sz0gv7KbCPI
         klI5WsrbUPdHOz61NFjyL387Id8yd0wftj+mLxt7ORrzc9mnUNAxB5dhiZaE/aO7hu
         9F6cBVsp4e2XFT7AnjhRFNowyvaJtkoO2boTCa8hiZh9xP7zf4PWQUrG0U/6YEG6ol
         nxqk4yPZE8u2w==
Received: from [2620:0:100e:913:4957:471c:6cae:55cb] ([IPv6:2620:0:100e:913:4957:471c:6cae:55cb])
        by resomta-po-16v.sys.comcast.net with ESMTPSA
        id ClnxgayjoLvnvClo8gmqzl; Wed, 17 Oct 2018 13:24:29 +0000
Date:   Wed, 17 Oct 2018 06:24:05 -0700 (PDT)
From:   Matthew DeVore <matvore@comcast.net>
X-X-Sender: matvore@matvore-linux.svl.corp.google.com
To:     Jeff King <peff@peff.net>
cc:     Andreas Gruenbacher <agruenba@redhat.com>, git@vger.kernel.org,
        rpeterso@redhat.com, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] revision: Add --sticky-default option
In-Reply-To: <20181017091215.GA2052@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1810170620260.166761@matvore-linux.svl.corp.google.com>
References: <20181016212438.30176-1-agruenba@redhat.com> <20181017091215.GA2052@sigill.intra.peff.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-CMAE-Envelope: MS4wfHsW/T4Q+U1tuZAm1T+gAOV3oRPOg/rozio7wdwj1mkEhSj9v3V5mocZK3ka9H/kuKyae/jge0Ap/nhD+EI5yykZTyFTYON6XrQLsA/Pyyfwl2txuxnD
 LdJJ1Sn/tDlAnAp3r2PiENKbRqDEulcYyz+JfiTswg4J9+vR/oLoL55dDPwvfARanBRkqx7hBl2whRq2jRHkymNxc8KGNyJLvGXPumcJ0KEhFLfKHTaV8GXi
 77CSbiYCgDxtA5d8Fyk2FiOje272IgY4cv6Ja6w2mc9W7HQf+lYRkeuRvkVBPQbqsz3adi77EF7bLlIIrzcoldXxvaxEEV1owpqy4wnOnlr5VpHgx/mgNLgD
 jrCrJuLfq8hzK+NwpNYq7RYNEciE2w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, 17 Oct 2018, Jeff King wrote:

>
> Yuck, t4202 is a mix of older and newer styles. I'm OK with this as-is
> because you've matched the surrounding code, but these days I'd probably
> write:
>
>  test_expect_success '--sticky-default ^<rev>' '
> 	{
> 		echo sixth
> 		echo fifth
> 	} >expect &&
> 	git log --format=%s --sticky-default ^HEAD~2 >actual &&
> 	test_cmp expect actual
>  '
>

How about test_write_lines? That is a little more readable to me than
the echos in a subshell. A patch was recently queued with a usage of
that function:

https://public-inbox.org/git/CAMfpvhK4a15gd-PT3W+4YJmpe6c7HyhJE5N_UqOzu8gsYYej4A@mail.gmail.com/T/#m9b5ade1551722938ac97b75af58fec195f246c01

- Matt
