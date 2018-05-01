Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E64B9215F4
	for <e@80x24.org>; Tue,  1 May 2018 20:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750823AbeEAUXL (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 16:23:11 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:45001 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750743AbeEAUXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 16:23:11 -0400
Received: by mail-yw0-f181.google.com with SMTP id l142-v6so2694286ywc.11
        for <git@vger.kernel.org>; Tue, 01 May 2018 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6jYBXGPPVwnkcyLvt+8LfTlmVnXzT+JLSq5V60bqcts=;
        b=ObTWwmOzNVsfc3w9FNCXiRusgJbwhCztA5oovLrf6eQblIbG/XIDsFsf4JA/9WQuwn
         bYCPvrFgneOmo3mHHKfo+vcDTNROUatVz/wbiarym2j0Abta+PLxmRuHcEsqkgQn0bzM
         nSQQ8xUh2nyCqRT3+Yz5pTDoxvaKZfC4AKdWl4jOSKBtUB+ZcwiJ1NmLBjWheh6kn1Jo
         qN2aqRYZCOi4vr8tXINREJhmxmjNW4iUPCdlS8yuIoIf7tdVR4hJegPdUOAx/dkVkK44
         kj37Gjn6mlcvlzZeQQJl586FoPfDPbuJonWPjbH9AAomK6G4TUav62O+jGCzeR3ITXI6
         4eFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6jYBXGPPVwnkcyLvt+8LfTlmVnXzT+JLSq5V60bqcts=;
        b=HZLeri7G0f6OLeVKG4f5VMSErDY7DcqMe1xT17XMVDzBxgO9L3YnwbuoTw+dL/sZhv
         VHPjQ1TjDIbSVtcSdWy7H8C3OEkuou8UfltYOeX2bdU6GQYgeOcMS63fnLEN+SirutbV
         fZFQmeBS0IjxAfHz9g85Fk8QS5G849Qc4dyryu/MZrdCDeVkJiVnq3Zhz/D/IOx9yo7j
         KPPKFFX0WCEV0WMkzSIohTOKdpQokbPresxdBboIG0/KJi8JlFPpGP86nhrpG2ILjW6f
         VbwSMcdF0qUUr+juFysKUBvELlqp52WDZVr8Iq3zMNm5T1+IGiJpepMIh1sHdSjFJCfw
         FXiQ==
X-Gm-Message-State: ALQs6tDhDexYav+1yOys4ZH2t723LUIZMqoYBOjHmR8jNBObbZ+X5GVV
        eYDRPgJZuEOOZgyesW9ZEe2ZDYsB/DeUlpaz8OHU+w==
X-Google-Smtp-Source: AB8JxZptaiJf8t5lOPp8Cj7xA3pQzAfTzr9IJA5we/VHIPMYqTxn0ruIgcmndhaiN+gE2pvLEq153oJUlIXZgmTIbXw=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr9653347ywa.340.1525206189855;
 Tue, 01 May 2018 13:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Tue, 1 May 2018 13:23:09 -0700 (PDT)
In-Reply-To: <20180501180908.17443-3-kcghost@gmail.com>
References: <CAEp-SHV4hP=v_=AJExRS3hqT-x9rXEONofWD=sVQZC79uewATA@mail.gmail.com>
 <20180501180908.17443-1-kcghost@gmail.com> <20180501180908.17443-3-kcghost@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 1 May 2018 13:23:09 -0700
Message-ID: <CAGZ79kY686ptTPY8DVwr79F2vC6eC_BP=5M7isu9Gfu+eX7vDg@mail.gmail.com>
Subject: Re: [PATCH 2/2] submodule: Add --dissociate option to add/update commands
To:     Casey Fitzpatrick <kcghost@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 11:09 AM, Casey Fitzpatrick <kcghost@gmail.com> wrote:
>
> +test_expect_success 'submodule add --reference with --dissociate doesnt use alternates' '
> +       (
> +               cd super &&
> +               git submodule add --reference ../B --dissociate "file://$base_dir/A" sub-dissociate &&
> +               git commit -m B-super-added &&
> +               git repack -ad
> +       ) &&
> +       test_must_fail test_alternate_is_used super/.git/modules/sub-dissociate/objects/info/alternates super/sub-dissociate

We do already have the unfortunate precedent of using "test_must_fail
test_alternate_is_used"
(and it was partially included by me in 31224cbdc72 (clone: recursive
and reference option
triggers submodule alternates, 2016-08-17), further used in
bf03b790471 (submodule--helper:
set alternateLocation for cloned submodules, 2016-12-08).

I think it is the wrong approach though, as the test_must_fail only ensure that
*something* doesn't return success. Usually we use it with
"test_must_fail git ..."
to ensure we properly error out on user requests, that are impossible
to fulfill in
the current implementation.

For this test case I'd suggest we rather test that the no alternate is setup,

    test_path_is_missing
super/.git/modules/sub-dissociate/objects/info/alternates

as that tests the correctness of the --dissociate option?

Thanks,
Stefan
