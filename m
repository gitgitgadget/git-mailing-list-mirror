Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9384C20248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCRGpa (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:45:30 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33341 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRGpa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:45:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so1391156wmi.0
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UmDWFDSkckYr/NUcFMEc5A4vD7qBRALLP714Ijd1Z74=;
        b=dKvJn5kNcQCbSX2O+osRQtOBmFAx+VHlQXz4YRFdyby+kZT+TU4CNJd3F0CACMOF32
         tOkvM2JWudTDzQPRVLvTYQPcYlPL1xB7GXp606KS1HthCnH9ml1BPjdP6UIsd7T70c9N
         HjQfPliZxFJiC1kSy2k/coYcU6KR+JHpvo5tq3JR6udV/P7yy6ocj4+/RfWO69+913yB
         iSOy/wgCwpOpqU9mCxJOVjS8b8kwvWkRbmjUeZhGr/LpLRndNOntGq1TJKUlfGvi9NOR
         0v+wJs9J1Qx7zn9k+En1Sy8es+qfZeosBjCqO9DrDKKVGUlN0GX3iGM7fLIOlJvHG9xa
         KZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UmDWFDSkckYr/NUcFMEc5A4vD7qBRALLP714Ijd1Z74=;
        b=lDkLxtAhK7zkvQfnfJX/NDe/xnXJgwWnvUG7k6y8254zBBhUwRJBNNxPKivF1hqmwc
         oXNmRExvUWYqGrbxTxt11Sps0vbjR/VfpcQYpCbyAgZNEJqrlwyJtSgTPMuPIe7N6uT6
         IOBJOHNVOnFoxwR9XlJjDDzdVcdLyHfTLc04jolVSbrZdxxNQl2svtrEduZ1GJ/oQzA/
         dBYfyusJwVFdcqYKnVrXkIittOn3rUDaipykrm3kZKPhdpXP4iEXt/1JEyLM5OggUa89
         V3FXlWaPdrBLx7EKF6NLA1D2wAnNi2WUKp6ZUyqI8WW2DlQurg0sWo7ardNgyfSxdT2S
         1pxQ==
X-Gm-Message-State: APjAAAW9D5oy7ALlXJ1n7R/thB1INZqaM9aihUjP13Imw7374AsdF9K4
        xlsp3ABC9JB/BGI18kzXWSQ=
X-Google-Smtp-Source: APXvYqz+22+20xCfGknk/gTvx06k2BXNvhfevuK/BXMprmncJbPlUJqTbg3LY2kWMa2s/TQD52sQVg==
X-Received: by 2002:a05:600c:d5:: with SMTP id u21mr4401867wmm.12.1552891528016;
        Sun, 17 Mar 2019 23:45:28 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id o20sm658687wmh.21.2019.03.17.23.45.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:45:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
        <CACsJy8DU02_kOqAHhU5EgMHKmkNSGdvt+7XzSHoZDB+b9sDRqg@mail.gmail.com>
Date:   Mon, 18 Mar 2019 15:45:25 +0900
In-Reply-To: <CACsJy8DU02_kOqAHhU5EgMHKmkNSGdvt+7XzSHoZDB+b9sDRqg@mail.gmail.com>
        (Duy Nguyen's message of "Sun, 17 Mar 2019 20:24:16 +0700")
Message-ID: <xmqq5zsg3cl6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> -       This is synonymous to the previous form.  If <commit> on
>> +       This is synonymous to the previous form.  However,
>> +       users should prefer the previous form over this form
>> +       as this form may be more confusing due to the same
>> +       notation having a logically conflicting meaning in
>> +       linkgit:git-rev-list[1]-ish commands.  If <commit> on
>>         one side is omitted, it will have the same effect as
>>         using HEAD instead.
>
> This is fine as-is. But another option to reduce even more exposure of
> these forms (both <commit>..[<commit>] and <commit>...[<commit>]) is
> to delete these forms in "DESCRIPTION" section and add maybe "EXOTIC
> SYNTAX" (or something) section after "OPTIONS" for just them.

There is no other way to express A...B (well, short of spelling it
out as "$(git merge-base A B) B"), so while it makes quite a lot of
sense to discourage A..B (simply because .. is unnecessary and can
be replace with a string with one fewer letter in it, namely " "),
I am not sure if it is wise to throw the three-dot form into the
same basket.

