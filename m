Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_NAME_MR_MRS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F51FC433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 06:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42A6A22513
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 06:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbhARGID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 01:08:03 -0500
Received: from kane-il.us ([198.74.55.137]:43766 "EHLO kane-il.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732060AbhARGIA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 01:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kane-il.us; s=mail;
        t=1610950038; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYWr28eYvu3HzPrIj5dSXQ/hW+cYVg99lE0pbg+CLOQ=;
        b=v1zYigkJHg4E2sRj3sA0EKp5LEz8P+UiLjZLA9Iph9Mzkp/42J5I80eHvRlHnXqkCNHQ8C
        wTmHrKz+pHuG4PtZfKLSJcCmnkM3ZvmT9Hqh1C4qN7Xs9jQJ3z//YPff5J99QSAlSSw64R
        vRqvgoTZCRR9NrLmC231PucO+TaFV+o=
MIME-Version: 1.0
Date:   Mon, 18 Jan 2021 06:07:17 +0000
From:   "Mr. Sandor Kunyik" <sandor@kane-il.us>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org
Subject: Re: Using Git for OpenSCAD and 3D Printing
In-Reply-To: <a3e191a0-5c39-fe50-f57e-6b2ddeb4373d@iee.email>
References: <cee9debaf32b69d793d0b8a3e8d4b2c6@kane-il.us>
 <a3e191a0-5c39-fe50-f57e-6b2ddeb4373d@iee.email>
Message-ID: <f470a4e0483e1e5c3e1961315bec5475@kane-il.us>
X-Sender: sandor@kane-il.us
Organization: Factory 4.0 Open Initiative, LLC.
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi Philip!

Thank you so much for the details! I am going to read this many times 
over the next couple of weeks.
I have advanced on this subject, I now have a federated forum dedicated 
to this at https://hubzilla.factoryfouroh.net, and I have a Gitea 
repository installed - all under YunoHost. I am going to be publishing 
all I print (dimension, material, etc.) OpenSCAD scripts, PNG images, 
printable models (STEP) and maybe even animation - OpenSCAD has some 
basic but functional animation capacity.

I stopped subscribing to the git mailing list as I do not want to 
pollute with newbie questions, but your answer is really valuable to me  
because now I have some idea about how a pro would go about this.
Gitea it is, thanks!

On 2021-01-11 12:28, Philip Oakley wrote:
> Hi Sandor
> 
> I haven't used OpenSCAD but I thought it worth mentioning some personal
> points about using Git for Engineering products, where variants
> proliferate and build-products must be  versioned.
>  I had a go with FreeCAD a few years ago to create an insulating spacer
> that the mech eng had forgotten...
> 
> On 05/01/2021 09:57, Mr. Sandor Kunyik wrote:
>> Greetings,
>> 
>> If you were to design a new workflow, what key observations would you
>> make in regards to OpenSCAD scripts?
> 
> I'm sure that git is able to store and version all the scripts and
> products, but it does need a vision about how to present the
> organisation of the scripts and products, especially for engineered
> items. Remember that software version control is just drawing office
> procedure with the hard stuff ripped out ;-) [1]
>> 
>> As a quick illustration: I have a model with cavities to hold hex
>> bolts and nuts. I fine-tuned the model to print on PrinterA, using
>> FilamentA, SettingsA.
> 
> Is the fine tuning done via the scripts, or is it manual. If it is the
> latter then it will need the user to record in the commit message for
> the revision the various what/why/how aspects that aren't obvious from
> the 'diff'. Does OpenSCAD have an informative 'diff' capability? If it
> is just a 'compile for printerA using known-tool' then it could be an
> automated commit message as you are storing a build product (If it was
> regular software it's likely it's a binary..)
> 
>> Once in "production" I need to "freeze" all relevant scripts,
>> especially when using multi-file structure. If the modules receive
>> parameters I need to "remember" those parameters (such as the radius
>> for the hex, and the dept of the cavity), and if they use hard-coded
>> values I must remember not to change them. Otherwise I cannot
>> repeatedly print the same model.
> 
> So these parameters are essentially a 'configuration file' (inc. the
> hard coded values). If you auto generate such a file then it can easily
> be stored within revision (commit) - It is important that the scripts
> should be able to work directly from that config file (idempotent [2])
> 
>> 
>> Now imagine this for the entire standard set of hex bolts - each of
>> these were fine-tuned, test-printed and verified.
> A library? Hence a sub-module perhaps. 
>> The rationale behind this to guarantee that the models trying to
>> conform to a standard (such as ASME B18.3) stay put, while models
>> receiving non-standardized sizes such as Nylon 6/6/ (which have bigger
>> hex heads) stay separated, and tweaked to work with each supplier.
> A configurable library item? Tricky. I remember a project that need to
> change 20,000 drawing because they changed the paint colour (green to
> grey), and then the next major order was in the old colour! In software
> terms its like 're-skinning' a GUI, but worse.
> More likely you'll have a separate sub-module-library for these
> 'specials' where the source part is cherry-picked (give give a backward
> textual reference) and then modified locally giving git level
> traceability. 
>> 
>> My question is, should I just "hardcode" everything, set up forks or
>> branches for all past scenarios? So far I only have a few dozen models
>> and I'm already having a hard time finding models I printed and used
>> in the past, to print again. How do I structure all this?
> 
> The hard part is to be both the 'design authority' that signs off the
> 'release' and also the day to day designer trying things where it's a
> 'fingers crossed' hope that this 3d print run will actually produce 
> what
> you want and expect, but mainly it's a case of realising the mistake 
> and
> cycle it around.
> You should at least use tags for the good release commits, to make them
> easy to find.
>> 
>> I am a mechanical engineer not a coder, new to all these.
> I feel you pain. Some of the above may be more suited for those who
> actually design and contribute OpenSCAD, rather that a user getting
> started.
>> Maybe git or revision control is not the correct tool for this job?
>> 
> As an ME you will know that without [good] revision control the world
> falls apart for anything other than bespoke item home jobs!
> 
> Git is great because it give you full control, and local storage,
> without taking up too much room.
> Git is a problem because it gives you too much control and too much
> choice. Start simple, be open to the 'mind-shift'.
> 
> Add any (i.e. more) files that you use to Git. Remove them (one at a
> time) when you stop using them. They will still be in the history!
> 
> Commit often: including halfway through a change - you know you will 
> add
> more and then more, then more tweaks before you print - have a commit
> for each. I.e. distinguish between 'Printing' runs, and the act of
> 'visualising the part' in the OpenSCAD viewer - both steps get a 
> commit,
> with concise description. (probably every 5 minutes or less!)
> 
> Use the 'git gui' and 'gitk' to visualise how you have developed and
> progressed. (or a GUI of your choice -> CAD people are NOT terminal
> people!!)
> 
> Git unfortunately lacks a short command to allow you to park a 
> completed
> items onto a 'Completed' branch that's just an easy quick way of seeing
> those finished items (Git has the view that they [old software 
> versions]
> are 'gone/left behind', with just a few v# tags), so I don't have any
> great solution for that.
> If you have concise commit subject titles and messages, then it's 
> easier
> to search history for "print: insulating spacer widget v2.1" (and 
> before
> that "visualise: insulating spacer widget v2.1a", 1b, 1c, 1d, 1e...).
> You may want to allow-empty commits for ease of recording!
> 
> Hope that helps.
> 
> [1] Drawing Office procedures allow for non perfect machining, serial
> numbering, etc. Software generally asserts perfect replication,
> repeatability and machining.
> [2] https://en.wikipedia.org/wiki/Idempotence
> [3] concise: adjective - giving a lot of information clearly and in a
> few words; brief but comprehensive. "a concise account of the country's
> history" (Git: without repeating the obvious changes shown in the 
> diff!)

-- 
Regards,
Mr. Sandor Kunyik
FourOh-LLC Technology Evangelist
