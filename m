Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CAD62027C
	for <e@80x24.org>; Tue, 30 May 2017 23:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751212AbdE3XHv (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:07:51 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33028 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751128AbdE3XHu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:07:50 -0400
Received: by mail-pf0-f170.google.com with SMTP id e193so321350pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MJWyqeWMaVqWrbpqS3LWM7SkSAURBb7koPyvxv2Givs=;
        b=AmIk0nI2VbfzvWIztmAXoNeBgv57pazMLcwd8GrLB4afQi5zdvD7QVDW4Nylw8Ly4W
         XAJKKlveUwEN5CRIWmXf98vE24Q/T+Z3OWstStoERnTRY/L43P+y0HkKcxHwbF+L+9TZ
         dD3QBH6DqbwshsSNDFhITISdiXefd+bdVly186TN+N7iJIeCUV3B5uMOTxX7BO1KjSjf
         L8t0j1BgE+1Txkffm1OR+ifz9PUtoRJBcGJmBaIVNbDEUXSPKIFxfScheZrRGrxrKd6g
         whfec2lBTCsXVKHJM13dtNniYG5N0XE0S3cAePtsz1CJJbLT0qMZUWeqAgyysk9n/dXb
         rVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MJWyqeWMaVqWrbpqS3LWM7SkSAURBb7koPyvxv2Givs=;
        b=AU9F5+Idc/Qb4LGX+j+P3AqlViWDq2e79ZaayrjSdkPgoUhHtK3HT+5KDrchqK1f+U
         Vn1VgGSpspyzIGxvudaZwiOSiQVCH54Uy3nAFBSr1ndIrKai6LeKUCETbfb2IXSRula/
         ixM7ics5cJsZZrLGyhlM/hIrT0s4OMUmzH5T6+ThkEP7nejKeBbudc4LePCfc6dWyxJP
         32BPZpjeTeB1XsXDmkV34ENjJAkMBJG3vFPP/Odl1od+qP4fP5Wwgr2MWa/IKOfWmYBA
         +O/dLLA+DHME4oHq1baWb8/TDpiHYNmVdUd6D72ww1IxOejAqNtcWisUDp/fhbCr7T6k
         jZeQ==
X-Gm-Message-State: AODbwcAsCDpqb3QSMqKN1YLfsut261lm/GOOiZ82wkkcUwXkL9vA2UDw
        p3/kJnpt9bMClBjvafs=
X-Received: by 10.84.164.106 with SMTP id m39mr29400195plg.58.1496185669572;
        Tue, 30 May 2017 16:07:49 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id h123sm22118505pgc.36.2017.05.30.16.07.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 16:07:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2017, #08; Mon, 29)
References: <xmqq1sr889lb.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZWmLnUr5hyKjy8bKFAksURW9a65035CHispAT0oH1rkA@mail.gmail.com>
Date:   Wed, 31 May 2017 08:07:48 +0900
In-Reply-To: <CAGZ79kZWmLnUr5hyKjy8bKFAksURW9a65035CHispAT0oH1rkA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 30 May 2017 10:42:10 -0700")
Message-ID: <xmqqshjm9c57.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>
>> * sb/submodule-blanket-recursive (2017-05-23) 6 commits
> ...
>
> And the retraction is retracted by sending a new series.
> You remarked that it still misbehaves with other series in flight,
> so I'll inspect it again.

What I said (or at least what I ment to say) was "it looked like it
is based on an older codebase and I do not yet know how messy the
conflict resolution and resulting history would look like".


