Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C57F207D6
	for <e@80x24.org>; Thu,  4 May 2017 23:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdEDXk2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 May 2017 19:40:28 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35079 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbdEDXk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2017 19:40:28 -0400
Received: by mail-qk0-f180.google.com with SMTP id q1so23911940qkd.2
        for <git@vger.kernel.org>; Thu, 04 May 2017 16:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=m+BuG7QISE+UhB/YMDwCQBzLD6cF1zcGrO3J0zq4DaI=;
        b=hTAWnMRt7A6MGVjULcTEocxrvvQwhyH+3V7jL+xDcDOTeEw04OctqUwpn7Yqf9jRlO
         cPYF4Bu05TD6COy3fwY/OGdB7H/dAcY/cGAKX3Xhdhi44P3S1deA4yyY6iB/Ou/3B9MH
         V16gnALff2aUOBJoH0ldbCMp5BSCDDnOCikcnnNwjJe2rNWncrS/3YkDEPv3G2+G/Y1J
         wKQ1Px3tbs3lbMIC73lSDBy02KPW2kpMQaDoaVJpl6fPgjZ4aiwLpcE/DVR9Vg1zdvU4
         AvZgRD+Po1JDgqSLMx+5+2y2FUvyY+pVCqC/c5KufDaROIHJspweRzYmpax5WIfB4Wyg
         UuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=m+BuG7QISE+UhB/YMDwCQBzLD6cF1zcGrO3J0zq4DaI=;
        b=YMtIl2Qr2pUaz9TaEE+cpUkaAdJuU/+ZBuaN60930jqRLJ4sd0l360bfQ5ohyTctyl
         99DLHLblOuv9VuYuoRvCOS9RgH1kRTcK/KGv8BbTi46pccL+Ogqjl0NxnQjeesCGBxY/
         2lAy2qiOw2oF46ekKUk8iLu0+gn2OAON8ASE5coZk/C2XZS7ZB4FiCwqvL1n4GKiRsgu
         if+0ZJxdCIlaMRPpDddNuPejCmDxJczGGhhTDxhyLJns0PR7sqIb9RIA8ruMEMkNEl7m
         8UwKTjNiDix4oWZJXVQhgEtFXQy+nO30iqOvLWnsU4J4CGcantesXT2vtffdV8GII+vc
         Mt8w==
X-Gm-Message-State: AN3rC/6TG9UMh71EwqMRUVfH5ggx19re/g/vici7+samwUHsWT+/g4Fj
        fGAYCSfzm8LeQA==
X-Received: by 10.55.127.199 with SMTP id a190mr11106332qkd.123.1493941227255;
        Thu, 04 May 2017 16:40:27 -0700 (PDT)
Received: from [192.168.0.90] ([187.104.145.234])
        by smtp.googlemail.com with ESMTPSA id x53sm561257qta.36.2017.05.04.16.40.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 16:40:26 -0700 (PDT)
Subject: Re: Delta compression hooks
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <b8f1dab4-896f-c9ad-7a89-87aacb2c3e61@gmail.com>
 <CAGZ79ka66czcGpNGWFEQ=2Qf7OJgH7A-O+R860P=usiFWV4RBA@mail.gmail.com>
From:   "Soni L." <fakedme+git@gmail.com>
Message-ID: <6e5b70c3-cf80-d26a-1c7e-14c2a00a778b@gmail.com>
Date:   Thu, 4 May 2017 20:40:22 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79ka66czcGpNGWFEQ=2Qf7OJgH7A-O+R860P=usiFWV4RBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2017-05-04 07:57 PM, Stefan Beller wrote:
> On Thu, May 4, 2017 at 3:48 PM, Soni L. <fakedme+git@gmail.com> wrote:
>> Can we get delta compression hooks? I'm working with voxel data as my source
>> code (it's a long story...) and git doesn't handle changing lines of voxels
>> very well.
>>
>> Example, I have something from position (0,0,0) to position (0,10,0) and I
>> replace it with something else. Git doesn't handle this difference very well
>> if the file is encoded in XYZ order (it'd handle it exceptionally well if
>> the file was in YXZ or YZX order), and Z-order curves aren't much better.
>> It's even worse if the file is compressed.
> Maybe look into smudge filters to store the data in a different format
> inside Git
> than what is in the working tree.
>
> https://git-scm.com/docs/gitattributes

Those can only do so much. The best it can do is re-encode voxel data 
into Z-order curves, or recompress files into pseudo-compressed format 
(valid gzip file but every block is of type "uncompressed data").

I want something that can say "this file is 3D and we change a line of 
voxels here".
