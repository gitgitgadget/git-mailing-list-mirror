From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 10:33:04 -0700
Message-ID: <7vip35jl7z.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
	<20130426101946.433f2d12@chalon.bertin.fr>
	<517A3E47.6010606@viscovery.net>
	<7v7gjpxjw0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0-C_TRC_eD_ZbN3WFe4NKWVPQVhh+ME-F5yBBwKs2NdA@mail.gmail.com>
	<7v8v45vvuy.fsf@alter.siamese.dyndns.org>
	<CALkWK0=W_FxDwc3Tby=h90yc5i8UEuT7maERahFRDQU=hQ633g@mail.gmail.com>
	<7vobcxl3ui.fsf@alter.siamese.dyndns.org>
	<CALkWK0k7w4xuewnJFNJLk730NSiZOA_1UF0_Dqcnw5Or3GYOcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Yann Dirson <dirson@bertin.fr>, Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 19:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWrwu-0004YJ-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 19:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757521Ab3D2RdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 13:33:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61613 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757181Ab3D2RdG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 13:33:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33C7D1A484;
	Mon, 29 Apr 2013 17:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cq1PNumgtu4j9L02Z2UVe4W1MV0=; b=j5AybF
	bN4wNP4RyCcEGUt1MDQ7eMg6aoRkgoM78wxaLBIfDi1S1BkTRBdJI9vXaz3cttht
	atf7tk+5oWaCqcOa4/T1GaFNZ2GlHKMj0EJ1OKk2N1An84PCre3SEOpdqURp9jLV
	rRrAvxV3jMXCohZuzcwnzGFRNu84gqQiJlAd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QiG+MX4qY37/uw1DrtmUctiXs1sBcnas
	oIbchO4hOPOwnLHRqmVavK+j06oYCwia06aIthK11ztP036NzwkBT+uk8z9drEgd
	D4SpelSPzNi9BwG7AGVKz1/nA4hHB12T3zULK7grJAUx7BUIKPg5SKSS0NE0ykib
	hoV7HZmDyg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26A941A483;
	Mon, 29 Apr 2013 17:33:06 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D2D21A481;
	Mon, 29 Apr 2013 17:33:05 +0000 (UTC)
In-Reply-To: <CALkWK0k7w4xuewnJFNJLk730NSiZOA_1UF0_Dqcnw5Or3GYOcA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 29 Apr 2013 22:44:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D9C523A6-B0F2-11E2-9ADD-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222818>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> That world view is broken, isn't it?  Perhaps you forgot to consider
>> symmetric differences, where left positives and right positives have
>> to be treated differently.
>
> No, I did consider symmetric difference.  How is git log A B --not
> $(git merge-base --all A B) different from git log B A --not $(git
> merge-base --all A B)?

Compare these (gitk will give you nicer picture):

   $ git log --oneline --graph --left-right A...B
   $ git log --oneline --graph --left-right B...A

> Um, my point was again that "ordering does not matter"; therefore for
> a third type of commit, you need a command-line parameter.
>
>>     git show A..B C..D
>
> This is seriously bad.  We'll have to think about fixing this along the way.

For the purpose of "doing one thing and well", we have drawn the
line at "we operate on at most one DAG and specify what happens to
it with various other parameters, which may include commits" long
time ago.  If you want to operate on more than one DAG, the cleanest
way is to do the set computation for A..B and C..D separately and
combine them yourself (which is the example you omitted from the
quote).

The setup_revisions() machinery that is the foundation of the
current codebase has this design decision ingrained in it.  That is
where the marking of commits with only two primary colors (i.e. the
UNINTERESTING bit) comes from, and where the "single DAG" limitation
originates.  You can extending it a little bit (e.g. by introducing
a secondary color left/right) to enrich it, but fundamentally the
infrastructure pretty much assumes we operate on one DAG and a
commit is either outside or inside (or at the boundary) of it.

It may be nice if the low-level operated on more than one DAG, but
it is very close to a proposition to throw the baby with the
bathwater and restart from scratch.  It is a lot more than a little
"as an aside" task.
