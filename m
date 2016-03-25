From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/GSoC] add a add.patch config variable
Date: Thu, 24 Mar 2016 23:30:54 -0700
Message-ID: <xmqqio0b5ash.fsf@gitster.mtv.corp.google.com>
References: <1458853787-29807-1-git-send-email-d.f.fischer@web.de>
	<1458853787-29807-2-git-send-email-d.f.fischer@web.de>
	<xmqqvb4b7eu9.fsf@gitster.mtv.corp.google.com>
	<56F489C3.9050400@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Dominik Fischer <d.f.fischer@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 25 07:31:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajLGw-0003lu-T9
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 07:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbcCYGa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 02:30:58 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751809AbcCYGa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 02:30:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B270A49552;
	Fri, 25 Mar 2016 02:30:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6K+q7WWp42vs+sDMDF0N1Hz7Rz4=; b=fP+mOH
	5oKgmRSRoBmtHw32AEMEOuF5GNloX397v8T2o1/1MixE4rHSOyqKuWFFN01pajb0
	uEbIyM22yY1j3tWal/DyHk+iPw/QkbU1iAvukFpCy4EK/96Iwqk7t5sKPZDFCUzn
	72K1V+lOkQCfSEih1Hqrq4yjjjUxWTqrUv7+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iQGfC0zSdLrf/lrhLI2b9XUyvQ9S5nUB
	15hXc2P2r0BKo0RZbGoEREE7gIqrEGMxkdiWPdbbKMUOyoWWidA9JVe2XfcLoc2o
	ejEfG/rIwdlOzZl17j3EB3Do7MO7r7tioUzVUQptC2fyVLy7Qs8UomcFQNKcozeG
	CegwQReqOVg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AB38D49551;
	Fri, 25 Mar 2016 02:30:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2DA8B49550;
	Fri, 25 Mar 2016 02:30:56 -0400 (EDT)
In-Reply-To: <56F489C3.9050400@web.de> (Dominik Fischer's message of "Fri, 25
	Mar 2016 01:43:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21720C38-F253-11E5-B706-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289854>

Dominik Fischer <d.f.fischer@web.de> writes:

> As the configuration variable can be overwritten by a command line
> option, I am tempted to amend this by replacing all occurrences of
> "git add" in other scripts with "git add --no-patch" to ensure the
> expected behavior.

Don't even think about it--you won't know all scripts you have to
fix like that, as a lot more invocations of "git add" appear in end
user's scripts that we have never seen.
