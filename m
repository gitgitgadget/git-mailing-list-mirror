Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8120520281
	for <e@80x24.org>; Wed,  4 Oct 2017 10:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbdJDKwa (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 06:52:30 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:47203 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbdJDKw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 06:52:29 -0400
Received: by mail-wr0-f170.google.com with SMTP id y44so3013940wrd.4
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IAwd/yM9XNLR45Oy2zKr1GhFLRBhJ2TOM8ANjlphgEo=;
        b=jKb/Hnb01ruo0CvBpDsnGiqT3TClGsG6zN31lYKVuGximemTlQOkM3zg4GjDoxMUzB
         9tlk5syS8fISxfKL0TW0JVjDVGiJ/dwVVFagmg8a6NodP0RF7c+dMTXtpzbyfHWoBQ0A
         sOidxIKh9WsYjJ0ZMe1Yce8t6MV6IpGKaDuZtBOFro2UMrr/AnUu4Wp1S4wGdeDQndt+
         WbKLBPEyKdlMn5OZmMxvheFOYfVYtdw+lVhtHt/CXks6E/cgmNbTqIiEoTOYCiSrj2By
         6yeOb0ERE7Ph3x5gGqtSupTL6M6vfQmOQVTBX8nuYP4ZxaSAkhaW/m+P+8G2LNDbbU6r
         cqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IAwd/yM9XNLR45Oy2zKr1GhFLRBhJ2TOM8ANjlphgEo=;
        b=P/vvCw0GOV92oK8OXjJH7yY+FtHgIvGKTJAu+lhEWXHQcufimXKqnIZWczy48J7gJH
         SPv0FraxINqC8edppmUIsARBUtpY/cLCQ47UVcZusrBD3VYxiRR/NU95Uj2s594c89Av
         eEeK/wr/KjGWDNm03IbWr486Q8OIB1SRxLn4CW6KASHVPfZks8VlWecE90inGSAnVjN3
         e2hGCltQTWAXgetPuRE6Zo697UmJiwhPInE7cFCLAVoVi+Edk8FEx27XGlSDUu5OCSbG
         wVj6fNRBUCKtQgo0MMcJzOTwnihZSLcn1tylMGR32zXOnfzTUKrUCSkrWj9J7myEWXli
         HMYQ==
X-Gm-Message-State: AHPjjUjbYDH3ZtYxNs5eZ/Nz/ybM9ww1uWLRz8ineW8fPLQpP2qJm8Hz
        b4pXB5HVy1KOMKWSKO8dJ3g=
X-Google-Smtp-Source: AOwi7QDCNocLPbMFzNsH/vPy7qj4Y+MRYS9zpXVSi0deKcVKIidgkrLVFdc2qkKfbi4Fnm4yD5g7xg==
X-Received: by 10.223.170.214 with SMTP id i22mr18884613wrc.271.1507114348126;
        Wed, 04 Oct 2017 03:52:28 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id r44sm3501684wrb.37.2017.10.04.03.52.26
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 Oct 2017 03:52:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: display progress for filtered objects that have been delayed
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 4 Oct 2017 12:52:25 +0200
Cc:     git@vger.kernel.org, me@ttaylorr.com
Content-Transfer-Encoding: 7bit
Message-Id: <1AD84BB7-5BCA-4982-B157-944890F796EE@gmail.com>
References: <20170820154720.32259-1-larsxschneider@gmail.com> <xmqqwp5svjne.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Aug 2017, at 21:40, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> In 2841e8f ("convert: add "status=delayed" to filter process protocol",
>> 2017-06-30) we taught the filter process protocol to delayed responses.
>> These responses are processed after the "Checking out files" phase.
>> If the processing takes noticeable time, then the user might think Git
>> is stuck.
>> 
>> Display the progress of the delayed responses to let the user know that
>> Git is still processing objects. This works very well for objects that
>> can be filtered quickly. If filtering of an individual object takes
>> noticeable time, then the user might still think that Git is stuck.
>> However, in that case the user would at least know what Git is doing.
>> 
>> It would be technical more correct to display "Checking out files whose
>> content filtering has been delayed". For brevity we only print
>> "Filtering content".
>> 
>> The finish_delayed_checkout() call was moved below the stop_progress()
>> call in unpack-trees.c to ensure that the "Checking out files" progress
>> is properly stopped before the "Filtering content" progress starts in
>> finish_delayed_checkout().
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> Suggested-by: Taylor Blau <me@ttaylorr.com>
>> ---
> 
> Makes sense.  The only thing that made me wonder was if we want the
> change in unpack-trees.c in this patch.  After all, the procedure to
> finish up the delayed checkout _is_ a part of the work need to be
> done to populate the working tree files, so stopping the progress
> before feels somewhat wrong at the phylosophical level.
> 
> I think our output cannot express nested progress bars, and I think
> that is the reason why this patch tweaks unpack-trees.c; so I am
> fine with the end result (and that is why I said "made me wonder
> was", not "makes me wonder", the latter would imply "this we might
> want fix before applying", but I do not think we want to change
> anything this patch does to unpack-trees.c in this case).
> 
> The delayed progress API is being simplified so I'll probably do a
> bit of evil merge while merging this to 'pu'.
> 
> Thanks.

Hi Junio,

I just realized that this patch got lost :-(
That means 2.14.2 supports the delayed filters but does not show
progress to the user. To the user Git will appear hanging.

Can you merge this this topic for 2.14.3 / 2.15 ?

Thank you,
Lars
