From: Junio C Hamano <gitster@pobox.com>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Wed, 29 Aug 2012 10:50:19 -0700
Message-ID: <7vd329wpt0.fsf@alter.siamese.dyndns.org>
References: <503E3CFE.1080603@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Emmanuel Michon <emmanuel_michon@sigmadesigns.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 19:50:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6mPN-0001pH-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 19:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077Ab2H2RuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Aug 2012 13:50:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49757 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912Ab2H2RuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Aug 2012 13:50:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0803F9142;
	Wed, 29 Aug 2012 13:50:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=uw4Zmp0hIWJk
	cMR8k3K7Hs5mC2Y=; b=cqRhxAqi8KZcT9qUfLDXbL7lUFJ9MMnc5ZbzdcGxyr6A
	RveMOGqRIShZOU1AgIm8KSB1M5jSRpp0j+W0q2R3UkiDqw4futvT4J95OGNMopGu
	Y/c3YEx/1PSCtYzObL0g9euqivTppJufg5k7RvTjWfK+D9ybYl988kjUC/T7ZjI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KIxYLb
	h4RKUjQpLunk2l5aiWKQGUZd39s4dlXUQ5IxPrT/n01qLVSFztMC69ZHnj3bmIy7
	UjqDeLL1vXFLunqvWZigGf9d51ifDRYwmL83DXOyxx0oMui/Sn189/rK7B+Kwxwo
	DofaC1D4X1QagJb8suP5sGAheZTthXsptdbvA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E706E9141;
	Wed, 29 Aug 2012 13:50:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66098913E; Wed, 29 Aug 2012
 13:50:21 -0400 (EDT)
In-Reply-To: <503E3CFE.1080603@sigmadesigns.com> (Emmanuel Michon's message
 of "Wed, 29 Aug 2012 18:02:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 00BFE370-F202-11E1-8567-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204490>

Emmanuel Michon <emmanuel_michon@sigmadesigns.com> writes:

> I believe UNIX recommends some rules in the =C2=ABless is more=C2=BB =
spirit when
> designing command line applications [basically listed here:
> http://en.wikipedia.org/wiki/Unix_philosophy].

That is exactly why our plumbing layer of commands (e.g. "git
diff-tree", "git rev-list") do not page by default for people who
want to go bare-metal Unix philosophy.

In other words, Porcelain (roughly speaking, those that page by
default when their standard output is terminal), are not "command
line applications"; they have a layer on top with a built-in UI.

If you follow Unix philosophy and want to combine tools each of
which is designed to do one thing and one thing well, you would be
using the commands from the plumbing layer to write your scripts,
and wouldn't have to raise that "minor concern" in the first place,
as they do not page by default ;-).
