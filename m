Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 296FE211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbeLEUnv (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 15:43:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36938 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbeLEUnv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 15:43:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id z16so23923282qtq.4
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 12:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ikPXNmX6zBOarTxibamYHkHK0qxBDBm1q2kuuqpX+3w=;
        b=gdCyl6LEg3HR6GzcphqRio134fhDvj7IszzoVFc+4SqDXDVuOvIjwjV3i3jjX1GDjz
         yYYESe127HOqLInIBkuReMpWYyn3ZGrF4JOr8iR5aONk79dexUldaYLeBJDJQtRtt5HM
         He24cvUAZBbpbdDEOz0rF+s8P8l+fXpgD9MFRMVgIhYgNBrBB1Bl+1WLPy28LfsGI5p4
         t+mFt7+/VaBiOFlmKl1EwCbxDUxTGx8egAQmTsHyb0hkQvzTG0bTXKRIW9i0xXGaKP2E
         NjzJPT3l5TgnGpqOshmZRi6NGSFB94/wUmp3eYgz3YpIqbmL1/e7GbNAkmwKcMJvnBJD
         Cu7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ikPXNmX6zBOarTxibamYHkHK0qxBDBm1q2kuuqpX+3w=;
        b=W/dKoLcxhcazXUHNEgVSgc7ELjup1qdWRzjtqHrgpPWX6FNDhKxv52GA2ggMF4QTjD
         MkHJUk0p0pDBKmV7tSe8e/ALsDlnC8ZKdMN47v0TkHRDqDqArgGwoTJOe1OAJyTKp5xc
         EHLxdvPkXIEuyDbGg0dxUM8+mOZwyiBdamL7C4N/5H/Mu6TW7sM1EFlOOUKyGVB4mXOF
         PGeovZRV+mYkFPBh6/RWEpPfUqlJgaiGFfiCMBLfAyUB/svn30/UWDn7FqaNp5jj6C7v
         G9KPE8k7uoXsFpu4WqwjqjgK13W4UDtVKS1TCf4u0o/Lm7tXg1KCsFSA3Skv1mMg097X
         jxeQ==
X-Gm-Message-State: AA+aEWZ0foK5RNZ0xdKX9bScwIkc5CgCFhP6jDggnUkkKGuHhuU/k/Oz
        2sR3FvjGBAtBeSTKA28fOMoO+SdM
X-Google-Smtp-Source: AFSGD/VALTnCQ+eael5I6H4PWy7m+R3U+rcP3GbUgKoshHKcW3tL1iZNbRfgBi9xsk2WpJmbDAvegQ==
X-Received: by 2002:ac8:46c6:: with SMTP id h6mr25128012qto.315.1544042629950;
        Wed, 05 Dec 2018 12:43:49 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:6c7a:75a8:9e98:c11c? ([2001:4898:8010:2:55ae:75a8:9e98:c11c])
        by smtp.gmail.com with ESMTPSA id j89sm15028180qkh.34.2018.12.05.12.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:43:49 -0800 (PST)
Subject: Re: git, monorepos, and access control
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "Coiner, John" <John.Coiner@amd.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
 <878t13zp8y.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a5a3009e-346e-2b63-5b7c-3e9daf0c7de2@gmail.com>
Date:   Wed, 5 Dec 2018 15:43:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <878t13zp8y.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/5/2018 3:34 PM, Ævar Arnfjörð Bjarmason wrote:
> On Wed, Dec 05 2018, Coiner, John wrote:
>
>> I'm an engineer with AMD. I'm looking at whether we could switch our
>> internal version control to a monorepo, possibly one based on git and
>> VFSForGit.
>>
>> Has anyone looked at adding access control to git, at a per-directory
>> granularity? Is this a feature that the git community would possibly
>> welcome?
> All of what you've described is possible to implement in git, but as far
> as I know there's no existing implementation of it.
>
> Microsoft's GVFS probably comes closest, and they're actively
> upstreaming bits of that, but as far as I know that doesn't in any way
> try to solve this "users XYZ can't even list such-and-such a tree"
> problem.
(Avar has a lot of good ideas in his message, so I'm just going to add
on a few here.)

This directory-level security is not a goal for VFS for Git, and I don't
see itbecoming a priority as it breaks a number of design decisions we
made in our object storage and communication models.

The best I can think about when considering Git as an approach would be
to use submodules for your security-related content, and then have server-
side security for access to those repos. Of course, submodules are not
supported in VFS for Git, either.

The Gerrit service has _branch_ level security, which is related to the
reachability questions that a directory security would need. However,
the problem is quite different. Gerrit does have a lot of experience in
dealing with submodules, though, so that's probably a good place to
start.

Thanks,
-Stolee
