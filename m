Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D6C891F597
	for <e@80x24.org>; Thu, 19 Jul 2018 16:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732061AbeGSRRr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:17:47 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42233 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731663AbeGSRRr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:17:47 -0400
Received: by mail-wr1-f49.google.com with SMTP id e7-v6so8684807wrs.9
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oso+7ysX5GUGZrLB6OXX4ymjHc9HHfkM5AlHWqdkZ80=;
        b=DpJ9EtNjlVl4r4I8CCsk7yCgwYCelp9Wyoc3QKaFu49K8ccBW8ACiemarXGRvqjwAB
         1XVvcB0oNaaMpOq7yrhalAkVqY+mD30xU5oCLtuFIfjO7Fl5mvEJRLi3+oXXsv6xGrD5
         czuzL4jCRnYF4tNTHpg/tzBCnVlZz3usdnv39TGmXDuN1LZX+vM4d4QQUFds/AupwHDB
         uWPtbRzm5Jdm/M7AZ9JxQEBnDQLa0zSa+CdeBGm6K4HFqyLXQuX63EqMvU5flQyrgevx
         JLPMTe9rBOdAPwJWH/4RwHUq8tExv0WAP4nTPHnE1pQB7EO94pNezaP79We+is1HBFc+
         dK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oso+7ysX5GUGZrLB6OXX4ymjHc9HHfkM5AlHWqdkZ80=;
        b=bCFAqadXPqaPOeq7k/VdDW1Z7U1gRAeBP7p35Du/dwi52uchgRQ1S/ybElI9Vj5/OC
         yOCy6QTNvh7IuAdn36CdXLmugCJ22Q3iOuQlXlpht5f6oodIuLdHlftnc8qfhLh3z2VO
         t4/JyIMdhfzo5k/aVKz8lK4xm6UW5S20lpnjZ/vLgJS4MXg69xXxlLYrFjmnl8pupmDU
         Q7iHXxI13OO4x9jbARe4m+mxYxlnJQGnnfIqUVOrvBflk+MgX2UeA3e8EKE7ebJtXguy
         Z1v+Nm3V0W5ypiDq6Y+zngonLAQ+nZC0mpOSZnESq/++6+63Y3dewK+EbxfVIOfwes60
         bseQ==
X-Gm-Message-State: AOUpUlF6IOoNJmsNcM8yRUXTd37eL+aWpVGlnaU/boabmCUwcxBhjwKH
        h3jJGQdrmbjQSsy8W7UrPsFzlq+C
X-Google-Smtp-Source: AAOMgpdFbbbts+/U4umTN7qB4zjS/NujcCpffOtg5mUIKsXY3fbi7Q6sM5SUEGmqhBELLwNepohojw==
X-Received: by 2002:adf:82f0:: with SMTP id 103-v6mr7837334wrc.131.1532018028455;
        Thu, 19 Jul 2018 09:33:48 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p184-v6sm3912499wmp.31.2018.07.19.09.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Jul 2018 09:33:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2018, #02; Wed, 18)
References: <xmqqtvowi4l3.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kY15nPGwtOF=i09gQpykcxT4ZRzakuBr=aD94wRXtKOAQ@mail.gmail.com>
Date:   Thu, 19 Jul 2018 09:33:47 -0700
In-Reply-To: <CAGZ79kY15nPGwtOF=i09gQpykcxT4ZRzakuBr=aD94wRXtKOAQ@mail.gmail.com>
        (Stefan Beller's message of "Wed, 18 Jul 2018 16:41:13 -0700")
Message-ID: <xmqqmuungp78.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  It seems to pass its own self-tests standalone, but seems to break
>>  horribly when merged to 'pu'.
>
> It actually breaks combined with sb/submodule-core-worktree  :-(
> as that introduces another user of $name in git-submodule.sh
> which we eliminate in this series.

Thanks for diagnosing it.  I couldn't get around to figure out the
interaction before pushing out.

