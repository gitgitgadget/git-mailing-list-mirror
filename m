Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D7E91F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfHOVwb (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:52:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36120 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbfHOVwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:52:31 -0400
Received: by mail-pg1-f195.google.com with SMTP id l21so1888842pgm.3
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DPqrAXUcv9Bsvyyu1grFxvENdbvfrYGG892go+7pdr4=;
        b=hWxz6dVSZo8YNYZYp5/8xcM16+cMg4cyTKPWxCmRWLbRescfW4b0hAps1c8EW8ZFr9
         NR3angunL36VgOosAr1V6Pc0gHLx4iLEoFS2aPdqf1jP1p86xd03ffDjCPtxhW5PYZ7E
         MW+BbmmwEULWEYAW8N9nX0anOa/4QcTP0wzOcbTAcx2O7PKgFR3lrRDCefn+j2Ybux0C
         Kzzk3x6HimdnV5jC5oCHJ8FrsBqCTPa14GCrN97xEHmQIMtRWnStmISQDPD0cJTWi/qd
         t/4BKo4r7aaoonPlUt02Byc8tBGUVo4ZuT7pLsPjOa9vPfGdgMlGqr6gqChmOpcXLzmu
         uunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DPqrAXUcv9Bsvyyu1grFxvENdbvfrYGG892go+7pdr4=;
        b=GauH0LmFtnZdZxT5DFxxm0bKG0+cMiREKpWrVdvd60OPCoEQTUqmV2hLQLAQ+cc2he
         yBTOOwPpTM+6E4bo0IzugkcZR0mUDntYVgvZbJSJs3H2n5RoZa2Cbsh+9skRfxTFU2RO
         XHPXxNqCW8d9jJC0crtxIz2ROS9Jdu2BV4pmwzF+bjxJ+wL9DM8mttrCICOQWDMjcWaR
         1N0xrT2PjVfCoAzXKKXtcb1ZeDI4Gq40dW/dCjhKheW0y3+ltiB5e/lwnqaxJBmYvoab
         AO0Rpr8JAqdZbygWeagSMaMOY6E9S8KYEI8IXYswCNWOaUGymp0fSdEs1q3fTI+fSEmf
         yEWQ==
X-Gm-Message-State: APjAAAXUBhOX5kSkZKXkY9bcA6qM7/RDBdy8I3aRacUv4HoL/RiELA/k
        yNa30Ruz6ou5r9Wpi35uGMnG+rsJsqE=
X-Google-Smtp-Source: APXvYqzTF1iNU3Fr0hX/DkT4k2lhQj9YeRC5o4Cyif6Eds9OfRtTOyYsFyq01dlsi1HktnQk2ujfOg==
X-Received: by 2002:a63:c1c:: with SMTP id b28mr5112243pgl.354.1565905949864;
        Thu, 15 Aug 2019 14:52:29 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y23sm4244138pfr.86.2019.08.15.14.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 14:52:29 -0700 (PDT)
Date:   Thu, 15 Aug 2019 14:52:25 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] bugreport: add tool to generate debugging info
Message-ID: <20190815215225.GB208753@google.com>
References: <20190815023418.33407-1-emilyshaffer@google.com>
 <xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhka2tbv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 11:10:12AM -0700, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
> > new file mode 100644
> > index 0000000000..c5f45bbee8
> > --- /dev/null
> > +++ b/Documentation/git-bugreport.txt
> > @@ -0,0 +1,48 @@
> > +git-bugreport(1)
> > +================
> > +
> > +NAME
> > +----
> > +git-bugreport - Collect information for user to file a bug report
> > +
> > +SYNOPSIS
> > +--------
> > +[verse]
> > +'git bugreport' [-o | --output <path>]
> > +
> > +DESCRIPTION
> > +-----------
> > +Captures information about the user's machine, Git client, and repository state,
> > +as well as a form requesting information about the behavior the user observed,
> > +into a single text file which the user can then share, for example to the Git
> > +mailing list, in order to report an observed bug.
> > +
> > +The following information is requested from the user:
> > +
> > + - Reproduction steps
> > + - Expected behavior
> > + - Actual behavior
> 
> + - How the above two are different
> 
> It is often helpful to have users explain how the expected and
> actual are different in their own words.

Good point; added.

> 
> > +NOTE
> > +----
> > +Bug reports can be sent to git@vger.kernel.org.
> 
> I am not sure if this belongs here.

Sure, I wasn't certain either. Would you rather I remove the "what to do
with this bugreport" NOTE section entirely? I worry that folks will
think this generated text file is being magically reported behind the
scenes, or that they won't know what to do with the file now that it's
created.

I suppose I did mention in the DESCRIPTION section that the user can
share the generated text file to report a bug. Maybe I should remove
"for example to the Git ML" from there as well.

> 
> > diff --git a/git-bugreport.sh b/git-bugreport.sh
> > new file mode 100755
> > index 0000000000..2200703a51
> > --- /dev/null
> > +++ b/git-bugreport.sh
> > @@ -0,0 +1,86 @@
> > +#!/bin/sh
> > +
> > +print_filenames_and_content() {
> > +while read -r line; do
> > +	echo "$line";
> > +	echo "========";
> > +	cat "$line";
> > +	echo;
> > +done
> > +}
> 
> Style.
> 
>  - have SP on both sides of ()
>  - one more HT indent for the function body
>  - "do" on its own line
>  - no unnecessary semicolons when LF would do
> 
> You probably are better off asking xargs to do this instead of
> relying on "read -r".
> 
> 	find ... | xargs -n 1 sh -c 'echo "$1" && cat "$1"' -
> 
> or something like that, perhaps.

