Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74E361F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 13:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933345AbeGJNtU (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 09:49:20 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:58971 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933145AbeGJNtT (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Jul 2018 09:49:19 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AFED221B88;
        Tue, 10 Jul 2018 09:49:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 10 Jul 2018 09:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:content-transfer-encoding:content-type:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Kkc1GbVw0PuwNoqsZ
        qEMajrmUHb13OTZtKUxXM6diTQ=; b=wTdfkq+GHPsP5BIRt5BR4y68jAb8irMP1
        WgInyngZ9A298xPGgHtpejdmWJK+naZNSsZxdYnvSKjxw5BL1qxS5qVv8jR/tsu9
        onQ57Inv7wUnud3Asqtf2pHVvN/RJBdU+jnMEWm4r7Hx6RK2UIHkSsJyZtSc55RV
        9mjXiEEU/xRfdnp8V7DH+3pwA7A1gAfz2Az7I5qFCZdyNUMqx3d775ghhl5FhGma
        Q8dTS4IYtVrZNnwZYaQxqYspmj7XEaWHxYjKQWdXRnKlFOfe+16iWvQ78fdxf3q8
        id0YzrQt3a4bjO86IbJorZ8f1CxqeZ0IxBvBlSDxsUGzMFrCRSYFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Kkc1Gb
        Vw0PuwNoqsZqEMajrmUHb13OTZtKUxXM6diTQ=; b=KiM53vDDkHclGYY9C2g2jA
        l24pLiBD04uFVGelB7ftZ4VtTBkgKG9DoaXpN4CKpoQnPK5U7CDBHfW6u+96QMrK
        Zdyc5ZD7+uA+pt5jsHPVy5YAfBNtlPcdgFsxN5XJBKaIa66sEstq2xCmPmq9A2cT
        yxLEP837LktoKM18iDKvQ7EM/2l748IJNJ3NquGtdWH5GS6fIG9NhgHK8n8aLGjo
        hX5+PQTUiFDXlc5Z8cYFCG4eLhgW7heZnP6NRJWqCtAaGlKnTQjwBCrhw8xXf6mc
        Wd7/4yUv42I9qaCaNgeN3qKYI65wEw7F8ngLqRLtZxWfk1HQe7ZpFf8kcjZhHNeg
        ==
X-ME-Proxy: <xmx:XrlEW-ZtbEEETnvcgiepOkloqbv7xPyEijZG3NYqqA0tQu4C8NJF-Q>
    <xmx:XrlEW6Nir3nMpTzGplvfxQogs1vyYMpEoBB_W1f3tgGTKGY1T4HiRg>
    <xmx:XrlEW3XLAJj3wY1EhX17p5z9-ouNtRT-nPBiNzaUStXEAgg2d1ObXw>
    <xmx:XrlEWwUbT_kc-gWSEaG6goUng-JvRYmKxseYlvTXihdkYFULWhtJjg>
    <xmx:XrlEW1PNBpfaLW49Ek5i47sjEvSPbQtOEiT5912rhETpa5g8iNuBhQ>
    <xmx:XrlEW-h-cSwWYcYFqZbgvVSOTYL6GfgO7ES7oUPD2I-7VD9Jc6HbZg>
X-ME-Sender: <xms:XrlEW_hjr2ppC9o5slG0UEZm9YqcbZIk6bQStV6cK9g27zOPIUy6Vw>
Received: from [0.0.0.0] (unknown [173.199.115.247])
        by mail.messagingengine.com (Postfix) with ESMTPA id 28927E4686;
        Tue, 10 Jul 2018 09:49:16 -0400 (EDT)
Subject: Re: [PATCH 2/2] t3430: update to test with custom commentChar
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180708184110.14792-1-dharding@living180.net>
 <20180708184110.14792-3-dharding@living180.net>
 <20180708210200.GA4573@genre.crustytoothpaste.net>
 <1084a573-4ed5-5a8c-a159-7773f7465704@living180.net>
 <nycvar.QRO.7.76.6.1807092109440.75@tvgsbejvaqbjf.bet>
 <aa716d3f-6a80-e3fc-0172-1027fb85c792@living180.net>
 <nycvar.QRO.7.76.6.1807101504530.75@tvgsbejvaqbjf.bet>
From:   Daniel Harding <dharding@living180.net>
Message-ID: <9628abb4-86ec-a6f1-0c9c-64458949ebdb@living180.net>
Date:   Tue, 10 Jul 2018 16:49:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1807101504530.75@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, 10 Jul 2018 at 16:08:57 +0300, Johannes Schindelin wrote:>
> On Tue, 10 Jul 2018, Daniel Harding wrote:
> 
>> On Mon, 09 Jul 2018 at 22:14:58 +0300, Johannes Schindelin wrote:
>>>
>>> On Mon, 9 Jul 2018, Daniel Harding wrote:
>>>>
>>>> On Mon, 09 Jul 2018 at 00:02:00 +0300, brian m. carlson wrote:
>>>>>
>>>>> Should this affect the "# Merge the topic branch" line (and the "# C",
>>>>> "# E", and "# H" lines in the next test) that appears below this?  It
>>>>> would seem those would qualify as comments as well.
>>>>
>>>> I intentionally did not change that behavior for two reasons:
>>>>
>>>> a) from a Git perspective, comment characters are only effectual for
>>>> comments
>>>> if they are the first character in a line
>>>>
>>>> and
>>>>
>>>> b) there are places where a '#' character from the todo list is actually
>>>> parsed and used e.g. [0] and [1].  I have not yet gotten to the point of
>>>> grokking what is going on there, so I didn't want to risk breaking
>>>> something I
>>>> didn't understand.  Perhaps Johannes could shed some light on whether the
>>>> cases you mentioned should be changed to use the configured commentChar or
>>>> not.
>>>>
>>>> [0]
>>>> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L2869
>>>> [1]
>>>> https://github.com/git/git/blob/53f9a3e157dbbc901a02ac2c73346d375e24978c/sequencer.c#L3797
>>>
>>> These are related. The first one tries to support
>>>
>>>   merge -C cafecafe second-branch third-branch # Octopus 2nd/3rd branch
>>>
>>> i.e. use '#' to separate between the commit(s) to merge and the oneline
>>> (the latter for the reader's pleasure, just like the onelines in the `pick
>>> <hash> <oneline>` lines.
>>>
>>> The second ensures that there is no valid label `#`.
>>>
>>> I have not really thought about the ramifications of changing this to
>>> comment_line_char, but I guess it *could* work if both locations were
>>> changed.
>>
>> Is there interest in such a change?  I'm happy to take a stab at it if there
>> is, otherwise I'll leave things as they are.
> 
> I think it would be a fine change, once we convinced ourselves that it
> does not break things (I am a little worried about this because I remember
> just how long I had to reflect about the ramifications with regards to the
> label: `#` is a valid ref name, after all, and that was the reason why I
> had to treat it specially, and I wonder whether allowing arbitrary comment
> chars will require us to add more such special handling that is not
> necessary if we stick to `#`).

Would it simpler/safer to perhaps put the oneline on its own commented 
line above?  I know it isn't quite consistent with the way onelines are 
displayed for normal commits, but it might be a worthwhile tradeoff for 
the sake of the code.  As an idea of what I am suggesting, your example 
above would become perhaps

     # Merge: Octopus 2nd/3rd branch
     merge -C cafecafe second-branch third-branch

or perhaps just

     # Octopus 2nd/3rd branch
     merge -C cafecafe second-branch third-branch

Thoughts?

> Not that the comment line char feature seems to be all that safe. I could
> imagine that setting it to ' ' (i.e. a single space) wreaks havoc with
> Git, and we have no safeguard to error out in this obviously broken case.

Technically, I think a single space might actually work with commit 
messages (at least, I can't off the top of my head think of a case where 
git would insert a non-comment line starting with a space if it wasn't 
already present in a commit message).  But if someone were actually 
crazy enough to do that I might suggest a diagnosis of "if it hurts, 
don't do that" rather than trying to equip git defend against that sort 
of thing.

Daniel Harding
