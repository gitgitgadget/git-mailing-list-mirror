From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH for next] insert missing newline in a diagnostic
Date: Thu, 02 Sep 2010 10:20:33 +0200
Message-ID: <87lj7kimjy.fsf@meyering.net>
References: <87iq2s4ewn.fsf@meyering.net> <20100901001729.GG6747@burratino>
	<vpqeide0zkx.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 02 10:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or52P-00007s-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 10:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752504Ab0IBIUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 04:20:43 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:52123 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752167Ab0IBIUm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 04:20:42 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 86575940034
	for <git@vger.kernel.org>; Thu,  2 Sep 2010 10:20:34 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1A509D894; Thu,  2 Sep 2010 10:20:33 +0200 (CEST)
In-Reply-To: <vpqeide0zkx.fsf@bauges.imag.fr> (Matthieu Moy's message of "Wed,
	01 Sep 2010 08:04:14 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155110>

Matthieu Moy wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Jim Meyering wrote:
>>
>>> When merging, I would get a message like this:
>>>
>>>   error: The following untracked working tree files would be overwritten by merge:
>>>   FILE_NAMEPlease move or remove them before you can merge.
>>>
>>> This change inserts the newline after FILE_NAME.
>>
>> I fear it is more complicated.  With your patch, in some situations
>> (e.g., when running t7609-merge-co-error-msgs.sh) I get a leading tab
>> and extra newline:
>>
>>  error: The following untrack...
>> 	FILE_NAME
>>
>>  Please move or remove them before you can merge.
>>
>> In unpack-trees, display_error_msgs() prints the version with a tab
>> but you are getting the message from add_rejected_path which suggests
>> to me that o->show_all_errors is unset.
>
> That sounds like an explanation. The patch series did two things:
> override plumbing error messages, and introducing show_all_errors. The
> two are meant to work together, and clearly, if you set one without
> the other, you get surprising results. A fix would be to make sure
> that we set both in the same places.

Thanks to both of you.

> Patch follows, untested. Jim, can you tell us whether it fixes the
> problem? If not, can your give us a reproduction script (preferably as
> a patch to t7609-merge-co-error-msgs.sh)?

Matthieu, should your patch have gone to the mailing list?
I do not see it there.
