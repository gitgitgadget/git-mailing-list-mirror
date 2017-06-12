Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5DEF20C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 21:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752525AbdFLVb2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 17:31:28 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34662 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752401AbdFLVb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 17:31:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id d5so5471837pfe.1
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 14:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QwtBx18e4c3BPnx7DyUApM2N4FG0qvTJ4iTlDdhZEx0=;
        b=XW9VR8pMrvw8T3Usul5i3G4S5GjhBaTkwtE/9d7il+kWrzDyUUTKKL7COwX3ArhljI
         wWnGqAn8GyDMo5rUfit2l0ZCBZF7Hu8TwhwwvtMSKSyI9qxrpbR2uM8Vl0SrzsdcDdQQ
         lHPslEnwNVGSrXYE2GqzzKHE4oUI0RI8gt4YaLgtDmeDIhiXxA/Cp5mdQEz1xsCQIlyG
         qs3A+vrubyb1LXgOVvnj9/HTyzyTNHQBnMhgZURSSegbR7sSObb5onAw/P0jatvatPWv
         46SUJdQ2ldqv2n1qwdXzGI6f4BKYaMGsotJpy3iXIv+dQP1e1YZ2QurlfhlQzZs4qCl5
         xm4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QwtBx18e4c3BPnx7DyUApM2N4FG0qvTJ4iTlDdhZEx0=;
        b=ks3n//WVl+vyaU6uly1LVxgG6Zs5O93VD9qeiviJkc9JslT5cqRKORDQ8R7SJCxEdp
         h9ousQmwpXpm0PIEXuTG2rG+GfdDeyloWNWPuI9xPyFm5l64nqVnf2du1E/s7wWINi6w
         MV3wE9B02zRNqnn9gFHqf2QSS3X8GrWd3qcVmSzoPCKiGz2cLTUs5Nx7SUbZdbd18Gr9
         4x8fQSSFiQYHJGXhg2Cm/eDW8ymCMqjRb4ySXvQxyF3uX68VZSj9G9ichRmEgjJq9lFd
         n2Z/BAGAhs0aW6ZgPQ4GlH6ROJBLpid4rUpetsqdl5ceubfvHIateIrjJ1XGy31qZ0Og
         8i2A==
X-Gm-Message-State: AODbwcA1vgrw3JDxUDIjCecjRW5flGHvFWmBr2IxkpNpkcqrL0q++HxD
        EbHsXD3lMyZvMbbLaVQ=
X-Received: by 10.84.238.136 with SMTP id v8mr58926871plk.249.1497303086379;
        Mon, 12 Jun 2017 14:31:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id h14sm7793784pfh.71.2017.06.12.14.31.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 14:31:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH] wt-status.c: Modified status message shown for a parent-less branch
References: <20170610015236.5237-1-kaarticsivaraam91196@gmail.com>
        <xmqq7f0k4m3e.fsf@gitster.mtv.corp.google.com>
        <1497084241.8531.2.camel@gmail.com>
        <20170610102127.ftvko3m7gazavpj7@sigill.intra.peff.net>
        <xmqqzidg14xn.fsf@gitster.mtv.corp.google.com>
        <1497255003.1718.1.camel@gmail.com>
        <xmqqa85dnjpz.fsf@gitster.mtv.corp.google.com>
        <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net>
Date:   Mon, 12 Jun 2017 14:31:25 -0700
In-Reply-To: <20170612212025.ytyukvmmthfcsejh@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 12 Jun 2017 17:20:26 -0400")
Message-ID: <xmqqshj4nb9u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> .... But I'm not sure it's actually helping for
> some of these cases. E.g.:
>
>> -	status_printf_ln(s, c, _("Changes not staged for commit:"));
>> +	if (s->commit_template)
>> +		status_printf_ln(s, c, _("Changes not staged for commit:"));
>> +	else
>> +		status_printf_ln(s, c, _("Changes not yet in the index:"));
>
> I think "staged for commit" still makes perfect sense even when we are
> just asking "what's the current status" and not "what would it look like
> if I were to commit".
>
> And avoiding the word "index" is worth-while here, I think. I am not in
> general of the "let's hide the index" camp" but it is a technical term.
> If we can say the same thing in a way that is understood both by people
> who know what the index is and people who do not, that seems like a win.

I do not mind "Changes not staged yet:".  The point was not about
getting rid of "stage" but about not mentioning "commit", because
stepping back a bit, if the readers are prepared to accept these
messages in the mindset that they are guiding them toward their next
commit, "I find 'Initial commit' confusing" would not have been an
issue in the first place.

>> -	status_printf_ln(s, c, _("Changes to be committed:"));
>> +	if (s->commit_template)
>> +		status_printf_ln(s, c, _("Changes to be committed:"));
>> +	else
>> +		status_printf_ln(s, c, _("Changes already in the index:"));
>
> This one is less obvious, because "to be committed" more strongly
> implies making an actual commit.

Again, I do not mind "Changes already staged:" too much.

If we can get rid of 'yet' and 'already' from the above two, that
would be even better.  The point of the exercise is to be understood
by those who do not think in terms of 'preparing for the next commit',
so 'yet', 'already', 'to be committed' are all counter-productive
for that goal.  Those who accept the 'description of the current
state in the context of preparing for the next commit' are not the
ones we are trying to help with the suggested three changes.

>> @@ -1578,7 +1584,10 @@ static void wt_longstatus_print(struct wt_status *s)
>>  
>>  	if (s->is_initial) {
>>  		status_printf_ln(s, color(WT_STATUS_HEADER, s), "%s", "");
>> -		status_printf_ln(s, color(WT_STATUS_HEADER, s), _("Initial commit"));
>> +		status_printf_ln(s, color(WT_STATUS_HEADER, s),
>> +				 s->commit_template
>> +				 ? _("Initial commit")
>> +				 : _("No commit yet on the branch"));
>
> This one I think is an improvement. :)
>
> -Peff
