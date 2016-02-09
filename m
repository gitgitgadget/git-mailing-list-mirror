From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1] travis-ci: override CFLAGS properly, add -Wdeclaration-after-statement
Date: Tue, 09 Feb 2016 10:42:42 -0800
Message-ID: <xmqq4mdh4tel.fsf@gitster.mtv.corp.google.com>
References: <1454921958-53129-1-git-send-email-larsxschneider@gmail.com>
	<20160208122551.GD24217@sigill.intra.peff.net>
	<9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git Users <git@vger.kernel.org>,
	linux.mdb@gmail.com, Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:42:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTDFR-0004NY-NO
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 19:42:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754046AbcBISmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 13:42:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:65202 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751802AbcBISmp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 13:42:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D48A418FF;
	Tue,  9 Feb 2016 13:42:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=v+UTKAsQtKzLE5I709fkYIQft0M=; b=v10QHm
	VGCMxodxCCnzPEG86gLM0Zvj7nnEb7evedfO8JHtnT/v7SCPoMqdS71Wfu5yeLNp
	4ssbyKqsWv7fO4mbgD0Lnp5DXtLfm35mRIFKzX1zn3vDKw47dlBLXag5NRHgyqUB
	7jVKV6QiHHxs30xd1/s4pd+s9u2nDDTCeQ1x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=viCmGXdB/8nNZ1dH5DrIjh2miPq7d1SZ
	WCjrpcJ7qqsl9YZE19bdJj8AJj66InwkfX3lNLjatPlZeqaASx8Y23W5P3PlHz/0
	O+Ol0gILagz/TKI7TMCGrJ3K4NjOqbngxDEpxbUwiw7Y0KnCQAMO/AYNzPF7CZ+q
	pmlJg1pCSAs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04E2D418FE;
	Tue,  9 Feb 2016 13:42:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 707AC418FD;
	Tue,  9 Feb 2016 13:42:43 -0500 (EST)
In-Reply-To: <9FBB5AFB-D44C-43A1-A0C5-A5A45675A122@gmail.com> (Lars
	Schneider's message of "Tue, 9 Feb 2016 11:06:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E7AC3C3A-CF5C-11E5-B60D-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285849>

Lars Schneider <larsxschneider@gmail.com> writes:

> Jeff Merkey made me aware of http://kernelnewbies.org/FirstKernelPatch [2]
> where I found checkpatch.pl [3]. Would it make sense to check all commits
> that are not in next/master/maint with this script on Travis-CI?

That does not help very much.  These changes are already shown to
people and dirtied their eyes, and most likely I've already have
wasted time tweaking the glitches out locally.  The damage has
already been done.

It would make a lot of sense if the checkpatch is called inside
Roberto Tyley's "pull-request-to-patch-submission" thing, though.
