Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7519B1FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 22:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751717AbdBNWRb (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 17:17:31 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36355 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbdBNWRa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 17:17:30 -0500
Received: by mail-ot0-f195.google.com with SMTP id l26so5598724ota.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=07uPkX9ziLaJnHqVCdG+RsouMQtySvoHPt7YSnVtRPs=;
        b=oryNl6sI52xDMwlzkx3pZbz2qA7zI+7NS41ae9xSEnaa6Bo8ibxPyVgH3e5eO9khNk
         ef9HWngCkriBlSM3yQOj0ksN6GyKJ8Jmy4yiBRYUofpCr98wnNTqMb/W9u5S+iLbj1rN
         CK9Zw/D8SFh1ItOKiGxmoyLizPcru7cCcKsjBCJg1iPuFBHrx+eXdHse+WHhUTGI9hZS
         F3ZYwvXVBcLIEe8nnP8rophsX50FM3uP/0zn7CuVuRV2HlGMHtdgBb7CAbNSBLsWRd3n
         oeKBqZG+/NhGWR3X1pVlRCanu38l530QRojHpTlEAsbrVBN1N0ob1FAQ4rgEZJlIIRzn
         BdAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=07uPkX9ziLaJnHqVCdG+RsouMQtySvoHPt7YSnVtRPs=;
        b=Y7PDe3pxNWH31PpSah/EfCHQT6WGIG2Ubf/LS5Q2HTqHLQR+DVRkLcJopV+lJKf0iP
         2/5Uzh6JSCOMrlfkvfPrO+f+tRuziI3Iksq2WOLxhxy5HUVb/YlGwQ5vPPOl93T230cP
         Fdsllh31m+sofeBfd7BNsUGH8IkMmWY0iHQ676c+0fZb/Cr/liS4FSia7Xk+YBo1Cl/8
         8lcTR7fMMv7pL2Qcix99Hip7+4JcejHMhHM2YnVSxWse/QjDVQVXLXCxIVcQGOdyIZGI
         guzKI5xtP1861KXmqCRrp2sNaklxBoXDRbV8on6MEhK8ccCk0r6a1Yg2uPvmBnia4IOb
         u2Pw==
X-Gm-Message-State: AMke39k8ostdd/4+PPJ8UilVksHxq32WFNPZuvJI9Lxdpq/Zc1GrSYsizWEa4XwE1exKNw==
X-Received: by 10.99.125.68 with SMTP id m4mr35329738pgn.13.1487110649254;
        Tue, 14 Feb 2017 14:17:29 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:2447:f72c:8fdf:75c6])
        by smtp.gmail.com with ESMTPSA id o24sm3069854pfj.78.2017.02.14.14.17.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 14:17:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC-PATCHv2] submodules: add a background story
References: <20170209020855.23486-1-sbeller@google.com>
        <xmqqo9yblz33.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kb2jZ9fgct6gncDqmWFsbY4MRiboFXPvw7AMcU2KanyfQ@mail.gmail.com>
        <xmqq4lzw8mim.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
Date:   Tue, 14 Feb 2017 14:17:27 -0800
In-Reply-To: <CAGZ79kbjSLaUsJH_KuT6EiC+Kt-87+GjONt08hCytXULecMijA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 14 Feb 2017 14:10:12 -0800")
Message-ID: <xmqqmvdo76yw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Feb 14, 2017 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> If we were to redesign the .gitmodules file, we might have it as
>>>
>>>     [submodule "path"]
>>>         url = git://example.org
>>>         branch = .
>>>         ...
>>>
>>> and the "path -> name/UID" mapping would be inside $GIT_DIR.
>>
>> I am not sure how you are going to keep track of that mapping,
>> though.  If .gitmodules file does not have a way to tell that what
>> used to be at "path" in its v1.0 is now at "htap" (instead the above
>> seems to assume there will just be an entry for [submodule "htap"]
>> in the newer version, without anything that links the old one with
>> the new one), how would the mapping inside $GIT_DIR know?
>
> It depends. Maybe git-mv could have rewritten the internal mapping
> as well.

And then after doing the "git mv" you have pushed the result, which
I pulled.  Now, how will your "internal mapping" propagate to me?

I also do not think "this is similar to file renames" holds water.
Moving the path a submodule bound to from one path to another is
done as a whole, and it is not like the blob contents where we need
to handle patch application that expresses a move as creation and
deletion of similar contents at two different paths.  We can afford
to be precise (after all, we are recording other information about
submodules by having an extra .gitmodules file).

In short, "name" is not a design mistake at all.  That needs to be
excised from the "background story".
