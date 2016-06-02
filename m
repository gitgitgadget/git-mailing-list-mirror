From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 09/13] refs: introduce an iterator interface
Date: Thu, 2 Jun 2016 18:23:53 +0200
Message-ID: <57505D99.9060308@alum.mit.edu>
References: <cover.1464537050.git.mhagger@alum.mit.edu>
 <89634d216544d1102dafd5d18247bff2581d48a8.1464537050.git.mhagger@alum.mit.edu>
 <CACsJy8AZRJ_qa8KHTt_xcX5sDmJ2rCuMd6LpW+MB0MXKErDJQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 18:24:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8VPe-0001ox-9n
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 18:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753476AbcFBQX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 12:23:57 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:44302 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751360AbcFBQX5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 12:23:57 -0400
X-AuditID: 12074413-473ff700000008c7-d7-57505d9b5913
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id F6.72.02247.B9D50575; Thu,  2 Jun 2016 12:23:55 -0400 (EDT)
Received: from [192.168.69.130] (p508EAEB0.dip0.t-ipconnect.de [80.142.174.176])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u52GNrrf012750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Thu, 2 Jun 2016 12:23:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.8.0
In-Reply-To: <CACsJy8AZRJ_qa8KHTt_xcX5sDmJ2rCuMd6LpW+MB0MXKErDJQw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqDs7NiDcYPELc4v5m04wWnRd6Way
	aOi9wmzRPeUto8WPlh5mB1aPnbPusns8693D6HHxkrLHguf32T0+b5ILYI3itklKLCkLzkzP
	07dL4M54dWMhY8FS/opNs9+zNjBu5+li5OSQEDCRODixnRHEFhLYyigx+ZNKFyMXkH2eSWLC
	3lMsIAlhAQeJu5+bwGwRASWJNx3bmKGKGCUWXJjPBuIwCyxhlHjeMJMJpIpNQFdiUU8zmM0r
	oC2xft8HVhCbRUBFYt3mG8wgtqhAiMT5dVtZIWoEJU7OfAK2gVMgUKJj7Us2EJtZQF3iz7xL
	zBC2vMT2t3OYJzDyz0LSMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW
	6KWmlG5ihISz8A7GXSflDjEKcDAq8fAy6PiHC7EmlhVX5h5ilORgUhLlXVkGFOJLyk+pzEgs
	zogvKs1JLT7EKMHBrCTCuyg6IFyINyWxsiq1KB8mJc3BoiTOq7ZE3U9IID2xJDU7NbUgtQgm
	K8PBoSTBqx0D1ChYlJqeWpGWmVOCkGbi4AQZziUlUpyal5JalFhakhEPisr4YmBcgqR4gPZ2
	ge0tLkjMBYpCtJ5iNObY9OPaWiaOI/vvrWUSYsnLz0uVEuf9D1IqAFKaUZoHtwiWyF4xigP9
	Lcx7AeQeHmAShJv3CmgVE9Cqgkf+IKtKEhFSUg2MzVsOLigu+/Lv7cTXt8ubFx6UO5g3LZQp
	liunusCv6VEv94Sg2hvzeS9H/zQp450ntdGDv0KN94ekw++a3S6c0/o7fh7k+r2y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296213>

On 06/02/2016 12:08 PM, Duy Nguyen wrote:
> On Mon, May 30, 2016 at 2:55 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Currently, the API for iterating over references is via a family of
>> for_each_ref()-type functions that invoke a callback function for each
>> selected reference. All of these eventually call do_for_each_ref(),
>> which knows how to do one thing: iterate in parallel through two
>> ref_caches, one for loose and one for packed refs, giving loose
>> references precedence over packed refs. This is rather complicated code,
>> and is quite specialized to the files backend. It also requires callers
>> to encapsulate their work into a callback function, which often means
>> that they have to define and use a "cb_data" struct to manage their
>> context.
>>
>> The current design is already bursting at the seams, and will become
>> even more awkward in the upcoming world of multiple reference storage
>> backends:
>>
>> * Per-worktree vs. shared references are currently handled via a kludge
>>   in git_path() rather than iterating over each part of the reference
>>   namespace separately and merging the results. This kludge will cease
>>   to work when we have multiple reference storage backends.
> 
> Question from a refs user. Right now worktree.c:get_worktrees() peeks
> directly to "$GIT_DIR/worktrees/xxx/HEAD" and parses the content
> itself, something that I  promised to fix but never got around to do
> it. Will we have an iterator to go through all worktrees' HEAD, or
> will  there be an API to say "resolve ref HEAD from worktree XYZ"?

My preference is that there is a way to say "create a ref_store object
representing the loose references stored physically under
"$GIT_DIR/worktrees/xxx". Then that ref_store could be asked to read its
`HEAD` (or iterate over all of the refs under that path or whatever).
You could even write `HEAD` through the same ref_store.

Michael
