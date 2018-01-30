Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146F21F404
	for <e@80x24.org>; Tue, 30 Jan 2018 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753292AbeA3Uh3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 15:37:29 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46113 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752496AbeA3Uh0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 15:37:26 -0500
Received: by mail-wr0-f194.google.com with SMTP id g21so12627111wrb.13
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 12:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=K69dH/bqoUmlveNcOQ0GieNArX6bm6C5zqPwGLcl7bA=;
        b=cGpaqq5uWyGj4P5L10J//b7RVmzVzqlglcDASwkhqLtTK2ZpNiL2iLtX4t+oJbOfzh
         FMaQ0zgCNiYxQh2RRuFTUspWLmf52ovk23neBebvQ/xefbAHZWUuQiOZVBXZZyOld0er
         slL5qxcGTm9JSthnOYt4J0k4XGNs04U71QlSVOzEI1KSeLTz8567y+VvMRle8SnsNqtT
         aOLWG0KUhOqLzDAcWlNcNtg7eVTiyirt9hKONHLEEQ1MhKCsHi4XSpvY+8SKVvB57n/W
         GxaSmKpRyEkkKbqubYltSIkGiSpZHPR2m7+h8FVchkifzv+ZOwfJuejUWKtWb8oLJYKr
         OE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=K69dH/bqoUmlveNcOQ0GieNArX6bm6C5zqPwGLcl7bA=;
        b=IAb4wNCQh7ecqmdZSztrqexwVocwOIANLk0Jvsmjr+cXD6vzcPBDDy/pJMUK66Iuzt
         9VJsjcoxlg/ySSPV79P0QlIxfusRms+pYs37uSpJ1b4evCutLSNd37rkmBp8fRfU+t6Z
         7gzXjSyV0vi2rdmCN2DYVxFzCotjxlGWv04VB7DEaq95IkU+uzyj4vZVhSJm6adZGsxi
         wtJvBsdjKi5liB0049kAXAo0hVx8U0kVy9E7h4xrFal3gkwaXcuICyOJjEY9p0/8iAsV
         pJyrDxHd3FUTKLVmuvLkWMikWFro+83zNYowDASWKJAOSkuaewJJOD6/8HxXrw0ilvVV
         GHKg==
X-Gm-Message-State: AKwxytf3IuLxcYYq5B2C24P2hyAIxAfFWLqkC7uEtbvkADZGCmyRNUDb
        lKrcPDCld7bzz8dPr96Uf08=
X-Google-Smtp-Source: AH8x226YQBIQNTsW46pbdqjdY5UG6AfCMQVL7MCfcDFMzalZ0QtG/3L8r236xNY1AOnAJ5Gce+MWUQ==
X-Received: by 10.223.150.208 with SMTP id u74mr13562485wrb.193.1517344644750;
        Tue, 30 Jan 2018 12:37:24 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 32sm16777839wrm.14.2018.01.30.12.37.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Jan 2018 12:37:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc:     git@vger.kernel.org
Subject: Re: git send-email sets date
References: <20180126183230.0ae0c76b@kitsune.suse.cz>
Date:   Tue, 30 Jan 2018 12:37:23 -0800
In-Reply-To: <20180126183230.0ae0c76b@kitsune.suse.cz> ("Michal
 =?utf-8?Q?Such=C3=A1nek=22's?=
        message of "Fri, 26 Jan 2018 18:32:30 +0100")
Message-ID: <xmqqo9lbt75o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Suchánek <msuchanek@suse.de> writes:

> git send-email sets the message date to author date.
>
> This is wrong because the message will most likely not get delivered
> when the author date differs from current time. It might give slightly
> better results with commit date instead of author date but can't is
> just skip that header and leave it to the mailer?
>
> It does not even seem to have an option to suppress adding the date
> header.

I think you are complaining about output from "git format-patch",
and the reason why the date header is recorded in the output is as
others already mentioned in this thread.

The complaint about "delivery" is misplaced because that date is not
used to drive the SMTP conversation in any way.  "git send-email"
does create its own timestamp, but that is based on the current time
and does not have anything to do with the author or committer date
of the original commit the patch message came from.  

I think we confused end-users like you by allowing the command to
drive "git format-patch" from the command line (and worse, somehow
appearing to encourage such use), which probably was a UI mistake.
We should encourage people to run two commands separately instead,
which incidentally will allow the patch messages to be proofread for
the last time before they are sent out, but also reduce this
confusion when users see that these dates from the author timestamp
are not used in the "Date:" header of received e-mails.
