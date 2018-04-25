Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1606A1F424
	for <e@80x24.org>; Wed, 25 Apr 2018 00:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbeDYAkN (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 20:40:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34196 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDYAkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 20:40:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id p18-v6so32441715wrm.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 17:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SfoAkcSKM397xaLRC6mOM7B+BMg/knO+SJurE3ci4DY=;
        b=UnJ9ZQPTevyv2Jc0wPdtpBP8AyVRC5pit77ZILMwzguzVMf/NFA8KMrQEMG6MBAVw6
         OPL1f9qOR5FVfLs9IQXeExxGbqXkg6xQ675B4WHaH7pZOBjC1nEJcVpXd3gdDM26KRx5
         QJMgkgy86PbmA94FFMufeMr9uR3MWHsPEd4LVVrctGM9b4Re9dFyebJf33kww53YSDxy
         LOxHe55r13Tl0k/8MIlaB5Aoy0dksdmOptIUr3PaARZYajF/yYq2IpVWT3uqi2hhROpG
         C0Lka3seiPGZAp7bjn/xURPmNUSkRFn8X0G00/bKtjwKkyWpOIEO8qfGf6qE0yJixp+I
         7lrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SfoAkcSKM397xaLRC6mOM7B+BMg/knO+SJurE3ci4DY=;
        b=HIy98Tice8OXfUhMFwkcICXxyM5QYBMdve4jE5/HUffBLRIpVYCl4yO6R1bxtsCSpo
         4qIzhzX9j/PhC+75rx1JDuJeuHRUpRpznbq9Wog+naXKViNyax+176dDPEU413jLM2mg
         3y+93LO4dUP56eNxo+89rptxF4XsJl8eorQE/oJCzVpVZR1QICnfXx7CMS+q3ZgtueDX
         5NbvKNIgRvyrEtvsxNhMZMEe77N5t6rSXzWx4T6u1Ai/rIQBDciK+nviTk+1yKtBrh0T
         w9bTeor9MGG9BscJcOBPjuslS15Q1jR+tTAzqxqtTpcHZvOpKjzYx2X2qrNIW+9ke+eg
         JnDw==
X-Gm-Message-State: ALQs6tDJ11yLvfEcyFgIahFAY0bK+ndWUCGwNnJxI5iLI69A+gB4TD2n
        Sv0QgwVpQglc/CWZmGqeXuE=
X-Google-Smtp-Source: AIpwx4/gjv6vN5e+gcYc7a/o8hvnE/pJKMwLj3NPVAj2dN2RYaSAu65ib33/Hduq/xU75wGDAo3hkw==
X-Received: by 2002:adf:e688:: with SMTP id r8-v6mr14955014wrm.90.1524616810918;
        Tue, 24 Apr 2018 17:40:10 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 80sm16587981wmk.46.2018.04.24.17.40.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 17:40:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philip Oakley" <philipoakley@iee.org>
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
        <git@vger.kernel.org>, "Jakub Narebski" <jnareb@gmail.com>,
        "Stefan Beller" <sbeller@google.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Christian Couder" <christian.couder@gmail.com>
Subject: Re: [PATCH v3 09/11] technical/shallow: describe the relationship with replace refs
References: <cover.1524125760.git.johannes.schindelin@gmx.de>
        <cover.1524262793.git.johannes.schindelin@gmx.de>
        <853b0a445ab1d78e8cbe19dacd09e70892b34b03.1524262793.git.johannes.schindelin@gmx.de>
        <52C2C5A51FE7400E937F06B7641F4319@PhilipOakley>
        <nycvar.QRO.7.76.6.1804242106220.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <538CF27C224E4AE0A1C45374AE367C3A@PhilipOakley>
Date:   Wed, 25 Apr 2018 09:40:09 +0900
In-Reply-To: <538CF27C224E4AE0A1C45374AE367C3A@PhilipOakley> (Philip Oakley's
        message of "Tue, 24 Apr 2018 22:34:16 +0100")
Message-ID: <xmqq4lk05dau.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> Perhaps something like:
> +$GIT_DIR/shallow, and handle its contents similar to replace
> +refs (with the difference that shallow does not actually
> +create those replace refs) with the difference that shallow commits will
> +always have their parents not present.

I am not sure if there is enough similarity to replace mechanism to
mention that.  It has lines of text, each of which records a commit
object for which Git is told to pretend that it has no parent.

To those who are familiar with "graft" format, it is possible to
explain the format as "it is similar to graft", as a line with a
single commit object name tells Git to pretend that it has no parent
in the "graft" format, but because we are getting rid of graft, it
probably makes sense to just explain it without reference to replace
(which may serve a similar purpose, but is certainly very far from
"similar" as a mechanism when you explain how the contents of shallow
is handled).

    $GIT_DIR/shallow lists commit object names and tells Git to
    pretend as if they are root commits (e.g. "git log" traversal
    stops after showing them; "git fsck" does not complain saying
    the commits listed on their "parent" lines do not exist).



