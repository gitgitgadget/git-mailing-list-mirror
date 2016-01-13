From: greened@obbligato.org (David A. Greene)
Subject: Re: [PATCH] contrib/subtree: unwrap tag refs
Date: Tue, 12 Jan 2016 20:35:28 -0600
Message-ID: <87d1t6p5ov.fsf@waller.obbligato.org>
References: <1447388144-23806-1-git-send-email-git@rob.dqd.com>
	<87h9kqwm67.fsf@waller.obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com
To: Rob Mayoff <mayoff@dqd.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 03:36:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJBIF-0005tZ-59
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 03:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbcAMCfg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 21:35:36 -0500
Received: from li209-253.members.linode.com ([173.255.199.253]:58447 "EHLO
	johnson.obbligato.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752209AbcAMCff (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 21:35:35 -0500
Received: from chippewa-nat.cray.com ([136.162.34.1] helo=waller.obbligato.org)
	by johnson.obbligato.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.85)
	(envelope-from <greened@obbligato.org>)
	id 1aJBIl-0001YD-EC; Tue, 12 Jan 2016 20:36:47 -0600
In-Reply-To: <87h9kqwm67.fsf@waller.obbligato.org> (David A. Greene's message
	of "Thu, 12 Nov 2015 22:36:16 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
X-Filter-Spam-Score: ()
X-Filter-Spam-Report: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283869>

I am sorry I neglected to follow-up on this.

greened@obbligato.org (David A. Greene) writes:

> Rob Mayoff <mayoff@dqd.com> writes:
>
>> diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
>> index 9f06571..b051600 100755
>> --- a/contrib/subtree/git-subtree.sh
>> +++ b/contrib/subtree/git-subtree.sh
>> @@ -245,7 +245,10 @@ find_latest_squash()
>>  		case "$a" in
>>  			START) sq="$b" ;;
>>  			git-subtree-mainline:) main="$b" ;;
>> -			git-subtree-split:) sub="$b" ;;
>> +			git-subtree-split:)
>> +				sub="$b"
>
> Why include the above line?

My bad.  Missed the diff markers.  This is fine.

>> +				sub="$(git rev-parse "$b^0")" || die "could not rev-parse split hash $b from commit $sq"
>
> This seems like odd quoting.  Would not this do the same?
>
> 				sub="$(git rev-parse $b^0)" || die "could not rev-parse split hash $b from commit $sq"
>
> Perhaps I am missing something.

Jeff explained it, so this is ok.

This all looks good to me.  Junio, please apply.

                            -David
