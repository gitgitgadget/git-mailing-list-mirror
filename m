Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E9BC207D2
	for <e@80x24.org>; Sat, 24 Jun 2017 00:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754499AbdFXAhi (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 20:37:38 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35723 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754126AbdFXAhh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 20:37:37 -0400
Received: by mail-pf0-f194.google.com with SMTP id s66so9531982pfs.2
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 17:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zKSfIqZdP0p7jiQw2hXwS3GnhlSAy8VdV/mPcgSXKqw=;
        b=PmkbIuikcw2YbEW/KBp8llT44H1XTfEx7rIebQWfO5uH77EaDVsewDOFUPfQSXGRws
         tDGyFu/9crdVkZ/AN5BG7PCDf9n4Pp+pc8ddJtdRYS8Hx/6LJV/Z7o0dGQ2jAx9vY1Jx
         puH5qwYyfJuJX1KpEQ5OYBO+0Bpiw+ArPrX/ddmWj33yXu7Fu7xCoL8/pbeHKmHxVgjY
         uPzcSD7EbwHx3nmQq6+SdF5K8DT5tKi+dcB7zklgvD7lsnkf1yP7itkCEToymLifH87t
         1W9dWFyBoL8krw7qdzlQH5IQVZy+JMaeStMY0URqQFIklS/aWyrYrR8wEJk3Cx6YjHbE
         B4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zKSfIqZdP0p7jiQw2hXwS3GnhlSAy8VdV/mPcgSXKqw=;
        b=Co8hFG3NbaKI9t4m2ZO1IVFZEtqMEQ3UrCoWT9Ya/uUCI+J/wS7SbH4uvr90tA72pQ
         mBDDgcJ5NKvviEbaMy+8QfY2V8yO7etrHsrKAtXOwvI4EvFTJ3NfJgN9xvYqiil/HbPM
         tyTdPS6kWeLqMSiUCDz4RChkbihYZa31SGczWWiHQ7I+wKWLkELhesNOEcDQuDqzfv4E
         NvYk6zz6zvVHrmeluVikpb6GNgfxJMlpHCwvUd71K2bpWStrVJCeTJk7KpV+0SqmJbIT
         a2p8mu2HIhR5ajGTO7imXF4kwWDlUYlZpc5Q8qtW5REXFRZ4t2FPv96aZHKkD8Q6iDmI
         wIvQ==
X-Gm-Message-State: AKS2vOw/CgJNtjwL5Gh97u17k3oNDtYRy4GWv4snCmzZP+XM3drrHyRw
        pvULdKQhE+MhFQ==
X-Received: by 10.99.146.88 with SMTP id s24mr10513419pgn.85.1498264656962;
        Fri, 23 Jun 2017 17:37:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id v62sm10778277pfb.124.2017.06.23.17.37.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 17:37:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #06; Thu, 22)
References: <xmqqinjnhcr8.fsf@gitster.mtv.corp.google.com>
        <871sqajrgi.fsf@gmail.com>
        <CAGZ79kZyMUKPahTXOF7ds6zSvFKLrM2N78JKG-2+GRL5nnmuvA@mail.gmail.com>
Date:   Fri, 23 Jun 2017 17:37:35 -0700
In-Reply-To: <CAGZ79kZyMUKPahTXOF7ds6zSvFKLrM2N78JKG-2+GRL5nnmuvA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 23 Jun 2017 16:39:55 -0700")
Message-ID: <xmqq60fmb4q8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> * add some heuristic to omit small blobs, (empty lines, closing braces)
>   Maybe this is can be solved by not considering anything
>   that occurs multiple times?

I vaguely recall that we had to do something similar in "blame -C"
where it tries to avoid passing blame for insignificant changes down
as copied.  But for the purpose of this "moved line coloring",
excluding multiple copy destinations of the same thing may be a
simpler and more robust solution.  It will not catch "somebody
stupidly removed one function and made two private copies", though.

