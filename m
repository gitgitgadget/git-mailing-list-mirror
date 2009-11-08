From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [gitweb feature request] Release snapshots with vX.X.X tags
Date: Sun, 08 Nov 2009 10:53:22 -0800
Message-ID: <7vbpjcetlp.fsf@alter.siamese.dyndns.org>
References: <1257680442.14087.78.camel@owl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Bram Neijt <bneijt@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 08 19:53:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7CtO-0007Mp-4L
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 19:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754923AbZKHSx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2009 13:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZKHSx0
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 13:53:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754841AbZKHSxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 13:53:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 55C1897AA7;
	Sun,  8 Nov 2009 13:53:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+pyjD0IoSSVGYu7o0CHDDYqsPnc=; b=Dln21w
	ekGYTq/+yVSEgR0CPNJlSDVBGUM9UUNTNsx/IeMLqY07AtMIppKF4JZKvv8kSfqP
	ZN3ZKTvZX/d6jgJC6OgcQpDqYlQjnJQmo0lEsSsNdOu8Z2Vz3Y92URSBCNRFUf1y
	Qrl2MCa5mkpz3lBiZ2UuN5V9t2oiprC6a2o+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qD97QMrkH4/VQUNQXrmphXRy7xQgFHC3
	x8MhMcsAV6vozG1frUmeqayLEqycIvmBWxzRBqYx0MK5CIlkSQVNTNb2hDElJDFQ
	AyNQNewwjjR6EL+HWHvVsdrbMTETQGGCvclFpf8cSrqtutccxBHDGJ+yNHKQhl5q
	qTbLFVmlgFk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37AF397AA6;
	Sun,  8 Nov 2009 13:53:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D8EE897AA4; Sun,  8 Nov 2009
 13:53:24 -0500 (EST)
In-Reply-To: <1257680442.14087.78.camel@owl> (Bram Neijt's message of "Sun\,
 08 Nov 2009 12\:40\:42 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 006AAAAA-CC98-11DE-A512-D595BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132410>

Bram Neijt <bneijt@gmail.com> writes:

> I would like to create release snapshots with a git tag like "v0.0.1".
> For proper Debian packaging, a release snapshot of tag "v0.0.1" would
> have to be named "project-0.0.1.tar.gz" and contain a single directory
> with "project-0.0.1/" in the archive.

What the intended audience of this feature?  IOW,

 - who are going to "click" such a link on gitweb to obtain
   project-0.0.1.tar.gz with project-0.0.1/?

 - how are they going to use that tarball?

I somehow suspect that they won't be the official Debian distro packagers.

Most likely they actually have a clone of the upstream project (how else
they can stay up to date?  In addition they would want to track their own
changes), so it would be more efficient for them to generate such a
tarball from a tag, and more importantly, doing it locally means that they
can they can verify the tag (and the whole history leading to it) before
doing so, instead of relying on somebody else's gitweb.

You could be a mere Debian user who produces a *.deb for his own use out
of such tarball, and in such a case you are a lot less likely be tracking
the project (meaning, reading the history and keeping track of fixed bugs,
new regressions and such) than just getting a snapshot that happens to be
there and building it blindly, and I can understand it would be nicer if
you did not have to unpack, rename and regenerate an archive.

Also, whose gitweb installations are you envisioning to enable this new
feature?  Are you going to convince all the gitweb administrators of
projects packaged by Debian (and derivatives) that have gitweb, and what
are the incentive for these upstream projects to do so?  I would guess
that most of the upstream projects do not consider Debian as their sole
target distribution, and it would be a tough sell if changing the snapshot
name to suit Debian breaks some other distro's (or human users) needs.

Jakub is polishing Mark's patch to change the snapshot name and contents
hierarchy, but I think it won't satisfy Debian's naming guideline (it will
have v0.0.1, not 0.0.1 in the name).  Changing the series's default to
drop 'v' from the beginning of the tagname when the rest of it consists of
all digits and dots would not be a correct solution, as Debian is not the
only system in the world and other people may want different naming rules.

In order to make his series useful for your objective, it probably would
require a bit more customizability, but because I cannot tell whom such a
feature is really trying to help, and what the deployment plans are, I
cannot judge if extra complexity to add such a customizability is worth
it.  Also because there will be conflicts in the desired archive format
("Distro X people want this kind of archive, distro Y people want this
different kind"), the choice somehow how to come from whoever is clicking
the link, not from the gitweb administrator, and it probably would mean
the codepath involved would need a lot more careful audit than just a
server only "this gitweb installation would use this format"
configuration.
