From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] am: preliminary support for hg patches
Date: Tue, 30 Aug 2011 10:02:15 -0700
Message-ID: <7vwrdu3ka0.fsf@alter.siamese.dyndns.org>
References: <1314636247-26125-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1314636247-26125-2-git-send-email-giuseppe.bilotta@gmail.com>
 <7v62lg6tr3.fsf@alter.siamese.dyndns.org>
 <CAOxFTcyqGCB3TcS2CmFuVXqrCP2H-1aBDv3JJVKrNp-Q8Zahmg@mail.gmail.com>
 <7vd3fo53oe.fsf@alter.siamese.dyndns.org>
 <CAOxFTczyNtyLWyXppj=0UW_zeD3t+rDtzt-vwqXkwvWOTdxi2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 19:02:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyRhg-0005ub-8D
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 19:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab1H3RCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 13:02:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37786 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752258Ab1H3RCS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 13:02:18 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 075D83DC2;
	Tue, 30 Aug 2011 13:02:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wCwSBHrQeE8N80un+jE2beB2CJU=; b=grPuga
	g1nZ1dY1gLLWoS633VHqvoVSPhHd0wDObxB/oBe0qaG0HAFFXSuB9b2XJr7501Bk
	G+vr0YKnSa9JAagQ6xN8CUofy2mAWglA0/c/VJBdd029mm1PEE4m+a/PXRTTkkR1
	qP8lTzwrRZib7VW+wCHpGi6OMRQ2lbHFCZm6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=geyVhlp75uAz6w3WNz05ehPbkPgyvPLg
	u+ify3F/iLUS7gU6gd0Hda15OJt8DbF5K/QXvS2guxNAH80eBA/F3Qt2s4Mk1/0Y
	+DYSUWdKIYRuaEsqr1PNEnseIUHgQfXnehG9LoXbhMpVIdAAWitQylzAdgJxmCxw
	eiiw3GKfN0A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F29C63DC1;
	Tue, 30 Aug 2011 13:02:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8330F3DC0; Tue, 30 Aug 2011
 13:02:16 -0400 (EDT)
In-Reply-To: <CAOxFTczyNtyLWyXppj=0UW_zeD3t+rDtzt-vwqXkwvWOTdxi2g@mail.gmail.com>
 (Giuseppe Bilotta's message of "Tue, 30 Aug 2011 10:28:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D073B78E-D329-11E0-831F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180417>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> ... This is
> correctly detected by -3, with
>
> Applying: Threeway test
> fatal: sha1 information is lacking or useless (dir.h).
> Repository lacks necessary blobs to fall back on 3-way merge.
> Cannot fall back to three-way merge.
> Patch failed at 0001 Threeway test
>
> The message is a bit misleading (it's not the repo lacking the blobs,
> it's the patch missing the information), but the process fails as
> expected.
>
>> What about renaming patches?
>
> They lack similarity indices, but they seem to be properly formated
> (and the simple cases I tested apply correctly).

These were exactly what I wanted to know. Thanks for experimenting.

> So I think that keeping the --git is the right choice.

Yeah, sounds like we are safe and better off keeping it.
