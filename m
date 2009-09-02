From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Tue, 01 Sep 2009 17:18:40 -0700
Message-ID: <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
References: <20090901145213.GB4194@debian.b2j>
 <200909012213.54611.j6t@kdbg.org> <7vy6oy9z9r.fsf@alter.siamese.dyndns.org>
 <200909012325.45739.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Sep 02 02:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MidZ6-0002A9-QH
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 02:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbZIBASx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 20:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755273AbZIBASx
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 20:18:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbZIBASx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 20:18:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6828E405CD;
	Tue,  1 Sep 2009 20:18:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=swPormEp/3lhAqgGKf63jv8Jf0Q=; b=vnMXGsO+RktZ+tJlvI0paGt
	WbPHVrnxjwhXX8o/IcnxP90Pohz3UQuqt3zG6j30UPWukVnDlcRGvb2NSGh+VVo3
	YOLLpP/R5407LhLSAV83TdXP67Q2zG6SFhU8USvVCxhSfDFog4547CweqtvCidqG
	cRXU0EwKwYgO+o0fY/Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=di3kC0riV+bzty/oi/hTx5NUKgG9mKdFOuJQ495VctJytKNoQ
	IOAE0Pu0SCwmgl97YGRFXiHhcBOdLGxD96Jaw7tgW4tZgxbIInWbIpp9OdL/Hhd9
	J9PRlFdh3cTuGD/25FXUUchQBuB6QbZcZ52JGMx4qCK+B1oIE49rmzudOY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E5E1405CA;
	Tue,  1 Sep 2009 20:18:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7F597405C8; Tue,  1 Sep 2009
 20:18:44 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2FC1DF20-9756-11DE-81DC-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127570>

Johannes Sixt <j6t@kdbg.org> writes:

> The list of unmerged files is considered rather important because after
> a conflicted merge they need attention. Since the output of git status does
> not go through the pager, the end of the output remains immediately visible
> in the terminal window. By placing unmerge entries at the end of the list,
> the user can see them immediately.
>
> Moreover, keeping the unmerge entries at the top is inconvenient if a merge
> touched many files, but only a few conflicted: After the conflicts were
> resolved, the user will conduct a 'git add' command. In order to do that
> with copy-and-paste, the user must scroll the terminal window up, and must
> do so for each individual entry (because terminal windows commonly scroll
> down automatically on the paste operation to make the cursor visible).
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>

> On Dienstag, 1. September 2009, Junio C Hamano wrote:
>
>> I actually was expecting that you would move this at the very bottom after
>> untracked list for the above reason, and also because this part is only
>> shown while running status (that was a good point you made in the previous
>> message) and never in commit.
>
> So you would not mind a more "drastic" change?

Well, it's not really about what _I_ like or mind.  It is primarily about
what the list collectively thinks.  I'd like to let other eyeballs and
brains to weigh in, as I am known to pick the worst layout from the UI
point of view as you saw in this thread already ;-).

> (Originally I didn't dare to change too much and thought keeping staged
> files together would make sense.)

Yes, unmerged ones are modified and the index knows about them, but you
haven't told git what you want to commit yet, so they are in the same
category as "changed but not updated" in that sense, but unlike "changed
but not updated", you cannot leave them as they are before proceeding, so
they are worse.

The "keeping related things together" argument does mean your v1 is better
than this patch, as you had "unmerged" next to "changed but not updated".
I personally think the "keep related things together" argument makes much
more sense than the "close to the bottom is easier to cut and paste"
argument, as I tend to focus at the top of the output when looking at the
status output and almost never cut & paste using mouse (screen for
rectangular cutting and pasting works wonderfully), but it probably is
just me.  And remember that I am only just one of the users, nothing more.

Sadly, "keep related things together" and "as close to the bottom as
possible" are not quite compatible, and we can pick one or the other, but
not both.

If I were to pick the middle ground, I would probably move it immediately
after the call to wt_status_print_changed(), with "keeping related things
together" as the primary justification.  It would be an incidental benefit
that it moves the part slightly closer to the bottom and gives it a better
chance of staying on the screen.

But I am not a great UI designer ;-)
