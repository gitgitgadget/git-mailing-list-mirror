Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 878481F859
	for <e@80x24.org>; Thu, 25 Aug 2016 22:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbcHYWqW (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 18:46:22 -0400
Received: from mail-yb0-f179.google.com ([209.85.213.179]:33470 "EHLO
        mail-yb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbcHYWqV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 18:46:21 -0400
Received: by mail-yb0-f179.google.com with SMTP id a7so20428875ybi.0
        for <git@vger.kernel.org>; Thu, 25 Aug 2016 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XwYFTmjcEu7DGRGVHMlhl4m0ZoXwj1tehBtmHgxlLTE=;
        b=LcTJH0aom24WBE085FoNKE0rVNHaJ3nrlGcpdNnI9KLkegQE509zUd7V5GVBtXYZqI
         FgV5Kt9MhEtMIYEyJ8g8YYYh+LjZfUT3Nx9ztB70dmPR3UYbiku3YUWcvHGnnuvm5qXY
         z9HCRH4YMK9t4XHin1m/cC1H2rMgRzOCYjp+QGWfsgbnCct9wZpDbTI/AARtV1mibL5A
         lsBAGGsOkE0e5/de6IRFHnNiswLkrueSPz/7ac86DgcQsu4/4/EsdIsjRupOL0Bnv3Dk
         eTW0KR8CBFytvsK91fecL/VNX2PhEiQHDUcYYKMosDpzMVyjOg8DeNnnK++RqzCZ3p3s
         c1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XwYFTmjcEu7DGRGVHMlhl4m0ZoXwj1tehBtmHgxlLTE=;
        b=Yd5U2elLOnNnmOjjNLZMuXTnAzZULP59p+Plwil6IGRBt7iu75Fti0IdcwRljAbq7Y
         b5Akm/EV/fnBx7VgAI2J7n9FBmSuJI1ji8GMFkqYmBPFGLXqcq/uEFfAXjTnyFpcBwZn
         NU9Au3LZR+1TYyjPcMaRrB1HypfnCdhvvjwV/vmKDdi/uRRIiGNsDRdpVn/JBnPGVDMt
         HsyylO0XmQ1Inp3k43RGjVDs10paQHRCB93JkufHXTsqYesMLyc3Mb6+2lIY+NJhHOHU
         d1CphOewdLHBDrA+mQctdCPt3QEYxNyXOQQeWIVAuSvXHJh1P3o70PB7B0FogMNv6N5V
         my6A==
X-Gm-Message-State: AEkoous112j94f4VcA4cHaY1h0mxnApaOgogATYcQVUvjTSZUORFSvfhwpYqg8BRzKd3gMMJlHw52qaJZFg/4A==
X-Received: by 10.37.98.197 with SMTP id w188mr3983410ybb.164.1472165180730;
 Thu, 25 Aug 2016 15:46:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 25 Aug 2016 15:46:00 -0700 (PDT)
In-Reply-To: <xmqqr39cjwxx.fsf@gitster.mtv.corp.google.com>
References: <20160822234344.22797-1-jacob.e.keller@intel.com>
 <CAGZ79kbKibe2RpQ9QWN1naY07feZLKbhc+dts3BD-4+y-pUOVw@mail.gmail.com>
 <xmqqlgznwg6o.fsf@gitster.mtv.corp.google.com> <CAGZ79kbsq52Qh0Jtn5hpPPfHu_9r2CUHvAHOTh6Cgz8ODkzreg@mail.gmail.com>
 <CA+P7+xrQy33gt8bnsagLVPAHhZPZx-3s0E_Aj7tOwXnHjOoCBg@mail.gmail.com> <xmqqr39cjwxx.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 25 Aug 2016 15:46:00 -0700
Message-ID: <CA+P7+xqDRD4akNShqxs4D2dDUBK0E5Eyp2Y3-8xK6wEb5gCU6w@mail.gmail.com>
Subject: Re: [PATCH v10 0/9] submodule inline diff format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 25, 2016 at 3:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> So we should support the gitlink to a repository stored at <path>
>> without stuff inside the .git/modules, and we should support submodule
>> gitlinks with a proper .gitmodules setup. I don't think we should
>> die() but we should error properly so I will introduce a _gently()
>> variant of these functions, and die properly in the regular flow.
>
> Because "git diff [--cached] [<tree-ish>]" in the top-level is
> driven by a gitlink in the index, immediately after adding a new
> submodule to the index but before describing it in .gitmodules you
> might not have a name (and you know in that case the path will
> become the name when adding it to .gitmodules).  Also a gitlink in
> the index may correspond to a submodule the user of the top-level is
> not interested in, so there may not be anything in .git/modules/
> that corresponds to it.  In these cases, I suspect that you do not
> want to die, but you can just tell the user "I do not have enough
> information to tell you a useful story yet".
>

Right. submodule_from_path() fails to find a config. I don't think
die() is right here, because there is no easy way to make this into a
gently() variant.... I can still do it if we think a die() is
worthwhile otherwise for the other callers of do_submodule_path...

However, I think the safest thing is to just:

a) read_gitfile on <path>/.git
b) if read_gitfile succeeds, use it's contents, otherwise use
<path>/.git for next steps
c) check if the resulting file is a git directory, we're fine.. we
found a gitdir, so stop.
d) otherwise,  empty the buffer, then lookup submodules
e) when submodules lookup succeeds.. see if we found a name. If so, use that.
f) if we didn't just exit with an empty buffer.

That empty buffer *should* trigger  revision error codes since it
won't point to any valid path and it also triggers the regular error
code in add_submodule_odb so it handles that with showing not
initizlied.

This method is less work then re-implementing a _gently() variant for
all of these functions.

Stefan, does this make sense and seem reasonable?

If we just die when submodule_from_path fails I think it's bad for the
submodule=* formats beside short. I don't know if it causes problems
for revision code or not... I think falling back to resetting the
buffer as our way of indicating error is reasonable enough...

Thanks,
Jake
