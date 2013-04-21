From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git-log.txt: rewrite note on why "--" may be required
Date: Sun, 21 Apr 2013 00:46:50 -0700
Message-ID: <7vzjwsuxzp.fsf@alter.siamese.dyndns.org>
References: <1366458313-7186-1-git-send-email-artagnon@gmail.com>
	<1366458313-7186-5-git-send-email-artagnon@gmail.com>
	<7vtxn0wf4j.fsf@alter.siamese.dyndns.org>
	<CALkWK0nFAzPPb0_jTRev6nuicCV81sRQAbe=277nhyyY8TnQ7A@mail.gmail.com>
	<7v8v4cwd6g.fsf@alter.siamese.dyndns.org>
	<CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 09:47:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTozL-0006cj-02
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 09:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752378Ab3DUHrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 03:47:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752358Ab3DUHrA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 03:47:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D572147E0;
	Sun, 21 Apr 2013 07:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f37UCcaHMNwIgY/2d/4TELpbMTU=; b=pQMt3j
	OEUzWa8dOqHgSklGsV5SecOG2pPHo/gkiL25Ce2nauKPmgklUjL27SpyDOxoZKv6
	UrJTSmdcncFjU0yNhAzyh39uaXGR0DNZpYlJnK5MLV4uWM9NI2N8svEnCSgjDO8B
	WY/fqYwxf+FKFkYm+I4rmCLfasVyXS7XUYcZc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ypt5wOTXRl7VfVwg5SQOO2bYKZZaoCsf
	spk12JJJQ8lgHgu9NjZ9d47qMb4dOmcyMbVUWlu/LBXkarB7Ly9+NEMWMImJEcN5
	SNnm9b4XLOjdCKwsynXb0RfKizrLAXVPHXidepJYZCtVZkmQmHBWa/B5W3MZkv44
	cvu04qJfY3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44FA3147DF;
	Sun, 21 Apr 2013 07:46:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCB3E147D8;
	Sun, 21 Apr 2013 07:46:51 +0000 (UTC)
In-Reply-To: <CALkWK0kiT7vggXgqGs2iiMooiw7TyJEgr2=Yy06S7H1NKiWJ3g@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Sun, 21 Apr 2013 13:08:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A13BAEDE-AA57-11E2-8BAD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221911>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> ... and what about 'git log HEAD^!'?  Is that a range?  

Of course it _is_ a range; didn't you read it in the "specifying
ranges" section?  It is a short-hand for "include HEAD, exclude its
parents", and you can further combine it with other starting points.

> What about 'git log HEAD:README' (hint: it doesn't error out)?

Sounds like a bug, if it doesn't.

Patches welcome---I suspect that it can be solved the same way as
the recent cherry-pick patch by Miklos.

> I would argue that "A B" is not inherently a revision range, but
> rather two revisions.  It's upto different commands to interpret
> it differently.

That is why I said this is "git log", not "git show".
