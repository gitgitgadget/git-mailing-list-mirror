From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 07/13] prune_remote(): use delete_refs()
Date: Tue, 09 Jun 2015 12:50:13 +0200
Message-ID: <5576C4E5.4080107@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu> <2ce5b2c64d002ce649c2192bacdf505c4921caa6.1433763494.git.mhagger@alum.mit.edu> <CAGZ79kYcO95M6DsPa71uckOcOKs-mkz2P+NtEKx5qYfOcDw99g@mail.gmail.com> <20150608171202.GB6863@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:50:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2H7C-0001Z7-Kv
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 12:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753621AbbFIKuc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 06:50:32 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:53745 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753303AbbFIKu3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 06:50:29 -0400
X-AuditID: 12074411-f796c6d000000bc9-2e-5576c4e77be4
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 5E.DF.03017.7E4C6755; Tue,  9 Jun 2015 06:50:15 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97525.dip0.t-ipconnect.de [79.201.117.37])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t59AoD7e016913
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 9 Jun 2015 06:50:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <20150608171202.GB6863@peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqPv8SFmowalVohZdV7qZLBp6rzBb
	/GjpYbbYvLmdxYHFY8GmUo9nvXsYPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvj68GygoV8
	FatP1jcwruPuYuTgkBAwkdjzNb+LkRPIFJO4cG89WxcjF4eQwGVGiVs/vjFCOOeYJCafuMkK
	UsUroC3xb0M/I4jNIqAq8fnVTxYQm01AV2JRTzMTyFBRgSCJ1y9zIcoFJU7OfAJWIiLgKHHk
	13Q2EJtZIEbi0ZFusJHCAjYSRx+8ZYfY9YZR4uWrZ+wgCU6gmXO+r2CGaFCX+DPvEpQtL9G8
	dTbzBEaBWUh2zEJSNgtJ2QJG5lWMcok5pbm6uYmZOcWpybrFyYl5ealFuqZ6uZkleqkppZsY
	IYEsuINxxkm5Q4wCHIxKPLwnFMpChVgTy4orcw8xSnIwKYny/l4JFOJLyk+pzEgszogvKs1J
	LT7EKMHBrCTCy9IFlONNSaysSi3Kh0lJc7AoifPyLVH3ExJITyxJzU5NLUgtgsnKcHAoSfBW
	HQZqFCxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFaXwxME5BUjxAe7tB2nmLCxJz
	gaIQracYFaXEeZtBEgIgiYzSPLixsPT0ilEc6Eth3k8gVTzA1AbX/QpoMBPQ4O9fi0EGlyQi
	pKQaGLuLwhY+jj5yYMu6454F13f/9Vny82G/3WO5gvf3nl3U+eqhJKvItHHhPsepD3JuuKiy
	iUrI/fpnc/dB7T4FFyPPLs60rvJLb4/ONUuOa/zjmlTd7xCy48TXiOgP6zduTJ7g 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271164>

On 06/08/2015 07:12 PM, Jeff King wrote:
> On Mon, Jun 08, 2015 at 09:57:04AM -0700, Stefan Beller wrote:
> 
>> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>> This will result in errors being emitted for references that can't be
>>> deleted, but that is a good thing.
>>
>> This sounds a bit like hand-waving to me. "Trust me, I'm an engineer!".
> 
> I think the argument is "we failed to do that the user asked for, but
> never reported the reason why".
> 
> But I don't see how that is the case. We already complain if
> repack_without_refs fail, and AFAICT the original call to delete_ref()
> would emit an error, as well.

The old and new code report errors that come from repack_without_refs()
the same way. The difference is how they report errors within delete_ref().

The old code only allowed delete_ref() to emit its error.

The new code (in delete_refs()) allows delete_ref() to emit its error,
but then follows it up with

    error(_("could not remove reference %s"), refname)

The "could not remove reference" error originally came from a similar
message in remove_branches() (from builtin/remote.c).

I *think* this is an improvement, because the error from delete_ref()
(which usually comes from ref_transaction_commit()) can be pretty
low-level, like

    Cannot lock ref '%s': unable to resolve reference %s: %s

where the last "%s" is the original strerror.

I would be happy to change the behavior if somebody has a concrete wish.
At the same time I don't think we need to sweat the details too much,
because these errors should only ever be seen in the case of a broken
repository or a race between two processes; i.e., only in pretty rare
and anomalous situations.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
