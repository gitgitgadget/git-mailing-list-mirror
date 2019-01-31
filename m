Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5F461F453
	for <e@80x24.org>; Thu, 31 Jan 2019 00:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfAaABk (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 19:01:40 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42210 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfAaABk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 19:01:40 -0500
Received: by mail-pl1-f181.google.com with SMTP id y1so582864plp.9
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 16:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MJQOvh+ShEwn7Pkji7QAMKICcEftpF2ztop1rjMlwbk=;
        b=jrBrKXZA6JXYBJmxKRn9nF36at9fQqhpl1MWAm8DpD7ukZFQsgyAuC1rCdhiaJaZzy
         U1v73dnSLtAFsBkqfgTMqz6Tg3kV3zKTmBoyjV2jt/AvqyBqcBhZdxte/4ZL2g8TXr4r
         aqgnL7x9tEddrIqkDnoayR452ScV0ZKLht7KD4Mm/TPeZrAQf+IqFzISoeOv5T/IcPAm
         Azn3QDZvhQZ2KcUk2p0Az+ggPLSGdv0zZWEGyPUsTdoM0luP070Whh4TDx15VPmMly9h
         xrNfRHtVZIoiswITAsaeTEgKo4nnEe+X4IsGWoYUYXSvpgLXEdkyZwXW6fttlkLOZfs7
         1jmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MJQOvh+ShEwn7Pkji7QAMKICcEftpF2ztop1rjMlwbk=;
        b=dqXCxtxdNFN0Mog8Aiw7IEofrV82vORPll85XUNrIBXYeTc3gPVr7QQotfVyYSF+GK
         R2bcBb+05/lpJcOQOpbi1LeGVciUtFbHsDWlLW7igWokU/O0gaAP6AwGcqWhbik58c0X
         4aZEMy4LQio6+RzyL2B5KFLjgQfV5Zzf0Zjqm0vORJ0/wBcIjvYOd6MJFmjn/A+Nm2ea
         hEWMEEM7wwGmYt8dAzoz/TQ9/PMSD9bmR7+Bjke7FJ7JaswN4Q6xAZRs2GcVcpFAg748
         dViiOohYeqCSTUOuBTSFjJl6mdoV0En3AQJYkKyXEF3gjILUhdY5nm8UzFHiZ9S04hR4
         +lOw==
X-Gm-Message-State: AJcUukdMruu/3ObBsXjtx9kWI+FAjswdk7mgrQnXIeWcAykxqJUKyV0J
        e6/3ucW6N10SMK4YDXYM/34=
X-Google-Smtp-Source: ALg8bN5gxPd6tPYE0Egx0cEgliRNa6pyXC3x/FDYcfLTkL2E9lBA2gZqNbhJQF2/59NsxaCVXdj23g==
X-Received: by 2002:a17:902:d90d:: with SMTP id c13mr26996357plz.31.1548892899414;
        Wed, 30 Jan 2019 16:01:39 -0800 (PST)
Received: from gmail.com (105.35.197.35.bc.googleusercontent.com. [35.197.35.105])
        by smtp.gmail.com with ESMTPSA id o8sm5284442pfa.42.2019.01.30.16.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 16:01:38 -0800 (PST)
Date:   Wed, 30 Jan 2019 16:01:37 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH (Apple Git) 12/13] Enable support for Xcode.app-bundled
 gitconfig
Message-ID: <20190131000137.GB23492@gmail.com>
References: <20190129193818.8645-1-jeremyhu@apple.com>
 <20190129193818.8645-13-jeremyhu@apple.com>
 <xmqqo97z5ac9.fsf@gitster-ct.c.googlers.com>
 <7A37A7C1-6B82-44F8-AECB-189A57B94FBD@apple.com>
 <nycvar.QRO.7.76.6.1901302030100.41@tvgsbejvaqbjf.bet>
 <EE1DF652-C42D-4106-8A81-55262EC578D0@apple.com>
 <8507DB9E-A76E-4038-BDB6-110066865C1E@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8507DB9E-A76E-4038-BDB6-110066865C1E@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeremy Huddleston Sequoia wrote:

> Unfortunately, I was quick to celebrate.  This picks up the bundled
> file instead of a system-wide file.  I'd love it if we could still
> honor system-wide config/attributes in addition to
> RUNTIME_PREFIX-relative ones (eg: user overrides system which
> overrides distribution).  I worry that as is, we'd stop referencing
> the system-wide configs which might confuse users.
> 
> Is that something you'd be interested in, or should we just continue
> to maintain our separate patches?

For the internal deployment at Google, what we've done is to put an
[include] path directive in the global gitconfig:

	[include]
		path = /usr/share/git-core/config

Users can edit the global git config in etc, but the distributed
config at /usr/share/git-core/config is read-only as part of the
distributed package.

We considered making an upstream change to bake in the distributed
config in the git binary but decided that this way is a little
nicer since it lets people comment out the include.path setting if
they want to e.g. for experimentation.  It's also more explicit
(hence easier to understand).

Would a similar approach work for your setup?  Can you say a little
more about how you'd like things to work from an end-user pov?

Thanks,
Jonathan
