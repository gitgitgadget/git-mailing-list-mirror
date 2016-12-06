Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F2DB1FBB0
	for <e@80x24.org>; Tue,  6 Dec 2016 00:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbcLFASc (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 19:18:32 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35612 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbcLFASb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 19:18:31 -0500
Received: by mail-qt0-f179.google.com with SMTP id c47so331610859qtc.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 16:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uIxUrC6Ke/kzKGT4WUmb+M7MeyRLztN7r7Hfy05XGmM=;
        b=n3y5fTJJdG77I1h5gkdyVhfYBIOxHZ8CxA2uMS/uAcU/aBzuS6GG+/uImft5adHpeG
         BPam0h8EJk8UR9Q71GNookCkaW8WmbWgYWkvaTvsLwBcAFFVGc6ltBgNpvuSryxr1FVc
         nkZFGj+rKOFas+Zo/qwJMpuBl5IeijfyMScRjsC4J35xCj8igLZSW1gnYkFditb0HNGj
         6d5Fzng0BAEUNz/a9zpHADR7c2Sxk+b74arzj4NF3+RdjEE8BMel3+wDiqoBxHLWhB3G
         lyJ6siMfJjsvonJqaJb2kFrBxgDFU8OqjPA4KIaT6yqO0Tattj4xGnuHfB1rJ+5+DZjL
         89TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uIxUrC6Ke/kzKGT4WUmb+M7MeyRLztN7r7Hfy05XGmM=;
        b=DP6Pyv705fdntnHhV/o3P3i8yXhYopCzr74BPu3zBgkp40q8YZqTJX++vXJymkMh7s
         /w65i67ofy2f8TtxhONj0Wm0YPfEMOtZgcWOElTHKtwh84d7w+bP//b2y1GUi79ec38s
         AYuR4EHAiOeogyqaMWO4801uYuMZthAxXknxfwYnQ59jE+fvOX1gYbySBTD8afgbhwUR
         UPMS7NsWm8yh5pPBsmuooHW7Gx3AmIAdk3g8JHVal8OzcUqnxoIPy5Aufe2nrJbGk4vg
         ywPHotJw8iw8jWnzhJB7gXwtXt6SWAbfPR/kbO+8ukwejq5DEFtp0RxsPylx9TbvQE/N
         xEPQ==
X-Gm-Message-State: AKaTC02UJofAqWbxNF0BDxLnjn1GPV3wilfdCk1C3C29kK8VzXF76pg0TkKBSIa4JCByZBa9ORYE8zhzVb5e1ODM
X-Received: by 10.200.37.221 with SMTP id f29mr58185578qtf.123.1480983510231;
 Mon, 05 Dec 2016 16:18:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 5 Dec 2016 16:18:29 -0800 (PST)
In-Reply-To: <832dcc3eec0d4237a1e2766e8df690ee@exmbdft7.ad.twosigma.com>
References: <20161203003022.29797-1-sbeller@google.com> <20161203003022.29797-9-sbeller@google.com>
 <832dcc3eec0d4237a1e2766e8df690ee@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Dec 2016 16:18:29 -0800
Message-ID: <CAGZ79kaXqOjT_Jd_Q=GkDegbFJjoEQoxHJ-wvvCTkjALndBwFg@mail.gmail.com>
Subject: Re: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
To:     David Turner <David.Turner@twosigma.com>
Cc:     "bmwill@google.com" <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "hvoigt@hvoigt.net" <hvoigt@hvoigt.net>,
        "gitster@pobox.com" <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 5, 2016 at 3:37 PM, David Turner <David.Turner@twosigma.com> wr=
ote:
>> -----Original Message-----
>> From: Stefan Beller [mailto:sbeller@google.com]
>> Sent: Friday, December 02, 2016 7:30 PM
>> To: bmwill@google.com; David Turner
>> Cc: git@vger.kernel.org; sandals@crustytoothpaste.net; hvoigt@hvoigt.net=
;
>> gitster@pobox.com; Stefan Beller
>> Subject: [RFC PATCHv2 08/17] update submodules: add depopulate_submodule
>>
>> Implement the functionality needed to enable work tree manipulating
>> commands so that a deleted submodule should not only affect the index
>> (leaving all the files of the submodule in the work tree) but also to
>> remove the work tree of the superproject (including any untracked files)=
.
>
> "including any untracked files" bothers me, I think.  Checkout is not usu=
ally willing to overwrite untracked files; it seems odd to me that it would=
 be willing to do so in the submodule case.  I would be OK if they were bot=
h untracked and gitignored, I think.

I agree on being bothered, this is one of the things I thought how to solve=
.
See the test in "checkout: recurse into submodules if asked to", which
tests for untracked files and is still marked as a failure.

I think to address that issue, I'll add a flag to ok_to_remove_submodule
which let's you specify which files you care about and which you don't.

>> +                     warning(_("Cannot remove submodule '%s'\n"
>> +                               "because it (or one of its nested submod=
ules)
>> has a git \n"
>> +                               "directory in the working tree, which co=
uld not
>> be embedded\n"
>> +                               "the superprojects git directory
>> automatically."), path);
>
> What if instead it couldn't run the command because you're out of file de=
scriptors or pids or memory or something?
>
> I think this message should be in submodule--helper --embed-git-dirs inst=
ead, and we should just pass it through here.  Or, perhaps, instead of shel=
ling out here, we should just call the functions directly?

heh, good point. Will call the function directly.

>
