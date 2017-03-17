Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF2AB2095B
	for <e@80x24.org>; Fri, 17 Mar 2017 10:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751052AbdCQK4x (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 06:56:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54912 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751031AbdCQK4w (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 06:56:52 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F73620707;
        Fri, 17 Mar 2017 06:56:51 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 06:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=fyOyA2jgaI7kY2VX/2
        0C3gqkA6k=; b=DLA9ewP3ndthIH+H5hizmCJ/Gks/93v0MYhUN3cpXfHWYf2sdK
        XUcz+AW7e+irirN76C66qQZE3qUFq4TYq2mzY9CDcOeaPN1Hoq/QBBsPlWaavy4A
        QAm/oGzkRQ46hJ3ur6/4u/fYMgrK9D7fb0zFlsIo4B3NP8jiM5znt5dUHLIY9wCo
        oQ19nFKe0OEwL/NERbUI++nsWlz3/8wK7IyBRJOugW7tlVDGbpw2fgs5FhyGD4rb
        IlDWEsGuvnNZ8hEjmftO51b1CmRtk19he0H7Vd3N1/VDLSmRJOz3647HOucty5qn
        ltZlFazjIsCLpM5VQEMsbD1vtt15n+AKKTpw==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=fyOyA2jgaI7kY2VX/20C3gqkA6k=; b=ANwOeWC018O6GapWif5KW7P9
        JRMTMNHR+cYCFqmOuyAYKn1eNPvovIm44y96MpKsCLxqFkHtpD4oLVVFXq9dDCvA
        p815naZ2vhicjc86OSlpFxwzwzGieCzR4AqJKNEc2E5zmn39gIZYiXLXUDLyHNK9
        5serTS45XPbahBdGzlEFkokU2HtM1witlE0Mi16oVjhNjTfVM3ATKeYP9XAkEjHn
        euQ0c48MwabSOeSk5IXT4SPe9KGjNR+P8bxLvfM55BISkxFbuf0of00C5ExWyE6g
        gCCae7Frj34DpplOu75gWG5zUg4Gbv/8Yq0x1hq2eE7qFY6kV0BT6LjtjCt7NQ==
X-ME-Sender: <xms:88DLWOuSJaMQKbfoHbhj7d_xWoJoJ9kxhbcdx605DSwSrUgbAWGc_w>
X-Sasl-enc: a8Q+KOGW7XdbtfIJfSBVcu2U1qVzqECwEq1rXHDqlW6j 1489748210
Received: from UltraSam.fritz.box (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B9CF240A5;
        Fri, 17 Mar 2017 06:56:50 -0400 (EDT)
Subject: Re: [PATCH 2/3] git-prompt: add a describe style for any tags
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1489581340.git.git@drmicha.warpmail.net>
 <8d8fcdb4134090328662bf6fa5dfdba6c73fb6a5.1489581340.git.git@drmicha.warpmail.net>
 <xmqqvarae3zy.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <8b74cbad-dca5-4dc8-4656-1568fb2f1868@drmicha.warpmail.net>
Date:   Fri, 17 Mar 2017 11:56:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqvarae3zy.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano venit, vidit, dixit 15.03.2017 20:25:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> git-prompt has various describe styles, among them "describe" (by
>> annotated tags) and "default" (by exact match with any tag).
>>
>> Add a mode "tag" that describes by any tag, annotated or not.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>>  contrib/completion/git-prompt.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index 97eacd7832..c6cbef38c2 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -82,6 +82,7 @@
>>  #     contains      relative to newer annotated tag (v1.6.3.2~35)
>>  #     branch        relative to newer tag or branch (master~4)
>>  #     describe      relative to older annotated tag (v1.6.3.1-13-gdd42c2f)
>> +#     tag           relative to any older tag (v1.6.3.1-13-gdd42c2f)
> 
> I guess this feature makes sense.  
> 
> I just wish we had a well-known unannotated tag we can use for such
> an example; using v1.6.3.1 that is annotated does not help to make
> the distinctin between describe and tag stand out.  We want to
> convey "both annotated one and unannotated one can be used".
> 
> I am wondering if it makes sense to do something like this instead:
> 
> #	tag 	similar to 'describe' but also allow unannotated tags

or inventing a local lightweight tag such as "lastgood-5-gbadbad").
Either way would be fine with me. (I guess it's in next as is now.)

>>  #     default       exactly matching tag
>>  #
>>  # If you would like a colored hint about the current dirty state, set
>> @@ -443,6 +444,8 @@ __git_ps1 ()
>>  					git describe --contains HEAD ;;
>>  				(branch)
>>  					git describe --contains --all HEAD ;;
>> +				(tag)
>> +					git describe --tags HEAD ;;
>>  				(describe)
>>  					git describe HEAD ;;
>>  				(* | default)
