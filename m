Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3378205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030223AbdAKOxd (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:53:33 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:33034 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdAKOxc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:53:32 -0500
Received: by mail-lf0-f68.google.com with SMTP id k62so15044752lfg.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 06:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=WzRhuA6+UWccLBd27nR528vCcoU8eBN1ORkt825aEpk=;
        b=bX7PO8r1r43r8+EgmL0v24A3ayk69jSCGDxVKZlA2Z2ErMYRBEQNI2vjAlmVMQCL9Y
         xDg0B038NfXOV+VZnVashE22yTrYKHW/QtEFTSB6HYRdd1mFODmuU8v6BWIrxjgp1AS2
         OXkd8c82TXocRzVieGTCNTIgg/Wx9oAFeCYulMEwMrXCUKPPMw9nDCgyO4/78iFS22U9
         f9CrCqeKOhUja3Wxdogz51x4XFGZzU3mpRYFdi6zqgL7qEAANm+hrNy11MQhFEp+pvuz
         EIWt1P2xdI7Jke1ekVYLdBf7SrzaaQA99xNzePrsaEOMIWduvdbf345tG4rb5z0N1xiS
         IuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=WzRhuA6+UWccLBd27nR528vCcoU8eBN1ORkt825aEpk=;
        b=ZaX7TyLPR94ue+hF3glWV16//e/Kc8dWjqFEjku4wP4eU8V+HT0AuCD74zvb5ufbna
         waly/eCYsbxGH5DuPUtmfmAnS+PFvsvUZ0jpWBjlYkhb0FPNlv1LGb/zv5z4+tIxRTeB
         z+2lKny3QDZ3Ex1nY0GD1hFYhSz50HIzsgcTnX0fo+/yI+h0qKZUgPv5o7vf5akNJ5NB
         SjuURsqS3BSfKtrcAm1hzGsTS93F+TygooPajcfInAs1QI1OodtlFAjRJTrYBxZbJKzI
         +PyHsLItJKctp5JyM3KKft84dPiNhNx2CmhyjVSj0khE6VOD0OV6N2nsuck2iB2vYWc/
         /zTQ==
X-Gm-Message-State: AIkVDXLjp2ZJ4SChOqUHNVZfcNU5RHrYBOIU0oxapmu82xG+0TSUIo/3RWpHq2bnyGowGA==
X-Received: by 10.46.21.2 with SMTP id s2mr3299229ljd.19.1484146410489;
        Wed, 11 Jan 2017 06:53:30 -0800 (PST)
Received: from [192.168.1.26] (dbo238.neoplus.adsl.tpnet.pl. [83.23.40.238])
        by smtp.googlemail.com with ESMTPSA id i9sm1379851lfg.45.2017.01.11.06.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jan 2017 06:53:29 -0800 (PST)
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process
 protocol
To:     Lars Schneider <larsxschneider@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com>
 <xmqqa8b115ll.fsf@gitster.mtv.corp.google.com>
 <ec8078ef-8ff2-d26f-ef73-5ef612737eee@gmail.com>
 <9A1064BB-DA72-44DB-A875-39E007708A69@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>, Taylor Blau <ttaylorr@github.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <17fa31a5-8689-2766-952b-704f433a5b3a@gmail.com>
Date:   Wed, 11 Jan 2017 15:53:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <9A1064BB-DA72-44DB-A875-39E007708A69@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 11.01.2017 o 11:20, Lars Schneider pisze: 
> On 10 Jan 2017, at 23:11, Jakub Narębski <jnareb@gmail.com> wrote:
>> W dniu 09.01.2017 o 00:42, Junio C Hamano pisze:
>>> larsxschneider@gmail.com writes:
>>>> From: Lars Schneider <larsxschneider@gmail.com>
>>>>
>>>> Some `clean` / `smudge` filters might require a significant amount of
>>>> time to process a single blob. During this process the Git checkout
>>>> operation is blocked and Git needs to wait until the filter is done to
>>>> continue with the checkout.
>>
>> Lars, what is expected use case for this feature; that is when do you
>> think this problem may happen?  Is it something that happened IRL?
> 
> Yes, this problem happens every day with filters that perform network
> requests (e.g. GitLFS). 

Do I understand it correctly that the expected performance improvement
thanks to this feature is possible only if there is some amount of
parallelism and concurrency in the filter?  That is, filter can be sending
one blob to Git while processing other one, or filter can be fetching blobs
in parallel.

This means that filter process works as a kind of (de)multiplexer for
fetching and/or processing blob contents, I think.

> [...] In GitLFS we even implemented Git wrapper
> commands to address the problem: https://github.com/git-lfs/git-lfs/pull/988
> The ultimate goal of this patch is to be able to get rid of the wrapper 
> commands.

I'm sorry, I don't see it how the wrapper helps here.

> 
>>>> Teach the filter process protocol (introduced in edcc858) to accept the
>>>> status "delayed" as response to a filter request. Upon this response Git
>>>> continues with the checkout operation and asks the filter to process the
>>>> blob again after all other blobs have been processed.
>>>
>>> Hmm, I would have expected that the basic flow would become
>>>
>>> 	for each paths to be processed:
>>> 		convert-to-worktree to buf
>>> 		if not delayed:
>>> 			do the caller's thing to use buf
>>> 		else:
>>> 			remember path
>>>
>>> 	for each delayed paths:
>>> 		ensure filter process finished processing for path
>>> 		fetch the thing to buf from the process
>>> 		do the caller's thing to use buf
>>
>> I would expect here to have a kind of event loop, namely
>>
>>        while there are delayed paths:
>>                get path that is ready from filter
>>                fetch the thing to buf (supporting "delayed")
>>                if path done
>>                        do the caller's thing to use buf 
>>                        (e.g. finish checkout path, eof convert, etc.)
>>
>> We can either trust filter process to tell us when it finished sending
>> delayed paths, or keep list of paths that are being delayed in Git.
> 
> I could implement "get path that is ready from filter" but wouldn't
> that complicate the filter protocol? I think we can use the protocol pretty 
> much as if with the strategy outlined here:
> http://public-inbox.org/git/F533857D-9B51-44C1-8889-AA0542AD8250@gmail.com/

You are talking about the "busy-loop" solution, isn't it?  In the
same notation, it would look like this:

          while there are delayed paths:
                  for each delayed path:
                          request path from filter [1]
                          fetch the thing (supporting "delayed") [2]
                          if path done
                                  do the caller's thing to use buf
                                  remove it from delayed paths list


Footnotes:
----------
1) We don't send the Git-side contents of blob again, isn't it?
   So we need some protocol extension / new understanding anyway.
   for example that we don't send contents if we request path again.
2) If path is not ready at all, filter protocol would send status=delayed
   with empty contents.  This means that we would immediately go to the
   next path, if there is one.

There are some cases where busy loop is preferable, but I don't think
it is the case here.


The event loop solution would require additional protocol extension,
but I don't think those complicate protocol too much:

A. Git would need to signal filter process that it has sent all paths,
and that it should be sending delayed paths when they are ready.  This
could be done for example with "command=continue".

    packet:          git> command=continue


B. Filter driver, in the event-loop phase, when (de)multiplexing fetching
or processing of data, it would need now to initialize transfer, instead
of waiting for Git to ask.  It could look like this:

    packet:          git< status=resumed [3]
    packet:          git< pathname=file/to/be/resumed [4]
    packet:          git< 0000
    packet:          git< SMUDGED_CONTENT_CONTINUED
    packet:          git< 0000
    packet:          git< 0000  # empty list, means "status=success" [5]

Footnotes:
----------
3.) It could be "status=success", "status=delayed", "command=resumed", etc.
4.) In the future we can add byte at which we resume, size of file, etc.
5.) Of course sending reminder of contents may be further delayed.

-- 
Jakub Narębski
