Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5348C1F404
	for <e@80x24.org>; Fri,  9 Mar 2018 19:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932269AbeCITEk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 14:04:40 -0500
Received: from mail-wr0-f178.google.com ([209.85.128.178]:36538 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCITEj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 14:04:39 -0500
Received: by mail-wr0-f178.google.com with SMTP id v111so9990257wrb.3
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 11:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FzTF+4eOc9nmEPRfX6B7rIL3WswdY3tadd2k8mvUPlw=;
        b=GJZhUUPMQKDkFR/kndS8+wm+m8scmY+nNl8YW+ZUa8lCxzJVNpdGEYK5XQwBk8RDmf
         2QmP7C9lzcoql9BGZuEfzcLQyQ0BKj9Rtg3J7aB7kHFw7Fm+3s1EANRg8DYo9MITJeo6
         40dO4Ax4f1QSLIv43fZIfUqtabK6EYVlcKG61ocU2zvloQuOC1RJNt8upSN2PsUYyjCX
         QQFaV3fvVkcNpax+wxCHnkuYZuPR+NNC2E9o14faCSujGWFAvqQbNEpMfsB3ruKfugYA
         C2RUlqjOC/StdPkJNPIxgGyk9Y8Bm2jGq8eV51uHVhi/Zgvx71UYSmMLhhlLD/j6Evvn
         foZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FzTF+4eOc9nmEPRfX6B7rIL3WswdY3tadd2k8mvUPlw=;
        b=pZZ1iA4FEA+VCMWPtdKTiJ9MpchPYArNLiUGHkDmrL0T4LL3EyVDESPSIDJ8ucdJ2/
         o9+CCD/4HIubGsWYGtJTrLrpBKOmkoSXLxkLdllejv2sEMbZWf9wMJ1OQINY3VH/90ZT
         8gl4zi9uwPsdMGtopatP59dZHWgs87h7jpfpNziQ5CI2TjaYFXK6F9cTJp/IphW9g9Kc
         3L4aJTXm5I2kMrlwl0PE0n3uwyG7fn12/FsTSh9yZ1rGCg7A3ma/QvUG170NjcQXq51L
         5Ofge+Y6JG3ZgaRSK+ntG8+xlT7+8IVY7s0y0ylXfDIoeMy01sgJdpToWgqkrXhwogkR
         glmQ==
X-Gm-Message-State: APf1xPBc5v/9Xn5f/1IQzdO0O+hGX19vH9xcNJtu6+4hD4oClX9ViR7K
        N76bRSyke+fFDJxJe3gQ3Yg=
X-Google-Smtp-Source: AG47ELsLtl+CVVoPLVjcT5N5EwYwiFfTFdeZhH44/6NM0O8/UcNuMthfHyYiViA7QyMrhvG2ddMxKw==
X-Received: by 10.223.131.38 with SMTP id 35mr26707438wrd.197.1520622277945;
        Fri, 09 Mar 2018 11:04:37 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5BF6.dip0.t-ipconnect.de. [93.219.91.246])
        by smtp.gmail.com with ESMTPSA id r128sm2008004wmf.37.2018.03.09.11.04.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 09 Mar 2018 11:04:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v11 07/10] convert: check for detectable errors in UTF encodings
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqy3j15b2h.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 9 Mar 2018 20:04:34 +0100
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <AB377212-0551-4DFF-A953-734DC847934B@gmail.com>
References: <20180309173536.62012-1-lars.schneider@autodesk.com> <20180309173536.62012-8-lars.schneider@autodesk.com> <xmqqy3j15b2h.fsf@gitster-ct.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 09 Mar 2018, at 20:00, Junio C Hamano <gitster@pobox.com> wrote:
> 
> lars.schneider@autodesk.com writes:
> 
>> +			const char *advise_msg = _(
>> +				"The file '%s' contains a byte order "
>> +				"mark (BOM). Please use %.6s as "
>> +				"working-tree-encoding.");
> 
> I know that this will go away in a later step, but why ".6"?

I deleted the original comment in the rebase, sorry:

    /*
     * This advice is shown for UTF-??BE and UTF-??LE
     * encodings. We truncate the encoding name to 6
     * chars with %.6s to cut off the last two "byte
     * order" characters.
     */

- Lars
