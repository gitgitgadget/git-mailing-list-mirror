Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57231F597
	for <e@80x24.org>; Fri,  3 Aug 2018 14:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbeHCQJZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 12:09:25 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:32016 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbeHCQJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 12:09:25 -0400
Received: from [192.168.2.240] ([92.22.30.174])
        by smtp.talktalk.net with SMTP
        id lap0fqyIIbZX5lap0f2JpM; Fri, 03 Aug 2018 15:12:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1533305571;
        bh=latwl3g1vRTHZlLii0EtKR9K8oV7ibavHOlIzK4kq2g=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JKLfEvmWCJZlQlKVzCSydEJBr28JVDc8GTuRf5tKCP3j389hhbHHhU67mVhSfkcAZ
         6NJwwes0KQ2kMhyI8cKeUr/5SVwnocI+Uue+4IT/dX68qb9+A9lpWox2P6mdTiFy+8
         27ygVOunYJULph05HYEOItpT42UGt3XVAfoSJe0Q=
X-Originating-IP: [92.22.30.174]
X-Spam: 0
X-OAuthority: v=2.3 cv=Poq9kTE3 c=1 sm=1 tr=0 a=2xfjePbNG5I+/HyESt+5YA==:117
 a=2xfjePbNG5I+/HyESt+5YA==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=5rxgeBVgAAAA:8 a=pGLkceISAAAA:8 a=ALIegXmXl326kq6TJXgA:9 a=QEXdDO2ut3YA:10
 a=PwKx63F5tFurRwaNxrlG:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] sequencer: fix quoting in write_author_script
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20180731073331.40007-1-sunshine@sunshineco.com>
 <20180802112002.720-1-phillip.wood@talktalk.net>
 <20180802112002.720-3-phillip.wood@talktalk.net>
 <xmqqk1p83cig.fsf@gitster-ct.c.googlers.com>
 <CAPig+cQaaHfkR8jrXb-+PB4bSZbKLQzRkZNo+DNfz92hKO=04Q@mail.gmail.com>
 <c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net>
 <CAPig+cTyTHxwFvk3ZtOq3L7KEtEjKLKu6-RnLC-_NuL1Xzhqzw@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <455fafb5-3c92-4348-0c2c-0a4ab62cf2ce@talktalk.net>
Date:   Fri, 3 Aug 2018 15:12:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAPig+cTyTHxwFvk3ZtOq3L7KEtEjKLKu6-RnLC-_NuL1Xzhqzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEf1D2PpugakSo112swJT5xxEJwJJ4jP1A97Jp3qGlfEq6pMcPwcc1gJylunhNXwhy5x8N83e5jzvQxSrCZ8QQ4cSIuK+R/Y/0aaVK/4ahoe7O1//+Pe
 mx8uiIkAVLL5yntfAWCD9VhaP1CZETyQtNF+b3yOWebXlG8eso8IG9TT7PvjEiY7T8hC1KuPEQX7vW0z/DXjBkh9ltJ90PlppBRdMvWxmegIskX+aD8D0R+/
 yUAv0UoCQv8/5xqzBa3J9kEfwMkCrk/F7OHd4H5RMRDstnPStsb+DCDa3peEa1V8UsZnBj+ibT4QlqPSTnLhc034jlR9iPkM+LaVnnVLajctd8ti7dSDMAFw
 EMpm0wun
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric
On 03/08/18 11:02, Eric Sunshine wrote:
> On Fri, Aug 3, 2018 at 5:33 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
>> If there isn't some backward compatibility then if git gets upgraded
>> while rebase is stopped then the author data will be silently corrupted
>> if it contains "'". read_author_ident() will error out but that is only
>> used for the root commit. read_env_script() which is used for normal
>> picks will not dequote the badly quoted value correctly and will not
>> return an error. It is unlikely but possible, I'll leave it to Junio to
>> decide if it is worth it
> 
> If I understand correctly, the approach you implemented earlier[1]
> (perhaps coupled with the more robust detection suggested here[2])
> would be sufficient to handle this backward compatibility concern.
> While it may not be as pretty or generalized as the current patch, it
> involves far less machinery, thus is less likely to harbor its own
> bugs. The earlier version is also much more self-contained, which
> makes it easier to drop at some point when backward compatibility is
> no longer a concern (if ever).

Yes I think the earlier approach with the more robust detection you 
suggested is probably a good compromise. Junio does that sound good to you?

Best Wishes

Phillip

>> There is a precedent for adding backwards compatibility 84df4560ed
>> ("rebase: extract code for writing basic state", 2011-02-06) though it
>> is much simpler.
> 
> Indeed, it is much simpler, adding a one-liner 'else' case to an
> 'if-then' for backward compatibility. Your earlier implementation[1]
> was pretty much the equivalent, just adding an extra one-liner arm to
> an 'if-then' statement.
> 
> The bug fix itself is important, and, while I do favor the cleaner
> approach of not worrying about backward compatibility for this fairly
> unlikely case, your earlier version seems a better compromise between
> having no backward compatibility and the much more heavyweight version
> implemented here.
> 
> Anyhow, I'm fine with whatever Junio decides.
> 
> [1]: https://public-inbox.org/git/20180731111532.9358-3-phillip.wood@talktalk.net/
> [2]: https://public-inbox.org/git/CAPig+cTttbV2FjnoS_SZtwh2J4wwzsbK+48BAbt1cV0utynYzw@mail.gmail.com/
> 

