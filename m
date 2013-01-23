From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #08; Tue, 22)
Date: Tue, 22 Jan 2013 16:11:59 -0800
Message-ID: <7vobgglpv4.fsf@alter.siamese.dyndns.org>
References: <7va9s0n8gv.fsf@alter.siamese.dyndns.org>
 <20130122234554.GI7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>,
	Chris Rorvick <chris@rorvick.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jan 23 01:12:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Txnx7-00086T-7G
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 01:12:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756163Ab3AWAMH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2013 19:12:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279Ab3AWAMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2013 19:12:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E47FB2A3;
	Tue, 22 Jan 2013 19:12:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HJ3yNvHG9Dghy5gxpzAF2cTM878=; b=scghz4
	fdwqrvnLXvPkPQHN/f1hwKodE7q5u0DYm+9wL8Ee6TGZPl1S2y2FCUafs3E83zeT
	DavufoCeA2XgIE1TMTpBM+BOl8neCpSoWefXlTsoKGJ8zzrRl0rk/UhF/rDPC24R
	rbEKuWbz1KXlayusE+Z08ftFeuf/xE4sUaaJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VA7oZOLTQFB1+R28zz1vdDcnt35xEv/l
	nnrnrR7tKjsoqUmz+GlauOcAFAGuzU4cu68ldRJGOw5IPdsTnDH8oUERueO56RIy
	ETilCd7JyMDI8G9j5ZLU8Z1jHFchoeS4rO8rqU23Ie/t3SjSLzwXzbSnduVBwbOI
	gGjawEwsfvI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F8B6B2A1;
	Tue, 22 Jan 2013 19:12:02 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC289B29E; Tue, 22 Jan 2013
 19:12:01 -0500 (EST)
In-Reply-To: <20130122234554.GI7498@serenity.lan> (John Keeping's message of
 "Tue, 22 Jan 2013 23:45:54 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 82BBF5E6-64F1-11E2-ABE5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214264>

John Keeping <john@keeping.me.uk> writes:

> On Tue, Jan 22, 2013 at 02:44:48PM -0800, Junio C Hamano wrote:
>> * jc/cvsimport-upgrade (2013-01-14) 8 commits
>>  - t9600: adjust for new cvsimport
>>  - t9600: further prepare for sharing
>>  - cvsimport-3: add a sample test
>>  - cvsimport: make tests reusable for cvsimport-3
>>  - cvsimport: start adding cvsps 3.x support
>>  - cvsimport: introduce a version-switch wrapper
>>  - cvsimport: allow setting a custom cvsps (2.x) program name
>>  - Makefile: add description on PERL/PYTHON_PATH
>> 
>>  The most important part of this series is the addition of the new
>>  cvsimport by Eric Raymond that works with cvsps 3.x.  Given some
>>  distros have inertia to be conservative, Git with cvsimport that
>>  does not work with both 3.x will block adoption of cvsps 3.x by
>>  them, and shipping Git with cvsimport that does not work with cvsps
>>  2.x will block such a version of Git, so we'll do the proven "both
>>  old and new are available, but we aim to deprecate and remove the
>>  old one in due time" strategy that we used successfully in the
>>  past.
>> 
>>  Will merge to 'next'.
>
> Would you mind holding off on this?  As it stands there are a couple of
> issues with the cvsimport-3 script including: ...

Actually I do. I think this, at least the early part of it, should
be merged to 'next' as soon as possible, *unless*

 (1) The cvsimport-2 & cvsps2 combo this series ships gives worse
     experience than cvsimport we ship in v1.8.1 to end users of the
     current cvsimport with cvsps2; and/or

 (2) The cvsimport-3 in this series, which is a copy of an older
     version of what Eric has, is so broken that we are better off
     starting cvsimport-3 by getting a fresh copy from Eric which
     has been rewritten in a major way, than applying huge
     incremental update patches that amounts to a total rewrite.

The point (1) is important from "no regression" point of view, and
in a sense more important between the two because it is the first
step in the overall transition plan.

Even though there may be remaining issues in cvsimport-3 and cvsps3
(what new piece of software don't have issues?), my limited
observation of the exchanges between you and Eric suggests me that
the problem is not something that requires a total rewrite of how
cvsimport-3 works, so I do not expect the point (2) to be true,
either, but if I am mistaken, please let me know.

By advancing the topic to 'next', we will give people a more solid
(read: not getting rewound) foundation to work with than "if you are
really interested, grab the tip of 'pu', replace it with even newer
copy from Eric's repository and try it out", so that more people can
help us polish the scaffolding to let us ship two versions and also
find issues in the new cvsimport-3 and help fixing them.  At least,
that is what I've been hoping.

I could stop at the first three patches, that is, introducing the
version switch wrapper that switches between cvsps2+cvsimport-2
combo and nothing, and then let you and Eric redo the "start adding
cvsps 3.x support" and later patches when cvsimport-3 is ready.
That would give you a larger lattitude to rework cvsimport-3.  Is
that preferrable?
