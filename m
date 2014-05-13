From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Tue, 13 May 2014 16:12:56 -0700
Message-ID: <xmqqy4y5l1c7.fsf@gitster.dls.corp.google.com>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
	<xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
	<20140513230201.GA32562@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: James Denholm <nod.helm@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 01:20:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkLzb-00057l-3x
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 01:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165AbaEMXUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 19:20:11 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61560 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755111AbaEMXUI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 19:20:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4838218524;
	Tue, 13 May 2014 19:20:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=274YMNV1/QddD4NRxAxkCSmAiqo=; b=D/iV89
	EWpm+feZP2J75mD9BC8r3VfW2J27M9Srzq6l7Cs1qMqC+EPPR+QG8FsB55xO8rt6
	Az3qM6EgsEkti2Lbcgp2enPBWF8V4XhnFrLjMmuv5WW8vEeWnjRykJJDWFFZdwh8
	KxfZif3rWVwqdIMhafxeFTs+6pSiZL4jz05po=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uk5/882Tx3jilJOfTFNrliubyup5wpJG
	IC3dpNhrYrRKzI7Jp5EaZlBHrM6B4yZ8zhhNc5eld0jv8DVVhDocOk/FgAp4IoJ7
	fofJUSmB2UnzIBGcM+yk5fe2vl+q63cm6QHIlya2hJwvDoxVI0ybeQZHSiK14JN/
	W0/UeChWiF4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3DC1218523;
	Tue, 13 May 2014 19:20:07 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EC1A217FA0;
	Tue, 13 May 2014 19:12:57 -0400 (EDT)
In-Reply-To: <20140513230201.GA32562@debian> (James Denholm's message of "Tue,
	13 May 2014 23:02:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F17BE56-DAF4-11E3-B23F-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248888>

James Denholm <nod.helm@gmail.com> writes:

> I'm not sure that can actually happen - peel_committish is essentially
> implemented as `rev-parse $arg^0` (though with a bit of bling, of
> course), and to my understanding FETCH_HEAD will always parse to a
> committish - I could have missed something, of course.

 $ git fetch git://repo.or.cz/alt-git junio-gpg-pub
 $ git rev-parse FETCH_HEAD^0
