From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 27 Feb 2011 15:57:57 -0800
Message-ID: <7vmxlhm3ne.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110227084317.GB3356@sigill.intra.peff.net> <87bp1xest7.fsf@catnip.gol.com>
 <AANLkTinphmVJe8XW6BhjoyHgA38aopgEk=o=qEp4UT+4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 00:58:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtqVK-0004Hl-NO
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 00:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922Ab1B0X6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Feb 2011 18:58:18 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46983 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1B0X6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Feb 2011 18:58:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5DD0D468B;
	Sun, 27 Feb 2011 18:59:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Z9vZebeogjgXbCaG+JN9WiEKOwo=; b=Qb0v9ih2vjtmz0EcopG5tBR
	GPezdtpl1KXEhaiPS1GmWfLg3TbWL652/1fhPzixJNDSMdcp+uuwawoF7yuhRK+s
	u7R9wkyK89xR/SmPJFfqMkTCyDpdzLrGRscIA0EIovrATtdJyPKC29V5/fgvp/Gv
	oj4q3nkCNSDk0+JgaQMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=v8T70bphyzXQOfp7CpEFNX2kGkVVXE/yBbPXn/vhytjQSTGIh
	4RlduN7LsqdrL0aKwyNYUD6TP1hMKzFBJXm/J3UBonMLheLHLaDv6AwXT9Xkg4Fy
	GgYPqmY9gBA3AuIHvsA46ISq0eTPNsuBw4VxRS8wjF5yMCab0hQFM2g/qo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1AF74684;
	Sun, 27 Feb 2011 18:59:27 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 732C64676; Sun, 27 Feb 2011
 18:59:17 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9C3EAF4C-42CD-11E0-A7F1-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168062>

Jon Seymour <jon.seymour@gmail.com> writes:

> I guess the noun 'stage' does have a use in git-speak to refer to the
> different arms of an unresolved merge.

That is correct.

For some historical background around "cache" and "index", this

  http://thread.gmane.org/gmane.comp.version-control.git/780/focus=924

may shed some light.

    From: Linus Torvalds <torvalds@osdl.org>
    Subject: Re: [RFC] Possible strategy cleanup for git add/remove/diff etc.
    Date: Tue, 19 Apr 2005 18:51:06 -0700 (PDT)
    Message-ID: <Pine.LNX.4.58.0504191846290.6467@ppc970.osdl.org>

    That is indeed the whole point of the index file. In my world-view, the
    index file does _everything_. It's the staging area ("work file"), it's
    the merging area ("merge directory") and it's the cache file ("stat
    cache").

And this one:

  http://thread.gmane.org/gmane.comp.version-control.git/6670/focus=6863

is even more illuminating.

Notice that the word "staging area" is used in the old article as a way to
explain one of the three important aspects of the index, and the other
article that is about nailing down the terminology, the word does not even
come into the picture at all (one reason being that it will confuse
readers if "staging area" is used too casually in a document to precisely
define terminology, which needs to explain the merge stage(s) in the
index).
