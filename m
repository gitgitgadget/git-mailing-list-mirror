Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 433E41F935
	for <e@80x24.org>; Wed, 21 Sep 2016 15:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935006AbcIUPFJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 11:05:09 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33696 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750822AbcIUPFI (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 21 Sep 2016 11:05:08 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F100E2054D;
        Wed, 21 Sep 2016 11:05:06 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 21 Sep 2016 11:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=PF89G88YhrPj3D+zgO9dcljsB3Q=; b=gCO6uc
        HOOjqAM0n+ePEX2B+1mGiTOAIwUlNs/KTgfjCbpc7uKnk47uhx0Fl3wcSgVFpHV1
        ULJDEd3vJn6Mj9+7SFMw6JYYFWE00VufcYG9nK9elDBM8+znuGEjyigbuyKsXijm
        6UXYu8EiyS5rE8xThQj7eFJIuM08tABnQheoA=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=PF89G88YhrPj3D+
        zgO9dcljsB3Q=; b=O3PecL1b4KNqNzma7j9+fLN2g+0D876qcMxd1d4zXCUe99o
        0TDyG+B3f0+uv0WpU4KRx1OOTkWNuCuWWb6PS7AE5Ajl2yqnG1scHe1M/gq+Ptnq
        sBpMMcX2ufiQ2b7337HuGh/ZywB2KBPNN/Ty3E6cwxEXvjQl/CyAPiwM4gZM=
X-Sasl-enc: 8lkHP1PsE7y9Akqg9RKn12K9nY2e73IN0X4pZGcK/MNs 1474470306
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 139CFF2C38;
        Wed, 21 Sep 2016 11:05:05 -0400 (EDT)
Subject: Re: 2.10.0: git log --oneline prints gpg signatures in 4 lines
To:     Leandro Lucarella <leandro.lucarella@sociomantic.com>,
        Jeff King <peff@peff.net>
References: <20160920170954.38b24284@labs-064.localdomain>
 <20160920231533.fxcdjgphz25hnbxt@sigill.intra.peff.net>
 <20160921155300.79252e68@labs-064.localdomain>
Cc:     Mehul Jain <mehul.jain2029@gmail.com>, git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <ebdb9974-9ab8-1e8a-f678-847a798f4c44@drmicha.warpmail.net>
Date:   Wed, 21 Sep 2016 17:05:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20160921155300.79252e68@labs-064.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Leandro Lucarella venit, vidit, dixit 21.09.2016 15:53:
> On Tue, 20 Sep 2016 19:15:33 -0400
> Jeff King <peff@peff.net> wrote:
> 
>> On Tue, Sep 20, 2016 at 05:09:54PM +0200, Leandro Lucarella wrote:
>>
>>> Hi, starting from 2.10.0 I noticed that when using git log
>>> --oneline, if commits are signed with GPG, now the signatures are
>>> printed too, and it takes 3 lines for the signature information + 1
>>> line for the title of the commit, so suddenly --oneline became
>>> --fourline :)
>>>
>>> Is this really intended?
>>
>> I don't think anything has changed here in 2.10. Running "git log
>> --oneline --show-signature" has _always_ been horribly ugly. However,
>> 2.10 did introduce the "log.showsignature" config, which makes "git
>> log --oneline" pretty unusable when it is enabled. Ditto for
>> one-liner uses of "--format".
>>
>> I think we should probably ignore the config entirely when using any
>> of the one-liner formats (and I'd include --format, too, even though
>> it can sometimes be multi-line; it already has %GG to include that
>> information as appropriate).
> 
> Woops! Definitely it shouldn't be added when --format is used, this is
> also breaking some scripts I have using git log --format to get some
> information about commits, and GPG information is being output even
> when there is anything about GPG requested in the chosen format.
> 
> I guess I will disable log.showsignatures for now... :(
> 

I guess that's one of the reasons why I didn't like that config option
to begin with. There's a flood of these config "convenience" options
lately where we have to special case for scripting... Aliases must have
become old school or something.

Note that "git log --show-notes", "git log --oneline --raw", "git log
--oneline -p" and similar are not "one line" either. So
"--show-signature" behaves just like all others.

git log --format="%h %G? %s"

or a colored version thereof may be what you want to alias as "log1" or
such.

Cheers,
Michael
