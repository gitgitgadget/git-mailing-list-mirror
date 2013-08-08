From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Thu, 08 Aug 2013 10:23:57 -0700
Message-ID: <7vwqnw9jv6.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com>
	<52027B17.7040602@googlemail.com>
	<7vtxj1crv6.fsf@alter.siamese.dyndns.org>
	<CALkWK0kTfQYZG8R1EMuV37pdJ-aj9btXmfJ1Fb4QoMeZ1QucAw@mail.gmail.com>
	<vpqfvukdy39.fsf@anie.imag.fr>
	<CALkWK0kD=adWKVf+zb+Pnjz-HBkhks8ZvmQ3eYSpdXvahr=e4g@mail.gmail.com>
	<vpqvc3gcijh.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Aug 08 19:24:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7TwX-0001rO-OC
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 19:24:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965980Ab3HHRYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 13:24:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46363 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965977Ab3HHRYB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 13:24:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9DE137527;
	Thu,  8 Aug 2013 17:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FEj3cwRg/J+4vx/gPhP+rKgagSQ=; b=Lqnclk
	JyGyBOONZFWf2dNxMgerGK3AanpVf61if8Fepn9ZyMYv/acJq1GtiQ8ENbiA41An
	mW0dZHkL8S98H2TgiP9MIi56bzB6oUPQlHZx3Gm9f4Hur3375GTphU2PwgkrD5ZS
	QNfl+nIWICahL0lym6Ez4ELLSmyJW56SHBJKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RS1tVm0OyvGQgpT28bjIsJXg8gAxx8qf
	t3iig+Es4ySK5Lii4FiJqukG1DEEs6nKFxZt0St6pKCFR4D65QDU+uBeEjMhRm/v
	du1Ib1d7dLybNEsPRUIWJchcQyLctI3lq1BXJDeLv+k+jeMJOXSl2VMrLAQFSt5M
	zjcnDPDJtUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8BA337526;
	Thu,  8 Aug 2013 17:24:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0FB2237513;
	Thu,  8 Aug 2013 17:23:58 +0000 (UTC)
In-Reply-To: <vpqvc3gcijh.fsf@anie.imag.fr> (Matthieu Moy's message of "Thu,
	08 Aug 2013 17:24:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4FB27266-004F-11E3-8372-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231905>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I'd say either this, or add the missing features to "git log" to make my
> suggestion possible (after all, if some people like "git whatchanged",
> then maybe the feature would be of interest to "git log" users ?).

There is no _missing feature_ per se.  whatchanged by default (1) gives
diffs, (2) does not show empty commits, and (3) uses raw format for
its diff output.

I am fuzzy about where the name of the command and its default
behaviour came from (I suspect it may have been modelled after
another SCM kernel folks were familiar with), but I do not mind if
somebody does an archaeology (read: ask Linus) and reduce the
document to something like this:

git-whatchanged(1)
==================

NAME
----
git-whatchanged - Show logs with difference each commit introduces


SYNOPSIS
--------
[verse]
'git whatchanged' <option>...

DESCRIPTION
-----------

Shows commit logs and diff output each commit introduces.  This is
essentially the same as linkgit:git-log[1] run with different
defaults.

The command name and behaviour were originally borrowed from XXXX
and the command is kept primarily for historical reasons (fingers of
many people who learned Git by reading Linux kernel mailing list are
trained to type it before `git log` was invented).

New users are encouraged to use linkgit:git-log[1] instead.


Examples
--------
`git whatchanged -p v2.6.12.. include/scsi drivers/scsi`::

	Show as patches the commits since version 'v2.6.12' that changed
	any file in the include/scsi or drivers/scsi subdirectories

`git whatchanged --since="2 weeks ago" -- gitk`::

	Show the changes during the last two weeks to the file 'gitk'.
	The "--" is necessary to avoid confusion with the *branch* named
	'gitk'

GIT
---
Part of the linkgit:git[1] suite
