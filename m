Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20511F600
	for <e@80x24.org>; Thu, 20 Jul 2017 17:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbdGTRoM (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 13:44:12 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37822 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936168AbdGTRoK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 13:44:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id n43so4371794qtc.4
        for <git@vger.kernel.org>; Thu, 20 Jul 2017 10:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OL9uIXPK9K/pNqpXkXHX5ZPhiudqcq0/7z62ankNaq4=;
        b=HxdjqECpgMfxfa0xKXRGZWZx7magG6Q7h29CVrxkIkHEwZSEyRrXycSDpj+OLDuwAj
         U4pY5gz+v1hwgh7dGJScINiOnAqxU21/LAeutMbjACYmoFspZoXSxc3LxBF1+oDKDyfh
         Rstn86fc/M5Xvt8G/ixkzVW6bjLUAMJMZ9lnbXo03w9uJzMi4AoAMFNqCb+Xta3dwlNl
         /R1eymP7mOYbxR9Ptvm+auxczjV7p+4NBj+tp916YNzrJt2Y6po6TehVELNv+0s6cJeB
         GGCkCNx8zJ9u9oyzyHYSY+f7EpG2AKchavdX/dDYw4qdNPpCXcQVTrQUUTIYsctzqNy0
         PKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OL9uIXPK9K/pNqpXkXHX5ZPhiudqcq0/7z62ankNaq4=;
        b=WQHi+WTMlie/yrd8r5y6iIYL6ga9zJ0VAAGcBPREc6o3VsgpeXfRuwoz93Z3yMNMY0
         rRE8O+EU+DBhqq4pmOWnWmhqJAUQQKNaZP310R3vnClGHaUiRCpMJCOyvsyqL5Nimr/S
         /84JZBIPxKkTuW80n/lepQyNtKGrT0dQJHSd5IZw/QNVqtvv1IdhzDdai5/lAzmIHj9o
         m3lIr0F2g+zK3FOwcdUFGnp+dwkxt3MoAeXeVuUzeVNn5wJnw1PWhjM10I4S8ScVdQL8
         F1i5OEasgV25WIeq8mVsdIeMhywDEPyIQsG7GGjq7TrD4Pd+RfaogEAIyKYEKkc4niJs
         kNCQ==
X-Gm-Message-State: AIVw112znh2ibOqXJpjQ+aY7l5dsy6IIZ0Qv4/JCWeYscYbCGGJw1sT7
        Ls2p6Qtkx8qr0Q==
X-Received: by 10.200.51.23 with SMTP id t23mr5911185qta.38.1500572649329;
        Thu, 20 Jul 2017 10:44:09 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id s3sm2069665qke.66.2017.07.20.10.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2017 10:44:07 -0700 (PDT)
Subject: Re: [RFC PATCH v2 1/4] object: remove "used" field from struct object
To:     Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Philip Oakley <philipoakley@iee.org>
References: <cover.1499800530.git.jonathantanmy@google.com>
 <cover.1500508695.git.jonathantanmy@google.com>
 <0eb270f40095f132bf9383f230506e45d895e5e1.1500508695.git.jonathantanmy@google.com>
 <CAGZ79kbYebKkSBtiFOMO5+uknbNMnhyT6P6uu=MMhmFyOZRE+w@mail.gmail.com>
 <20170719175512.4974d1a2@twelve2.svl.corp.google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dfa6a97c-683c-66d6-61f1-cf7cde6f8b16@gmail.com>
Date:   Thu, 20 Jul 2017 13:44:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20170719175512.4974d1a2@twelve2.svl.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/19/2017 8:55 PM, Jonathan Tan wrote:
> On Wed, 19 Jul 2017 17:36:39 -0700
> Stefan Beller <sbeller@google.com> wrote:
> 
>> On Wed, Jul 19, 2017 at 5:21 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
>>> The "used" field in struct object is only used by builtin/fsck. Remove
>>> that field and modify builtin/fsck to use a flag instead.
>>
>> The patch looks good to me (I would even claim this could
>> go in as an independent cleanup, not tied to the RFCish nature
>> of the later patches), though I have a question:
>> How did you select 0x0008 for USED, i.e. does it
>> collide with other flags (theoretically?), and if so
>> how do we make sure to avoid the collusion in
>> the future?
> 
> Thanks. 0x0008 was the next one in the series (as you can see in the
> context). As for whether it collides with other flags, that is what the
> chart in object.h is for (which I have added to in this patch), I
> presume. As far as I can tell, each component must make sure not to
> overlap with any other component running concurrently.
> 

This patch seems reasonable to me.  I agree it could go in separately as 
a general cleanup.
