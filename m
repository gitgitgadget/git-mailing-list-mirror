From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fsck: return non-zero status on missing ref tips
Date: Mon, 15 Sep 2014 16:57:33 +0200
Message-ID: <5416FE5D.5050102@alum.mit.edu>
References: <1409177412.15185.3.camel@leckie> <20140829185325.GC29456@peff.net> <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com> <1409343480.19256.2.camel@leckie> <20140829203145.GA510@peff.net> <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com> <20140909220709.GA14029@peff.net> <20140912033830.GA5507@peff.net> <20140912042939.GA5968@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 17:04:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTXpa-0007Wc-3i
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 17:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865AbaIOPEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 11:04:38 -0400
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:64067 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751847AbaIOPEh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2014 11:04:37 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Sep 2014 11:04:37 EDT
X-AuditID: 1207440f-f79156d000006a5c-0a-5416fe5ffebf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 39.19.27228.F5EF6145; Mon, 15 Sep 2014 10:57:35 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2598.dip0.t-ipconnect.de [93.219.37.152])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s8FEvXHf019167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 15 Sep 2014 10:57:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.0
In-Reply-To: <20140912042939.GA5968@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqBv/TyzEYPlGaYv5m04wWnRd6Way
	aOi9wmzxo6WH2YHF41nvHkaPi5eUPRY8v8/u8XmTXABLFLdNUmJJWXBmep6+XQJ3xvdD15kK
	5kpVtPdHNDCeF+li5OSQEDCRmPllFyOELSZx4d56ti5GLg4hgcuMEu3HjzNBOOeZJP5daWUF
	qeIV0JZovHeeDcRmEVCVmHRoK1g3m4CuxKKeZiYQW1QgQOJD5wNGiHpBiZMzn7CA2CICjhIX
	thwBs5kFYiTWTV3GDGILC7hKXFzzkRli2TUmifkHt4ElOIGGPny3gA2iQV3iz7xLzBC2vETz
	1tnMExgFZiHZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zro5WaW6KWmlG5i
	hAQ0/w7GrvUyhxgFOBiVeHhPTBALEWJNLCuuzD3EKMnBpCTKa/gHKMSXlJ9SmZFYnBFfVJqT
	WnyIUYKDWUmEl/cXUI43JbGyKrUoHyYlzcGiJM6rvkTdT0ggPbEkNTs1tSC1CCYrw8GhJMEb
	8BeoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4Uq/HFwGgFSfEA7QVr5y0uSMwF
	ikK0nmLU5VjX+a2fSYglLz8vVUqc9xvI4QIgRRmleXArYOnrFaM40MfCvDogo3iAqQ9u0iug
	JUxAS872gC0pSURISTUwSq3tnuC+IKGv/s0ama3zRI6qy24OfqV/KTdrwud3ZdpZy1OOf/9c
	OdV+57XJ1kx3N35Xe/N7leUzIYXJWgHxz1fvFlQS4lrpdZgn9me4YqBC3W67lD9O 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257052>

On 09/12/2014 06:29 AM, Jeff King wrote:
> [+cc mhagger for packed-refs wisdom]
> 
> On Thu, Sep 11, 2014 at 11:38:30PM -0400, Jeff King wrote:
> 
>> Fsck tries hard to detect missing objects, and will complain
>> (and exit non-zero) about any inter-object links that are
>> missing. However, it will not exit non-zero for any missing
>> ref tips, meaning that a severely broken repository may
>> still pass "git fsck && echo ok".
>>
>> The problem is that we use for_each_ref to iterate over the
>> ref tips, which hides broken tips. It does at least print an
>> error from the refs.c code, but fsck does not ever see the
>> ref and cannot note the problem in its exit code. We can solve
>> this by using for_each_rawref and noting the error ourselves.
> 
> There's a possibly related problem with packed-refs that I noticed while
> looking at this.
> 
> When we call pack-refs, it will refuse to pack any broken loose refs,
> and leave them loose. Which is sane. But when we delete a ref, we need
> to rewrite the packed-refs file, and we omit any broken packed refs. We
> wouldn't have written a broken entry, but we may get broken later (i.e.,
> the tip object may go missing after the packed-refs file is written).
> 
> If we only have a packed copy of "refs/heads/master" and it is broken,
> then deleting any _other_ unrelated ref will cause refs/heads/master to
> be dropped from the packed-refs file entirely. We get an error message,
> but that's easy to miss, and the pointer to master's sha1 is lost
> forever.

I was confused for a while by your observation, because the curate
function has

	if (read_ref_full(entry->name, sha1, 0, &flags))
		/* We should at least have found the packed ref. */
		die("Internal error");

, which looks like more than "emit an error message and continue". But
in fact the flow never gets this far, because iterating without
DO_FOR_EACH_INCLUDE_BROKEN doesn't just skip references for which
REF_ISBROKEN is set, but also (do to a test in do_one_ref()) references
for which ref_resolves_to_object() fails. The ultimate source of my
confusion is that the word BROKEN has two different meanings in the two
constants' names.

> [...]
> I am tempted to say that we do not need to do curate_each_ref_fn at all.
> Any entry with a broken sha1 is either:
> 
>   1. A truly broken ref, in which case we should make sure to keep it
>      (i.e., it is not cruft at all).
> 
>   2. A crufty entry that has been replaced by a loose reference that has
>      not yet been packed. Such a crufty entry may point to broken
>      objects, and that is OK.
> 
> In case 2, we _could_ delete the cruft. But I do not think we need to.
> The loose ref will take precedence to anybody who actually does a ref
> lookup, so the cruft is not hurting anybody.
> 
> Dropping curate_packed_ref_fn (as below) fixes the test above. And
> miraculously does not even seem to conflict with ref patches in pu. :)
> 
> Am I missing any case that it is actually helping?

Something inside me screams out in horror that we would pass up an
opportunity to delete unneeded cruft from the packed-refs file. But I
can't think of a rational reason to disagree with you, so as far as I'm
concerned your suggestion seems OK.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
