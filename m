From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote prune"?
Date: Fri, 20 Mar 2015 05:51:56 +0100
Message-ID: <550BA76C.80501@alum.mit.edu>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>	<20150306225917.GA1589@peff.net> <550AE1E4.7020407@alum.mit.edu> <xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>,
	=?windows-1252?Q?=C6var_Arnfj=F6r=F0_B?=
	 =?windows-1252?Q?jarmason?= <avarab@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?windows-1252?Q?Bj=F6rn_Gustavsson?= <bgustavsson@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 05:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYouq-00043C-HY
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 05:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbbCTEwG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 00:52:06 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:54756 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750756AbbCTEwD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 00:52:03 -0400
X-AuditID: 1207440c-f79376d00000680a-59-550ba76f971f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 25.76.26634.F67AB055; Fri, 20 Mar 2015 00:51:59 -0400 (EDT)
Received: from [192.168.69.130] (p4FC969B5.dip0.t-ipconnect.de [79.201.105.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t2K4pufV030985
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 20 Mar 2015 00:51:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <xmqqpp84iye2.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqJu/nDvU4N5SbYu1z+4wWcw/tpjZ
	outKN5NFQ+8VZouGD84WP1p6mC02b25ncWD32DnrLrvHgk2lHs969zB6XLyk7PF5k1wAaxS3
	TVJiSVlwZnqevl0Cd8aka8dZCv4qVFzYLNTAeEmqi5GTQ0LAROLh2w2MELaYxIV769m6GLk4
	hAQuM0r86ZjPCuFcYJKYumQ+E0gVr4CmxM9r31hBbBYBVYnDax+ygdhsAroSi3qawWpEBYIk
	Xt76ywhRLyhxcuYTFhBbREBNYmLbIRaQocwCV5gkXn3eDNYsLOAvsf3GWRaIbQcYJWYd/gnW
	wSlgLXGp9TnYJGYBPYkd13+xQtjyEs1bZzNPYBSYhWTJLCRls5CULWBkXsUol5hTmqubm5iZ
	U5yarFucnJiXl1qka6iXm1mil5pSuokREvY8Oxi/rZM5xCjAwajEw3uglDtUiDWxrLgy9xCj
	JAeTkihvai9QiC8pP6UyI7E4I76oNCe1+BCjBAezkgiv2gKgHG9KYmVValE+TEqag0VJnFd1
	ibqfkEB6YklqdmpqQWoRTFaGg0NJgjd9GVCjYFFqempFWmZOCUKaiYMTZDiXlEhxal5KalFi
	aUlGPCha44uB8QqS4gHauwSknbe4IDEXKArReopRUUqc1xQkIQCSyCjNgxsLS2avGMWBvhSG
	2M4DTIRw3a+ABjMBDf5XywUyuCQRISXVwOhwamrXPBEds5nCMz8FqpW5itlH/rZW5MjsXSnp
	szZzt9+DZ4dCu31nneotuN5me82LKV+2Y8KuU1VVFlxLZvwRmSOyP9Bqn2+uwy6F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265862>

On 03/19/2015 08:24 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>>> Now that we have ref_transaction_*, I think if git-fetch fed all of the
>>> deletes (along with the updates) into a single transaction, we would get
>>> the same optimization for free. Maybe that is even part of some of the
>>> pending ref_transaction work from Stefan or Michael (both cc'd). I
>>> haven't kept up very well with what is cooking in pu.
>>
>> I am looking into this now.
>>
>> For pruning, we can't use a ref_transaction as it is currently
>> implemented because it would fail if any of the reference deletions
>> failed. But in this case I think if any deletions fail, we would prefer
>> to emit a warning but keep going.
> 
> I am not quite sure what you mean here.  I agree with you if you
> meant "we shouldn't fail the fetch only because 'fetch --prune'
> failed to remove only one of the remote-tracking refs that are no
> longer there" but that can easily be solved by the pruning phase
> into a separate transaction.  If you meant "we would rather remove
> origin/{a,b} non-atomically when we noticed that origin/{a,b,c} are
> all gone than leaving all three intact only because we failed to
> remove origin/c for whatever reason", my knee-jerk reaction is "does
> it make practical difference to the end user between these two?"
> 
> What are the plausible cause of failing to prune unused
> remote-tracking refs?

I wasn't proposing to combine the updates with the prunes in a single
transaction. (Though now that I think about it, when "fetch --atomic" is
specified it wouldn't be so crazy. It would also have the virtue of
allowing the reference transaction code to deal with any D/F conflicts
between references being added and references being deleted.)

What I meant is the second thing you mentioned, namely that currently we
prune each reference on a "best-effort" basis and wouldn't skip *all*
prunes just because one failed.

But you raise an interesting question: what could cause a failure to
prune an unused remote-tracking ref (i.e. if all pruning is done in a
single transaction)?

* I think the most likely reason for a failure would be a lock conflict
with another process. We don't retry lock attempts [1], so this would
cause the whole transaction to fail. This could happen, for example, if
the user launches two "fetch --prune" operations at the same time, or
runs "pack-refs" while fetching [2].

* It is *not* a failure if another process deletes or updates the
reference before we get to it, because we don't provide an "old" value
of the reference for a pre-check.

* I haven't verified this, but I can imagine it could fail if another
process deletes the reference (say refs/remotes/origin/foo/bar) and adds
another reference that would D/F conflict with it (say
refs/remotes/origin/foo) while we are working, because our attempt to
create refs/remotes/origin/foo/bar.lock would fail.

* A repository problem, like for example wrong file permissions
somewhere in the loose refs directory, could prevent us from being able
to create the lockfile or delete the loose reference file.

The lock conflict scenario is the only one that really worries me.

But I don't think it is *so* hard to keep the current "best-effort"
behavior. I am working on a function delete_refs() for the reference API
that deletes a bunch of references on a "best effort" basis, reporting
per-reference errors for any deletions that fail. Longer term, we could
add something like a REFS_NON_ATOMIC flag to the
refs_transaction_update() functions, which allows the rest of the
transaction to proceed even if that particular update fails.

Michael

[1] I hope to submit a patch to make it possible to retry lock
acquisition with a specified timeout. This should help in scenarios like
this.

[2] Maybe a careful analysis or a slight change to our locking protocol
could prove that the only lock acquisition that can fail is the one on
packed-refs, which would cause all of the deletes to fail anyway. In
that case per-reference failures would cease to be a worry.

-- 
Michael Haggerty
mhagger@alum.mit.edu
