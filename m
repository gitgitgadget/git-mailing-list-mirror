From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/8] lock_ref_sha1_basic(): do not set force_write for
 missing references
Date: Thu, 12 Feb 2015 13:09:59 +0100
Message-ID: <54DC9817.7050309@alum.mit.edu>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu> <1423473164-6011-4-git-send-email-mhagger@alum.mit.edu> <CAGZ79kbrFpgF6_dLYdgT2D0JjWggu8edjV2sgXER5btpmyjDNw@mail.gmail.com> <20150211000520.GA30561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:10:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLsbB-00062N-1e
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 13:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbbBLMKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 07:10:19 -0500
Received: from alum-mailsec-scanner-4.mit.edu ([18.7.68.15]:50684 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755288AbbBLMKR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 07:10:17 -0500
X-AuditID: 1207440f-f792a6d000001284-e9-54dc981a6b76
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id D2.12.04740.A189CD45; Thu, 12 Feb 2015 07:10:02 -0500 (EST)
Received: from [192.168.69.130] (p4FC96396.dip0.t-ipconnect.de [79.201.99.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1CC9xno005332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 12 Feb 2015 07:10:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <20150211000520.GA30561@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsUixO6iqCs1406IwaHNwhZdV7qZLBp6rzBb
	vL25hNGie8pbRosfLT3MFr19n1gtNm9uZ7GYf2giqwOHx85Zd9k9Fmwq9XjWu4fR4+IlZY8/
	5/ewenzeJBfAFsVtk5RYUhacmZ6nb5fAnbFg/3KWggXCFc/X9zI1ME7l72Lk5JAQMJFYeG8v
	C4QtJnHh3nq2LkYuDiGBy4wSz48vYIJwzjNJnDtziw2kildAW+Ln/49gNouAqsTE62eZQGw2
	AV2JRT3NYLaoQJDEodOPWSDqBSVOznwCZosIOEoc+TUdbAOzwGkmiVuX7zODJIQF4iXmfTrA
	DLHtEaPE+ilfWEESnAJ6EhN2QmxmFlCX+DPvEjOELS/RvHU28wRGgVlIlsxCUjYLSdkCRuZV
	jHKJOaW5urmJmTnFqcm6xcmJeXmpRbomermZJXqpKaWbGCHxwL+DsWu9zCFGAQ5GJR7eFaZ3
	QoRYE8uKK3MPMUpyMCmJ8nK1AoX4kvJTKjMSizPii0pzUosPMUpwMCuJ8Po2AeV4UxIrq1KL
	8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8YtOBGgWLUtNTK9Iyc0oQ0kwcnCDD
	uaREilPzUlKLEktLMuJB8RpfDIxYkBQP0N6pU0D2Fhck5gJFIVpPMSpKifNygcwVAElklObB
	jYUluVeM4kBfCvPOnAZUxQNMkHDdr4AGMwENnjjjNsjgkkSElFQDoyPrnLNL09fPfnN8+6XE
	4plCCu1NpzUDJt/0zP5ddaXI4fv/KYuDkkS+C/S9emYcOXFZidokjt99G2rVZrke 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263731>

On 02/11/2015 01:05 AM, Jeff King wrote:
> On Tue, Feb 10, 2015 at 03:24:47PM -0800, Stefan Beller wrote:
> 
>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> If a reference is missing, its SHA-1 will be null_sha1, which can't
>>> possibly match a new value that ref_transaction_commit() is trying to
>>> update it to. So there is no need to set force_write in this scenario.
>>>
>>
>> This commit reverts half the lines of 5bdd8d4a3062a (2008-11, do not
>> force write of packed refs). And reading both commit messages, they
>> seem to contradict each other. (Both agree on  "If a reference is
>> missing, its SHA-1 will be null_sha1 as provided by resolve_ref", but
>> the conclusion seems to be different.)
> 
> Most of the lines of 5bdd8d4a3062a that are being reverted here are
> caching the is_null_sha1() check in the "missing" variable. And that's
> a cleanup in this patch that is not strictly necessary ("missing" would
> only be used once, so it becomes noise).
> 
> The interesting thing in the earlier commit was to use the null sha1 to
> cause a force-write, rather than lstat()ing the filesystem. And here we
> are saying the force-write is not necessary at all, no matter what
> storage scheme is used. So I don't think there is any contradiction
> between the two.
> 
> Is this patch correct that the force-write is not necessary? I think so.
> The force-write flag comes from:
> 
> commit 732232a123e1e61e38babb1c572722bb8a189ba3
> Author: Shawn Pearce <spearce@spearce.org>
> Date:   Fri May 19 03:29:05 2006 -0400
> 
>     Force writing ref if it doesn't exist.
>     
>     Normally we try to skip writing a ref if its value hasn't changed
>     but in the special case that the ref doesn't exist but the new
>     value is going to be 0{40} then force writing the ref anyway.
> 
> but I am not sure that logic still holds (if it ever did). We do not ever write
> 0{40} into a ref value.

I don't understand that old commit, either. Maybe there was an idea of
storing 0{40} in a loose ref file to mark a packed reference as deleted?
CC to Shawn Pearce in case he can shed some light on the situation.

I still think that my change is OK, because we definitely don't want to
write 0{40} to any loose reference file. The reference-reading code
can't deal with it, so this would break the repository.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
