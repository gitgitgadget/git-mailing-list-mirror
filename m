Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736271FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbdBJWxD (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:53:03 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33539 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752416AbdBJWxC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:53:02 -0500
Received: by mail-pg0-f66.google.com with SMTP id 194so4047128pgd.0
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=m4KfjIfAHepoHMUqaD4wjCmQbg9Msaxik4DyCUjJVq0=;
        b=dibSH6UzzVzEHjGPV48qPilauYYYUpvWOpepJAEf0KYfRgfxogq1dS/hCZg8JzbPLW
         Sna8Mu+Kf9KOwTnmIqo6pzNx96PtitgXGFYOjdOYDHB2niQ65u7hOEZiMmRBFIMKhLC8
         g45Ll0EAlO+HwQYd3o0H4o2HIQflpmLSBNpkB0/0ZvNsIk/c8pDZyuF2AC9W3Jd5RPZY
         Ay4CJcCpEtXDp+irfKdsX3MqcWLcjIRGcbLCGyPy5LPhcrBWMJPJLmBpqzRkxb622V/a
         SOgPgWtU6ipIy406tfBP6TguRLeixoumOTsEGxhgVXfbmh5iuU4qvzbigdqoRe2MjEVT
         mC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=m4KfjIfAHepoHMUqaD4wjCmQbg9Msaxik4DyCUjJVq0=;
        b=Mf0KjIf53F7ePwaQE/XsLV73Z8t0nKqoCUQ8152TJ9NA5sGspoddgR07nsJI0o58pA
         SywrdO+IW3kypFW8AgcdGO19qRjwpKLvJAcIeK32flMVeUVYVwr5mODfuU86ABLJ04rQ
         WuFEvthE0CKPP71WkAC87tHUVrJS8GRC74VOWfIrRiEgAEj5GXVsQ3CBHoPbOkkNmPr8
         aPHa+URIo06yT8/TGmb/Aj0+rppxyKj/QUu2S7hLvCoNbgUSvgs+pi1f7F357JXknFq5
         Caz8ojLvb/S24UKkE2gQuVWT6m2ozM6F1v+2R05nEjJa7soLtbsYLOOU+COMusR4jbRD
         PTuw==
X-Gm-Message-State: AMke39mIMkY5AJPZk5TXdISC4HMpKihR5Rm6xx5GGDQXpZEdY9Ai8jD2y3LuUkULVKAuBg==
X-Received: by 10.84.224.133 with SMTP id s5mr14670601plj.130.1486767182023;
        Fri, 10 Feb 2017 14:53:02 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id a62sm1197955pgc.60.2017.02.10.14.53.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 14:53:01 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: fuzzy patch application
References: <CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com>
        <20170210205749.c72ajnld7zjfjkwj@sigill.intra.peff.net>
        <CAGZ79kaG=oqDM=1+rz_zk6Qn-7wAszxPnBtqrkAJS29_qT7SoA@mail.gmail.com>
        <20170210214850.2ok62xdmemgotwnt@sigill.intra.peff.net>
        <xmqqy3xdisos.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 10 Feb 2017 14:53:00 -0800
In-Reply-To: <xmqqy3xdisos.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 10 Feb 2017 14:31:31 -0800")
Message-ID: <xmqqlgtdiroz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Making "am -3" default may also scare users who are not exactly
> comfortable with reading "git diff" output during a conflicted merge
> and resolving a conflict, but other than that there shouldn't be any
> downside.

Another obvious downside is that there are those of us who prefer to
run "am" without "-3" first to notice that the patch we expect to
apply cleanly does apply cleanly, which gives us a chance to catch
mistakes.  I personally feel that as long as there is a configuration
that makes -3 a personal default (with --no-3way override from the
command line), it is a better design not to enable "-3" by default
for everybody.  New people can first learn using both forms and then
after they got comfortable with resolving merges, they can choose to
flip the default for themselves.
