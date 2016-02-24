From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 2/5] t4001-diff-rename: wrap file creations in a test
Date: Wed, 24 Feb 2016 14:16:02 +0100
Message-ID: <vpq7fhu8d0t.fsf@anie.imag.fr>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr>
	<1456249498-3232-3-git-send-email-Matthieu.Moy@imag.fr>
	<20160224102510.GB21152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:16:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZIf-0004g4-61
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 14:16:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815AbcBXNQN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 08:16:13 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40219 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671AbcBXNQL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 08:16:11 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id u1ODG09V011502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 24 Feb 2016 14:16:00 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u1ODG2gk027768;
	Wed, 24 Feb 2016 14:16:02 +0100
In-Reply-To: <20160224102510.GB21152@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 24 Feb 2016 05:25:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 24 Feb 2016 14:16:01 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u1ODG09V011502
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1456924562.47654@aEY9CcMvv/FhESCLrlPY1A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287207>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 23, 2016 at 06:44:55PM +0100, Matthieu Moy wrote:
>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>> ---
>>  t/t4001-diff-rename.sh | 38 +++++++++++++++++++++-----------------
>>  1 file changed, 21 insertions(+), 17 deletions(-)
>> 
>> diff --git a/t/t4001-diff-rename.sh b/t/t4001-diff-rename.sh
>> index 2f327b7..bfb364c 100755
>> --- a/t/t4001-diff-rename.sh
>> +++ b/t/t4001-diff-rename.sh
>> @@ -9,7 +9,9 @@ test_description='Test rename detection in diff engine.
>>  . ./test-lib.sh
>>  . "$TEST_DIRECTORY"/diff-lib.sh
>>  
>> -echo >path0 'Line 1
>> +test_expect_success 'setup' '
>> +	cat >path0 <<\EOF &&
>> +Line 1
>>  Line 2
>>  Line 3
>>  Line 4
>
> Should we use "<<-" here (and elsewhere) to indent the sample lines?

I did not use it because I thought it would strip the leading space
(' '), but actually it strips only tabs so we can definitely use it.

I changed it to <<- and pushed it here:
https://github.com/moy/git/commits/set-diff-renames

I'll resend later.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
