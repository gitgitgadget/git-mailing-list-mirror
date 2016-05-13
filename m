From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 29/33] refs: resolve symbolic refs first
Date: Fri, 13 May 2016 14:33:20 +0200
Message-ID: <5735C990.8080502@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
 <66d33af21bd1e398973414435af43d06f2e2099c.1462550456.git.mhagger@alum.mit.edu>
 <20160512074528.GB10922@sigill.intra.peff.net>
 <20160512082526.GA20817@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, David Turner <dturner@twopensource.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 13 14:33:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1CHe-00038h-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 14:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbcEMMda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 08:33:30 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:54087 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751139AbcEMMda (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2016 08:33:30 -0400
X-AuditID: 1207440e-ef3ff700000008c5-22-5735c9944e00
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 2B.0F.02245.499C5375; Fri, 13 May 2016 08:33:24 -0400 (EDT)
Received: from [192.168.69.130] (p508EABB6.dip0.t-ipconnect.de [80.142.171.182])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u4DCXKkX022346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 13 May 2016 08:33:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.7.0
In-Reply-To: <20160512082526.GA20817@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGKsWRmVeSWpSXmKPExsUixO6iqDvlpGm4wdpNohbzN51gtOi60s1k
	0dB7hdmie8pbRosfLT3MFjOvWlt0dnxldGD32DnrLrvHs949jB4XLyl77F+6jc1jwfP77B6f
	N8l53H62jSWAPYrbJimxpCw4Mz1P3y6BO2Pmt/KCyRIV5z6tZG5gnCbcxcjJISFgIvHh4WVm
	EFtIYCujxIU1LF2MXED2BSaJSSsfsoAkhAXsJRoP/gMrEhGQlfh+eCMjRMMroIYTySANzAKP
	mST2fVnIBJJgE9CVWNTTDGbzCmhLfN++Dcjm4GARUJVYN4cfJCwqECKxbd03VogSQYmTM5+A
	7eIUsJb42dcNFmcWUJf4M+8SM4QtL7H97RzmCYz8s5C0zEJSNgtJ2QJG5lWMcok5pbm6uYmZ
	OcWpybrFyYl5ealFusZ6uZkleqkppZsYIeHOt4Oxfb3MIUYBDkYlHt4EJdNwIdbEsuLK3EOM
	khxMSqK8E/cDhfiS8lMqMxKLM+KLSnNSiw8xSnAwK4nwrjoOlONNSaysSi3Kh0lJc7AoifOq
	LVH3ExJITyxJzU5NLUgtgsnKcHAoSfAmnQBqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1K
	LC3JiAfFY3wxMCJBUjxAezNB2nmLCxJzgaIQracYdTmO7L+3lkmIJS8/L1VKnPcTyHECIEUZ
	pXlwK2DJ7RWjONDHwryLQEbxABMj3CRgtAI9LsJbfd0IZElJIkJKqoFxnqVD/AmLXV0z63/8
	NQk8kBjSzv+1S/PsxNfv1TiOq79TfNR4TZZhapbCs3qX53MO/J7QzJEufHfxnfly 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294527>

On 05/12/2016 10:25 AM, Jeff King wrote:
> On Thu, May 12, 2016 at 03:45:28AM -0400, Jeff King wrote:
> 
>> So I'd expect us to hit that lock_ref_for_update() for each of the new
>> refs. But then we end up in verify_refname_available_dir(), which wants
>> to read all of the loose refs again. So we end up with a quadratic
>> number of calls to read_ref_full().
>>
>> I haven't found the actual bug yet. It may be something as simple as not
>> clearing REF_INCOMPLETE from the loose-ref cache when we ought to. But
>> that's a wild (optimistic) guess.
> 
> Ah, nope, nothing so simple.
> 
> It looks like we get in a chain of:
> 
>   1. we want to update a ref, so we end up in
>      verify_refname_available_dir to make sure we can do so.
> 
>   2. that has to load all of the loose refs in refs/tags, which is
>      expensive.
> 
>   3. we actually update the ref, which calls clear_loose_ref_cache().
> 
> And repeat. Each ref update does the expensive step 2, and it gets
> larger and larger each time.
> 
> I understand why we need to verify_refname_available() on the packed
> refs. But traditionally we would rely on EISDIR or EEXIST to detect
> conflicts with the loose refs, rather than loading using our own cache.
> So I guess that's the new thing that is causing a problem.

Torsten, thanks for the report. Peff, thanks for the analysis.

The problem in this case is a misguided call to
verify_refname_available_dir() in the case that read_raw_ref() fails
with ENOENT. In that case it is not possible for there to be a conflict
with another loose reference, because (1) we already hold the lock, so
the containing directory must exist, and (2) we got ENOENT, so there
can't be a loose reference in a subdirectory named after the reference
that we are trying to create.

As Peff explained, the call of verify_refname_available_dir() was
forcing the loose tags to be loaded, which is expensive in this test
because there are 100000 of them being created one at a time. (If they
were created in a single ref_transaction instead, the "available" tests
would all be done together, before any changes are committed, so the
loose ref cache would not have to be invalidated each time.)

So instead of calling verify_refname_available_dir() here, we should
just consider the reference to be missing but available to be written.

I'll rewrite this patch and submit the new version to the mailing list
as v3 (also with a fix in the commit message). The rest of the patch
series is OK as is, so I won't resend it. The entire series is also
available from my GitHub repo [1] as branch "split-under-lock".

Please note that there are still some calls of
verify_refname_available_dir() against the loose reference cache in this
function. If we wanted to give up a little bit on the quality of our
error messages, I think we could make those paths faster, too. But they
are all in failure paths, so I don't think that they are performance
critical, so I won't make that change.

Michael

[1] https://github.com/mhagger/git
