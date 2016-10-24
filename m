Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AD2F20193
	for <e@80x24.org>; Mon, 24 Oct 2016 22:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757333AbcJXWrY (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 18:47:24 -0400
Received: from mail-yw0-f178.google.com ([209.85.161.178]:34627 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753853AbcJXWrX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 18:47:23 -0400
Received: by mail-yw0-f178.google.com with SMTP id w3so208413629ywg.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 15:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MMb3EGjA++TBrzfAVwWokM+vL9E0dYWrVmIDGj03l6g=;
        b=GTPnkQ8pirS6qCG2FMf4M7IkQJaHO2mAbLj+RItns25bj9o7mzbfCIMFBnojorwG5Q
         4UhrY7CNWKvCX3MynxzunP7hrxT2E2oiTfdfqMEZ7QnzMsO9BN5b3XoCm0d85PanqpiO
         werBbqPS2yLCYlVRN7Sn7kdwB6iUSC9RJzejBEbP+2dbW2049/zwN1x9rfaXC0g5KPaO
         4hmRmVI5reg4g4dV06FjhefHKAF7c6qdPVJg0vHehpcIU0demIUXIqc+Hv/B9r54zyEa
         ZJomzJLUvn1mSboSepqHm0o/UfYoLLkoFwlUo20NkXWxDhReLiZpmPoRjDKMVhlKh164
         PkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MMb3EGjA++TBrzfAVwWokM+vL9E0dYWrVmIDGj03l6g=;
        b=TtEqiRGlS1rtRakCSuba9a2zobolBiB/+RufOPUKo+G5clNY67/0dVkRguhO5igy6/
         Eg59DmY915QmYbGCtMDG5iQC15I0sCtZaeo2abSJ69BmtXGzLskxOr9IJYvK2HosCsDC
         k6qPMNss63A5n5xKRelsN+0ae2wJxIdm4rIBVn0TivkZUc9ZJsK+GwfEgNsSt6ZrKGEE
         1EFuJ56TzY9V6FLk62gOSLgnuB9SD3lleIUk7gjRAoq9CF2WisTAOkGmxb1ersZOG7uf
         gB6ax2DEThUtOaHKlSlmp2944FcOyQ5VwGGFddDqYIZVyRMnFpvoqFHMBbANj2PJDIlf
         OnfA==
X-Gm-Message-State: ABUngvfnR9tOHMxwDtWH5I5JSZzpL2+qA+iPEK7xl7DBKzYKG0nKdom3q2QFtR6gEAHYrSoOcaV7vGv8CKttHQ==
X-Received: by 10.107.138.160 with SMTP id c32mr15765242ioj.235.1477349242856;
 Mon, 24 Oct 2016 15:47:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.5.212 with HTTP; Mon, 24 Oct 2016 15:47:02 -0700 (PDT)
In-Reply-To: <CALhvvbYnTf9qqsCFWjgfnynRy9LDEQf=Y++2tQioTKHbaYGHDA@mail.gmail.com>
References: <20161024214601.GA11699@hostname_variable_in_muttrc> <CALhvvbYnTf9qqsCFWjgfnynRy9LDEQf=Y++2tQioTKHbaYGHDA@mail.gmail.com>
From:   Alexei Lozovsky <a.lozovsky@gmail.com>
Date:   Tue, 25 Oct 2016 01:47:02 +0300
Message-ID: <CALhvvbap=-KNHiDvKy4bb9BdWkgbxOjhVXAw+EQpRNXKeqgQFw@mail.gmail.com>
Subject: Re: An anomaly, not a bug
To:     "m." <botmetkas@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Actually, git reads
>
>     # comment
>
> as 'ignore files with name "    " (4 spaces)', and then a comment.
> It does not ignore the leading whitespace.

Even not as a comment, it treats it as literally a filename with
a hash and that comment in it. However, one (usually) does not
name their files like that, so for all purposes this can be thought
of as a sort of comment.
