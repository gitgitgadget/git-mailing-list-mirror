From: Hannu Koivisto <azure@iki.fi>
Subject: Re: [PATCH 1/2] user-manual: Simplify the user configuration.
Date: Thu, 22 Jan 2009 20:59:32 +0200
Message-ID: <83wscndv57.fsf@kalahari.s2.org>
References: <1232561365-5919-1-git-send-email-felipe.contreras@gmail.com>
	<7v8wp4e5wn.fsf@gitster.siamese.dyndns.org>
	<94a0d4530901211319t8126611wc1437848631fe988@mail.gmail.com>
	<831vuvfh7t.fsf@kalahari.s2.org>
	<94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 20:01:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQ4nX-0003Ym-NU
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 20:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754554AbZAVS7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 13:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbZAVS7i
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 13:59:38 -0500
Received: from s2.org ([195.197.64.39]:55830 "EHLO kalahari.s2.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753557AbZAVS7i (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 13:59:38 -0500
Received: from azure by kalahari.s2.org with local (Exim 4.69)
	(envelope-from <azure@iki.fi>)
	id 1LQ4m4-0000IP-Av; Thu, 22 Jan 2009 20:59:32 +0200
In-Reply-To: <94a0d4530901220857q1027c05bs137dcc0244a1cc5a@mail.gmail.com>
	(Felipe Contreras's message of "Thu, 22 Jan 2009 18:57:23 +0200")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/22.2 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: azure@iki.fi
X-SA-Exim-Scanned: No (on kalahari.s2.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106780>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jan 22, 2009 at 6:17 PM, Hannu Koivisto <azure@iki.fi> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> This brings back my previous question: where is the home directory in
>>> a Windows system?
>>
>> It's where %HOMEDRIVE%%HOMEPATH% points to.
>
> I thought it was something like that. Do we want something like that
> in the manual, or should we assume Windows users know that?

I should have added that Unix programs (i.e. Cygwin programs and
even some native ports) probably use %HOME% which may be different
from %HOMEDRIVE%%HOMEPATH%.  I recall that if you haven't
explicitly set up HOME in Windows environment, Cygwin sets it up
magically from passwd or falls back to %HOMEDRIVE%%HOMEPATH%.  I
have no idea if msysgit respects %HOME% if it is set or always uses
%HOMEDRIVE%%HOMEPATH% or something completely different (user
profile, most likely).

It certainly may be that "home directory" is a foreign concept to
some Windows users.  Some might know it as a user profile or a
personal folder (just guessing, I'm pretty isolated from less
experienced Windows users), even though user profile is a separate
concept from "home directory" (note that there is %USERPROFILE%
which by default is the same as %HOMEDRIVE%%HOMEPATH% at least in
XP).

In any case, what Cygwin git does should be expected by Cygwin
users.  If msysgit wanted to be a really native Windows application
and store the configuration where Microsoft thinks it should be
stored, it probably shouldn't store the config under "home
directory" to begin with (I'm guessing that's what it does) but
under %USERPROFILE\Application Data\Git (...FILE\Local
Settings\... in case non-roaming storage is wanted).  And in that
case the manual might be misleading for msysgit users.  See
e.g. <http://msdn.microsoft.com/en-us/library/ms995853.aspx>.

-- 
Hannu
