Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5717DC433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 18:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346792AbiDGSNQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346794AbiDGSNM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 14:13:12 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 11:11:08 PDT
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA32E190598
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 11:11:07 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7AF9B17CF4B;
        Thu,  7 Apr 2022 14:05:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=Z4AuGGzBGSnND9EwwI3ZVqbK8vuIYb6wSbayqPg
        m144=; b=Y1si4geZzXICuuE9A0QWenh3p0fn8ZH75T38SzhxqLX25lXu7byGyrH
        g9xDtHzI44HwUfUNTFcpg3eO1U1OyyakLBbgTXWj6gUE2W+Uc0XQwa1vIkIok+EN
        FpyMzHeCz1KDmTOqwEFSh6L5u63KHZpuo7Cso63PX/SyKCZRT2dc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 719A517CF4A;
        Thu,  7 Apr 2022 14:05:36 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6BCB17CF49;
        Thu,  7 Apr 2022 14:05:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Thu, 7 Apr 2022 14:05:29 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] doc: replace "--" with {litdd} in
 credential-cache/fsmonitor
Message-ID: <Yk8n6R33HrCCvSsP@pobox.com>
References: <20220406184122.4126898-1-tmz@pobox.com>
 <nycvar.QRO.7.76.6.2204071528590.347@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2204071528590.347@tvgsbejvaqbjf.bet>
X-Pobox-Relay-ID: 5141814A-B69D-11EC-AE96-CBA7845BAAA9-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin wrote:
> Hi Todd,
>> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
>> index 889522956e..e67392cc83 100644
>> --- a/Documentation/config/core.txt
>> +++ b/Documentation/config/core.txt
>> @@ -63,7 +63,7 @@ core.protectNTFS::
>>
>>  core.fsmonitor::
>>  	If set to true, enable the built-in file system monitor
>> -	daemon for this working directory (linkgit:git-fsmonitor--daemon[1]).
>> +	daemon for this working directory (linkgit:git-fsmonitor{litdd}daemon[1]).
> 
> I am not quite certain that using `{litdd}` in a `linkgit` construct works
> both in AsciiDoc and AsciiDoctor, but I trust that you have verified that
> this works.

I did not do a build with asciidoc, but when I still built
the Fedora packages with asciidoc, we had already fixed
similar issues with `{litdd}` and I don't believe that has
changed.  If it has, then we've got other broken links:

    $ git grep 'linkgit:[^]]+\{litdd\}[^]]*\[' -- Documentation/ | wc -l
    8

    $ git grep 'linkgit:[^]]+--[^]]*\[' -- Documentation/ | wc -l
    0

> Thank you for doing this,

And thank you for reviewing and testing.

-- 
Todd
