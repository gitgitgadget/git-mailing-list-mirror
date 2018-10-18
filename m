Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0B951F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeJRK2q (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 06:28:46 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39815 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbeJRK2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 06:28:46 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so4083010wmd.4
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6i1sv4wNbXHxPYDcX/pu77aoj/jPtKrFTs7/GW4Cxo8=;
        b=RQtyEJtJS9ZFZaJCdzBnB7aN+MUzaNP0Lvcz+sNds0tyErqqCv4XgEgV+v3hQUIcqG
         NyrpzBUUyZ0gvcppBYyMb/SXrOEhPMwVWewgdPqZ17OwzpoK0jo3SR+zVwvxC410Xohw
         WnU9raQBeTgbDt1/OwGg/YIDcF0d6Czi46twTSQ7Wpf7eP6ISEEa5aHdC+i7ydrJWhGo
         x7BHz+7XfhwnqUk5+BMgL4CddWya1AZm2+GOkLx5KGzh51yPNRdRyYRXKJ+BpBthREMU
         8H8OuGFtuVEgnUWno/+7vvjJ7OeEXjuiEz2JEFfVskOJ9R0zKD+rsY5Uj6QfOpM/MLlj
         3iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6i1sv4wNbXHxPYDcX/pu77aoj/jPtKrFTs7/GW4Cxo8=;
        b=lcdtAuRZba7gs6QvX62iJpOxCeXEmpYBnadQQ7Tod24OeqFlOyR+hHRR780Jd8zk7e
         QD3ZqZxPg1ndIbEWQZLOvxuAwhCGfsvZxD0ghHfEu41rf4HTKzrV0z0oHsoVm9sUJFD+
         dWFLTtvQ6VAPki8r2l92B1Zl+WAiqHMxMFJHGKpMF7V8qla0H4yhGiTpco1qIhUNKX1T
         uEk3jONASEqjwKl9MBe659xN39v0YbfWYT+rRrU/3M3GUeCH28NePiYbTK2fF7n5UBeG
         XheWW/2nRKBOR0yqPdNMrfm6sHlsP/uFHo8Feua8BdwQXzmNSBPSyTUS9UCIKz3sZWBd
         Pnmw==
X-Gm-Message-State: ABuFfojeAItfsqskCJbZvLag4seyejOsW3iHT3bZRS0Tv44dgWZF7ox/
        m9/d8hLFZPKGx9EaL1+tgnxn7B4QLjI=
X-Google-Smtp-Source: ACcGV621w+GtpZFSAKF8ELtyGv9XftpO79OUF2PVjs3nyURynJ06NXP/Zf2k5lSQgbznvAoOs/RewQ==
X-Received: by 2002:a1c:9e93:: with SMTP id h141-v6mr5529624wme.56.1539829806251;
        Wed, 17 Oct 2018 19:30:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1335748wmd.0.2018.10.17.19.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:30:04 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/9] Resending sb/submodule-recursive-fetch-gets-the-tip
References: <20181016181327.107186-1-sbeller@google.com>
Date:   Thu, 18 Oct 2018 11:30:03 +0900
In-Reply-To: <20181016181327.107186-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 16 Oct 2018 11:13:18 -0700")
Message-ID: <xmqqbm7svvf8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is based on ao/submodule-wo-gitmodules-checked-out.

Thanks.  I had an impression that we were not entirely happy with
the topic and are expecting a reroll, but let's hope that the part
we expect to be updated won't have much overlaps.

> A range-diff below shows how picking a different base changed the patches,
> apart from that no further adjustments have been made.

Thanks.  Let's see how well this plays together with other topics in 'pu'.q