Hm. In responding to Stolee's comments, I ended up replacing "cat $line"
with another function, and it seems xargs isn't happy directing to
functions which haven't been exported, because it spins a new process
for each argument it's passed. I had originally intended to do this with
xargs but then didn't want to pack many lines into one xargs call.

The way the code is in PS1 I think it's a reasonable replacement, but
the code in PS2 is less so - there's a check for whether a file given is
binary or whether it exists at all (the former for hooks, which I think
you were worried about, and the latter for the alternates file, which I
found I do not have.)

Why is "read -r" unreliable? Is it better to export a function and use
xargs, compared to using "read -r" in a loop like this? I was worried
that exporting a function is similar to namespace pollution in C++, but
maybe I'm mistaken.

> 
> > +
> > +generate_report_text() {
> > +
> > +	# Generate a form for the user to fill out with their issue.
> > +	gettextln "Thank you for filling out a Git bug report!"
> > +	gettextln "Please answer the following questions to help us understand your issue."
> > +	echo
> > +	gettextln "What did you do before the bug happened? (Steps to reproduce your issue)"
> > +	echo
> > +	gettextln "What did you expect to happen? (Expected behavior)"
> > +	echo
> > +	gettextln "What happened instead? (Actual behavior)"
> > +	echo
> > +	gettextln "Anything else you want to add:"
> > +	echo
> > +	gettextln "Please review the rest of the bug report below."
> > +	gettextln "You can delete any lines you don't wish to send."
> > +	echo
> 
> Would we on the receiving end be able to tell these section headers
> in translated to 47 different languages?  I am sure that i18n is
> used here to encourage non-C-locale users to file bugs in their own
> languages, but are we prepared to react to them?

I hope that we could accept reports in many languages with online
translation as a guide, but practically speaking,
machine-learning-powered online translation may not be as good for
technical topics as it is for conversational.

At the same time, it seems unnecessarily restrictive to ask for bugs to
come in English. My heart thinks it's better to encourage other
languages too.

> 
> > +	echo "[System Information]"
> > +	git version --build-options
> > +	uname -a
> > +	curl-config --version
> > +	ldd --version
> 
> "curl-config: command not found" may be clear enough, but would
> there be a case where errors from two or more consecutive commands
> in the above sequence would make the output confusing to the person
> sitting on the receiving end?  Would it help, as a convention, to
> always ahve "echo [what am I reporting]" before each of these
> commands?

Yeah, I think that's a good point.

In responding to Stolee's review, I mentioned adding additional context
to some command's output so that "those reviewing the report don't need
to be intimately familiar with what the bugreport script runs". But it
might actually be most useful to echo the command that's being run
everywhere.

I imagine it's fine to include the [] header as well, to make it easier
for the user to understand what was generated.

> 
> > +# Create bugreport file
> > +BUGREPORT_FILE="$basedir/git-bugreport-$(whoami)-$(hostname)-$(date -Iminutes)"
> 
> How portable is -Iminutes?

Ah, it seems while it works in MingW and bash, it doesn't work in zsh.
I'll figure something else out. Thanks.

> 
> > diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> > new file mode 100755
> > index 0000000000..6eb2ee4f66
> > --- /dev/null
> > +++ b/t/t0091-bugreport.sh
> > @@ -0,0 +1,41 @@
> > +#!/bin/bash
> 
> Make sure /bin/sh suffices to run the test script.

Will do. Thanks.

> 
> > +test_description='git bugreport'
> > +
> > +. ./test-lib.sh
> > +
> > +# Headers "[System Info]" will be followed by a non-empty line if we put some
> > +# information there; we can make sure all our headers were followed by some
> > +# information to check if the command was successful.
> > +HEADER_PATTERN="^\[.*\]$"
> > +check_all_headers_populated() {
> > +	while read -r line; do
> > +		if [$(grep $HEADER_PATTERN $line)]; then
> 
> Documentation/CodingGuidelines
> 
> I am not sure if the traits this test script checks about the
> contents of the output is all that interesting.  Whenever we add new
> sections to the main command because we want other kinds of
> information collected, we'd update this test script because
> otherwise the test would fail, but would it result in quality
> bugreport tool, or is it just additional busywork?

I'm a little confused about this - I checked for a general [...] header
standing alone on a line specifically so that we wouldn't need to update
the test script when adding a new section. What do you see that will
grow stale?

> 
> If we decide later that a header and its body needs to be separated
> with a blank line for better readablity, the check done here would
> also need to be updated, but again, that does not feel like anything
> more than just busywork to me.

Sure, I agree with that.

So, what's your suggestion? Not to check the output at all? (This may
actually be fine; it occurred to me while reading your review that if a
user is filing a bug report about something, one of the diagnostic
commands in bugreport might be what's broken for them. So perhaps it
should be tolerant to missing information...)

> 
> The tests for "-o" and unknown options do make sense, though.
> 
> Thanks.
Thanks for reviewing.

 - Emily
