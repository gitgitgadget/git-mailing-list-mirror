Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B8C77B6F
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 16:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDKQaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 12:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjDKQaG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 12:30:06 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE5940FC
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:30:02 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id m18so8318787plx.5
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681230602; x=1683822602;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=/PWIFAMmpnOpqXQ4vPZBXRovWExHk8mFwpSq1QLF/hY=;
        b=MFcNOlGFB9Id/8Ug4ltgYePEBH7DX11m9vz6/zVkPZs6rMXnnK+OD4TkTA27apYFgi
         +rJE0fVA4VkcGEluFEVsMgdOaEvNtHCQDMwUwnfpiAx3vQkCcKVQcvaCoivdjjibS05e
         diU9UU/reqyZedta6+dcWCFCCrGn4sACUt09EqgLGdA0iLCkXcFp63sUhC0S5NImH+X+
         bUept7tSrQ++2ePEMgmGdYRxlnlQH7tibnxqX3LyCc1LJqIwKHKYsrNBkZAs5bpog+Hh
         WvJ687Lesjb5r3oqkGsNQpBOsK4t0BKY0wC3W1aQsR6sv4jWuc/yIlGw3ub14BWDRsDM
         RDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681230602; x=1683822602;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/PWIFAMmpnOpqXQ4vPZBXRovWExHk8mFwpSq1QLF/hY=;
        b=pC6Rs7LPSEYbrXIPwAfS4XqSYlEFV8ylrWbuOF3QFENbsfw+g/0sq2Hzhqbjg9kVoc
         PBvMCyvadtniLNNCjq1MsiuYm2S25xWs7OagHnos4rsOOP3tdjysCWA0Lp27y7E23yGM
         5WblRrrAk0CTGKC72CByPqgKMASIdlA+W7Se+JnXgEeAkQ31WpA6l/3wFs8Pcs7vD5RI
         vxgfFiqDngn+XncPtH3rU5YK2cosMYkGd0irNC6QpspPi8lcjAjRnu9XLquvuaA3r5Y+
         5AHhoqNeDlecrr7wNHnFRnqo9d7fnaq7qcFUnb/HqztvUoRtZtuZi4V9jqgVXd/rVgDp
         AggQ==
X-Gm-Message-State: AAQBX9ceuQc5Iar8xkukEg2+1WFSe28o82xIy9QXJDHQB2xRxDXpTBc0
        QuTZ7F3xaL6x4dfYvPR9FHM=
X-Google-Smtp-Source: AKy350ZKP84peP9tAi0d3BIjoG9dz0wA4VoeYtD1HEsTCb2qFWI50wwst+wFvUZwfBQSXFd8XY76yQ==
X-Received: by 2002:a17:90a:1981:b0:246:cac9:330d with SMTP id 1-20020a17090a198100b00246cac9330dmr6124521pji.8.1681230601953;
        Tue, 11 Apr 2023 09:30:01 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id s1-20020a17090ae68100b002349fcf17f8sm11468893pjy.15.2023.04.11.09.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:30:00 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] doc: simplify man version
References: <20230408001829.11031-1-felipe.contreras@gmail.com>
        <xmqqr0suf0wz.fsf@gitster.g> <64349c7dc4f49_7452943c@chronos.notmuch>
Date:   Tue, 11 Apr 2023 09:30:00 -0700
Message-ID: <xmqqwn2i9ybb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Junio C Hamano wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > diff --git a/Documentation/Makefile b/Documentation/Makefile
>> > index a6ba5bd460..4721b000c1 100644
>> > --- a/Documentation/Makefile
>> > +++ b/Documentation/Makefile
>> > @@ -150,8 +150,7 @@ ASCIIDOC_HTML = xhtml11
>> >  ASCIIDOC_DOCBOOK = docbook
>> >  ASCIIDOC_CONF = -f asciidoc.conf
>> >  ASCIIDOC_COMMON = $(ASCIIDOC) $(ASCIIDOC_EXTRA) $(ASCIIDOC_CONF) \
>> > -		-amanversion=$(GIT_VERSION) \
>> > -		-amanmanual='Git Manual' -amansource='Git'
>> > +		-amanmanual='Git Manual' -amansource='Git $(GIT_VERSION)'
>> >  ASCIIDOC_DEPS = asciidoc.conf GIT-ASCIIDOCFLAGS
>> >  TXT_TO_HTML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_HTML)
>> >  TXT_TO_XML = $(ASCIIDOC_COMMON) -b $(ASCIIDOC_DOCBOOK)
>> 
>> Is this a complete patch,
>
> Yes it is complete.

Good.

> I don't know know what could give this impression, given that a link to
> the documentation and the link to the source code was given:
> ...
> The code clearly tests for empty strings:
>
>   test="not($Name = '') and not($Version = '')

This part is exactly what I meant.  The readers of "git log"
shouldn't have to dig to external source material and find that
line to convince themselves why this is safe thing to do.

> And it's not clear to me what else it would be checking for.

Good.  The job of reviewers is not about nitpicking, but work with
and help a patch author to polish the patch text (both proposed log
message or diff) by pointing out what the author may have thought
obvious to everybody, because it was obvious to the author, but may
not be so obvious.  The goal is not to convince reviewers how the
patch text is correct in review discussion thread.  The goal is to
use reviewers' input to identify such parts of the patch text that
needs clarifying and update the patch text.  It is to avoid future
readers of "git log -p" to ask the same question, because unlike
reviewers, they will not have the original author readily available
to answer their questions.

Thanks.
