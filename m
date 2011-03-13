From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Sat, 12 Mar 2011 23:33:52 -0800
Message-ID: <7vd3lviie7.fsf@alter.siamese.dyndns.org>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
 <20110313030214.GB10452@sigill.intra.peff.net>
 <7vsjuril5r.fsf@alter.siamese.dyndns.org>
 <20110313064710.GA13135@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 13 08:34:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pyfoo-0001Pg-My
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 08:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295Ab1CMHeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 03:34:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55435 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab1CMHeH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 03:34:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B040123B4;
	Sun, 13 Mar 2011 03:35:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TvR9B3c1pYA/HZaYu6gfHsi7Pfo=; b=s8EEt2
	GPtvAnsI0SaM+X7GYUgiHfMuAArdWoIkcBeN79kwSNm4xbsVo4PK2wohbkbvG7b6
	jc7ZeAFsKD60XUD2oUUWswSs8tpXVdIu7XeK3Iy6G6um78AVSaGYH1WwoEP7fuL8
	2SUBGAJwIJT7W4m0poCW5JxXg6c2TjVDkBriY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lXOifi7yd4NtWDC7vKhsvEOIP3VDPGB9
	xfeoz0LPmn2Fn7VMHdCmu3r0Wg8Rk+dL0FHh96GiZBwicR+Qd40NDRKUfw24Pzph
	6dLg/s4ymZ6W5f6lxjlwIJkMf9GKNXHUTS3rjMqsmvAyT0WlZ4xLrKxpdHlaGGtn
	REqmVscI3a4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5AE3423B3;
	Sun, 13 Mar 2011 03:35:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F11C323B2; Sun, 13 Mar 2011
 03:35:25 -0400 (EDT)
In-Reply-To: <20110313064710.GA13135@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 13 Mar 2011 01:47:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7982534C-4D44-11E0-B0FB-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168963>

Jeff King <peff@peff.net> writes:

> [1] I have mixed feelings about the aggressive rebasing. Our 'master' is
> pretty stable, so I don't feel the need to build off the last tagged
> release.

In a very busy project (like the kernel), it would make sense to build off
of the last tagged release when your interaction with the upstream is
primarily based on patch exchange. But I think that is primarily because
the maintainer and the reviewer do not have to ask "where does this apply
to?  It does not apply to my tree; please resend" if you did so. Because
our "master" does not move so fast, sending a complete patch series based
on any commit that was once at the tip of "master" works similarly well,
especially because "am -3" works well in such an environment if "master"
is never rewound.

But if your interaction with the upstream is merge based, I think it is
preferrable to base your fork point as if you are the person at the
upstream. There is no "where does this apply to" at that point, and you
have a larger responsibility and say in the final shape of the history.

Namely (I know you know this, and I am writing this primarily for other
people on the list):

 - an fix would be appropriate to be made on top of the oldest maintenance
   track that contains the commit that introduced a bug (or even directly
   on the buggy commit itself), as long as merging up from maint-O to
   maint-N (O < N) to master is simple enough;

 - For enhancement patches that do not deserve to be backported to
   maintenance branches, "master" is a good place to start.

For this topic, you could have said that this is a documentation bug fix
and started the topic at the tip of maint, given that this is a fairly
low-risk change, and that we haven't added any new file between maint and
master that requires an evil merge to fix up.  Or you can say that this is
very minor and not worth fixing in maintenance track to fork from master.

> Git-cherry sort of does this, but patch-ids miss a lot of cases: patches
> tweaked in transit, patches applied on a different commit, or even
> patches taken partially or split up. So I rebase frequently, and as
> patches get picked up in master, the branches dwindle to empty.
> Suggestions welcome if anybody else has figured out something clever.

A solution to string different iterations of the same patch together,
perhaps using notes as the storage media, that makes it easier to view the
changes between different iterations?  I think Shawn does something like
that in Gerrit code review.

When I rebase, I tend to keep the base stable (in other words, I don't use
"rebase" in order to change the base, but to rewrite individual patches),
too keep comparison between iterations simpler, but I haven't found a
satisfactory solution for such a comparison for changes near the tip of
longer series.
