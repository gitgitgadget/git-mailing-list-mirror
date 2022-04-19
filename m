Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C3C433F5
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 22:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358369AbiDSW4t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 18:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiDSW4s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 18:56:48 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5942E289A1
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 15:54:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id md4so171213pjb.4
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uKTdQ507a9OJFEaVSCv+VaoX6jaMip9hjw4+2ijmjkk=;
        b=Ob9rpH4r/xhiQL/99gUStKiP9tFp4JzE8yICIL78/lez0wbdJQtv0l4jN3euINRpLq
         9HbEHLUDSATu2SkeSV28O1SeBlAXFDekqbIL2enzv6aNVriUSWFGKdX1853XENX6y0L3
         +5W/1lul6fEkoKwMTRlE2+a75MG/1iUjsu/DSb9dajUYd4AEAplWGLfVsHulORLTT8D7
         zsSoxGpHJvMk+CEKt6fPbb4UJV+JDrRBkn+bKqpWKGyFmvgot/b76mkXgNN8XcBELc83
         0OtX/Ye1Dx+fmXcqhod8F3M750WtFTrsbDQCYN3nCTeaV+S8Z9CJS/b7kJofBCS3or+V
         x1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uKTdQ507a9OJFEaVSCv+VaoX6jaMip9hjw4+2ijmjkk=;
        b=7fFi+zT+VNiqVxY5FbO3OduXcC+sJfoGPcpxmra+usl8/DFiim6r3A6pUcvPsLU52S
         sEN5cpyhYduNK2f2lLt+kW7MTkNrf1+iywHaGeGp0wCEEFsKfbSZen7r6RQetiZOx/Hr
         Ew88a3HwuvVY1SlocQ3E6hDV1uDxPwVKVMjEX6D8uEWSxkppcUwHwF5A2Gy+Pl3DAAqw
         sF09ZOpwmspM+GGQZ7BIJm9XFuyHL8rYS7SEhA8qFJlUMGddHGUq++XHsZ2aNzPmGv+m
         kGwaYwqhwb4vZz94/7T98zwk5TY52fDoC81rks3ApKgLckhOZ/2Sd+HbPe2NsRxy9hlE
         Yz0w==
X-Gm-Message-State: AOAM531TtH6dC5cZPJw044ZHd8PNb3hkTFnxaAT91ZklaTBPsgePkGLp
        YS1CkzMVukZaNobrRP+2XrBGAA==
X-Google-Smtp-Source: ABdhPJy19UaN4AfYKO84Ar/AgCcEKQj3V/WI67VUAQeBxksTAMRNCi+RJMc+aLvWIrfrm3Ax54zADw==
X-Received: by 2002:a17:902:f690:b0:158:d6ee:b1f9 with SMTP id l16-20020a170902f69000b00158d6eeb1f9mr17450238plg.80.1650408843425;
        Tue, 19 Apr 2022 15:54:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:db68:2c97:40f3:5624])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b004e1b7cdb8fdsm18769887pfl.70.2022.04.19.15.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 15:54:02 -0700 (PDT)
Date:   Tue, 19 Apr 2022 15:53:56 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/3] CodingGuidelines: hint why we value clearly
 written log messages
Message-ID: <Yl89hMGLN3DqIkJ7@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-3-gitster@pobox.com>
 <YiFYQBWBVq/HQULM@google.com>
 <xmqqv8wu5zpr.fsf@gitster.g>
 <xmqq8rs82m4f.fsf@gitster.g>
 <220414.86lew7d7tb.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <220414.86lew7d7tb.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2022 at 04:04:59PM +0200, Ævar Arnfjörð Bjarmason wrote:
