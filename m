Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6ED420248
	for <e@80x24.org>; Fri,  8 Mar 2019 00:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbfCHACW (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 19:02:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55699 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfCHACW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 19:02:22 -0500
Received: by mail-wm1-f65.google.com with SMTP id q187so11044076wme.5
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 16:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qJmggDbqDVB0bHIWJuEHfuGLIRXisU9HW770E2CFRXI=;
        b=lOA4FWxtME59Dmkdx+teY+Swkk56LAaNYdf59u8soJToVEbyg4KNhiWxDuQ5HgJDBW
         6q+dGemXew4vfJnqKHmh2oQcyN9LFv0YZ5cXXVtondzs/DItzXxzLD7yIXz70tPwytqm
         a3gWeF7u6xDkOA5GpLK9P5sspZli/57zQZ7mL0BLocFc3RISfpvcb2BZGVqedHNoDcmN
         06a1474a0Lu8Eq5nhUOIfKKGDJZPerbBbDq9UDHmvBicGSYc51btENHi9+xRzMctkdvK
         AAkZd0Ev8JeGEvphIht3czO053KApmOV7+TTJPnK8wxvsIf6kkzNFSGGt9op+ha7RmoF
         MwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qJmggDbqDVB0bHIWJuEHfuGLIRXisU9HW770E2CFRXI=;
        b=dHyfylzBpJhszM+bMBFQfiMjetgGY5nUV/LGRsdDLXKNgFiTex3cJjBVlQIDjaXEpO
         HYVjCw8CFXAT55IXdbNdhCjTik9bcaHdCHU1rSTu0gzdSlUqrcHpTqyKjuPD+XbUDNRE
         kVlT/b6TdAf/ByorBU0zDBJNoWkJzL0/iv4rPNzoOgG5XFRv/VdGsdwws4Y8Coss1S3Q
         0SN7lNASlAzWvtk0ZKDAxoT2qTJ1irSs5x+I5SLSlYqbrv1g66gGjGj38ARYp27+JrzX
         cISwVMbDc3r7A+qz/o7K19N/v9nPn7qr2F8NNCYPWfzOKW1XcBwWMTBTFvYZH8n2FkwH
         lHZw==
X-Gm-Message-State: APjAAAUhASyDP29wglJgJoe57xTtedI7DgxYwde8C63ok1wfEthLvkGk
        BJyYxdgk9QvrT/H/dB7gweY=
X-Google-Smtp-Source: APXvYqzXXIjFo9FgIflYKFmAGW2NH6O6ViXzlDieUONHR3nTLaKUqu8GMHUH6me/gZSVCYuvDxHRsw==
X-Received: by 2002:a1c:751a:: with SMTP id o26mr7306670wmc.10.1552003340391;
        Thu, 07 Mar 2019 16:02:20 -0800 (PST)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id y66sm9071897wmd.37.2019.03.07.16.02.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:02:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Mar 2019, #01; Wed, 6)
References: <xmqqa7i8ss4l.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C7F_Ju2F7COUVd9-1FcyQL=mZph7qmkDh9sS-ENb4PEQ@mail.gmail.com>
        <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org>
Date:   Fri, 08 Mar 2019 09:02:18 +0900
In-Reply-To: <f6052ac6-60c4-1e70-b3f4-571885ba9e8d@iee.org> (Philip Oakley's
        message of "Thu, 7 Mar 2019 12:34:48 +0000")
Message-ID: <xmqqsgvykzcl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

>> I should send switch/restore again soon. There are still a few
>> unaddressed concerns for git-restore since last time. Probably time to
>> refresh those discussions.
>
> Just catching up on back emails:
>
> The one point I noted is that "Overlay" is a new magic term without
> any explanation within the _documentation_.
>
> It would appear worth it to also add something (follow up patch?) to
> the e.g. git glossary to clarify how overlay differs, or is similar
> to, the different merge and reset modes.

Yeah, I recall that.  I was hoping that it would stop mattering when
we start using switch-branches and restore-paths, but of course it
would not hurt to clarify the doc in the meantime.

