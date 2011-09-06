From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] push: old receive-pack does not understand --quiet
Date: Tue, 06 Sep 2011 11:01:44 -0700
Message-ID: <7vty8p8s8n.fsf@alter.siamese.dyndns.org>
References: <20110903105723.GA16304@tin.tmux.org>
 <1315067656-2846-1-git-send-email-drizzd@aon.at>
 <1315067656-2846-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, tobiasu@tmux.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 06 20:01:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0zy4-0003c6-E8
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 20:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab1IFSBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 14:01:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585Ab1IFSBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 14:01:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C97E54C3;
	Tue,  6 Sep 2011 14:01:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+/ZI+xO6gjxuaWdL1IJRST4ShNg=; b=l7wB0L
	1V+unKnZw810pdAKsJhsfiMDDhnIoJHjk01kgbm4tJGR+E/xnRadcvzlsJJ2GPxd
	pJk3ui0XZSoGDrAalZEfiuxMu4Rq3wEDYQkx9wkDIHrmHehppylJ65MIdeslNJv9
	3WEZ+i9uhE1GFMIbksJqN96jo5p2N9+DnzUqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rh0KPTsUjDuer5baP9atnu9IjJIl/hYi
	qojHofkqRYhZzqA9e8Bk8oTjE3Xdo3UK+TsbsOfje5SvnzG2paU0l2xOMnJW/VRX
	jAl+lE7junVZUKJ+k7OlCHb9h9Eh47EFJbqWyKMeippXV/YDmvgv1YuiAMJHa+eG
	/S/+4YgEIJU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9433E54C2;
	Tue,  6 Sep 2011 14:01:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F46554BE; Tue,  6 Sep 2011
 14:01:46 -0400 (EDT)
In-Reply-To: <1315067656-2846-4-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Sat, 3 Sep 2011 18:34:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 490658EA-D8B2-11E0-B991-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180820>

Clemens Buchacher <drizzd@aon.at> writes:

> Commit 90a6c7d4 (propagate --quiet to send-pack/receive-pack)
> introduced the --quiet option to receive-pack and made send-pack
> pass that option. Older versions of receive-pack do not recognize
> the option, however, and terminate immediately.
>
> This change restores backwards compatibility by adding a 'quiet'
> capability to receive-pack.

Wouldn't this mean that there is no point in adding --quiet command line
option to the receive-pack command? IOW, shouldn't parts of 90a6c7d
(propagate --quiet to send-pack/receive-pack, 2011-07-30) be reverted?

At this late stage in the release cycle, I would rather prefer to revert
the whole commit and leave anything new for the next cycle.
