Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6914A200E0
	for <e@80x24.org>; Thu, 29 Dec 2016 07:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbcL2H7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Dec 2016 02:59:35 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:34879 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752442AbcL2H7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2016 02:59:34 -0500
Received: by mail-it0-f66.google.com with SMTP id b123so38373003itb.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2016 23:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tactBCMdE02yFOBA+KIkxFXr+uM4TxsQjKLZllhh7jI=;
        b=cpyKZuXmlKcY6EPI+uHU3nT0h+nBjbBJesOqTP1VOomQWibpK0xltzLRnQNyKi+fIc
         QBuEevcB+OzEyyluNlcooA2dqJB0NBQVX1mzr2LH3twd1qlY4udQGkUptfmCQTT8Ns3r
         k9U7AZsLKj6jSA2s6S54TiJPW7vynFJQ7IDQTGuhuFvrNVFaeu2OaoyCbrRWmWwHMY6e
         gv+RlPeuJyavIieBTmOGEaTCsL1WBa8YTTwj2hMByS7AMFpVcDKNHaNEhgTfUx81C5xo
         qi+6/eKukdi50dyouizsyQA7wm16bS17gyN7zJ8g7JqaAdYkUIaI1xbFu9u5CDvMb5R4
         4ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tactBCMdE02yFOBA+KIkxFXr+uM4TxsQjKLZllhh7jI=;
        b=neE3siADsJ9sM5LxrVf2ucYX3+XxyoQFkZVToOijaFj+cskGXtydmEPahu6/zfrwPo
         PEf1zqZI/Z2W2MwpqihLcggzlULhjSRHwg7DU5aWslQftHlnhPbeDAqOsHlxOqBcfLQi
         lvQZAEliFTjBCYl5SgrKK7eDVB1O2TVcV2vSPe1s4KUGr5uZS63nS2TpjQ22REni/5L+
         4CzPA+pR11xCoj+KtlE8RsTn2mGSjxjQP/SLycTPR3m05MrHp0icBfDjs1420ZGKGmi/
         RN73gnO9Ul1t1zJY5De5gtLisCvpiBbBRTTazY6mk7eL/c44e25JE/AyuS5trALWQV4l
         YcbA==
X-Gm-Message-State: AIkVDXK4QdjCoRBLkkLDQEfozClrrb237/5DoeIRX4aPGVMowiTCV4dP6idDTzmccUpf+CbJN29Vw9h2rSVozQ==
X-Received: by 10.36.216.132 with SMTP id b126mr35998120itg.45.1482998373635;
 Wed, 28 Dec 2016 23:59:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.137 with HTTP; Wed, 28 Dec 2016 23:59:33 -0800 (PST)
In-Reply-To: <20161228191928.GH3441@thinpad.lan.raisama.net>
References: <20161228183501.15068-1-ehabkost@redhat.com> <CAGZ79kaBpC5ym2N_fMZHDmL4gGpU8pFAsupCE4aTdENh+=z72g@mail.gmail.com>
 <20161228191142.GF3441@thinpad.lan.raisama.net> <20161228191928.GH3441@thinpad.lan.raisama.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Thu, 29 Dec 2016 13:29:33 +0530
Message-ID: <CAFZEwPOPMrCXTc+SMhjGSnPKLmefcde4MgJsz7n5rBApACZOug@mail.gmail.com>
Subject: Re: [PATCH v2] am: add am.signoff add config variable
To:     Eduardo Habkost <ehabkost@redhat.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Paul Tan <pyokagan@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Eduardo,

On Thu, Dec 29, 2016 at 12:49 AM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> test_expect_success '--no-signoff overrides am.signoff' '
>>       rm -fr .git/rebase-apply &&
>>       git reset --hard first &&
>>       test_config am.signoff true &&
>>       git am --no-signoff <patch2 &&
>>       printf "%s\n" "$signoff" >expected &&
>>       git cat-file commit HEAD^ | grep "Signed-off-by:" >actual &&
>>       test_cmp expected actual &&
>>       git cat-file commit HEAD | grep "Signed-off-by:" >actual &&
>>       test_must_be_empty actual
>> '
>>
>> The test fails because the second "grep" command returns a
>> non-zero exit code. Any suggestions to avoid that problem in a
>> more idiomatic way?
>
> I just found out that "test_must_fail grep ..." is a common
> idiom, so what about:

Is there any particular reason to use "grep" instead of "test_cmp"? To
check for non-zero error code, you can always use "! test_cmp".

Regards,
Pranit Bauva
