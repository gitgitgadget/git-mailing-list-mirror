From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v6 08/19] fsck: Make =?UTF-8?Q?fsck=5Fcommit=28=29=20w?=
 =?UTF-8?Q?arn-friendly?=
Date: Fri, 19 Jun 2015 22:52:28 +0200
Organization: gmx
Message-ID: <ba0cb32edf26639a8a00ad9d17b49e32@www.dscho.org>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
 <1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
 <xmqqmvzv78z9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 19 22:52:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63HU-00062Z-Uv
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 22:52:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbbFSUww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 16:52:52 -0400
Received: from mout.gmx.net ([212.227.17.21]:57375 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932335AbbFSUwq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 16:52:46 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M4TgW-1Ytum949WO-00ylb8; Fri, 19 Jun 2015 22:52:30
 +0200
In-Reply-To: <xmqqmvzv78z9.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:H2RWOe8jNuApUQkMfRDSsZ6o2lRqF8Laox+7BDE6ZiRR1vb5EIq
 PjaZIJFYh3m89x08SKZtFs3ivqWASyjN2uzswEdMfE+9eqvcAmWD3IUtShhbK97b/n4MqiM
 a6A3Vsex2/9bZbKJ002F+4cL2c21+ZZyMmi6X789pkN3inLBLEyQTOVFOn788dkcYM3DDaW
 bs0Fsi5pZseUS5rY0Hg9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:aRhw+a2UktM=:f8/pA8qXDbLmd7uWmqglxI
 NezZ+m1TYBnRJdDD8uFAGQMrtyjf2/SFUCbGktAJKIRTf+JLa5W3DPPAJdKOnIOIr0JGxeyVV
 kG9BZEFY0AX9FfSqfo/5T33dGRccXWSoUtfG/+VbseA5x5DEXyvCSCxwXkXOG4Q7PVM57qhao
 Ls6IzfpMGhvlnDh60tfgyXTqch4nqRCEE3+1Q4rtWecfVUmkH+qFexbZwyDjaJI2X8pCq3076
 HOtHeUqRF5Apv4k5ia2jQJ3FEzgj92k1jhcvIYfjfg9JRPluoNe+a4nHFokeVZpwW4xSdbJhi
 y45iYj/vF0ctt2Ib6mfMgqiJoMYiZmfWx8y1nrRxIb+txIupTTCz89816zKn5cjmNNKB3P1pw
 EHp8dDZKdOaPClxRiBqSFaY33LDVlJ6+ecdfZBdNyXOUwt67IGLqBgW8tygveGOEGTuu0hVd3
 8Ah6UowxqHY4b1pGeD9e2+jtbO0Ag+gsOlqHczjNIHuEOWnpRCZrTm9WFCrzQjiacEjMy7gs+
 76mRKqVpd8Q4ak7Z7KRMny9D0co4BjzgKfcGxG9zrLj4tXzEaNwwK/nkTsCvvvUYnOfHS56O/
 8v01qY3lwkDj+Y+9kB3ABbOQWfVotsXtvs/nxsih2h4NOqUEzqeLKPEVPYMejmJZr98IHcoZD
 x5ugW4YS6jODyeXWXxdlEABY/ciptuUJA/E/BCD0ct1PNYRuTyh421C29s4g04ZKGbnw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272203>

Hi Junio,

On 2015-06-19 22:12, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Note that some problems are too problematic to simply ignore. For
>> example, when the header lines are mixed up, we punt after encountering
>> an incorrect line. Therefore, demoting certain warnings to errors can
>> hide other problems. Example: demoting the missingauthor error to
>> a warning would hide a problematic committer line.
> 
> Is this a warning to end-users (which should be better in the doc),
> or "because some of them are too problematic to ignore" that forgot
> to add the explanation "hence we do not keep going in this code"
> (which should be in the log message if that is what is going on)?

It was intended to offer the explanation for the design decision you commented on later:

> I notice that there are many instances of
> 
> 	if (object does not pass some test)
> 		return report(...);
> 
> that do not do "err = report(); if (err) return;" in this function
> after applying this patch.
> 
> I think that answers the above question.  The answer is "because
> some are too problematic, even after this patch, we give up parsing
> the remainder of the commit object once we hit certain errors,
> leaving some other errors that appear later in the object
> undetected".
> 
> I think that is a sensible design decision, but the proposed log
> message forgets to say so.
> 
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>>  fsck.c | 28 ++++++++++++++++++++--------
>>  1 file changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/fsck.c b/fsck.c
>> index 9faaf53..9fe9f48 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -534,12 +534,18 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>>
>>  	if (!skip_prefix(buffer, "tree ", &buffer))
>>  		return report(options, &commit->object, FSCK_MSG_MISSING_TREE, "invalid format - expected 'tree' line");
>> -	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
>> -		return report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
>> +	if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n') {
>> +		err = report(options, &commit->object, FSCK_MSG_BAD_TREE_SHA1, "invalid 'tree' line format - bad sha1");
>> +		if (err)
>> +			return err;
>> +	}
> 
> I do not think this "if (err) return err;" that uses the return
> value of report(), makes sense.
> 
> As all the errors that use this pattern are isolated ones that does
> not break parsing of the remainder (e.g. author ident had an extra >
> in it may break "author " but that does not prevent us from checking
> "committer ").
> 
> Your report() switches its return value based on the user setting;
> specifically, it returns 0 if the user tells us to ignore/skip or
> warn.  Which means that the user will see all warnings, but we stop
> at the first error.
> 
> Shouldn't we continue regardless of the end-user setting in order to
> show errors on other fields, too?

I can make that happen, but please note that this is a change of behavior: we always stopped upon the first error.

It was my intention not to change behavior in that way without a proper reason, and I saw none.

I actually see a really good reason to *keep* the current behavior: one of the most prominent users of this code path is `git receive-pack --strict`. It is used heavily by GitHub to ensure at least a certain level of validity of pushed objects. Now, for this use case it is easy to see that you want to stop *as soon as an error was encountered*. And as GitHub sponsors my work on this patch series, my main aim is to support their use case.

Having said that, I agree that it could actually make sense for `git fsck` to show all errors, or at least to have an option to do so.

But that is a story for another night ;-)
Dscho
