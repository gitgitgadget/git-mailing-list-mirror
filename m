From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/7] New remote-bzr remote helper
Date: Tue, 27 Nov 2012 18:37:33 -0800
Message-ID: <7vpq2yihaq.fsf@alter.siamese.dyndns.org>
References: <1352643598-8500-1-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s2F9C4cr6v===M3AWHieaiUk1adigcU8txpZPL0wN81Ow@mail.gmail.com>
 <7v4nkdxawx.fsf@alter.siamese.dyndns.org>
 <CAMP44s1G3b3XQX+=5Ag2exdy83hULbz1m0Z6UFDrhZU2TGwBMg@mail.gmail.com>
 <7vehjelizc.fsf@alter.siamese.dyndns.org>
 <CAMP44s0swzsg1MkQHkPUtwZi71xaad3y4uY542jYvXAf8Ha5nQ@mail.gmail.com>
 <7vsj7ujxr2.fsf@alter.siamese.dyndns.org>
 <CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 03:38:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdXXx-0004aN-H6
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 03:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab2K1Cia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 21:38:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2K1Chg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 21:37:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE53AEA5;
	Tue, 27 Nov 2012 21:37:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hGWRB6MjeSdY152eehBfxxe6mhQ=; b=tNjPQz
	Dj2WwIDSNjEmKQeFzYEOuKSaR6p/CI11IcV/7kT5veMP3jLhgMIKCouyG+sxUelL
	CeFm3tOmKTB7IMcvaTBu7iJ44NFxLC2j5iz2yR2QC5Gp+nDOQoa9NPd53YUIvkR6
	lcgNMHTAYrGbmblDwiGPh10qTluYea+1Eg/B8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z4Ir+RkFevxTr3wpEPlcqolMQh/56uKV
	Zgm9JEbu5V7wfM/XqsasShrWcJCjwR6+3Rt//xeDR3RuHZVL49EPGy2atzy3rXSf
	auj1zQdBw46AHp1Sv1YQdHMRhTvX+6EtU8rpO9HI1GEeHUvqwcWSu/X5ZgoahUtF
	5nT8fR2P708=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0920AEA4;
	Tue, 27 Nov 2012 21:37:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51E96AEA0; Tue, 27 Nov 2012
 21:37:35 -0500 (EST)
In-Reply-To: <CAMP44s3t54zYFha_qsDrg0JDZ52q8=WTs7q0rJ9qZL8kVCVWKA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 28 Nov 2012 03:18:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91365436-3904-11E2-B27B-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210677>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> At this point, both have been cooking for a week or more in 'next',
>> there is no existing users, they are on the fringe so breakages in
>> them won't negatively affect anybody anyway.  So it doesn't matter
>> much if they are merged to 'master' and then fixed up with follow up
>> patches after that, or fixed up with follow up patches while they
>> are in 'next', as they won't be rewound and restarted from scratch.
>
> The fixes are affecting some people, that's why I did them. Some were
> reported here in the mailing list, and some in my github's clone:
>
> https://github.com/felipec/git/issues?page=1&state=closed

Are you talking about -hg or -bzr or both?

In any case, I am mostly concerned about *my* next release, whose
rc0 will be tagged sometime this week or the next week.

People who have been bitten by bugs from *your* tree or versions in
'next' do not count.  When I said "no existing users", I was talking
about the end users who need rock solid stable "releases" because
tagged versions are the only ones they use.

If the code of these topics is still in flux and needs constant
fixes, probably it is a better idea to cook them longer in 'next',
skipping the upcoming 1.8.1 release.  If we are going to go that
route, we can drop the v2 fc/remote-bzr and queue v3 when we rewind
the tip of 'next' after 1.8.1 release (by that time you may have v4
of the series, but then we can skip v3).  Is that more preferrable
than rushing these topics forward before they are ready for general
audience?
