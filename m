From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 23:29:03 -0800
Message-ID: <7v1udxladc.fsf@alter.siamese.dyndns.org>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com>
 <20130106120917.GC22081@elie.Belkin>
 <7vfw2enl2l.fsf@alter.siamese.dyndns.org> <50E9F7C2.1000603@gmail.com>
 <FBDECCA565D94DF9838DD81FE2E2543A@black>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, Eric Blake <eblake@redhat.com>
To: "Jason Pyeron" <jpyeron@pdinc.us>
X-From: git-owner@vger.kernel.org Mon Jan 07 08:29:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts79S-0001Sv-C9
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 08:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab3AGH3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 02:29:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751399Ab3AGH3J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 02:29:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A13ACA767;
	Mon,  7 Jan 2013 02:29:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/UBi1eAtMRWobDWKz0GQwCHSQmo=; b=PWxibU
	KY27/Ul3e47zKPjbUjEDv1RK+CC0ubT9Xj1OErOzOLgDgizqGI1hOAEYS4wLmR/T
	dJdH+Ml4A1ee5B/TMKMRaiQppEWlkulitwjlH++BXrOX6tFCbwmA2v4TEp/k5Ach
	ph5QE/fgDoB0J8eEFsfJQIS5QGAOQwTQKR2EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tqrUMSwqjOKISXK/tVgyrYabZxqiJONw
	nr6kVJC4eolBvwFUttAUkx9E/W1um8dZU+9yaP3G01RmyH0ugtHmJeCOmQNe4iNK
	eK7gK7NEHmR7LPKeHiY9gP5qpeQS/H2Z2w4659ePIJRW1+pKoIpn1bcz0pSQOb9r
	UTH4bVmK7o0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA89A766;
	Mon,  7 Jan 2013 02:29:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8B6BA763; Mon,  7 Jan 2013
 02:29:04 -0500 (EST)
In-Reply-To: <FBDECCA565D94DF9838DD81FE2E2543A@black> (Jason Pyeron's message
 of "Mon, 7 Jan 2013 00:37:14 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA3E67BA-589B-11E2-AF69-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212881>

"Jason Pyeron" <jpyeron@pdinc.us> writes:

[administrivia: please never cull CC list when you respond to a
message on this list without a good reason]

>> circumvent the Cygwin API (and by extension, Cygwin project goals).
>> 
>> So, perhaps a better path forward is to disable / remove the 
>> above code by default. (Those wanting a native Win32 git 
>> should just use the native
>> Win32 git).
>
> Or a make option...

It already is a runtime option, isn't it?

I do not have much stake in this personally, but IIRC, the (l)stat
workaround was back then found to make Cygwin version from "unusably
slow" to "slow but torelable", as our POSIX-y codebase assumes that
lstat is fairly efficient, which Cygwin cannot satisify because it
has call many win32 calls to collect bits that we do not even look
at, in order to give faithful emulation.  It does place extra
maintenance burden (e.g. conditional compilation depending on the
header file the particular version of Cygwin installation the user
has at hand) on us, but as long as it works, the ugly hack is fairly
isolated and I do not see a reason to unconditionally rip it out,
especially if the reasoning behind such move is on "All programs
that run in Cygwin environment has to be POSIX only and must not use
Win32 API directly, even in a controlled way."

It is a completely different matter if the direct win32 calls we
make, bypassing (l)stat emulation, somehow change the internal state
of win32 resources Cygwin controls and violates the invariants
Cygwin API implemenation expects, breaking later calls to it.  I
do not know that is the case here, but I doubt it.
