From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Mon, 09 Sep 2013 11:47:45 -0700
Message-ID: <xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6Vw-0005kP-Pa
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755974Ab3IISry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Sep 2013 14:47:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59053 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab3IISrv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Sep 2013 14:47:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECB97401A4;
	Mon,  9 Sep 2013 18:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RmgtGDTHTFrh5Yyg4TDrmycXUdI=; b=K92TUb
	CN5TQEDPneoVzzJ2lHNS4/91H0QjkTeVvMnkRciCpNrWOFpYTEVSF9sEkZ91DCXu
	L4HZOYuVE3kZ9206BktKz6ORZaiXij1BbewzvGdMH+v/Ej+a5uYGtqF0b3zkcPZ1
	CTfC/0ZwRqdWva6rBmNvO4FFhzx8z1lwvg8K0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z/1a8zMTvJN7HqHfFI3C9NwpAVMumbuo
	50Oo0AUX9Equb7kE+9oeBTmRvYdUQb+MKPP1DUaJnIxmmR64Jm7XrDNlf0k+T2NF
	SQ32xtSoY7XaRaGyHCU0CgUj+o1ePM66/o8GhfS0mN4wkwI7y+bwZNU47aIeKAqn
	m9tNKaKsj/Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D282A401A2;
	Mon,  9 Sep 2013 18:47:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ED07240199;
	Mon,  9 Sep 2013 18:47:47 +0000 (UTC)
In-Reply-To: <vpqr4cy4g5q.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	09 Sep 2013 09:18:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5275C1A2-1980-11E3-A7A7-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234357>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> First, the discussions on this thread show that it's hard to find the
> right behavior. My guess is that it's hard because we're trying to think
> for the users. I've used GNU Arch for a while, and this VCS was trying
> to impose what the developer thought was good for me. I had to fight
> with the tool whenever I tried to do something "non-standard". I don't
> want to go back there.

Fond memories of tla comes back to me as well ... ;-)

> Preventing _users_ to do something because _we_ considered it was
> bad for them is wrong IMHO.
> I already mentionned another reason in
> http://thread.gmane.org/gmane.comp.version-control.git/225146/focus=229162 :
> "git rebase" is hard to use for many people.
> ...
> "git pull" is one of the first things one learns with Git, and
> _requiring_ users to chose between merge and rebase is a nonsense at
> this time of learning.

After I re-read that message, I am starting to think that the topic
that has been cooking in 'next' that attempts to catch "git pull"
(no "from where, integrate with what" parameters) may already be bad
by that standard. Brian Carlson's comments on the impact on existing
users seems to the same direction to me.

You are in favor of an _option_ to allow people to forbid a pull in
a non-ff situation, and I think other people are also in
agreement. So perhaps:

 - drop jc/pull-training-wheel and revert its merge from 'next';

 - update Felipe's series with a bit of tweak to make it less
   impactful by demoting error into warning and advice.

would be a good way forward?
