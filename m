Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 824A41F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbeGSRU1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:20:27 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39373 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbeGSRU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:20:27 -0400
Received: by mail-wr1-f47.google.com with SMTP id h10-v6so8692570wre.6
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DLA7ktlRsWH/sDKpiYtqN48dZH8xzl/vrCdsp6Ovhj8=;
        b=j71pFWlBthr72Xt5iZMYd9vPNWYKEX3mt0JwiGClFP0Ltx2CCXhv+pEAWaFbNWTdFw
         uDgEp+Azsm3wqj8P26hKd4OQ1tDoUTmZMQ3wP+AuJQdYw6fITE1ys+uEbTfLvV62g08p
         06yb46v06DEbrkoPzm9+6neQfrF0JgdbyPmmBX3sxuWMXWtXJOLxKerGL/fMflJOjsrq
         UtiolCWB1RrPLtNTRcKR4q43/kWgxnmL35sHikXNa+aYYVdleEHiBiJ0+9bPViBmxjjc
         oQdGNmYhhxPdGtimSQyis7KvhCKJKuXgyhpOFQFxSJp7u41BQBoLLTPYaEei6vhZU11W
         +dDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DLA7ktlRsWH/sDKpiYtqN48dZH8xzl/vrCdsp6Ovhj8=;
        b=Nb0YoDcdiL47kTAPZofqzhOWCjVYMzzpFqfOqyx6fJ7ua8uPpxHpmhN05o0IXz8erZ
         JC8FC8Xs+qa8Aw7GWm2x4Y9sYDkK9P140yj3CRoyfO6iH9/bib+4bYs5sKKjTWfVjvdE
         ZPQmt2Xmlk8xI0vDMUT8Ptfar/WCEbgDOQhkIHv9XuedNf1XUDU+NvYCPzvSFSy1q2Hz
         9eXpxP0AZyfeqyC1wO3M9gZh4Hkc3bdWosa4TDQbFdf2prs64M2UFPsELE3jE7ix/a8U
         qnQE9dAqtrhueGBsRN7HB8M/6wWFZyZBgW2S1IB6FAkFoUi4m6XcY1YSvdz4qmZ9h2OW
         mf2g==
X-Gm-Message-State: AOUpUlFruflbC4u+pad5tZZKU3rPowiIT42p2zF6Lj5d6g+FN+1qCkMH
        hQC7bmWPjI/TU5U74gDDqig=
X-Google-Smtp-Source: AAOMgperYP7gv0KawUGvWyS4ZV4Dqk7FCuwlPjZkgpzWxHpOE8FTqvs1KOzblVN8YaMamVEEJBqU9g==
X-Received: by 2002:adf:80c9:: with SMTP id 67-v6mr7675711wrl.95.1532018188345;
        Thu, 19 Jul 2018 09:36:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v1-v6sm17806442wrs.34.2018.07.19.09.36.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 09:36:27 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
        <CAPig+cQTWHzYZ9+LqadhZ=u-NkDOtmf7gDL5MvahC3=SCfjhZA@mail.gmail.com>
Date:   Thu, 19 Jul 2018 09:36:27 -0700
In-Reply-To: <CAPig+cQTWHzYZ9+LqadhZ=u-NkDOtmf7gDL5MvahC3=SCfjhZA@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 19 Jul 2018 04:48:09 -0400")
Message-ID: <xmqqeffzgp2s.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I guess the two fixup!'s were meant to be squashed (and it's probably
> too late to do so now?).

I guess so.  That is what we get from trying to be nice to reduce
the number of iterations and cheating by short-circuitting the
process X-<.
