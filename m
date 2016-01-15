From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Find main branch
Date: Fri, 15 Jan 2016 09:30:24 -0800
Message-ID: <xmqq1t9ikaxb.fsf@gitster.mtv.corp.google.com>
References: <CAPMsMoDsay7_n53HY6cxHWEtv5vyugxYUZqwi9tU4dKLv6MGBg@mail.gmail.com>
	<20160114213113.c700484c7e3acddc467d0e75@domain007.com>
	<CAPMsMoBNzmK618NPP-VXP_70hTxTsa13O9f_usiCPJ-SUOUz_g@mail.gmail.com>
	<CAGyf7-H2jSW0vJZ7ng1OcN7X5tvs+sEuGUH4yMSpJ_-wwUcoTQ@mail.gmail.com>
	<20160114211335.GB10825@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Bryan Turner <bturner@atlassian.com>,
	pedro rijo <pedrorijo91@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 15 18:30:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK8Cp-00089p-G5
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 18:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448AbcAORa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 12:30:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754422AbcAORa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 12:30:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A38039456;
	Fri, 15 Jan 2016 12:30:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Suw01vIZuJuUMegViuH/RKijyCc=; b=W/uJdu
	lwhKhxvmhER/LpuEwejqInJV5657P1KeYFh7nuRZ/R7Xp7BTyoiE8AK7NVZ4M5wv
	izD18lIQk8JZJbyNDJv8ZJYaC4okFRAhjZdm+RWCspjhZFbs168YmKyZQlxvu/+w
	YYDC7epPtgrB5tXG8Zo4/rx2xAO2pI9DZSXSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=laLuWYTB4qkkXg0r/iTE/vQ2B77P//pX
	s/9JxXxvwnaHczSAgZcbY7Rz4GKE3HLgxxiPtyIxmhRAzDtn2sNJJPv3BqGT9nGt
	aK+99BpRoNL0UwdmBqCt34IY7i2kOxmkswgfRmOeG3AWO+o+HgYhPqxFT+HfTBxi
	8/bO5UBmTms=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 532AF39455;
	Fri, 15 Jan 2016 12:30:26 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CC9D739454;
	Fri, 15 Jan 2016 12:30:25 -0500 (EST)
In-Reply-To: <20160114211335.GB10825@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 14 Jan 2016 16:13:35 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A9E15308-BBAD-11E5-B55E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284189>

Jeff King <peff@peff.net> writes:

> It would be nice if "git ls-remote" just had some way of printing the
> capabilities.

I would agree that it would be nice to give an option to ls-remote
to show which ones are symrefs pointing at what.  You are being more
ambitious than that, but I am not sure I would agree it is a good
idea.

Most normal capabilities have no value to ordinary end users, and
the symref= thing is interesting for them only because there isn't
such an option in ls-remote (hence "capabilities" thing could be
used as a poor-man's substitute).
