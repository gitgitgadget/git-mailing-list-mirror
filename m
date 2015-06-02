From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 3/3] read_loose_refs(): treat NULL_SHA1 loose references
 as broken
Date: Tue, 02 Jun 2015 23:10:22 +0200
Message-ID: <556E1BBE.7000708@alum.mit.edu>
References: <1433260647-18181-1-git-send-email-mhagger@alum.mit.edu>	<1433260647-18181-4-git-send-email-mhagger@alum.mit.edu> <CAGZ79kZG95HB-siR_jMORPuqcL2J_YEwg0VPHE=8XN7gWD4JkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Anders Kaseorg <andersk@mit.edu>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztSP-0003xG-Rk
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbbFBVKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:10:37 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58375 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751593AbbFBVKf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Jun 2015 17:10:35 -0400
X-AuditID: 12074412-f79066d000000bc5-62-556e1bc0c791
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 0B.89.03013.0CB1E655; Tue,  2 Jun 2015 17:10:24 -0400 (EDT)
Received: from [192.168.69.130] (p4FC966E3.dip0.t-ipconnect.de [79.201.102.227])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t52LAMjH026794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 2 Jun 2015 17:10:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAGZ79kZG95HB-siR_jMORPuqcL2J_YEwg0VPHE=8XN7gWD4JkA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqHtAOi/U4NwnBYszfeEWXVe6mSwa
	eq8wW/xo6WG22Ly5ncWB1WPBplKPpjNHmT2e9e5h9Lh4Sdnj8ya5ANYobpukxJKy4Mz0PH27
	BO6MBYuyCj6LVfTtaGFpYLws0MXIySEhYCJxdPpvNghbTOLCvfVANheHkMBlRonjSyewQjjn
	mSQutv5mBaniFdCW+L7nK0sXIwcHi4CqxK0FViBhNgFdiUU9zUwgYVGBIInXL3MhqgUlTs58
	wgJiiwioScxcNRtsF7PATEaJNR8rQWxhgWiJR83rWCBWHWKU2DtxMTtIglMgUKK9aTkzRIO6
	xJ95l6BseYnmrbOZJzAKzEKyYxaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXT
	y80s0UtNKd3ECAluoR2M60/KHWIU4GBU4uFl/JQTKsSaWFZcmXuIUZKDSUmU9xB/XqgQX1J+
	SmVGYnFGfFFpTmox0MkczEoivD5iQDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWp
	RTBZGQ4OJQleEymgRsGi1PTUirTMnBKENBMHJ8hwLimR4tS8lNSixNKSjHhQnMYXAyMVJMUD
	tDcKpJ23uCAxFygK0XqKUVFKnNcXJCEAksgozYMbC0tZrxjFgb4U5g0GqeIBpju47ldAg5mA
	BrcL5IAMLklESEk1MK5I2ZDBIVf82rVgvaYE95Gm8u0e095Men7QidNbfr7sBvYN/36HRb7W
	f+c55Z2tC8+N+pUf/Rj7CqRTD+nLHlmqfivj+vMFq+S4TzUsP7vKRvJEUe8fx9Kb 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270597>

On 06/02/2015 07:28 PM, Stefan Beller wrote:
> On Tue, Jun 2, 2015 at 8:57 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> NULL_SHA1 is never a valid value for a reference. If a loose reference
>> has that value, mark it as broken.
>>
>> Why check NULL_SHA1 and not the nearly 2^160 other SHA-1s that are
>> also invalid in a given repository? Because (a) it is cheap to test
>> for NULL_SHA1, and (b) NULL_SHA1 is often used as a "SHA-1 is invalid"
> 
> I don't quite agree with the reasoning here. Just because it's cheap doesn't
> mean it's right. ;) But I fully agree with (b) so this still makes sense.

Its cheapness improves the cost/benefit ratio of adding this check.

>> value inside of Git client source code (not only ours!), and
>> accidentally writing it to a loose reference file would be an easy
>> mistake to make.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c                         | 7 +++++++
>>  t/t6301-for-each-ref-errors.sh | 2 +-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 47e4e53..c28fde1 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1321,6 +1321,13 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
>>                                 hashclr(sha1);
>>                                 flag |= REF_ISBROKEN;
>>                         }
>> +
>> +                       if (!(flag & REF_ISBROKEN) && is_null_sha1(sha1)) {
> 
> Why do we do the extra check for !(flag & REF_ISBROKEN) here?

That was an attempt to avoid calling is_null_sha1() unnecessarily. I
think I can make this go away and make the code clearer in general by
restructuring the logic a little bit. I will do that in the next round.

>> +                               /* NULL_SHA1 is never a valid reference value. ...
> 
> ... *by our definition*, because we believe it helps detecting
> errors/mistakes in the future.

It's not even by our definition. It is just astronomically more likely
that NULL_SHA1 got set there due to an error than that it is the SHA-1
of legitimate content. In fact it is so unlikely that we use NULL_SHA1
throughout our code to indicate "invalid SHA-1", ignoring the
theoretical possibility that it could appear some day as a real SHA-1.

I'll try to explain this point better in the comment.

> */
>> +                               hashclr(sha1);
> 
> While this code looks consistent to the rest around, at closer inspection
> this feels a bit redundant to me. If is_null_sha1(sha1) is true, then
> hashclr(sha1); doesn't change the state. Or did I miss a subtle side effect?

You're right, there is no reason to call hashclr() here.

>> +                               flag |= REF_ISBROKEN;
>> +                       }
>> +
>> [...]

Thanks for your review!

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
