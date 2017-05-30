Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4008D20D0A
	for <e@80x24.org>; Tue, 30 May 2017 01:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750994AbdE3Bz7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 May 2017 21:55:59 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34933 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750904AbdE3Bz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2017 21:55:59 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so14387275pfd.2
        for <git@vger.kernel.org>; Mon, 29 May 2017 18:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cVjGQ/alQr1Wgl4ml6/3rAFGflTIVx5Z65Fv9pWFsgE=;
        b=VmYia+AdFJ/44QubLYZSVVCNqyxg/J7uZaKl5hcanc+WGKhYPlwTsmdByzunWEDx+U
         x+XU28dypxmCMVb23Fh1VA5Bs1ffOteiohhHsH3JZLkVqjMICRrn7VQos+J08fi3q5NR
         ZvrXGBFgnAKCCJTW69OzxVzzYILHDIqXIvgXIFBrl9O/PfW8RL1k/vhUpNSYyahyog1f
         QwSZHQ0dX/SjTzr1yp9znoG4SlRoGbghdHLizxSiBKnKoKrc309vVuGKmFVze8qmjnc6
         noo1PZZH7ri/LKidB+XZZ39tbKNPNUu5AB0eWDgCpHQ0g6dPgHFbWjEvlm1Yeo4kmPTp
         YaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cVjGQ/alQr1Wgl4ml6/3rAFGflTIVx5Z65Fv9pWFsgE=;
        b=l3RX6s7BzV/glk9XQdaNItOSVIy0w76WyN78chsqz50lWWSOf7MbDuo6qxIbn6rhf1
         Z1aOCFtukCY/McST0ppaxl15eU4E9y+uGeflJnRR1VSf9OWoENjAJnoO0UNjaj5d+gEW
         Ij+k+2EJJyVKPKWpdKI6gCGMqifZ6fhkqJ+nJTknw1EptSI8/itq9n4tIOJ43L9oIoAO
         WwrDm2McCx1vxwY5KrvIG0KP5pSfaDa8sum57BF5oj5PKpBEvjOC74LN28xqXOSMcgcx
         /E4HD5YVorzjyR7LuWcbwgaZvUkt9RJfkO/3zKQe42ms1/TiUW3KCQVpKe/4d3Ngi8W3
         xxiA==
X-Gm-Message-State: AODbwcCIqM9p2hU27Ud3usyOiy8lFQ7JCn1msuyJWipM4CIoIDXEm/vo
        2IVrY6P58cOKNa2zPKI=
X-Received: by 10.98.71.214 with SMTP id p83mr20655939pfi.236.1496109358363;
        Mon, 29 May 2017 18:55:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f830:fc5f:a16b:f475])
        by smtp.gmail.com with ESMTPSA id u9sm19542915pgn.55.2017.05.29.18.55.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 29 May 2017 18:55:57 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] convert: add "status=delayed" to filter process protocol
References: <20170522135001.54506-1-larsxschneider@gmail.com>
        <20170522135001.54506-5-larsxschneider@gmail.com>
        <64b1fda4-9f79-1bd8-ad6d-43196b808d61@web.de>
        <04ECEBE5-CAC8-4344-B07A-6B7A7C795C94@gmail.com>
        <xmqq1srgm9kq.fsf@gitster.mtv.corp.google.com>
        <DB31E695-B7D5-4337-BACD-5191EB642F40@gmail.com>
        <832A4D04-F32F-4D1F-A5CE-3514F8469E63@gmail.com>
        <xmqqshjndul2.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 30 May 2017 10:55:56 +0900
In-Reply-To: <xmqqshjndul2.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 30 May 2017 10:03:37 +0900")
Message-ID: <xmqqd1ards5v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> If you are depending on a single topic in 'next', it is better to
> build on the tip of that topic, not on 'next', if you can figure out
> where the tip is.  In practice, while we are exchanging patches via
> e-mail, there should be no noticeable difference either way [*1*],
> ...

And the forgotten foot note would have said something like this:

 *1* If you are depending only on a single topic in 'next', and
     other topics in 'next' do not interfere with your work, then by
     definition, your patches that apply cleanly on 'next' ought to
     apply cleanly on the tip of that single topic.

;-)
