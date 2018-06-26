Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA591F516
	for <e@80x24.org>; Tue, 26 Jun 2018 17:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753051AbeFZRFh (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 13:05:37 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36644 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753024AbeFZRFc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 13:05:32 -0400
Received: by mail-pl0-f65.google.com with SMTP id a7-v6so8838229plp.3
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5NBEvbNJ+Cz1lyOnzAsmss5iERQwdBj8BE6C+eYBufA=;
        b=CMhxDwp/EDIRhGF3WdBqV7zSy7pt+wIkv79wLaf6OrzBlMYGLwpBk9ncFonkfMwBMg
         n4zqekp3HgBXi3xkY/s0FI+7jHYX6LTqJp4azWLsy3nVZK7gD4JtumaBTtk7ogBjlvol
         afrOvmzcdWebLz7ka+YCvDtBj3076B7b1QgIhXd8ZiVP2VV6e1KKeT4QxeImiKQdlm02
         H/6LDQQYafutNpIi8RjEwoQZ8+X8lplv/qUZc0AfNRlLtkfT8anETLwxmlXxU08GU8oM
         6xYkF+tvNW6RD5guhxKuKiJ61UKM8pL2j61kYF4fq5QbCY7ynY9PN68kkVcoihF8GnTH
         0fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5NBEvbNJ+Cz1lyOnzAsmss5iERQwdBj8BE6C+eYBufA=;
        b=eSAKl5fvbyxbm3XnbiHf43y6dqK3Xhb9iHxzOLW1SdCZf3fPFBJrEF5BJ3QVz2ItvC
         sihCShPMwU61CMKxGyQG2hKCRhl6V1uSYITguNq24zoiJLiic1KFkdRPCzrGzKsg2Pf8
         KeRbx7ySRBVpsFxGgyRYqTV6Qu0qvEzm2jbnVvz6mjfY1bX4Da1r5WQaqP5bx8Ga3whf
         +EWNWL8tTevcRw4KYC1zXFTfwdpEK6ogEomuOf+Ll4cNOvXJLHMgQfwtaIOb0dDER2+B
         bo90CCzoMAFuGg7EA+WVp4CH7M+A4xpuX03FTfLAKWi7XUgXemURhQ0CY0nsWjAE36xP
         ZbcA==
X-Gm-Message-State: APt69E3nKpD6cFEtUy/eM8V6FF9huYDSAYe55GXfGk71LKo/2yAvNr+S
        IsrOgnn6I9ziM5CSttXBEeh9WLv70z8=
X-Google-Smtp-Source: ADUXVKJ1ItlLEfAESfp0Pj5GYwhLse10G01oU5AK63pA5Qvj4YT221tiXfYgU+liOlg5JtCpy9eW0A==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6-v6mr2483127plp.21.1530032731738;
        Tue, 26 Jun 2018 10:05:31 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id h24-v6sm4241449pfd.69.2018.06.26.10.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:05:30 -0700 (PDT)
Date:   Tue, 26 Jun 2018 10:05:29 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     gitster@pobox.com, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/6] Restrict the usage of config_from_gitmodules to
 submodule-config
Message-ID: <20180626170529.GF19910@google.com>
References: <20180626104710.9859-1-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626104710.9859-1-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/26, Antonio Ospite wrote:
> Hi,
> 
> this is version 2 of the series from
> https://public-inbox.org/git/20180622162656.19338-1-ao2@ao2.it/
> 
> The .gitmodules file is not meant for arbitrary configuration, it should
> be used only for submodules properties.
> 
> Plus, arbitrary git configuration should not be distributed with the
> repository, and .gitmodules might be a possible "vector" for that.
> 
> The series tries to alleviate both these issues by moving the
> 'config_from_gitmodules' function from config.[ch] to submodule-config.c
> and making it private.
> 
> This should discourage future code from using the function with
> arbitrary config callbacks which might turn .gitmodules into a mechanism
> to load arbitrary configuration stored in the repository.
> 
> Backward compatibility exceptions to the rules above are handled by
> ad-hoc helpers.
> 
> Finally (in patch 6) some duplication is removed by using
> 'config_from_gitmodules' to load the submodules configuration in
> 'repo_read_gitmodules'.
> 
> Changes since v1:
>   * Remove an extra space before an arrow operator in patch 2
>   * Fix a typo in the commit message of patch 3: s/fetchobjs/fetchjobs
>   * Add a note in the commit message of patch 6 about checking the
>     worktree before loading .gitmodules
>   * Drop patch 7, it was meant as a cleanup but resulted in parsing the
>     .gitmodules file twice

Thanks for making these changes, this version looks good to me!

-- 
Brandon Williams
