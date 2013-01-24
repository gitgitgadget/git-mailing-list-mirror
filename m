From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetools: Add tortoisegitmerge helper
Date: Thu, 24 Jan 2013 14:15:58 -0800
Message-ID: <7vpq0u8bxd.fsf@alter.siamese.dyndns.org>
References: <50FBD4AD.2060208@tu-clausthal.de>
 <7v4nibjrg0.fsf@alter.siamese.dyndns.org> <50FCFBBB.2080305@tu-clausthal.de>
 <7vfw1qbbr4.fsf@alter.siamese.dyndns.org> <5101B0A5.1020308@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>,
	davvid@gmail.com, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Thu Jan 24 23:16:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyV5v-00058F-Ac
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 23:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845Ab3AXWQG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 17:16:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39851 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755756Ab3AXWQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 17:16:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 879C5BADD;
	Thu, 24 Jan 2013 17:16:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HV69Z5n0/P+Uz2bi9/p3ccoEdDE=; b=r0woC6
	RJJyJ4kykR+wLCclNMNlIBNfcpil5ValMK3IWRbccCUVP1jXr2/0kAv/R4opzT3h
	JXoxu+5IzdRIYemto4GoalbWXEPRwm9sIDC+yJzhBR8yUXg9aF+t3mIMCnABGFcd
	2241YEZTsjjDO+H1q3wDPetJP3oYaLNCMDjMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZukJPI4ZLBgPa0BzeI5aoCLHV10j8sw0
	k4bhw37/9GL88V1a3KFi2KIToEM9NVfygGx35tHH9QzG+nDpY+0rq4kWYC4V0xX2
	KAQjGvjenf/Dv2x4b8mw86hr9D3kTdlIrb+E6M5rwnSVQ6ntnPROeHl5Bj60DE8c
	BixRnecLtqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41698BADC;
	Thu, 24 Jan 2013 17:16:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EBC4BAD4; Thu, 24 Jan 2013
 17:16:00 -0500 (EST)
In-Reply-To: <5101B0A5.1020308@tu-clausthal.de> (Sven Strickroth's message of
 "Thu, 24 Jan 2013 23:07:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A22CCDBE-6673-11E2-A8E9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214465>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> Am 24.01.2013 20:51 schrieb Junio C Hamano:
>> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:
>> 
>>> - The TortoiseGit team renamed TortoiseMerge.exe to TortoiseGitMerge.exe
>>>   (starting with 1.8.0) in order to make clear that this one has special
>>>   support for git and prevent confusion with the TortoiseSVN TortoiseMerge
>>>   version.
>> 
>> Wouldn't it make more sense in such a situation if your users can
>> keep using the old "tortoisemerge" configured in their configuration
>> and when the renamed one is found the mergetool automatically used
>> it, rather than the way your patch is done?
>
> That was also my first idea, however, TortoiseMerge uses parameters as
> follows: '-base:"$BASE"'. TortoiseGitMerge uses values separated by
> space from keys: '-base "$BASE"'. So both are incompatible (the first
> approach has problems with spaces in filenames, the TortoiseGitMerge
> approach fixes this).

OK.  Please unconfuse future readers of "git log" by saying why such
a unification does not work in the proposed log message.

>>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>>> index 4314ad0..13cbe5b 100644
>>> --- a/Documentation/diff-config.txt
>>> +++ b/Documentation/diff-config.txt
>>> @@ -151,7 +151,7 @@ diff.<driver>.cachetextconv::
>>>  diff.tool::
>>>  	The diff tool to be used by linkgit:git-difftool[1].  This
>>>  	option overrides `merge.tool`, and has the same valid built-in
>>> -	values as `merge.tool` minus "tortoisemerge" and plus
>>> -	"kompare".  Any other value is treated as a custom diff tool,
>>> +	values as `merge.tool` minus "tortoisemerge"/"tortoisegitmerge" and
>>> +	plus "kompare".  Any other value is treated as a custom diff tool,
>>>  	and there must be a corresponding `difftool.<tool>.cmd`
>>>  	option.
>> 
>> So in short, two tortoises and kompare are only valid as mergetool
>> but cannot be used as difftool?  No, I am reading it wrong.
>> merge.tool can be used for both, kompare can be used as difftool,
>> and two tortoises can only be used as mergetool.
>> 
>> This paragraph needs to be rewritten to unconfuse readers.  The
>> original is barely intelligible, and it becomes unreadable as the
>> set of tools subtracted by "minus" and added by "plus" grows.
>
> But I think this should not be part of this patch.

I agree that it can be done (and it is better to be done) as a
preparatory step.  The current text is barely readable, but with
this patch there will be two "minus", and the result becomes
unreadable at that point.

It also could be done as a follow-up documentation readability fix.
