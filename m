From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: clean error message for --continue after
 failed exec
Date: Wed, 24 Aug 2011 11:42:27 -0700
Message-ID: <7v62lmps6k.fsf@alter.siamese.dyndns.org>
References: <vpqk4a3rkwb.fsf@bauges.imag.fr>
 <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:42:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwIPK-0004s6-RX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805Ab1HXSmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:42:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34085 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752915Ab1HXSma (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:42:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8CCA4C0A;
	Wed, 24 Aug 2011 14:42:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BlXfKj8TdMvP418qgysdS/hHfHw=; b=JGzJaq
	w1YwomFSx201e9qlGk6rLcoAW4Inyc2IY5SghFssYN53Ii1Ua+vu4XAY0zPvVPec
	8Atd1tzFprluhC95yG8341zW7Pfud6dKVeoFMTayj95xtnMbXhrU/Z7ZU7YE41yY
	MoG7NPsWEFQIks4OWl7OzWxfyMsLZz/MuQJdw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UfOD8lAx6+/0FLFSytwvbrTzBy1yGFaG
	Gs+1h2geRVnciBfY5pD2TO14o/6DBZ9mj94nLuw3sq2tcA79PzFUfXjdKwtnJAjn
	AmB2eg3sYTWvX8ieKJLHSh0MpexTYO9wXRZTYjpGgHS/9jBNENUTZvsN3xNvL7tX
	2vmqNklQ8Nw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0B694C09;
	Wed, 24 Aug 2011 14:42:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AB5E4C08; Wed, 24 Aug 2011
 14:42:29 -0400 (EDT)
In-Reply-To: <1314194508-12067-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed, 24 Aug 2011 16:01:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D1D2D7F2-CE80-11E0-85D8-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180025>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> If after a failed "exec" instruction there are staged changes,...

I have to wonder why whatever "exec" runs is mucking with the index in the
first place. Shouldn't we forbid it?
