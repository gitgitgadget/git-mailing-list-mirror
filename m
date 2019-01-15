Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D1581F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 18:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfAOSiN (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 13:38:13 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:43425 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729090AbfAOSiN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 13:38:13 -0500
Received: by mail-pg1-f201.google.com with SMTP id v72so2203999pgb.10
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 10:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WKm29yxpFuTo46qIowKPyCQRM7nqnTe0S9wCmIGbULg=;
        b=M+JFvc/Jirjm/mxDZOt373bL0qApwMaLSEzD/Bin2inz3sHyVRpjPbprCI6FeMh11r
         gQqVqpUxuE2JcPhBUI/0DHxCIFfgLENIIyKpq6rnwP7aARVqsm98U0Sa9pu0fLUPNoEg
         7rDeli+iGjiIdvR4566tzQgY/9IaaM7T/JKg/b1MQaz4neMWAfeDluXMi6cv/NLmD25x
         8IQvX3ZU8qODT5Dhch88A+fRKG2PrUkCm2hQwAylphhPMm1nNCCqMLEpWV/f+jz0FN0Z
         6Pndpac1xZ5FCxmTNQNbS/fmzXjxHLU+xICyzToWYZ3QyeZZ0tpIe1t95agyfPERPdVU
         d7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WKm29yxpFuTo46qIowKPyCQRM7nqnTe0S9wCmIGbULg=;
        b=id+P2l8Fk1/6PrkB+eObxxHapz5ihv6+6a6y5ovLBmAHqyYNkq/INDbiJ2sl49dm80
         +2cLZrTFNs5jvrl5E1dadnScJmR1PQKjp+c6zsFG6QrctoGaFmtSsyYqTvS0psEgclvT
         5UcTBOUQcKJm985WVm/1d5a8q1KPlVULApjc1akP4W1HsF60EUioM+OqhT3pwOuup4VE
         f11538KHFD3aSVuTXfBI0m6jxgh9aF8qLDvvgX+gXD4LR8M6yZZAKcu5vsVzRB8XFkna
         mahk0vm+2w+gUMXQEcwI35kWquCzPBE554izWgt6VAckK13maDmmYZ2I+NijX2GwKV2N
         N7Bw==
X-Gm-Message-State: AJcUukfphgNUM9lcetlF23Z+J+qS3qoRBeBpnXgzX5bpTqEL4frZlApf
        +NZ1F0CjZabGckeBsy/A36KuygGZqNzMPtVVRB+X
X-Google-Smtp-Source: ALg8bN40vqVW0CWZtiSEPjA5ikcdO4PirNxo8ro3AfbMRcVip3rUf+rtn0LvsvfzXRGIjakmU+X2odoXS8izx0JjEQWe
X-Received: by 2002:a17:902:2a6b:: with SMTP id i98mr1569674plb.67.1547577492191;
 Tue, 15 Jan 2019 10:38:12 -0800 (PST)
Date:   Tue, 15 Jan 2019 10:38:07 -0800
In-Reply-To: <xmqqlg3mubxt.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190115183807.255640-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqlg3mubxt.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH 2/4] sideband: reverse its dependency on pkt-line
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Lack of corresponding comment bothers readers.  In all of
> > REMOTE_ERROR, PROGRESS and PROTOCOL_ERROR cases, the other helper
> > stuffs the message in outbuf in "switch (band) { ... }" and writes
> > it out with xwrite(2, outbuf.buf, outbuf.len) [*1*], so I can see
> > there is no need for us to write anything out here.  Perhaps
> >
> > 		case SIDEBAND_FLUSH:
> > 		default: /* errors: message already written */
> > 			return retval;
> >
> > or something to clarify?
> 
> Forgot a footnote for *1* above.  I was wondering if xwrite is what
> we really want, rather than write_in_full().

There is an existing comment explaining this:

	 * The output is accumulated in a buffer and
	 * each line is printed to stderr using
	 * write(2) to ensure inter-process atomicity.

which seems reasonable to me (I know that write(2) does not guarantee to
write everything, but write_in_full() does not guarantee atomicity, as
far as I know).
