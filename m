Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 781A920D11
	for <e@80x24.org>; Fri,  2 Jun 2017 02:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbdFBCVe (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 22:21:34 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36025 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBCVe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 22:21:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id n23so10313609pfb.3
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 19:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o6lxvDhr/mZrI1H16HyEke3ttoFE31XxhdOJ6eFDMhM=;
        b=lkMiw+eDeZ9+9QPuZliaJ/nOwW58HsOmP01UrTzJxe8UvLdoO2GoMXPC0xcLgkvLBs
         Bwy0+MF54aO1U/IHwMrl/lYeusIBlsAsInipJmcuE2TBtxo+CKBXlxwGw3f5tj7LS8lZ
         chszc8Rakz/n03yTq8R+yJThLp/AMfCLl08z0Iv8dw12qsjNhusuhyW+tt+fmyFoYP/x
         cqOv5S+bPQeB70dHJmmIC8ZQC3X6EkTmr0+kzEjWYl/snex36dK7p89M3PZeIbDx+bZq
         8tN9FGflFnRPehphyKnL65TBK2/yxskZJGQTfyfyAbVWRRakL0e5pSaar1f3FJ4Qlro1
         fW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o6lxvDhr/mZrI1H16HyEke3ttoFE31XxhdOJ6eFDMhM=;
        b=GkmpJYUDx+RbMAPn74tA2up3+cr/qv3iMEZRF55Gztck+D4ROlbC0L/N83b3YbQRyW
         sBrzkL3M6JhdvpSZPJ0zTDnR4svM6D0Y71sZnxvOMyDESkdjMoggj5J1/xIt0m+QRJPW
         qzrrxDUOh+nHxED81u2PURbCJogm2ZENww5s4VdUzAn3EsfOXicIJQD9pOEOrXRNUn9q
         yRk8ykcOqDwikjRRW5ZVhSP8RV+R5bGg1LY/1yJ6aNa0QJvoxEr+LcReFexBiSjaKsEa
         FhwQP9m2IWB2LV5R2we7EA3AkqUEz8FIhOWa6bcQFc5hdLt5QzQ1XjNvsxGb14gv1Eue
         rhCQ==
X-Gm-Message-State: AODbwcCbATEllXJT5xmWfj9k0J+xtKhZJ84lBFGCXd9ctvSpwkWYy2tt
        O0dGGvIyTmcsQA==
X-Received: by 10.99.137.194 with SMTP id v185mr4394959pgd.206.1496370093248;
        Thu, 01 Jun 2017 19:21:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id 80sm35897438pfx.80.2017.06.01.19.21.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 19:21:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v5 5/5] convert: add "status=delayed" to filter process protocol
References: <20170601082203.50397-1-larsxschneider@gmail.com>
        <20170601082203.50397-6-larsxschneider@gmail.com>
Date:   Fri, 02 Jun 2017 11:21:31 +0900
In-Reply-To: <20170601082203.50397-6-larsxschneider@gmail.com> (Lars
        Schneider's message of "Thu, 1 Jun 2017 10:22:03 +0200")
Message-ID: <xmqq60gf1650.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> +Delay
> +^^^^^
> +
> +If the filter supports the "delay" capability, then Git can send the
> +flag "can-delay" after the filter command and pathname. This flag
> +denotes that the filter can delay filtering the current blob (e.g. to
> +compensate network latencies) by responding with no content but with
> +the status "delayed" and a flush packet.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> can-delay=1
> +packet:          git> 0000
> +packet:          git> CONTENT
> +packet:          git> 0000
> +packet:          git< status=delayed
> +packet:          git< 0000
> +------------------------
> +
> +If the filter supports the "delay" capability then it must support the
> +"list_available_blobs" command. If Git sends this command, then the
> +filter is expected to return a list of pathnames of blobs that are
> +available. The list must be terminated with a flush packet followed
> +by a "success" status that is also terminated with a flush packet. If
> +no blobs for the delayed paths are available, yet, then the filter is
> +expected to block the response until at least one blob becomes
> +available. The filter can tell Git that it has no more delayed blobs
> +by sending an empty list.
> +------------------------
> +packet:          git> command=list_available_blobs
> +packet:          git> 0000
> +packet:          git< pathname=path/testfile.dat
> +packet:          git< pathname=path/otherfile.dat
> +packet:          git< 0000
> +packet:          git< status=success
> +packet:          git< 0000
> +------------------------
> +
> +After Git received the pathnames, it will request the corresponding
> +blobs again. These requests contain a pathname and an empty content
> +section. The filter is expected to respond with the smudged content
> +in the usual way as explained above.
> +------------------------
> +packet:          git> command=smudge
> +packet:          git> pathname=path/testfile.dat
> +packet:          git> 0000
> +packet:          git> 0000  # empty content!
> +packet:          git< status=success
> +packet:          git< 0000
> +packet:          git< SMUDGED_CONTENT
> +packet:          git< 0000
> +packet:          git< 0000  # empty list, keep "status=success" unchanged!
> +------------------------

Random things that come to mind (which I suspect has been dealt with
in code but not described in the above in detail):

 * Using pathname as a "delay key" would mean that we assume that a
   single helper process is spawned to serve only a single Git
   invocation (as opposed to be sitting as a daemon accepting
   requests from instances of Git invoked much later than the daemon
   started), which is OK, but it is somewhat unclear when a filter
   is allowed to discard the requests that used to be outstanding
   from the write-up.  Imagine Git asked for A and B, both of which
   was delayed, and then asked for a list of available ones and
   learned that A is now ready.  

   - Is it an error to ask for B at this point, and if so how is the
     error handled?  Or will it turn into a blocking operation?

   - As A is available, Git can ask for it.  After retrieving
     smudged content for A, can Git ask for it again?  Or is it an
     error to do so, without starting over with another can-delay=1
     request for the same path?

 * The pathname does not have to be encoded/quoted in any way as it
   is just a payload on the tail end of a packet line, so I am
   guessing it is just a sequence raw bytes.  It is somewhat unclear
   in the above write-up.  Also, is this considered to be a part of
   "textual" exchange over the packet-line protocol, where it is
   customary to remove the trailing LF from the packet?  "We do not
   support a file whose name ends with LF" may or may not be an
   acceptable stance (I am personally OK, but some people who use
   Git may not), but it needs to be documented if there is such an
   issue.

 * The continued request throws an empty content in the above
   illustration.  Is a filter allowed/encouraged to assume that an
   empty content in the request is a continuation?  I am guessing
   that the answer is NO (otherwise you cannot filter an empty
   file), and it somehow need to be documented, perhaps?

