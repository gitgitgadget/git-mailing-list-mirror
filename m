From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 15:35:31 -0700
Message-ID: <7vr4tig7rg.fsf@alter.siamese.dyndns.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
 <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr> <4FD8FF25.6030908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: konglu@minatec.inpg.fr,
	Zbigniew J?drzejewski-Szmek <zbyszek@in.waw.pl>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:35:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SewA7-0007mZ-OD
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 00:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab2FMWff (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 18:35:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61440 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab2FMWfe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 18:35:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E85B88EAC;
	Wed, 13 Jun 2012 18:35:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7rVift+HnNOBbihHSdMdj+KbE28=; b=ZIH+1L
	j5Bi5942N6Oopf3h4OoTVW/K2fg8WhKOTFljiyaN2PLyjPeDJhwDu8tkFO4LY0k+
	a3LqSzZXZxsLSsCQ6ug1o+3NO5ootplrdPjUCFtv3iCX6UCke/EL5xs5tc/KzFb/
	HtVqA7Y+T+RuJSE4VgeUdeMfL9h0BjSMu7LdU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y/1XGvXM1wzd77wTZQxT3LYeSWHhtA9H
	AAwKqSjlqK2G2HpNrhkrIHDGYXssnUugXmNJIJY87lRjEiaSB8d0t+lyLAJXtQ5F
	/DzV4+DSLECWAixoG7Z/XseJEBb+tJPgTsdjMCAZppCNuzmtUmVkZ+g0ofh8fiuu
	NQcBx30/XDs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DD4958EAB;
	Wed, 13 Jun 2012 18:35:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3AF198EAA; Wed, 13 Jun 2012
 18:35:33 -0400 (EDT)
In-Reply-To: <4FD8FF25.6030908@kdbg.org> (Johannes Sixt's message of "Wed, 13
 Jun 2012 22:59:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1667984E-B5A8-11E1-ABBB-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199953>

Johannes Sixt <j6t@kdbg.org> writes:

> Not so fast.
>
> 	exec cmd1 && cmd2
> and
> 	exec cmd1
> 	exec cmd2
>
> are far from equivalent: If cmd1 fails, the first version never runs
> cmd2, but the second version runs cmd2 upon rebase --continue.

This reminds me of one thing.

For "exec" insns that are meant to validate each commit in the
resulting history, what should happen (I am not asking what the
current implementation of "rebase -i" does) after "exec cmd1" fails?

Ideally, the user will at that point fix the problem in the code,
run "commit --amend" to record the fix, and then want to make sure
it really fixed it by re-running "exec cmd1", no?

Shouldn't "rebase --continue" after such a "commit --amend" resume
execution from "exec cmd1", which failed in the initial run?

I said in the beginning 'For "exec" insns that are meant to validate',
as "exec" is not necessarily about validation, and other use cases
of it may want it run only once in the sequence, whether it succeeds
or fails.  So perhaps we would need two kinds of "exec", one that
just runs once and is not re-run even if the initial round fails,
and another (perhaps spell it "test") that runs upon "--continue"
until it passes.  The latter of course can be skipped by the user
with "rebase --skip".
