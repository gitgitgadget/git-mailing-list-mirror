From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document escaping of special characters in gitignore
 files
Date: Wed, 05 Jan 2011 12:37:21 -0800
Message-ID: <7vk4ijccji.fsf@alter.siamese.dyndns.org>
References: <1294234732-20094-1-git-send-email-jnareb@gmail.com>
 <7vwrmjchuu.fsf@alter.siamese.dyndns.org>
 <201101052027.24640.jnareb@gmail.com> <4D24D0CB.3030004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Schwab <schwab@linux-m68k.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 05 21:37:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paa76-0000WG-C2
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 21:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803Ab1AEUhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 15:37:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab1AEUhi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 15:37:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C43143EB2;
	Wed,  5 Jan 2011 15:38:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QOZIPK4lYxSn7M4HV7p2Cn/wp70=; b=fk4KRM
	IOqNMfNopfGuh7xbl/EIuWPO7dDjwG7MXdcm5pHl0CZN0iNd/np0zCdBX57Y7wlQ
	m6k03YsY1VsN5eA4gnkpRbZx6pGKEJEXj7c3fbdQ/MOCKnXS9RiEcQaK7Xm5qPcZ
	c5nPJwiG1GrB9Es1Mme/5rDRrNTOY3D4OCbg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=neazowySt22/OsEOtypbDCTAGCd4r1Rp
	FpTPl0KA6cpMunIJN6r2YnJstfO+pfUktYOL0nU827fIfwtK+5Si28zJTJTsgYFI
	mp4iVUvMCKR41xIzJcT7Y2TfowwCJwQkrQl4ycdpDaav5ak9DB8LQii1UxmgGiKw
	wnFsXYbnOLE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6CC9D3EAC;
	Wed,  5 Jan 2011 15:38:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9B8E83EA6; Wed,  5 Jan 2011
 15:38:00 -0500 (EST)
In-Reply-To: <4D24D0CB.3030004@gmail.com> (Bruce Korb's message of "Wed\, 05
 Jan 2011 12\:12\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B474D5BE-190B-11E0-B255-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164591>

Bruce Korb <bruce.korb@gmail.com> writes:

> On 01/05/11 11:27, Jakub Narebski wrote:
>>>> +++ b/templates/info--exclude
>>>> @@ -4,3 +4,4 @@
>>>>  # exclude patterns (uncomment them if you want to use them):
>>>>  # *.[oa]
>>>>  # *~
>>>> +# \#*#
>>>
>>> Do we need this?  Without explanation it is somewhat hard to realize that
>>> this last line is also an example of a pattern that excludes any filename
>>> that begins and ends with a pound.
>> 
>> Well, perhaps not.  Note though that this exclude pattern is actually
>> useful for me, as GNU Emacs uses this convention ("#<filename>#") for
>> auto-save files.
>
> As the source of this thread, I, too, use emacs and it is exactly
> the problem of trying to figure out how to get git to ignore these
> auto save files that got me down this path.  It was too hard to figure out.
> So I suggested some doc changes and the addition of the "exclude
> emacs auto save files" pattern to the sample text.  People who do not
> use emacs would not understand the \#*# line and folks who do would.
> They see files like that all the time.  For the sake of vi users, you
> might want to explain them, but I don't think it is crucial.
> It *is* important to have an example of a needs-to-be-escaped file name.

Perhaps a single liner comment to describe the three examples immediately
below "exclude patterns (uncomment them..." is in order in that case,
something like:

# exclude patterns (object and library, emacs backup, emacs autosave
# files) -- uncomment if you want to use them
# *.[oa]
# *~
# \#*#
