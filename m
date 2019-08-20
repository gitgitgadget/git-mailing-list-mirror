Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553931F461
	for <e@80x24.org>; Tue, 20 Aug 2019 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfHTMVW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 08:21:22 -0400
Received: from mail-ua1-f43.google.com ([209.85.222.43]:35224 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbfHTMVW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 08:21:22 -0400
Received: by mail-ua1-f43.google.com with SMTP id j21so1875467uap.2
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 05:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=P3kQqYsO5iEjadUtwHX66Dv84f0w5roHsGoAxuETLC0=;
        b=TlvImD8n27sb7P1SQwx8g8VS6Je17K50xK1+a23wztGTDpTewIx+wjzfw6omPYmcO3
         vwAO+2OzCY5WhakTkSrgL3C/3EkfKjsvUQuibJQi6RTJO6ObfLSfMwEIv0bYICxkpdCV
         hwKwJoACPgKYazDn7/FuRqZIMbeV+SwkS4C97TLcNu/PuYivlcaF9MKbbWlvzbbmGDlw
         6LF7kVW25JlXbPZZRcA+Mvm4GWsGEzZ3QRNCHB/BdDKNa2fWbC7HuihI7jhWJBfSmbJU
         k9FEydyDre8pF7hhEtq0gALuXaeMp6jk1hyYe/Qv3pCFVtfrZrgOmBNkFbJU+CihXpXX
         ukdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=P3kQqYsO5iEjadUtwHX66Dv84f0w5roHsGoAxuETLC0=;
        b=KtOAXcAVI7Bf/qW8xJYqBVeUKFnCLRIX1UNIisbkWbnt+q7f5yd4NAlRQeYsltS0mu
         +VEqm/wBEn6K8JNhuZn30lCQh2W6QGT7ny7xOp7SDIn5EFsbEc1dArtREtNWRgaDJ62X
         RdEtLga/gqcDcNzWtZADvsmejLnsnSqYCp9MdgcZBsmZMBjzze7glt8yIg/6mLhVxbVI
         CkvpFk29s/2c8Fi6F5MPiyZYvWr3z79Aimmhz5RUHMISsQrxkEn9cWokuUvDd7ToB89O
         nUpS9omjnLtWhcEjY/EnoIdapdkN0rg1oO1HP0mhYB706hTOFDeK3HMmSdmNnoRD9kKb
         eSZw==
X-Gm-Message-State: APjAAAWMnY56sQeS9F9oF2J0A9TaF5iZxXmjdmnyItAyOWPazdIsdHvy
        hGsKZTxZuWIPNBH1rKWCI3YadhWI
X-Google-Smtp-Source: APXvYqwt/s/CBahuqxSSnKeh/QtqG5bCJIlTQs2gc88e6r5qavCtivscgGwnHHWTIBvxpJSop+MquA==
X-Received: by 2002:ab0:3247:: with SMTP id r7mr7568389uan.5.1566303681044;
        Tue, 20 Aug 2019 05:21:21 -0700 (PDT)
Received: from [192.168.1.254] (c-73-217-142-143.hsd1.sc.comcast.net. [73.217.142.143])
        by smtp.gmail.com with ESMTPSA id s1sm2911034vsb.20.2019.08.20.05.21.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 05:21:20 -0700 (PDT)
To:     git@vger.kernel.org
From:   Leam Hall <leamhall@gmail.com>
Subject: Only track built files for final output?
Message-ID: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
Date:   Tue, 20 Aug 2019 08:21:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all, a newbie could use some help.

We have some code that generates data files, and as a part of our build 
process those files are rebuilt to ensure things work. This causes an 
issue with branches and merging, as the data files change slightly and 
dealing with half a dozen merge conflicts, for files that are in an 
interim state, is frustrating. The catch is that when the code goes to 
the production state, those files must be in place and current.

We use a release branch, and then fork off that for each issue. Testing, 
and file creation, is a part of the pre-merge process. This is what 
causes the merge conflicts.

Right now my thought is to put the "final" versions of the files in some 
other directory, and put the interim file storage directory in 
.gitignore. Is there a better way to do this?

Thanks!

Leam
