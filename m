Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7DF120958
	for <e@80x24.org>; Wed, 22 Mar 2017 08:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758933AbdCVIoV (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 04:44:21 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:55521 "EHLO
        alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758232AbdCVIoD (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Mar 2017 04:44:03 -0400
X-AuditID: 1207440f-129ff70000003517-50-58d23916ec0f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 50.BC.13591.61932D85; Wed, 22 Mar 2017 04:43:02 -0400 (EDT)
Received: from [192.168.69.190] (p579067DF.dip0.t-ipconnect.de [87.144.103.223])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v2M8gxQ2006514
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 22 Mar 2017 04:43:00 -0400
Subject: Re: [PATCH 18/20] commit_packed_refs(): use reference iteration
To:     Jeff King <peff@peff.net>
References: <cover.1490026594.git.mhagger@alum.mit.edu>
 <b8d279659c6755c5d042a3062b526e4752114c38.1490026594.git.mhagger@alum.mit.edu>
 <20170320180532.vxzra6tpf3t7qjks@sigill.intra.peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, David Turner <novalis@novalis.org>,
        git@vger.kernel.org
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <b49b4ae0-bcef-ce1d-62d5-f76a11e84766@alum.mit.edu>
Date:   Wed, 22 Mar 2017 09:42:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <20170320180532.vxzra6tpf3t7qjks@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsUixO6iqCtmeSnCYP4VS4uuK91MFg29V5gt
        ljx8zWzRPeUto8WPlh5mB1aPnbPusnt0tR9h83jWu4fR4+IlZY/Pm+QCWKO4bFJSczLLUov0
        7RK4Mp5Mv8FU8Eyxovn1P6YGxiPSXYycHBICJhJNa76ydjFycQgJ7GCSWDarnwXCucAk0T5n
        LyNIlbCAh8TO3U3MILaIgKzE98MbGSGKDjFKbDv2lxnEYRbYzijx8uYCdpAqNgFdiUU9zUwg
        Nq+AvcTpIy/YQGwWAVWJ/tNdLCC2qECIxJyFDxghagQlTs58AhbnFHCRWPruBJjNLKAu8Wfe
        JWYIW15i+9s5zBMY+WchaZmFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIz
        S/RSU0o3MULCmX8HY9d6mUOMAhyMSjy8CvIXI4RYE8uKK3MPMUpyMCmJ8rorX4oQ4kvKT6nM
        SCzOiC8qzUktBvqdg1lJhPe9PlCONyWxsiq1KB8mJc3BoiTOq75E3U9IID2xJDU7NbUgtQgm
        K8PBoSTBm2oO1ChYlJqeWpGWmVOCkGbi4AQZzgM0PAikhre4IDG3ODMdIn+KUVFKnDcXJCEA
        ksgozYPrhaWbV4ziQK8I8ypYAFXxAFMVXPcroMFMQIPL9lwAGVySiJCSamCc92tRXbzb48BH
        RfFykxcxLQ5q1tO/0Rnd0h3x9My0ginKDx0/zTh66FRE0cl12uWfG6Uqd903nnixe4FI1oul
        edtCTMNC1JcyR16/fkb4m538j7KH2wPfxbI76KUa7pw8w0FtQ7H/TI1pe5z/SusfO57jdPi2
        aNkBT7MXU803GXYuTOswnG2qxFKckWioxVxUnAgAOFZCXBIDAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/20/2017 07:05 PM, Jeff King wrote:
> On Mon, Mar 20, 2017 at 05:33:23PM +0100, Michael Haggerty wrote:
> 
>> -/*
>> - * An each_ref_entry_fn that writes the entry to a packed-refs file.
>> - */
>> -static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
>> -{
>> -	enum peel_status peel_status = peel_entry(entry, 0);
>> -
>> -	if (peel_status != PEEL_PEELED && peel_status != PEEL_NON_TAG)
>> -		error("internal error: %s is not a valid packed reference!",
>> -		      entry->name);
>> -	write_packed_entry(cb_data, entry->name, entry->u.value.oid.hash,
>> -			   peel_status == PEEL_PEELED ?
>> -			   entry->u.value.peeled.hash : NULL);
>> -	return 0;
>> -}
> 
> This assertion goes away. It can't be moved into write_packed_entry()
> because the peel status is only known in the caller.
> 
> But here:
> 
>> @@ -1376,8 +1362,18 @@ static int commit_packed_refs(struct files_ref_store *refs)
>>  		die_errno("unable to fdopen packed-refs descriptor");
>>  
>>  	fprintf_or_die(out, "%s", PACKED_REFS_HEADER);
>> -	do_for_each_entry_in_dir(get_packed_ref_dir(packed_ref_cache),
>> -				 write_packed_entry_fn, out);
>> +
>> +	iter = cache_ref_iterator_begin(packed_ref_cache->cache, NULL, 0);
>> +	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
>> +		struct object_id peeled;
>> +		int peel_error = ref_iterator_peel(iter, &peeled);
>> +
>> +		write_packed_entry(out, iter->refname, iter->oid->hash,
>> +				   peel_error ? NULL : peeled.hash);
>> +	}
> 
> Should we be checking that peel_error is only PEELED or NON_TAG?

This is a good question, and it took me a while to figure out the whole
answer. At first I deleted this check without much thought because it
was just an internal consistency check that should never trigger. But
actually the story is more complicated than that.

Tl;dr: the old code is slightly wrong and I think the new code is correct.

First the superficial answer: we can't `peel_error` in
`commit_packed_refs()` as you suggested, because `ref_iterator_peel()`
doesn't return an `enum peel_status`. It only returns 0 on OK /  nonzero
for problems. A legitimate reference should never have a status
`PEEL_INVALID`. That status is meant for stale packed refs that are
hidden by more recent loose refs, which *can* legitimately point at
objects that have since been GCed. Since `ref_iterator_peel()` is
someday meant to be an exposed part of the API, I didn't want it to give
out more information than pass/fail [1]. Also, the reason for a peel
failure is not necessarily known accurately (information is lost when a
reference is packed then the packed-refs file is read).

So, when could the old error message have been emitted? It is when there
is an entry in the packed-ref cache that is not `REF_KNOWS_PEELED`, and
when the peel is attempted, the result is `PEEL_INVALID`,
`PEEL_IS_SYMREF`, or `PEEL_BROKEN`. Since a packed ref cannot be a
symref, `PEEL_IS_SYMREF` and `PEEL_BROKEN` can be ruled out. So we're
left with `PEEL_INVALID`.

How could an entry get into the packed-refs cache without
`REF_KNOWS_PEELED`? One of the following:

* It was read from a `packed-refs` file that didn't have the
`fully-peeled` attribute. In that case, we *don't want* to emit an
error, because the broken value is presumably masked by a loose version
of the same reference (which we just don't happen to be packing this
time). The old code incorrectly emits the error message in this case. It
was probably never reported as a bug because this scenario is rare.

* It was a loose reference that was just added to the packed ref cache
by `files_packed_refs()` via `pack_if_possible_fn()` in preparation for
being packed. The latter function refuses to pack a reference for which
`entry_resolves_to_object()` returns false, and otherwise calls
`peel_entry()` itself and checks the return value. So a reference added
this way should always be `REF_KNOWS_PEELED`.

Therefore, I think it is a good thing to remove this check. I'll improve
the commit message to make this story clearer.

Michael

[1] We could change this policy, for example by only documenting the
pass/fail return value externally, while distinguishing between the
types of failure when iterating internal to the module.

