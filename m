From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3]More diffs for commit/status
Date: Thu, 05 Mar 2015 11:25:48 -0800
Message-ID: <xmqqtwxz2qmb.fsf@gitster.dls.corp.google.com>
References: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
	<cover.1425564336.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 20:25:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTbPA-0006B5-Bg
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 20:25:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758222AbbCETZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 14:25:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57195 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755863AbbCETZv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 14:25:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67E7B3D485;
	Thu,  5 Mar 2015 14:25:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iv+oiSQD3vu1Jm1nXFGBR1zyMc0=; b=MAI+e3
	j14veL1gsucFb2GnRNEvR/J216pk73g3ANRdgdSR2LDBrUV+GQA1a0UyMHbqjsiA
	Bd8St+c5mzDhs0oIlAbxTXxLI9j6fIjrHHABcMay0d4Vi5W0TKyPmZQngNCM7pVI
	01rlP91FMhcFB5Qmpyj5mTGxLDVS5qhjev5y4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E2kJRhNq8yQZt0L0KE3BBcUn2LXOKmJA
	rdWXKg6Pp8gip1aBbvY8EmK1bovmrge5zt5+bS4jQCefqoEXwaVHliekZAt59iYj
	FzW3iafyVgZIwLpeagHrE0yqtObzoIE/k5AjvIyWzdP/AAhP5CVsrMiFMczk8DUj
	ePxUGM3Ahks=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5D5463D484;
	Thu,  5 Mar 2015 14:25:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2E383D47E;
	Thu,  5 Mar 2015 14:25:49 -0500 (EST)
In-Reply-To: <cover.1425564336.git.git@drmicha.warpmail.net> (Michael
	J. Gruber's message of "Thu, 5 Mar 2015 15:13:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E44C548-C36D-11E4-9898-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264862>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> v3 has the following changes:
> - new leading patch by Junio to clean up t7508 (slightly modified by myself)
> - adjust tests accordingly
> - revert back to standard c/,i/ resp. i/,w/ diff prefixes with a header line
>
> Open questionis for 3/3:
> - Do we need the header to stick out even more? (I don't think so, although
>   having the STATUS_HEADER color to be different may help.)

If we have more than one paths in each category, I would think at
least a separator line (I used -{50} in my illustration you are
replying to) before the verbal "Changes to be committed" would help.

> - Do we want the header line also for "status -v"? (I would say yes, but that
>   would be a change to current behaviour.)

I would not object to it very strongly, but I do not see a point in
changing the behaviour.

And I do not see why a new user would want it anyway.  There is no
need to differenciate the changes to be committed from the changes
left in the working tree when the latter is not even shown.
