Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EF4A1F462
	for <e@80x24.org>; Wed, 12 Jun 2019 13:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbfFLN25 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 09:28:57 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35184 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727416AbfFLN25 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 09:28:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id p26so21739522edr.2
        for <git@vger.kernel.org>; Wed, 12 Jun 2019 06:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=x5M8zQf1a9ORp2QHTOx9NsS6UViy+C6IcA+Mm9CXd3s=;
        b=mJdFhXyNghdmoaBW4vM5zabVpY/6vy+P7jcprgVfF940c3Y50nXkVIdvPxwczWWRVI
         TI1+tOODFMrCZxuoIFaHhK/x1hvuM/vYPjxFtwhlvonyyjjYV6wEW3tIa/EDdD31jBHF
         jGSUWOLI+OoI7fQcEe/GgTaqZyJ978XRjpLMUnHCiwiXoseTUmrCCtu3OiWNoWjVMM13
         SsI/Ln9ZDLxN60wLaDmYy3CI1sSMfJOzrF2yBFRqMa2EujVYoBfNzJs9UcbzC1LprxmY
         VBpbWM6Z9yv2jxtX0B6hqCCJtXxswf5YGQucCJ/FjPEZRkwDi7mMtqLx0/ja/wj5IbjI
         nZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=x5M8zQf1a9ORp2QHTOx9NsS6UViy+C6IcA+Mm9CXd3s=;
        b=QirGPpzcjaIxaEDW3r8/j7mxBq+OPB5IEcE10xxMJIs3ZRDRN3amjHTm/OKBdR72Px
         QvGXNDujhjq34OgeWbSxTBsXbGy0MVRa1rWr4m3PYJsxLPTGRboXRFqKyEaUI1J4TdVZ
         utFJcwGgXcVFPZN5I6BM74HXyhF6jotM0X+X1Mpyjqi0c+9KMUSsFQWGFrINsjspcSM7
         9UBo6M3nkb35PoceqZpg/skrX4VMST0pYFiS3Q1bweYEBHM8gvdp4s/xXPfLbk/INJD8
         NayqQ0Pu89xJsZy/uayaK7GSev5hbPfPZGfUE03hO5SgBQpdqagl3lx3QH9eLWYg3Kp7
         MNQA==
X-Gm-Message-State: APjAAAUnaekbLnHwNZx5PVW9u33oNQWF7LlzY+y3yOQfXqfa3sXYR3Ze
        0AohU3oh6C3+sn1in9GbalSG1q8I
X-Google-Smtp-Source: APXvYqx3oGhapWsua4u0VSSBkCMolqGXSuCx2pULAl4c6pWiVp7M2JJYVva4m6ISq1XpFw+a0LToaA==
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr87772094edr.174.1560346135472;
        Wed, 12 Jun 2019 06:28:55 -0700 (PDT)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id m4sm4546097edc.24.2019.06.12.06.28.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 12 Jun 2019 06:28:54 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 3/3] trace2: add a schema validator for trace2 events
References: <cover.1560295286.git.steadmon@google.com> <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
User-agent: Debian GNU/Linux 10 (buster); Emacs 26.1; mu4e 1.1.0
In-reply-to: <7475c6220895d96cdc7d25d6edea70e2f978526b.1560295286.git.steadmon@google.com>
Date:   Wed, 12 Jun 2019 15:28:53 +0200
Message-ID: <87v9xb7x0q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jun 12 2019, Josh Steadmon wrote:

> trace_schema_validator can be used to verify that trace2 event output
> conforms to the expectations set by the API documentation and codified
> in event_schema.json (or strict_schema.json). This allows us to build a
> regression test to verify that trace2 output does not change
> unexpectedly.

Does this actually work for you? As seen in my code at
https://public-inbox.org/git/87zhnuwdkp.fsf@evledraar.gmail.com/ our
test suite emits various lines of JSON that aren't even validly encoded,
so I can't imagine we're passing any sort of proper parser validatior,
let alone a schema validator.

In terms of implementation I think it would make sense to have a *.sh
wrapper for this already, then we could test via prereqs if we have some
of the existing validators (seems there's a list at
https://json-schema.org/implementations.html) and e.g. run a dummy test
against some small list of git commands, and then you could also pass it
an env variable with "here's the trace file" so you could do:

    GIT_TRACE2_EVENT=/tmp/git.events prove <all testss> && VALIDATE_THIS=/tmp/git.events ./<that new test>.sh

And it would validate that file, if set.
