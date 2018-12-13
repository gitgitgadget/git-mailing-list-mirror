Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BE9A20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 02:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLMCsR (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 21:48:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40704 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeLMCsR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 21:48:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so413643wrt.7
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZaBx/WBUEdIQ+kZZ0zcxO5y7IBjgEzrSdNGpGO30Hg4=;
        b=Zoi4lA5yAqoMq9n6PzVS3zJyYTXldIv+c/U7YwtMq/a+PwuPDGPvyb7bOXssmZb6SO
         I8lgeNLrkGntIrRer5nHePNmyYZgDjrIAE0ZRnxKdbh87A13UMZ1VRYTGCoV/+VmWWJc
         pDdM3NomIcMWGCbGTpeY7xCJhZk326uOQeFmNCs+8YiN82E7K18Vk4Z8zKyfmw2l2F0/
         C18pfzh19fEaAy4dIVazO4sQEcOPgVZHlU3sJxCRuPIQb9TGcXcOhk76G/+BJS9qd9Qo
         Jzh+8xg/p81Lu6rLFnDB7KJRn/QNmVs6P/8D8jcuAF91wXTyGqUE/yECgk9wiSj3n1AM
         FGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZaBx/WBUEdIQ+kZZ0zcxO5y7IBjgEzrSdNGpGO30Hg4=;
        b=j2SiTiUvpsnxGKJKwxpJcAKvSlTzqWhY7gLWY9Fdh+1t1vAXTLaejkaavVpps5ZyAe
         +mqFusc3KmIX10ondH0la5jkQUNBbqp/ujfamwT1vq0FN1k0Sae3xGUnmN1I+aKXJl38
         Ex3luNyflsz5HATU2BWdbYVLXDef5m0A2j0MYv1Isdw+V9qwPzyluSXSMYTx+0Cl9ARj
         y26kFnZi3tLvrbJzWLe0NxU3K6/45MaB4lBZBmNEcme3IPmePn1lcgQhVIsZfNZIUiF8
         nIMtwZlKbb1Hj5ClzN9psiVOdDyUKDBo2cvaMsF57yOXUCEEXp5VjBu4IewA/RksGg0N
         VjUw==
X-Gm-Message-State: AA+aEWZt01ps1sIevSRLXzJdEaBY8VlPvYfSsGm5S/n+TiKe3Rrx/8lh
        d8xKAXroDOuMUyevBxHXfhw=
X-Google-Smtp-Source: AFSGD/VdKuAq1hP6g+BgxTpOFIsEwtEKvcf/QqHvSl4+m7tesO2F/R0uGeWScIb2SM5C21lo/+3CZA==
X-Received: by 2002:adf:be0f:: with SMTP id n15mr20057844wrh.267.1544669294933;
        Wed, 12 Dec 2018 18:48:14 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k26sm564697wmi.28.2018.12.12.18.48.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 18:48:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] mingw: allow absolute paths without drive prefix
References: <pull.96.git.gitgitgadget@gmail.com>
        <50ac31ef7f4380f37a0e2d3b75e82b324afee9e3.1544467631.git.gitgitgadget@gmail.com>
        <11b17e5d-e843-463b-77da-263e8e3b7598@kdbg.org>
        <nycvar.QRO.7.76.6.1812111134250.43@tvgsbejvaqbjf.bet>
        <8a484f86-1d43-fc0a-22b4-39c770cda6cb@kdbg.org>
Date:   Thu, 13 Dec 2018 11:48:13 +0900
In-Reply-To: <8a484f86-1d43-fc0a-22b4-39c770cda6cb@kdbg.org> (Johannes Sixt's
        message of "Tue, 11 Dec 2018 21:36:06 +0100")
Message-ID: <xmqqmupagn0y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>>> +	if (is_dir_sep(template[0]) && !is_dir_sep(template[1]) &&
>>>> +	    iswalpha(wtemplate[0]) && wtemplate[1] == L':') {
>>>> +		/* We have an absolute path missing the drive prefix */
>>>
>>> This comment is true for the source part, template, but I can't find
>>> where the destination, wtemplate, suddenly gets the drive prefix. As far
>>> as I can see, xutftowcs_path() just does a plain textual conversion
>>> without any interpretation of the text as path. Can you explain it?
>>
>> It is legal on Windows for such a path to lack the drive prefix, also in
>> the wide-character version. So the explanation is: even `wtemplate` won't
>> get the drive prefix. It does not need to.
>
> I'm sorry, my question was extremely fuzzy. I actually wanted to know
> how the condition that you introduce in this patch can ever be true.
>
> And after looking at the Git for Windows code, I could answer it
> myself: it cannot. Not with this patch alone. In GfW, there is
> additional code in xutftowcs_path() that massages wtemplate to receive
> a drive prefix; but vanilla Git does not have that code, so that
> is_dir_sep(template[0]) and iswalpha(wtemplate[0]) can never be true
> at the same time at this point.

So,... what's the conclusion?  The patch in the context of my tree
would be a no-op, and we'd need a prerequisite change to the support
function to accompany this patch to be effective?

