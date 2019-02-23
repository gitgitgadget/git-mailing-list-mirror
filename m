Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A72720248
	for <e@80x24.org>; Sat, 23 Feb 2019 15:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbfBWP2s (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 10:28:48 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:42114 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbfBWP2s (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 10:28:48 -0500
Received: by mail-wr1-f54.google.com with SMTP id r5so5383557wrg.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 07:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jENo0gWN4R1sGmRJn0J+Ha8yU/mv2SzLKbpOCDl5Bi8=;
        b=owrY+YJRIzDzuGw9/yR8fGVttywnbN39fPYT4wooMHF99Ms688A4+8OUb8W9xtavil
         YzXYBkwKleJJQ0gOgIXlJEmTI+faaZhYOfccDN7ZDTE977TZxpM6DC/cB7TgoAITfOsT
         kDdyO8Qc8ot/jCkayKK37TTRXkk8UPoZfgM6SBnx5gCiGPBE/cI577kDk59gqA94SEI+
         gt5WhD+ULDTDepvSD4cyMmCY7UynIqr3RerUkjVsLkXfflJsOM/lWWjmRtfikL0hToxe
         kAYz7+p3mx8TBET84hKgvd2JwploD2MF8H42H4FjamOnIeti0ZzKwAS5ANrH4LyeT44+
         DYlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jENo0gWN4R1sGmRJn0J+Ha8yU/mv2SzLKbpOCDl5Bi8=;
        b=tdJvWBgushIuiCDi8TyIDvjkz24/z3PWmE5hr3hGxUihpd83H0TZFKLNTPHV3i7F2O
         S0tAjNPalSdDe+1WZpvYwEEZ2Ksq3eMyJVrjuEMWYcayOYqSglK+5T+NcNJyisCSkKDZ
         D4eDIvh8EDTh5dUCbC70Tzjz5E13Ld4/6gkVBMyMlDVKSVRDYngLmhVs2JysU8rcybFu
         Q97Dsp6GPToBOnZRmXzzxDOL4zTTTJl4x7zrmCrjrOmx2/ptqziI/qnokjBvWnwDLxyZ
         /ZlNDp/Pcn1E5oHR2S44EYi2q9QZUxzFsnq3P+5rEw81mB9VPFiH3STKJARp4iFI+WH1
         XMuQ==
X-Gm-Message-State: AHQUAuZcBwwG/VUFslfAY0dXTmJ5lEGOoaAXuArGap8ITB6ZGaLyb8pZ
        s3j8NfMes1+L79U+UdiDovo=
X-Google-Smtp-Source: AHgI3Ia5rJSVAxs1JjXXNWvbuBLuyLWqCDFTxrE6cGW9+GI0HY8+JAChV3YQWDO9w5G2vXZT8Y82Ng==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr6960589wrn.45.1550935725699;
        Sat, 23 Feb 2019 07:28:45 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14sm3153828wrr.13.2019.02.23.07.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Feb 2019 07:28:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: does "git clean" deliberately ignore "core.excludesFile"?
References: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain>
Date:   Sat, 23 Feb 2019 07:28:44 -0800
In-Reply-To: <alpine.LFD.2.21.1902231008530.28936@localhost.localdomain>
        (Robert P. J. Day's message of "Sat, 23 Feb 2019 10:11:53 -0500
        (EST)")
Message-ID: <xmqqimxao76b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   am i misreading something? and if not, is there a reason git clean
> does not consult core.excludesFile?

Can you ask "git log" and "git blame" whch of  core.excludesFile and
"clean -x" features came earlier and by how big a difference?

Most likely this is because the exclude came much much later, and
either we forgot to teach the implementation of clean to pay
attention to it or (much more likely) the implementaiton is fine but
we did not update the doc, which was trying to overly be exhaustive,
doing no good (if the original just stopped at saying "... the
standard ignore rules read from the usual places", we won't be
having this discussion).
