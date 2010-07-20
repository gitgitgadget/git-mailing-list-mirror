From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/README: clarify test_must_fail description
Date: Tue, 20 Jul 2010 11:00:46 -0700
Message-ID: <7veieym3sh.fsf@alter.siamese.dyndns.org>
References: <20100720163822.GA8492@localhost.localdomain>
 <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jaredhance@gmail.com, git@vger.kernel.org, avarab@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jul 20 20:01:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObH7t-0006Zx-5w
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 20:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0GTSBB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 14:01:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57564 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962Ab0GTSBA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 14:01:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2794CC6E14;
	Tue, 20 Jul 2010 14:00:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lv+k4FEToxscpMhan7CWSjheWEA=; b=cavltD
	rolUmsjHw4mvQejXsB+xUjKV25gcVU/EOkLg2N6prO++Vvkwi4p0BtesF20OkisG
	fkhtmp/FdQyWbjScGNjSWDt3X9x978OZJER1Q+WoQm15IbcTvZvzlFmJi7jSbCOx
	cLVKo1OaYZvespUmvweFi24QWOJYjEG8hKC+I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i9O1WkMLGmPPU6Se32etQ2AQtgvcmiDY
	t7Ldt1qBFL1WNmGAUxnxDiHxKtiOUj5TzsC1ObSPzziqTlL8xKfRGGpzN18q5UJR
	WI4sqj3GuqkCyx5+inNiND7olCclvmE8dSQwBOqasVPX6u7IL0tlL+mHEJG8dwKF
	eal9c0QwSzU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC3FAC6E13;
	Tue, 20 Jul 2010 14:00:53 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6BB3C6E0E; Tue, 20 Jul
 2010 14:00:47 -0400 (EDT)
In-Reply-To: <0JXkybOAPrkw1RCkgKLY0ocfkmfqHFq_bWFMVWrzymAet2VX-veTSoZP1hBzIyN5JSrPw-IZjfI@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Tue\, 20 Jul 2010 12\:17\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD30943A-9428-11DF-BD4C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151338>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> From: Brandon Casey <drafnel@gmail.com>
>
> Some have found the wording of the description to be somewhat ambiguous
> with respect to when it is desirable to use test_must_fail instead of
> "! <git-command>".  Tweak the wording somewhat to hopefully clarify that
> it is _because_ test_must_fail can detect segmentation fault that it is
> desirable to use it instead of "! <git-command>".
>
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
>
>
> On 07/20/2010 11:38 AM, Jared Hance wrote:
>> I think the wording of description of test_must_fail is slightly
>> ambiguous. I read it to mean that:
>> 
>>     Use test_must_fail only when you are testing to see if git will
>>     segfault.
>
> I think that is a correct interpretation.  But I ask you this:
> Are there times when we would _not_ want to test for segfault? :)
>
>> Rather than:
>>     
>>     Use test_must_fail to be safe from git segfaults.
>> 
>> 
>> Perhaps the description should be updated to be a bit more clear?
>
> How about this?
>
>
>  t/README |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/README b/t/README
> index b906ceb..a830daa 100644
> --- a/t/README
> +++ b/t/README
> @@ -451,8 +451,8 @@ library for your script to use.
>   - test_must_fail <git-command>
>  
>     Run a git command and ensure it fails in a controlled way.  Use
> -   this instead of "! <git-command>" to fail when git commands
> -   segfault.
> +   this instead of "! <git-command>" since it will fail when git
> +   commands segfault.

I found your earlier

   Use test_must_fail instead of "! <git-command>" since test_must_fail
   will fail when <git-command> segfaults.

slightly clearer.

 - "it" in "since it will fail" is a bit ambiguous: is it "!" or
   "test_must_fail"?

 - it is not obvious if "fail" in "since it will fail" is a good thing or
   a bad thing; as we are discussing test_MUST_fail, it may even be a good
   thing that it "will fail"---which is not what we want our audience to
   read from this.

How about being more explicit?

    Run a git command and ensure it fails in a controlled way.  Use
    this instead of "! <git-command>".  When git-command dies due to a
    segfault, test_must_fail diagnoses it as an error; "! <git-command>"
    treats it as just another expected failure. letting such a bug go
    unnoticed.

>  
>   - test_might_fail <git-command>
>  
> -- 
> 1.6.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