> 
> 
> On Wed, Apr 13 2022, Junio C Hamano wrote:
> 
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Emily Shaffer <emilyshaffer@google.com> writes:
> >>
> >>>> + - Log messages to explain your changes are as important as the
> >>>> +   changes themselves.  Clearly written code and in-code comments
> >>>> +   explain how the code works and what is assumed from the surrounding
> >>>> +   context.  The log messages explain what the changes wanted to
> >>>> +   achieve and why the changes were necessary (more on this in the
> >>>> +   accompanying SubmittingPatches document).
> >>>> +
> >>>
> >>> One thing not listed here, that I often hope to find from the commit
> >>> message (and don't), is "why we did it this way instead of <other way>".
> >>> I am not sure how to phrase it in this document, though. Maybe:
> >>>
> >>>   The log messages explain what the changes wanted to achieve, any
> >>>   decisions that were made between alternative approaches, and why the
> >>>   changes were necessary (more on this in blah blah)
> >>>
> >>> Or maybe "...whether any alternative approaches were considered..." fits
> >>> the form of the surrounding sentence better.
> >>
> >> Quite valid observation.
> >>
> >> Documentation/SubmittingPatches::meaningful-message makes a note on
> >> these points, and the above may want to be more aligned to them.
> >>
> >> Patches welcome, as these have long been merged to 'master/main'.
> >
> > Another thing.  If you (not Emily, but figuratively) haven't watched
> > Victoria's talk https://www.youtube.com/watch?v=4qLtKx9S9a8 on the
> > topic of clearly written commits, you should drop everything you are
> > doing and go watch it.
> >
> > And with what we learn from it, we may be able to rewrite this part
> > of the documentation much more clearly.
> 
> The slides for it are at
> https://vdye.github..io/2022/OS101-Writing-Commits.pdf (not in the video
> description, but at the very end of the video).
> 
> It's easy to nitpick/improve existing examples, so here goes :)
> 
> The main commit message example in that talk starts as just "Make error
> text more helpful", and ends with a better version as:
> 
> 	git-portable.sh: make error text more helpful
> 	
> 	The message “Not a valid command: <invalid command>” is
> 	intended to notify the user that their subcommand is invalid.
> 	However, when no subcommand is given, the "empty" subcommand
> 	results in the same message: "Not a valid command:". This does
> 	not clearly guide the user to the correct behavior, so print
> 	"Please specify a command" when no subcommand is specified.
> 
> For our CodingGuidelines I think it would be useful to have some version
> of "if you can explain something with prose or tests, prefer
> tests".
> 
> I.e. other things being equal I'd much prefer this version
> (pseudo-patch):
> 
> 	git-portable.sh: don't conflate invalid and non-existing command
> 
> 	 git-portable-test.sh | 2 +-
> 	 1 file changed, 1 insertion(+), 1 deletion(-)
> 	
> 	diff --git a/git-portable-test.sh b/git-portable-test.sh
> 	index c8bd464..e03f4a8 100644
> 	--- a/git-portable-test.sh
> 	+++ b/git-portable-test.sh
> 	@@ -5,7 +5,7 @@ test_expect_failure 'usage: invalid command' '
> 	 '
> 	 
> 	 test_expect_failure 'usage: no command' '
> 	-	test_expect_code_output 129 "Not a valid command: " ./gitportable.sh
> 	+	test_expect_code_output 129 "Please specify a command" ./gitportable.sh
> 	 '
> 	 
> 	 test_done
> 
> It ends up basically saying the same thing, but now we're saying it with
> a regression test (test_expect_code_output doesn't exist, but let's
> pretend it's test_expect_code + a test_cmp-alike).
> 
> What it does entirely omit is the "why".
> 
> Now I realize I'm nitpicking a slide shown at a conference, which by its
> nature needs to show a small pseudo-example, but I think this applies in
> general:
> 
> While "why" is a good rule of thumb I think it's just as important to
> know when not to include explanations and when to include one.
> 
> For cases where something is straightforward enough (as in this case,
> the RHS of ": " is clearly missing) I'd think omitting the explanation
> would be better, as we should also be concerned about the overall signal
> ratio.

Preface: I don't want to start a fight ;)

I think if you are in a position where you already will read every
single patch that comes across the mailing list, including its diff,
then you make a really valid point. I can read the negative line of your
diff, infer the problem ("oh, there's nothing after :"), and examine the
solution. Fine.

But I also don't think that most of us working on Git have the time to
read every patch and its diff. I certainly don't. I'd agree that your
patch's subject line is a little more informative than Victoria's, but
past that, if the commit message is empty, I have no idea what problem
you were trying to solve until I have scrolled through lines of context,
diff lines, and finally arrive to the regression test (which ends up at
the very end of the patch in Git, because of the way the codebase is
organized). Whereas, with Victoria's proposed commit message, I can read
the paragraph and decide whether I need to review, and from there decide
whether the diff does what she says it should.

So as I'm deciding what to review, I definitely would prefer Victoria's
commit message. Plus, like I mentioned, it gives the extra safeguard of
allowing reviewers to check: does the patch actually do what the author
meant for it to do? If we're never told what the author meant for it to
do, then we are missing information needed for that part of the review.

Anyway, I haven't watched Victoria's talk yet, but I will do so soon :)

 - Emily
