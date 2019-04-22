Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B5CB20374
	for <e@80x24.org>; Mon, 22 Apr 2019 01:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfDVBNR (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Apr 2019 21:13:17 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39760 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfDVBNQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Apr 2019 21:13:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id j9so14118859wrn.6
        for <git@vger.kernel.org>; Sun, 21 Apr 2019 18:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VCyJ2qxQ9syDxfN3v3dFpF1++DShnuvqPh+Eb2DIUHw=;
        b=UCSU+3v97HvVintF8nr6GLuWV8NBz30Dsl0rxtr+oI/xUO6XuDUKw3jU06I6rL+efA
         22MWo1JwJXtJPi31WKRvJkmyB/evG0HEtocNcz1ePUQ0PmahMbJF4QM/l+ew2MkzFc83
         pfaT6Cn0ALXJ2Z6UQ8bUGttFFDSuY01givLx3Zw/2ElhDNBdgpOeljoK96mPOF33EHyx
         NOIij8VEcG9VWYiBisXyOt3j1Zdk0NwKSQmuZdBUTYPuz7I97MIPNg+GJzcg6/blqFVp
         zFjK28UdXP77s77WOzlgB6ag7ZSW7hDCi0/vA5yCdAkwPm4tJQREsVrCCqEARmyPkAYo
         0CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VCyJ2qxQ9syDxfN3v3dFpF1++DShnuvqPh+Eb2DIUHw=;
        b=qVWf41s6kSicIGb3eQZNZvU0qpUy7zCkKfn1+7kjY3JQslkb64gmc2bTgNqyaQX9J9
         IBHxO/e5ETDYrMXL/mS7qgh7/PpheIkGa+g1axWTfyUf0pd5h57zq5JCpbvpkUzZjWbg
         c/zBvFE5cEPABxD47BKZU8vzhYHTMta0SfDkcp1cVnI1MYlZGCWPqNzuJ08hkBIZDajU
         WjKyrGbK8N1MQ/nF4jzjpHFPbxQcOCRgp/RSjFLJTW1Eow4kEf8eUMT0iXFGFf2ROUDi
         6s8b1P5N7DXgc6jMVtO2PQ8vLMsb45TO8gA6WErY4I8N/uWgMTI1+ISJ0ZLnawUWSmrb
         4XQw==
X-Gm-Message-State: APjAAAVRMFYyMqc/RahfcT1+C9agtnw/gf4MYgIa8WPrrrbwV81ngr5M
        BOUsMdBJKQ4psjKLrc3yJi4=
X-Google-Smtp-Source: APXvYqzbs1Jy8mb73dmiZLc1caVf2xXz94YtI+4pps5DsyY3H9iwjR1HIS03Ws60PA5FeMJ0kcrMMQ==
X-Received: by 2002:adf:eb03:: with SMTP id s3mr1322357wrn.170.1555895594580;
        Sun, 21 Apr 2019 18:13:14 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id u2sm3016482wru.36.2019.04.21.18.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Apr 2019 18:13:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH/RFC 0/2] rebase: add switches to control todo-list setup
References: <20190422000712.13584-1-phil.hord@gmail.com>
Date:   Mon, 22 Apr 2019 10:13:13 +0900
In-Reply-To: <20190422000712.13584-1-phil.hord@gmail.com> (Phil Hord's message
        of "Sun, 21 Apr 2019 17:07:10 -0700")
Message-ID: <xmqqk1fm9712.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> Currently it supports these switches:
>
>     usage: git rebase [-i] [options] [--exec <cmd>] ...
>        :
>     --break <revision>    stop before the mentioned ref
>     --drop <revision>     drop the mentioned ref from the todo list
>     --edit <revision>     edit the mentioned ref instead of picking it
>     --reword <revision>   reword the mentioned ref instead of picking it
>
> I have plans to add these, but I don't like how their "onto" will be
> controlled. More thinking is needed here.
>
>     --fixup <revision>    fixup the mentioned ref instead of picking it
>     --squash <revision>   squash the mentioned ref instead of picking it
>     --pick <revision>     pick the mentioned ref onto the start of the list

Yeah, I can see that it may be very useful to shorten the sequence
to (1) learn what commits there are and think what you want to do
with each of them by looking at "git log --oneline master.." output
and then to (2) look at and edit todo in "git rebase -i master".

I personally would be fine without the step (1), as what "rebase -i"
gives me in step (2) essentially is "log --oneline master..".  So I
am not quite getting in what way these command line options would be
more useful than without them, though, especially since I do not see
how well an option to reorder commits would fit with the way you
structured your UI.

Having already said that, if I were to get in the habit of looking
at "log" first to decide and then running "rebase -i" after I made
up my mind, using a tweaked "log --oneline" output that looks
perhaps like this:

	$ git log --oneline master.. | tac | cat -n
	1 xxxxxx prelim cleanly
	2 xxxxxx implement the feature
	3 xxxxxx document and test the feature
	4 xxxxxx the final step
	5 xxxxxx fixup! implement the feature

I think I may appreciate such a feature in "rebase -i" even more, if
the UI were done a bit differently, e.g.

	$ git rebase -i --edit="1 3 2 b f5 b r4" master..

to mean "pick the first (i.e. bottommost) one, pick the third one
for testing, pick the second one, then break so that I can test,
fixup the fifth one, break to test, and finally pick the fourth
one but reword its log message", to come up with:

	pick xxxxxx prelim cleanly
	pick xxxxxx document and test the feature
	pick xxxxxx implement the feature
	break
	fixup xxxxxx oops, the second one needs fixing
        break
	reword xxxxxx the final step

I am guessing that the way you did it, the above would be impossible
(as it requires reordering) but given that you would leave most of
the 'pick's intact and only tweak them in-place into drop, edit,
reword, etc., that may not be too bad, but I suspect that it would
become very verbose.

	$ git rebase -i \
		--pick HEAD~4 --pick HEAD~3 --break --fixup HEAD \
		...

The --edit alternative I threw in in the above would make it
necessary for the user to spell out all the picks, and that would be
more cumbersome given our assumption that most picks will be left
intact, but then we could do something like

	--edit="1-4 5e 6 8-" master..

to say "pick 1 thru 4, edit 5, pick 6, drop 7 and pick 8 thru the
end".

I dunno.
