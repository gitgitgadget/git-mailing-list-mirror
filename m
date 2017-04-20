Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B490F1FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 15:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S970665AbdDTPcU (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 11:32:20 -0400
Received: from mail-wr0-f177.google.com ([209.85.128.177]:34760 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S970616AbdDTPcS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 11:32:18 -0400
Received: by mail-wr0-f177.google.com with SMTP id z109so38182730wrb.1
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 08:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=references:in-reply-to:mime-version:message-id
         :content-transfer-encoding:from:subject:date:to;
        bh=wIM82KBiSBy0XZcr0kgAJvuQi+ugOmkpRRGoBEFso+I=;
        b=CUWCGWCyzrO88MU3q9z/0m7hcO+lUzSghNvJ5cPHt+01qf8nNYVXfxOzokC/H47HQg
         PiMHle2YHqjnnJYIX5ieJ4S5cDcVIFBbNX28jI2a3u+gJu5Y1kWZ5ToK85IDELc5khL9
         Wfh8PtwnSUUJdQWc5mlEUj2/UNTaFE3RFtniVQM/jkEmQYX0hhVseR/xIjlmlHLnA/uw
         B0bbFOrRIU5APpHFrFk/WCE6OOKP8ri+30Juv5SVt+zSXZ0M3yAaYq5sT9HrhhsGDd/N
         yvp90ObgWv8wAEWM4ji5U0hpelbX/2xE1mfdMv4q4REgCbLAStqQGjH3BmAtdy+jyT7m
         DWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding:from:subject:date:to;
        bh=wIM82KBiSBy0XZcr0kgAJvuQi+ugOmkpRRGoBEFso+I=;
        b=WouJpaR7oGkdOUZ6nLNG+UYu/BBtUXHwbWFo5EEGRacS8LJviRhMEkuhvMq1pDb6hA
         5P//uLlFw7kcRoowWgdA5jEMfAapiF/MI7c/eIUTAA+/gOxKifeVELAwfbnCkO65Yz5t
         ZRENP8+M2iq65MC5DxHqdMLAXFv2KSt3B3m0lPKrP6w81Ki7BbfihyR5HoGPTh111Xok
         p7V6ZpJqlMWjDe31E3ck3w1SE+PNYn0T9SF58zekUh2+PvjDd3xF4XZT7fFbzHl0Bf3Z
         mjDO5ZDPju4RyS82goHac9a9ce7wdVdXXRlt5q2v5cXTdwqSDDjGf5auJg6jrx247bfq
         4dDg==
X-Gm-Message-State: AN3rC/7DQnRJhq8pK6erlX3+aX14WldNDyhWjPxLFsvg+F9/Tp4YN1tp
        wu4XnizI8GixwnBZCi4eeg==
X-Received: by 10.223.178.236 with SMTP id g99mr127409wrd.126.1492702336578;
        Thu, 20 Apr 2017 08:32:16 -0700 (PDT)
Received: from [172.16.1.94] ([92.70.185.162])
        by smtp.gmail.com with ESMTPSA id s137sm8450189wme.31.2017.04.20.08.32.15
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 08:32:15 -0700 (PDT)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
In-Reply-To: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Received: from [172.16.1.94] ([92.70.185.162]) by smtp.gmail.com with ESMTPSA id h68sm23988052wmd.19.2017.04.20.07.55.11 for <gitster@pobox.com> (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128); Thu, 20 Apr 2017 07:55:11 -0700 (PDT)
Message-Id: <25191991-F4EA-4D91-B291-854F46A34DC2@gmail.com>
Content-Transfer-Encoding: quoted-printable
X-Mailer: iPad Mail (13G36)
From:   Lars Schneider <larsxschneider@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
Date:   Thu, 20 Apr 2017 17:32:13 +0200
To:     git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for sending this email multiple times. My mobile email client created h=
tml... Should be fixed now!

>=20
> * ls/filter-process-delayed (2017-03-06) 1 commit
> - convert: add "status=3Ddelayed" to filter process protocol
>=20
> What's the status of this one???
> cf. <xmqq60jmnmef.fsf@junio-linux.mtv.corp.google.com>

posted v3 here:
https://public-inbox.org/git/20170409191107.20547-1-larsxschneider@gmail.com=
/=20

=46rom my point of view the only open question is if we use an index ("delay=
-id" favored by Peff) or the path (favored by Taylor) to identify delayed it=
ems:=20
https://public-inbox.org/git/20170227095825.jhdspwy6oa6mvvvm@sigill.intra.pe=
ff.net/=20
https://public-inbox.org/git/20170412173404.GA49694@Ida/#r=20

I slightly favor the path approach as it simplifies the protocol. But I also=
 trust Peff's opinion.


> * ls/travis-doc-asciidoctor (2017-04-16) 3 commits
> (merged to 'next' on 2017-04-19 at 359c32953b)
> + travis-ci: unset compiler for jobs that do not need one
> + travis-ci: parallelize documentation build
> + travis-ci: build documentation with AsciiDoc and Asciidoctor
>=20
> Have Travis CI format the documentation with both AsciiDoc and
> AsciiDoctor.
>=20
> Will merge to 'master'.

Can you hold this until next week?
The I would post a v2 and check asciidoc stderr:=20
https://public-inbox.org/git/D9F45212-91F7-4BB1-A0EC-74A84DA81860@gmail.com/=
=20

I can also post an additional patch if you prefer to merge now.

Thanks, Lars


