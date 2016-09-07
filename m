Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0854E20705
	for <e@80x24.org>; Wed,  7 Sep 2016 08:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757151AbcIGIwL (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 04:52:11 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37849 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751393AbcIGIwH (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 04:52:07 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6F591207B4;
        Wed,  7 Sep 2016 04:52:06 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 07 Sep 2016 04:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=3HAZ4XagF+K3KxVPSD9q7buXVq0=; b=MBGt6O
        jIzq2+voO00twEpdZtUe7Y8dh0pc4V7ECNW+kGZg5QpUFA3i8GR4GRw5eefwv5Da
        gfsPvIvifhUhwW6/jzjPM57RUjC6nurA32SWG4FpOxX4UFxrxDglKhnDJJLwPLTi
        NImMlXeppKKwtGqulHrRrBgXWPLDK8/2nCFR0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=3HAZ4XagF+K3KxV
        PSD9q7buXVq0=; b=V6A65YkX1ua0XCr9q6Bv4SgUx6aUf3vDOlObQ/ScCU9aDWX
        2nUqgt9SyXTaveyJkH+05unrHGSPKeGkG4dOvRC/IRUQbHwtj4VnAI4rOjVpb043
        cJ5nyXCXHp1GW98kDTXIlTf1SlvRFyAT/dg/MHkaLCdnNJrUcLtR+p2mVpOk=
X-Sasl-enc: 2U316zhDHWR0eKJQ9ErreXSIlxpbPBnLd8aT28cC3XCO 1473238326
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id DB37EF29CE;
        Wed,  7 Sep 2016 04:52:05 -0400 (EDT)
Subject: Re: How to simulate a real checkout to test a new smudge filter?
To:     john smith <wempwer@gmail.com>,
        =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
References: <CAKmQUfa_U-g6vC+SjbQSicEUwO+WofNfzezEEwikeOAeL31W5g@mail.gmail.com>
 <b71adc54-2ae6-ef8e-1dca-0883cd617e6e@web.de>
 <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <24dcd36d-dce9-879b-5bb0-0c40021be47f@drmicha.warpmail.net>
Date:   Wed, 7 Sep 2016 10:52:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAKmQUfbemaid61xPyvNheLM2jVGXGjiyF_x=NZnxkZ=5wccQ=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

john smith venit, vidit, dixit 06.09.2016 23:01:
> On 9/6/16, Torsten Bögershausen <tboegi@web.de> wrote:
>> On 06.09.16 19:47, john smith wrote:
>>> I am looking for a way to force smudge filter to run by simulating a
>>> real life checkout. Let's say I just created a new branch and did not
>>> modify any files but want to test my new smudge filter. According to
>>> some answers such as
>>> https://stackoverflow.com/questions/22909620/git-smudge-clean-filter-between-branches
>>> and
>>> https://stackoverflow.com/questions/21652242/git-re-checkout-files-after-creating-smudge-filter
>>> it should be possible by running:
>>>
>>> git checkout HEAD --
>>>
>>> but in doesn't work with git 2.9.0. Method suggested in accepted
>>> answer here
>>> https://stackoverflow.com/questions/17223527/how-do-i-force-git-to-checkout-the-master-branch-and-remove-carriage-returns-aft
>>> works but I don't like because it seems fragile. Is there a safe way
>>> to do what I want to do in Git still today?
>>>
>> It depends what you mean with "safe way".
> 
> I want to store all my dotfiles in a single repoitory.  The problem is
> that that some specific pieces of these files are different on
> different machines.  I have a special .conf file that is different on
> every branch and contains machine-specific definitions of some
> variables such as EMAIL or SMTP server.  In my smudge filter I call a
> script which parses .conf file and replace all template variable
> definitions saved in the given file with correct definitions.  For
> example in my ~/.bashrc I have this on all branches:
> 
> export EMAIL="@EMAIL@"
> 
> and in my .conf file on `home' branch
> 
> EMAIL=home@address.com
> 
> and on `work' branch:
> 
> EMAIL=work@address.com
> 
> And in .gitattributes on both branches:
> 
> bash/.bashrc     filter=make-usable
> 
> I also have single `master' branch that only contains template
> dotfiles and no .conf.  When setting up a new machine I could just
> create a new branch off master branch and add a new .conf.
> 
> In turn, clean filter replace all correct definitions in the given
> dotfiles back into template definitions.
> 
> I'd prefer smudge/clean filters instead of `make' scripts etc. to
> convert template dotfiles into something usable and back because
> filters:
> 
> 1. could be run automatically
> 
> 2. do not modify files as shown by `git show HEAD:<file>' and
> therefore no files are reported as modified by git status and also
> there are not conflicts when merging master into work/home branch.
> 
> I have problems because with point 1 because apparently smudge filter
> is not run automatically every time when branch is changed if files
> listed in .gitattributes do not change. As the last resort I could
> force smudge/clean filter to run just to keep advantage specified in
> point 2.

I'm afraid smudge/clean are not a good match for your use case:
smudge can do anything that clean removes again, i.e.: if you smudge a
blob, then clean it, it has to be the same blob.

Your smudge filter seems to give different results for the same blob
depending on other variables (your .conf), but git doesn't care as long
as clean output is the same. Also, git cannot possibly know when "it is
time" to rerun smudge.

Maybe "source"-ing .conf files would be an alternative approach for you,
or using hooks?

Cheers
Michael

