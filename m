From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 19 Jul 2013 09:22:43 -0700
Message-ID: <7vy592wmcs.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130718143009.GC2337@serenity.lan> <871u6v93a8.fsf@igel.home>
	<7vmwpj3g0l.fsf@alter.siamese.dyndns.org>
	<7vvc471x1s.fsf_-_@alter.siamese.dyndns.org>
	<CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:22:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DSF-00032A-BB
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760139Ab3GSQWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:22:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56906 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759422Ab3GSQWq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:22:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2B632EF4C;
	Fri, 19 Jul 2013 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jSHl7DcO2f0KWdR+lnqxoleC2X8=; b=mJg2r6
	svte/lDCMyNOZ+htS1grtj8jNa1myJX0Ss2q0iTkGibg7dKFAjOsDP5B5EyfrYvL
	q2pXmy5qNANEd4rckHGvH0Lol5nGQtnBtf7LlEvpeFZFl99IJuQda6RFUNtCvhHf
	jPlrNWnFdn7FwaGqgJhMZj7DGoURhXn+1fAcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LonZ7GxulhAXtpNDpJGzQ4GTFKcYdowy
	b6pB3O7E7C4I4Z3hiUXmcr8YIM4EWhckVdGFBONKUAgWgGj2CpAWnM3/M0s5ZOcC
	sNKGERYwiQEV6qsPthmam0l/tzZ69zrFUS9E8WEryfynQPbCZDSvrInfI1pbdXHM
	1JN8aQpePzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E06DC2EF4B;
	Fri, 19 Jul 2013 16:22:45 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2B962EF49;
	Fri, 19 Jul 2013 16:22:44 +0000 (UTC)
In-Reply-To: <CAPig+cTXn4hdKoCjnNXmybNxYt0Bt_QuxsfFxiA5b0J1FxUUmQ@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 18 Jul 2013 20:54:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7175DDAE-F08F-11E2-9E42-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230823>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +When `git pull` that does not explicitly specify what branch from
>> +which repository is to be integrated with your history on the
>> +command line, recent Git will refuse to work until you specify how
>> +that integration should happen, either with a command line option
>> +(`--merge` or `--rebase`) or a configuration variable (`pull.rebase`
>> +or `branch.<name>.rebase`, which is the same as `--merge`
>> +(`--rebase`) when set to `false` (`true`) respectively.
>
> This paragraph-long single sentence may be intimidating. Perhaps some
> simplification is possible:
>
>     As a safety measure, bare `git pull` (without repository or
>     branch) needs to be told how to integrate pulled changes with
>     your history; either via `--merge` or `--rebase`.  Also see
>     configuration variables `pull.rebase` and `branch.<name>.rebase`
>     in linkgit:git-config[1].
>
> I intentionally omitted the true/false explanation of the
> configuration variables since the user can follow the link and read
> about them. It also may make sense to drop mention of those variables
> altogether since they are already described (including link) in the
> description of --rebase.
>
> I also intentionally omitted "recent Git" since it's rather nebulous.

Looks much better than the original.  I would further suggest
dropping the "As a safety measure, bare " at the beginning.

      `git pull` (without repository or branch on the command line)
      needs to be told how to integrate the changes with your
      history via either `--merge` or `--rebase` (see configuration
      variables `pull.rebase` and `branch.<name>.rebase` in
      linkgit:git-config[1]).

perhaps?
