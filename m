From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --added (Re: Command-line interface thoughts)
Date: Mon, 13 Jun 2011 05:55:59 -0700
Message-ID: <7vhb7triu8.fsf@alter.siamese.dyndns.org>
References: <201106051311.00951.jnareb@gmail.com>
 <201106101844.16146.jnareb@gmail.com> <4DF25D50.5020107@ira.uka.de>
 <201106102035.42525.jnareb@gmail.com> <4DF29EA5.60502@ira.uka.de>
 <20110613034347.GA4222@elie> <buotybu2wx7.fsf@dhlpc061.dev.necel.com>
 <20110613080617.GC4570@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>, Holger Hellmuth <hellmuth@ira.uka.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 14:56:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW6gs-0005sM-AJ
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 14:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837Ab1FMM4V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 08:56:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531Ab1FMM4U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 08:56:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 57FEB5062;
	Mon, 13 Jun 2011 08:58:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ShikNGfc6D0w192nxjYxF/Q7XTM=; b=Zrbwos
	fI8OHkAU0UaFY/vsQWmJqGmV6uwz3B+MTXrVPNf7Tmv1+iRqfjEgaETWDGFMTmae
	9WmxdgkTDJeYI0KO56Woim0mnIrNraJcNxU8kK3fTWCAuPvvkgi1DdDv3N084M3J
	xCHN47yjWkUIJCokwfdUSUDiO9ELr7JmJzV9w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a40w9EIrfga7iXcISs4ICukCb+Xd88qB
	IkQSSYx1o3/sZYtMpIJfjnQFUh3kLzi6awB1JRgqjdqukvTJ5RgmhqIjLsznsxnI
	EAvv0IpxaVleJ64Z4c5+AVZCoKpEbiR7eKeHxXRZ00BDRxmAKzx6xxXUzX5fVwab
	jKiHfaojjz0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA74B5061;
	Mon, 13 Jun 2011 08:58:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 83F805058; Mon, 13 Jun 2011
 08:58:11 -0400 (EDT)
In-Reply-To: <20110613080617.GC4570@elie> (Jonathan Nieder's message of "Mon,
 13 Jun 2011 03:06:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D133A08A-95BC-11E0-9F74-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175702>

Jonathan Nieder <jrnieder@gmail.com> writes:

> -Show changes between the working tree and the index or a tree, changes
> -between the index and a tree, changes between two trees, or changes
> -between two files on disk.
> +The primary purpose of 'git diff' is to compare files in the working
> +tree to stored versions in the repository.  It can also be used to
> +show changes between the index and a tree, changes between two trees,
> +or changes between two files on disk.

I agree that it is a good idea to clarify whatever likely misunderstanding
new people might have, and I further agree that to some people the command
line syntax of diff to compare a tree with the index or with the working
tree may look like a different "modes" from the syntax to compare two
tree-ish.

I however am not sure it is a good idea to declare "comparing the index
with the working tree" is the "primary". People who are just starting out,
just downloading and sightseeing, are likely to use "git clone" followed
by "git diff v2.6.39 v3.0", I suspect, and to them, the primary use would
be to compare two revisions, no?

Instead of making them sound as if they are different "modes", I think it
may make more sense to teach them upfront that in addition to the two
"modes" they may be familiar with from their past experiences with other
SCMs, namely, comparing two revisions and comparing a revision with the
working tree, there are two extra pairs they could be comparing in git,
namely, comparing the index (the data you prepared for your next commit)
with the working tree, and comparing the index with a revision.

	Side note: note that even in the context of other SCMs, the choice
	the user makes when using "diff" is not about what two things to
	compare, i.e. "scm diff REV1 WTREE" vs "scm diff REV1 REV2". They
	choose two "modes" and then fill in the parameter(s) the chosen
	mode requires. When comparing two revs, you need two revs; when
	comparing a rev with the working tree, you need one rev, and
	worktree does not have to be specified. That way, you do not
	explicitly specify which "mode" you are using, as that can be
	inferred from the command line.

	But if we do not call these two "modes", I do not see a reason for
	us to call two extra pairs git gives them "modes" either.

Then if you feel "comparing the index with the working tree" the most
important combination, start your description from that "mode".

For the reason I stated in the other message, I think it was a wise
decision not to advertise "diff --staged" synonym when we introduced it at
2baf185 (git-diff: Add --staged as a synonym for --cached., 2008-10-29),
by the way.
