From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag usability issue: Lightweight vs Annotated confusion for the end user (ex. git describe default)
Date: Wed, 24 Jul 2013 13:37:28 -0700
Message-ID: <7vppu766ev.fsf@alter.siamese.dyndns.org>
References: <032D5084-C70F-4F62-8F62-975ADEA56ED6@JonathonMah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: daniele.segato@gmail.com,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathon Mah <me@JonathonMah.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 22:37:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V25oe-0004i5-Ru
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 22:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163Ab3GXUhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 16:37:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751971Ab3GXUhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 16:37:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42BE133F61;
	Wed, 24 Jul 2013 20:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rInsV2P7UpHMQGAVYsEafAXWvJU=; b=C40rkl
	w6moa4SXNySbAmHwjj+YP0l+pQaS7lbgCrwE+qKYTs8hqFx1Mu25PCmVZv2t98/5
	WtU2hiZW5RD1Ue2nwetES1Pu/mrLrgmlcl24dqYmOxZ4iUhKA6nlqiWQQBZRMHeR
	yBCamaTW1owey5iXfz7qZizto/cWd7FGdeGE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s1p6pLbRTZzxNMQgvgfQrl0AhqfxcPdk
	JzN1EwGwzb3XaownFH780A/bCf4xyUjxsEjb4h6zc1N3vIX29E+VPc6mzOk6OYuV
	UT3SQOYpkxo7EgV27RmDFAqSqpXpKL2YdeCpwLfZxUHE1r0N95Jv8eUSEwZPuk7I
	tDE1UejV/QU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 37B9233F5F;
	Wed, 24 Jul 2013 20:37:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8731433F5D;
	Wed, 24 Jul 2013 20:37:38 +0000 (UTC)
In-Reply-To: <032D5084-C70F-4F62-8F62-975ADEA56ED6@JonathonMah.com> (Jonathon
	Mah's message of "Wed, 24 Jul 2013 12:09:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E141CF02-F4A0-11E2-99AC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231118>

Jonathon Mah <me@JonathonMah.com> writes:

> I always add --tags when I call git-describe. Is there any reason this shouldn't become the new default (quickly, before git 2.0 perhaps)?

The distinction is there for a reason--- annotated tags are meant
for the more "public" and "permanent" stuff, while you can do
lightweight tags for random short-term stuff.

An argument could be to change Git not to follow unannotated tags
with "git fetch" and "git push --follow-tags" by default, which goes
in the direction to make the distinction even clear.  But for a
change to make the distinction less useful, I would have to say it
is probably a bad idea.
