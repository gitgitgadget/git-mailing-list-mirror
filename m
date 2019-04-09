Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9604D20248
	for <e@80x24.org>; Tue,  9 Apr 2019 18:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDIStx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 14:49:53 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:42265 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfDIStx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 14:49:53 -0400
Received: by mail-qt1-f201.google.com with SMTP id n10so16826069qtk.9
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 11:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4IRRw6GlkCVYlnE7wVEeCYuL5HC/N8rSG2/0eJg0+t8=;
        b=utGhPbiD9I0rearGFZCy0edcqWFXWuNr6AuJR7v5p5DibANzaIUIoR5/MCE7inhIz8
         h3EbbEjhZ07kZFhop3K1O7pQ+ePndWerQxOfDH/LCTIB+JYAzcRhyJXnESRle8liEu7G
         JVuTRsWt9u+8VeWOPXyrQkNf/vDbsQpEh5UC3yIFVfdNl3WkQVMyQP6p7XgjK6P15deC
         +a9Pqm+lPdD+iHidV3NuCYKU6TNqqe5NSscQuuuUUV+PA4zXU4BjQfKg0lPSsduE3CIB
         pTQsMttZbCkAITeJwYYA9L8fmcwN/6gp+7NwCSEGF8fWerRgZtyXouE5mnIZlh7nKPQu
         q7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4IRRw6GlkCVYlnE7wVEeCYuL5HC/N8rSG2/0eJg0+t8=;
        b=Eb1cUYOukeCrRaAdlObYMxwz4prp1Mx4BHvJ3FxG1Khuwm0ltj8U6YKBmB0rHWQ4UI
         xbxrg3fAxweIZZm5pPojH7H3U5qncB2wpJvIX8kerpvz/U3NSsTB414+auiFFmG6YdS6
         B+b7Vr35lMGoAUISHthLb2BYwyi0KNBaCbUpF7++OeldaHehFxciaAzpGiVyjSHqRYYe
         JiEEAm06+1JjIe84cZN7PzwiN3w153OTByGs89kYmf7JLfichU7OTTTY5AqdTbCWKpaA
         UqDR2Jpx23sNBuD+7i5LH/vrmM5+R7GLStlwV6iAYUxO2a8JqAKKglk78YT8Nte3XhBe
         plww==
X-Gm-Message-State: APjAAAXQnqVNwvQ11MrJscCqlO9oj6JXIZXSZ6op71JKzpMSlWTtVQTK
        eMH/z3Eql3bBnJtKZQwz2nGNfTjMduiZrpUzFaVC
X-Google-Smtp-Source: APXvYqxy3CLR2vldlFBHPFVx6lTZeCSBkVoyiHBN2zNtZoRG0KuuDBUu2u15Y/YctuHKcYRgx1kpnRKDoDhRLiKZTZXV
X-Received: by 2002:a37:6903:: with SMTP id e3mr4736726qkc.48.1554835792549;
 Tue, 09 Apr 2019 11:49:52 -0700 (PDT)
Date:   Tue,  9 Apr 2019 11:49:49 -0700
In-Reply-To: <xmqqk1g342xi.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190409184949.207114-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk1g342xi.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: Re: [PATCH] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, jrnieder@gmail.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Does the code behave sensibly when the --server-option=... option is
> given and
> 
>  (a) the given option is not understood by the other side that talks
>      protocol v2?  Or
> 
>  (b) it turns out that the other side does not talk protocol v2?
> 
> In the former case, I would expect that there would be a way to
> respond with a failure for the other side and "git clone" should
> notice and respond by die()-ing at the end.

Right now, the server ignores it (it collects them as "keys" in
process_request() in serve.c and then passes them to the individual
commands, but they don't do anything about it).

Right now it's documented as:

	-o <option>::
	--server-option=<option>::
		Transmit the given string to the server when communicating using
		protocol version 2.  The given string must not contain a NUL or LF
		character.
		When multiple `--server-option=<option>` are given, they are all
		sent to the other side in the order listed on the command line.

I'm inclined to add:

  The server's handling of server options, including unknown ones, is
  server-specific.

> In the latter case, I would expect at least that a warning about
> accepted but ignored server-option to be given, or "git clone" to
> fail with an error "cannot honor the server-option".

Right now there's no warning, but I'll add one in the next reroll to
both "fetch" and "clone".

> If the code does not match the above expectations, at least that
> should be documented, I think.  If "git fetch" shares the same
> issue, this would be a good time to address it, too.
