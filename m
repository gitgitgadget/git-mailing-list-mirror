From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] push: change `simple` to accommodate triangular workflows
Date: Mon, 24 Jun 2013 00:59:52 -0700
Message-ID: <7vppvcc51j.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-4-git-send-email-gitster@pobox.com>
	<CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:00:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1gt-0000MS-IS
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912Ab3FXH74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:59:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51492 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752647Ab3FXH7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:59:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7819527805;
	Mon, 24 Jun 2013 07:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gbl6Rf7obcUd3VFLgkVna89337A=; b=PM6eZO
	v1iVerK7NfpA6YWe8ndOp2H9UVdMOq+3Fd5bHv0NP6dOVZtjiZpk1ziB8WWlCGSf
	RXsha0LdWck96Ar+RjWc1V79cAvN652/EFTu7qt9OVfJdvTVDg2SFemK/hogBpO6
	21dOVfaMfOcbiBuvqAqV2EO0sb5oNTRBzQFkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O9V1DxCWXzKx5tT1sD4MB9rldKxVn/Rx
	wKADYcQBibHN56HqPL7Q4pt8vBAGfVbavYG4Tke3H+qS9HzKThrFEb81PV3rIAUS
	r6OYjVbThzkGUJZ1uihS3S6g+oX29sn46+HU+OQTsJxoHDu9M3plGuhgVmRZXHI5
	SNJl4A9EBIk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BFB727804;
	Mon, 24 Jun 2013 07:59:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DFF22277FF;
	Mon, 24 Jun 2013 07:59:53 +0000 (UTC)
In-Reply-To: <CALKQrgfAT9GhD-_tZHr9wRA6R6g7ttDWTsmUQXdWUhG-gwNBqQ@mail.gmail.com>
	(Johan Herland's message of "Mon, 24 Jun 2013 08:58:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0DD3A1EA-DCA4-11E2-948B-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228791>

Johan Herland <johan@herland.net> writes:

>> An earlier round of this change by mistake broke the safety for
>> "simple" mode we have had since day 1 of that mode to make sure that
>> the branch in the repository we update is set to be the one we fetch
>> and integrate with, but it has been fixed.
>
> Shouldn't there be an acompanying test to demonstrate this mistake being fixed?

An operation that has to expect failure due to safety was disabled
by the broken version.  The squashed end result reverts that change
to the test, to make sure we did not break the safety.
