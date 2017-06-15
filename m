Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB34E20401
	for <e@80x24.org>; Thu, 15 Jun 2017 15:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750835AbdFOPsf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 11:48:35 -0400
Received: from mout.web.de ([212.227.17.11]:58006 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdFOPse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 11:48:34 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBTQo-1dUqPb2fEk-00AYGx; Thu, 15
 Jun 2017 17:48:21 +0200
Subject: Re: [PATCH] checkout: don't write merge results into the object
 database
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <b46827a5-2a8f-c343-ac1f-814fc8a16943@web.de>
 <20170615135751.qxn6bsfsxz5es236@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f7d38553-484b-ee81-e059-2c737dad2bc4@web.de>
Date:   Thu, 15 Jun 2017 17:48:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20170615135751.qxn6bsfsxz5es236@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:W/wmTvNofOGilYAljFU3j3X5ONGw3hpxeD59JdQd0xInpCUE7hj
 WBjUv+kwh5fIostTO225FWl5Iuqr2odYnLUQlBDJSj21OfIFLOwzvlrLAshHb/d+cJAqvmg
 l5OHdeVFkMJ3XKr8ef6NmHE/RcA9pESDsmZmXs5DvXQuQ8wbPG5p99yAdEHmy6KColDKMLy
 VF502ekk0wvZ/kh51cpwQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:96DdYKne5TI=:SEHi0rVFX+VRtWVIUs3YVz
 sxWpnGNZagh02fquRe7qM4kKypvtLwErJoDLdn94LBCqko31zMpszRJ2Mpa7KJKDPPvP+mwxs
 6cF/tJYl2thUeLW7b6eV7mmHanfjZWWpa62J1qN81X849iJ4NeSISFB9TpDT1g+n9NrrocWfF
 QK9493MvB8TTZgtcLrT9nOimlM+MePhDlsieQGSVDlIv6mTUqtNcoUqfF0KL8F7gQWuROre/K
 UgVHVnpiSQEndJZgczGr0eA4FSFii68vKaSlsdetR6QmH1z/EMEM2PoHKCxDUvQ6hsRVXkDMW
 LdB1dczJByJ5q7EPIm4mcC8oc/IBMeMOhaibQQ04LnPnILPQezAS2tj5bdNBwzMuHiHlwTQ7B
 IRFpjfntcnN3tmseclJTblc4STMeuYwiBnugxlvpW6E8JLaDFvLEDNcAlHmkNQOAK1bd0iij7
 6BjMNjqXj1trizy35B4BlOyeNUjzcrb7yLVW7kfP9dgTEODrwpvXE/wH5Z9wph1e35ASX8YB0
 BOr3WHfOFPgGvPWAskpJsuiI91k1DU2mGEyN2ZhllEU/aHKjnw0P+SXcvQYHgZPulMnRLaPr+
 7dfW01kFhxUGgECuh3PSXWJXsxy+IhBd1+mG6aJxRwQujnRYzah44NLWVbPsO+E0MxPdErrit
 GRq8V8/JVlbxBMjarl0YlrSQkhTyfigCCIQqj1nHI5g1FJF/cjETiHmse4qTtg2ted5NlxOEI
 mMeZ96psp2nzaqxUk5NUpIBHN0vN9qbZOtQHeGVNlZq/znroJQCmGQO31qjjbXY/auHeK7aBu
 nGO3p3E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.06.2017 um 15:57 schrieb Jeff King:
> On Thu, Jun 15, 2017 at 01:33:42PM +0200, René Scharfe wrote:
> 
>> Merge results need to be written to the worktree, of course, but we
>> don't necessarily need object entries for them, especially if they
>> contain conflict markers.  Use pretend_sha1_file() to create fake
>> blobs to pass to make_cache_entry() and checkout_entry() instead.
> 
> Conceptually this makes sense, although I have a comment below.
> 
> Out of curiosity, did this come up when looking into the cherry-pick
> segfault/error from a few hours ago?

No, it came up in the discussion of Dscho's memory leak plug series [1].

>> @@ -225,8 +225,8 @@ static int checkout_merged(int pos, const struct checkout *state)
>>   	 * (it also writes the merge result to the object database even
>>   	 * when it may contain conflicts).
>>   	 */
>> -	if (write_sha1_file(result_buf.ptr, result_buf.size,
>> -			    blob_type, oid.hash))
>> +	if (pretend_sha1_file(result_buf.ptr, result_buf.size,
>> +			      OBJ_BLOB, oid.hash))
>>   		die(_("Unable to add merge result for '%s'"), path);
>>   	free(result_buf.ptr);
> 
> I wondered if pretend_sha1_file() makes a copy of the buffer, and indeed
> it does. So this is correct.
> 
> But that raises an interesting question: how big are these objects, and
> is it a good idea to store them in RAM? Obviously they're in RAM
> already, but I'm not sure if it's one-at-a-time. We could be bumping the
> peak RAM used if there's a large number of these entries. Touching the
> on-disk odb does feel hacky, but it also means they behave like other
> objects.
> 
> If it is a concern, I think it could be solved by "unpretending" after
> our call to checkout_entry completes. That would need a new call in
> sha1_file.c, but it should be easy to write.

Good point; we'd accumulate fake entries that we'll never need again.
The patch should clean them up.

Alternatively we could finally address the NEEDSWORK comment and
provide a way to checkout a file without faking an index entry..

René


[1] https://public-inbox.org/git/2704e145927c851c4163a68cfdfd5ada48fff21d.1493906085.git.johannes.schindelin@gmx.de/
