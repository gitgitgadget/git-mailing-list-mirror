From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 08 Apr 2013 07:46:12 -0700
Message-ID: <7v61zx13nv.fsf@alter.siamese.dyndns.org>
References: <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
 <20130407212342.GA19857@elie.Belkin>
 <CALkWK0=Q-P-fGLmkoiV3_CJ43MNmFzpfkvFjNUwxB+zOsqTxmg@mail.gmail.com>
 <5162763D.5030708@web.de>
 <CALkWK0m5iN8h0J1EkbMTJoXy6QHHzyTjRfPnhL3XMgi=NAi2eg@mail.gmail.com>
 <20130408083712.GE20159@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 18:33:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPEzz-0003oz-6C
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 18:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965185Ab3DHOqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 10:46:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62303 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965181Ab3DHOqP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 10:46:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD4EC139D2;
	Mon,  8 Apr 2013 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XdL3NZPxNMKb6tBc1jp0NDP38vA=; b=nEz/07
	eoo4RDSX0dPGUMiXUGHFrGDX+tJr1Ux0M/pH8+dspC/5w/Ra8HRzsUXQfkxKKzoa
	bo5kBjVWG2Egznv/nlQ01/4SKs+MCKKVNGc3Ht/tPghn8+YGd+skJCvtW6TL5HXQ
	NI4rDLBvjG+mjMlp8rE+9Yrpe0nJY6dbC5zng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OPVIq+niWtlAN8lAEGxSPMzP39/ys/k1
	E/G2K5iwmW63NDY5dZbq/IKvJU/4psAP65dLATdz1V2lJUdn8WjAko6TQondtn4J
	phpJl+DBEEOEjeHjVaSvEOpEwVT4GWt0f0v+W97DzI3xq34fx0vH0Y9sd0iz85lr
	RVwzQ1wPFYk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D41EB139D1;
	Mon,  8 Apr 2013 14:46:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32042139D0; Mon,  8 Apr
 2013 14:46:14 +0000 (UTC)
In-Reply-To: <20130408083712.GE20159@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 8 Apr 2013 01:37:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0FCDEBFC-A05B-11E2-BE0F-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220428>

Jonathan Nieder <jrnieder@gmail.com> writes:

[snipped everything I agree with...]

> On the other hand, the single .gitmodules file will be a pain to merge
> if multiple branches modify it.  So I do look forward to a merge
> strategy that deals more intelligently with its content, and wouldn't
> have minded a design that split this information into multiple files
> if we were starting over.

I find it a sensible suggestion to have a content-aware merge
driver.  Such a custom merge driver to help merging a structured
datafile in the config format will have other uses when we need to
do more than the current system (outside submodules there will be
other things "frotz" that need "information about frotz" in the
future, and a .gitfrotz file would be one possible way to do so).

I do not think it needs to be split per-submodule.

When a submodule in the common ancestor was at path dirA/, and you
are merging with another branch that moved it to path dirB/, the
contents of .gitmodules file for that module (that is identified by
its <name>) will need a three-way merge of its .path element:

    common ancestor:    submodule.<name>.path = dirA/
    ours:               submodule.<name>.path = dirA/
    theirs:             submodule.<name>.path = dirB/

And your content-aware merge driver should be able to do the
resolving by following the usual three-way merge rules.  We started
from the same dirA/ and only they changed, so the result is dirB/.

By the way, that's a "merge driver" (which deals with per-path
content merge), not a strategy (which deals with the entire tree
level merge).
