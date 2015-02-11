From: Junio C Hamano <gitster@pobox.com>
Subject: [poll] does anybody depend on RelNotes being a symbolic link?
Date: Wed, 11 Feb 2015 14:23:55 -0800
Message-ID: <xmqqegpwt7d0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 11 23:24:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLfhW-0004MV-3J
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 23:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754697AbbBKWX7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 17:23:59 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754670AbbBKWX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2015 17:23:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EED4D3811D;
	Wed, 11 Feb 2015 17:23:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=v
	Asno/l0NY9gKFaAhxbA/a7twnI=; b=bzZ6pv7NfOilnRPs3GE8M6zgc1T8DgwTr
	cNXUwobYIrWX4Oclfbubmm8m9ePnnnUWusDEbBDWxo5yP31s2fDSlcXu1vTqcVtm
	EBE+yVPv9UXNb27hBaqucTV/IbsA4ChhpoH5XGbMMFcxNw/gScbq59hKO1p7udRK
	AhztN400nE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Abd
	3t0YHFfegcXqsJv1cIwQYl9jeDR7XMtm0JlN8vGdv1PX26JE+1ZhYnrh79+znsZV
	SIQLP+Rbzh71/xK2bcf78a6bUZgYbtcUmhR11bPH+756+WDr85KJ3svjeISprePN
	K68E4vIOhQ2Acxn3DYsZvALfbJ7RLvLhNcLTnHzY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5E1B3811C;
	Wed, 11 Feb 2015 17:23:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 552B33811B;
	Wed, 11 Feb 2015 17:23:57 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AB883166-B23C-11E4-8B27-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263697>

I am wondering if I can turn the top-level RelNotes symbolic link
into a regular file.

The benefit for doing that is that I can start the file like so:

    Git ???? Release Notes
    ======================

    Updates since v2.3

early in the cycle and then later decide if we want to make the next
one 3.0 or 2.4.  And then just after the release, I move it down to
Documentation/RelNotes/3.0.0.txt (or 2.4.0.txt) and start the next
cycle.

One thing that worries me is that people and their build scripts
might depend on being able to figure out the upcoming release name
by reading the symbolic link, assuming that the link would point to
Documentation/RelNotes/x.y.z.txt, and such a change ends up breaking
their setup.  I am not sure how likely this would be.  Objections?

Also any other objections, other possible cause of breakages I may
have missed?
