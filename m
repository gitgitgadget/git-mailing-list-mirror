From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Version 1.8.1 does not compile on Cygwin 1.7.14
Date: Sun, 06 Jan 2013 11:54:58 -0800
Message-ID: <7vfw2enl2l.fsf@alter.siamese.dyndns.org>
References: <2491041.bQ51Qu8HcA@thunderbird> <1890551.8jTmplCF6O@thunderbird>
 <BB541ECCD3F04E479F06CA491DDB598D@black> <50E92675.4010907@web.de>
 <20130106093211.GB10956@elie.Belkin> <50E946EB.1000709@web.de>
 <20130106095757.GC10956@elie.Belkin> <50E9647F.4090209@gmail.com>
 <20130106120917.GC22081@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gershau?= =?utf-8?Q?sen?= 
	<tboegi@web.de>, Stephen & Linda Smith <ischis2@cox.net>,
	Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
	Eric Blake <eblake@redhat.com>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 20:55:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrwJi-0004Oj-BK
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 20:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752453Ab3AFTzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 14:55:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57124 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751242Ab3AFTzD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 14:55:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A294BA2F6;
	Sun,  6 Jan 2013 14:55:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W3GaoCYOV0/rIrFsC4mryTC/Aio=; b=A4uIiN
	DUDrplQZWiA51h/D2pWyDLuevlNT0gaDRsljxig7RI0/yIdymZLhBsJrtdQ2Q+R6
	jMnRWpUWoMHbu8EClnYdpMzkxzdo6YoSvahaHQ4N3UD04XLUnnCel9/U2NcmMV95
	p65niPCYKbu2VyHxJaVgd+Ul3oZTrz7cYvxdk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=la8LANx3zsMaYfwDxL1CqIsEcwYndx7R
	+eAWzeeO7ZviE++U9mL7XktqdE/yllahya9Oc7PeCndWh0t6weGr6gKq3UBbJmyu
	NLEoW//rT8piYGaqE5KMkW/Z9lTkHJNEinxKBu8ew3jFPMb8Ofgl94WHpq2EzgBx
	M2O4JAVh+yE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9402FA2F5;
	Sun,  6 Jan 2013 14:55:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C841A2F4; Sun,  6 Jan 2013
 14:55:00 -0500 (EST)
In-Reply-To: <20130106120917.GC22081@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 6 Jan 2013 04:09:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4AC83FA-583A-11E2-ACA8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212834>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Mark Levedahl wrote:
>
>>                                                          However, the newer
>> win32api is provided only for the current cygwin release series, which can
>> be reliably identified by having dll version 1.7.x, while the older frozen
>> releases (dll versions 1.6.x from redhat, 1.5.x open source) still have the
>> older api as no updates are being made for the legacy version(s).
>
> Ah.  That makes sense, thanks.
>
> (For the future, if we wanted to diagnose an out-of-date win32api and
> print a helpful message, I guess cygcheck would be the command to use.)

Hmph, so we might see somebody who cares about Cygwin to come up
with a solution based on cygcheck (not on uname) to update this
part, perhaps on top of Peff's "split default settings based on
uname into separate file" patch?

If I understood what Mark and Torsten wrote correctly, you will have
the new win32api if you install 1.7.17 (or newer) from scratch, but
if you are on older 1.7.x then you can update the win32api part as a
package update (as opposed to the whole-system upgrade).  A test
based on "uname -r" cannot notice that an older 1.7.x (say 1.7.14)
installation has a newer win32api because the user updated it from
the package (hence the user should not define CYGWIN_V15_WIN32API).

Am I on the same page as you guys, or am I still behind?

In the meantime, perhaps we would need something like this?


diff --git a/Makefile b/Makefile
index 8e225ca..b45b06d 100644
--- a/Makefile
+++ b/Makefile
@@ -281,6 +281,9 @@ all::
 #
 # Define NO_REGEX if you have no or inferior regex support in your C library.
 #
+# Define CYGWIN_V15_WIN32API if your Cygwin uses win32api dll older than
+# 1.7.x (this typically is true on Cygwin older than 1.7.17)
+#
 # Define HAVE_DEV_TTY if your system can open /dev/tty to interact with the
 # user.
 #
