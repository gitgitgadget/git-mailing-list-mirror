Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C4C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 13:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiBINqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 08:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbiBINqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 08:46:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D03C0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 05:46:13 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id bx2so5133734edb.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=odoo.com; s=google;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=+WPla29TwNgRJklkVG9fb7/YrG4Fq5Ybzmagqa9wRVA=;
        b=G7a/K3VBbDS9VVitr+pykGi3fd0lW9paga27KqPSg3bpVssEf+Otf9h64kZEJTjZRk
         ILK8uAnASt+TYbpVTEBMDBnCPQTRN8Rn2psNdK12z+tm1eDkLG6Xdrpwdq5EgDkT2AP6
         mfA0gIGbdKv2BcKuxQO3CK907dSQbnSYhNnd+17vnsKaP0q6Mrs7GN7LqW99PMDRWgNb
         81yd0dc8a6774YfmdvPL6QRMLoTlAbDOGX+95++11MUHdR/UoEFkdG7PmESMyRuS7C3r
         ekyJPb+pJilMHJht6JkK4+F/LMttEyVMz9l9gqsfo8xTfu7CTA+WzdvkATZp/1qFhWUR
         6kKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=+WPla29TwNgRJklkVG9fb7/YrG4Fq5Ybzmagqa9wRVA=;
        b=MYT4rAnjuAwtYDowe27H9bFnc2urQZromHgRFUzqJPD8Svw+1y0zqlzsDQiB4sj27e
         28ls78TASCmA0PFCokGHsRNV81ZusCEDvzDXxu307/WV5Qt+/pb8quJbg4H4E0hU/sc4
         6vg2HKrbtlHqchLVX2GYBVROwAJytwBF4wXurvBeCqYxVD1+N1y+tyLKHDPWuR3gWErJ
         45nzKCkiG7S1V5hG4val5/MTTbWzzoOPZrojJI2ldjEJZFOIgI4HuNK8nQJn7gX8fOsG
         IH2bs5H7JnncRcCrisaWG7EipudNRktNjCCWQARxHn3uj3YTX5cDUw8A6c+o8evvoHEp
         mdOA==
X-Gm-Message-State: AOAM5327q9Vosly0lt14iLJBHdzM1FXKv+sWkMSrcFFe9Q3520d0N1EE
        lxOTU3dq9f5iKd4rRJamSuKC80JcRie9Sw==
X-Google-Smtp-Source: ABdhPJwiBXo/8J0cUPWVu5FjhavonGF0qrm0UdBGeEZd84qxP9i5xTY6S40G2ymsuqb52LuH9kFd8Q==
X-Received: by 2002:a05:6402:2691:: with SMTP id w17mr2550767edd.126.1644414371572;
        Wed, 09 Feb 2022 05:46:11 -0800 (PST)
Received: from [10.10.10.121] (host-85-27-87-206.dynamic.voo.be. [85.27.87.206])
        by smtp.gmail.com with ESMTPSA id pj22sm4192316ejb.192.2022.02.09.05.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 05:46:10 -0800 (PST)
Message-ID: <b54a6cde-5065-632b-012c-0d6f777249ef@odoo.com>
Date:   Wed, 9 Feb 2022 14:46:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
To:     tao@klerks.biz
Cc:     git@vger.kernel.org
References: <CAPMMpog6vKBfYEWqKDgK7YQQ96pPVMH7hYPXUHMnJsgLNgYMXA@mail.gmail.com>
Subject: Re: branch.autoSetupMerge option for "if name matches only"?
Content-Language: en-US
From:   Xavier Morel <xmo@odoo.com>
In-Reply-To: <CAPMMpog6vKBfYEWqKDgK7YQQ96pPVMH7hYPXUHMnJsgLNgYMXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I found this message when trying to see if someone had already suggested 
something along those lines.

In fact I would be even more restrictive: what I wanted to propose was 
to only automatically setup the merge on implicit remote tracking 
branches, that is:

     git switch foo

if there is no such branch locally will look for the corresponding 
branch in the remotes, and will create a matching local one. In that 
case it makes a lot of sense to create a remote-tracking branch: when 
implicitly checking out a remote branch, it's likely the goal is to 
track it.

The issue is that

     git switch -c bar foo

will do the same, despite explicitely creating a differently named 
branch, which is probably some sort of feature which needs to be 
remote-ed somewhere else. If this issue is not caught immediately it is 
possible to push directly upstream by mistake.

Upon reading the documentation of `git switch` I actually believed this 
would behave correctly given `autoSetupMerge=false`:

     --guess, --no-guess
         If <branch> is not found but there does exist a tracking branch 
in exactly one remote (call it <remote>) with
         a matching name, treat as equivalent to

             $ git switch -c <branch> --track <remote>/<branch>

Because `--guess` is the default for the `git switch <name>` form, this 
description made me believe the tracking would be forced.

Sadly it is not so, setting `autoSetupMerge=false` will also disable 
automatic remote-tracking on guessed branch.

As far as I'm concerned, `git switch` actually behaving as documented 
would resolve the entire issue (especially if it were possible to 
disable `git checkout` somehow, such that I would have to force muscle 
memory).

This is made more annoying because

     git switch -t foo

*does not work*, frustratingly (if as documented, this time) `-t` 
implies `-c`. So it's not even possible to remember to type `git switch 
-t remotebranch` and then live happily with `autoSetupMerge=false`. This 
makes `autoSetupMerge=false` a lot more frustrating that necessary.
