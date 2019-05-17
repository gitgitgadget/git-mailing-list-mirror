Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,T_HK_NAME_DR shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA92E1F461
	for <e@80x24.org>; Fri, 17 May 2019 21:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfEQVns (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 17:43:48 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:37218 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfEQVns (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 May 2019 17:43:48 -0400
Received: from 200116b8469d3e00606c6dee5c00731d.dip.versatel-1u1.de ([2001:16b8:469d:3e00:606c:6dee:5c00:731d]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hRkdl-00083R-U4; Fri, 17 May 2019 23:43:46 +0200
Subject: Re: [PATCH] make slash-rules more readable
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
To:     git@vger.kernel.org
References: <20190507104507.18735-1-admin@in-ici.net>
 <xmqqzhnxh5nm.fsf@gitster-ct.c.googlers.com>
 <094f3746-67c9-0284-0593-eb6b24d5c4a3@in-ici.net>
Message-ID: <469c37d9-4491-9072-211f-d9d8614413e0@in-ici.net>
Date:   Fri, 17 May 2019 23:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <094f3746-67c9-0284-0593-eb6b24d5c4a3@in-ici.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1558129427;fcef7096;
X-HE-SMSGID: 1hRkdl-00083R-U4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Another thing that I noticed is that its not mentioned anywhere that the 
> pattern use a slash as a directory separator (instead of a backslash), 
> its only clear from the examples. Maybe its worth to mention it in the 
> "PATTERN FORMAT" section. Also its maybe worth to introduce the term 
> "leading slash" and "trailing slash" because they will be of importance 
> of the following paragraphs. Something like this after the paragraph of 
> "!":
> 
>      [...] for example, "\!important!.txt".
> 
>      A slash `/` is used as a directory separator.
>      A leading slash (that is if the pattern begins with a slash)
>      or a trailing slash (that is if the pattern ends with a slash)
>      have special meaning and are explained below.
> 
>      If the pattern contains a trailing slash, it would only find
>      a match with a directory. [...]
> 


I changed my mind about this last addition. I think it is not very 
readable and there is no need to explain leading/trailing slash. Maybe 
one could just note it like this:

       [...] for example, "\!important!.txt".

       A slash `/` is used as a directory separator.
       A leading and trailing slash have special meaning
       and are explained in the following.

       If the pattern ends with a slash, it would only find
       a match with a directory. [...]

then I would also add:

      If the pattern does not end with a slash, it would find a match
      with a file or directory.


Two notes about two sentences that I proposed a while ago:

 > + - If the pattern contains no slash "`/`" (except an optional 
trailing slash),
 > +   the ...

I think that this sentence is not very readable. The exceptional case in 
the brackets makes it over complicated.

 > + - A pattern that contains a non-trailing slash is matched

And I don't like this phrase either. I think its too easy to confuse it 
with "A pattern that contains no trailing slash".

So I would suggest to replace both with the following:

     If the pattern contains no slash or only a trailing slash, [...].
     Otherwise (when it contains a non-trailing slash) the pattern
     is matched [...].

All the best,
Adam
