From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Tue, 21 Apr 2015 14:37:21 +0200
Message-ID: <55364481.3020700@alum.mit.edu>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>	<xmqqsibyo141.fsf@gitster.dls.corp.google.com>	<CAGZ79kZvE+YJeKCYXN-RD3MFmP17VkqW8WUUssk6UgK_38iWrg@mail.gmail.com>	<CAGZ79kYEbnZvgdhjPvc2rR7QKp-CjUB3Ytqsp8JK2QBqzuUowA@mail.gmail.com>	<CAGZ79kZWm=Mi6o4jMNthiDRcR9irs_5MyRuEmHdDSrn-JFpQ=g@mail.gmail.com> <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 14:37:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkXQm-0001nM-US
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 14:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667AbbDUMhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 08:37:33 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43580 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621AbbDUMhc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Apr 2015 08:37:32 -0400
X-AuditID: 1207440d-f79976d000005643-d5-55364483f9a2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 40.47.22083.38446355; Tue, 21 Apr 2015 08:37:23 -0400 (EDT)
Received: from [192.168.69.130] (p4FC975C4.dip0.t-ipconnect.de [79.201.117.196])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t3LCbL2Z011863
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 21 Apr 2015 08:37:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqzj62ifc9.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqNvsYhZqsHWnhkXXlW4mi4beK8wW
	mze3szgweyzYVOpx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGctf/2IuuCZa0bxiB3sDY69g
	FyMnh4SAicTLfxMZIWwxiQv31rN1MXJxCAlcZpRYfeUGE4RzgUni5+Sr7CBVvALaEuvmvGYG
	sVkEVCXudy5kAbHZBHQlFvU0M4HYogJBEq3XpjJC1AtKnJz5BKiGg0NEwEuibWYxSJhZQF/i
	058DYOXCAvYSv77uZ4TYNY9ZYn/DJFaQBKeAtcTeviPsEA16Ejuu/2KFsOUlmrfOZp7AKDAL
	yYpZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXSC83s0QvNaV0EyMkdHl3MP5f
	J3OIUYCDUYmHl2GyaagQa2JZcWXuIUZJDiYlUd4mC7NQIb6k/JTKjMTijPii0pzU4kOMEhzM
	SiK8gkJAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBK+zM1CjYFFq
	empFWmZOCUKaiYMTZDiXlEhxal5KalFiaUlGPChW44uB0QqS4gHauxGknbe4IDEXKArReopR
	UUqc9yBIQgAkkVGaBzcWlpBeMYoDfSnMywVSxQNMZnDdr4AGMwENjttmAjK4JBEhJdXAyK4i
	Z/1wcjRXheS+56c0tjQV5iQtEjiWVT7PtVWiK5v/Rf78R0++GjipfjIsljbabm39jj8n5Vdi
	746b8ydutLY3N1KZkbLaS+lo16L1xUbfnrzIf+HxrumB5OfYlZZ3pdj8uX4vkubs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267525>

On 04/21/2015 12:51 AM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> The problem comes from guessing the number of fds we're allowed to use.
>> At first I thought it was a fundamental issue with the code being broken, but
>> it turns out we just need a larger offset as we apparently have 9 files open
>> already, before the transaction even starts.
>> I did not expect the number to be that high, which is why I came up with the
>> arbitrary number of 8 (3 for stdin/out/err, maybe packed refs and reflog so I
>> guessed, 8 would do fine).
>>
>> I am not sure if the 9 is a constant or if it scales to some unknown
>> property yet.
>> So to make the series work, all we need is:
>>
>> - int remaining_fds = get_max_fd_limit() - 8;
>> + int remaining_fds = get_max_fd_limit() - 9;
>>
>> I am going to try to understand where the 9 comes from and resend the patches.
> 
> I have a suspicion that the above is an indication that the approach
> is fundamentally not sound.  9 may be OK in your test repository,
> but that may fail in a repository with different resource usage
> patterns.
> 
> On the core management side, xmalloc() and friends retry upon
> failure, after attempting to free the resource.  I wonder if your
> codepath can do something similar to that, perhaps?
> 
> On the other hand, it may be that this "let's keep it open as long
> as possible, as creat-close-open-write-close is more expensive" may
> not be worth the complexity.  I wonder if it might not be a bad idea
> to start with a simpler rule, e.g. "use creat-write-close for ref
> updates outside transactions, and creat-close-open-write-close for
> inside transactions, as that is likely to be multi-ref updates" or
> something stupid and simple like that?
> 
> Michael?

Given that the release is so close, I think we should use the simplest
thing that could work, which I think is Stefan's original
N*(creat-close),N*(open-write-close),N*rename patch. I don't think there
are many code paths that might build up a big transaction anyway (I
guess only "git update-ref --stdin" and "git push --atomic"?) Neither of
these has been around very long, so I don't think the small performance
hit will bother anybody.

The correct solution is clearly N*(creat-write-close),N*rename, but that
is too complicated for this release. So let's get the bug fixed for the
release and try to get the better fix in the next release.

It would be possible to optimize the N=1 case (I guess it's by far the
most common case) really stupidly using something like

        if (n > 1)
                close_lock_file(update->lock->lk);

but I doubt even that's worth it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
