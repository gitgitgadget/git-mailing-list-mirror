From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ls-files -t broken? Or do I just not understand it?
Date: Wed, 19 Aug 2009 10:45:53 -0700
Message-ID: <7v1vn7wvce.fsf@alter.siamese.dyndns.org>
References: <20090819082423.GA18860@atjola.homenet>
 <vpqljlguqtn.fsf@bauges.imag.fr>
 <fcaeb9bf0908190204h31bc839ai39972a251040d449@mail.gmail.com>
 <20090819091445.GB18860@atjola.homenet>
 <fcaeb9bf0908190218x487dd7f4y355e411a8cb1f254@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 19:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdpEm-0005Su-8H
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 19:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbZHSRqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 13:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751882AbZHSRqG
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 13:46:06 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48939 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbZHSRqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 13:46:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E5E710471;
	Wed, 19 Aug 2009 13:46:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0avZANSRCq3gxcHYAscow9tQTZo=; b=jXllfYnZ8Vz4R+XCESZS5RH
	Mf2RJTPL72941R0AQpZLTLWKtfCfQpEyvS1WmAq+3PkeTi+E1bQSuI2NIA/n46mM
	b6ZOeUgWSwoYWXsegAsWQbLAUZ0Hp/7Z6u3Jb6SGN19jYUrdiCbsaAobyY2NXqc4
	qumMD2JaTJ7j1mK3W4Qs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IJDmCEee7pdvD8M7rPPYJXMmZihPkaWWzOI5sbeFxuZk05tNj
	XcaYUn+kHLsuKzM4GXG0uf7nz9dBZb99PZAwY6c85wpXTIkhj+CWfbeff+L2Shu8
	4CNnLej8PD3OdTZk+JIkUGADqHYZpwU1G29pNxz6iurJ8zD2Cr1OhpbPzE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 243261046D;
	Wed, 19 Aug 2009 13:46:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23C9610468; Wed, 19 Aug
 2009 13:45:55 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28B7BE0C-8CE8-11DE-95AB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126566>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It shows you whether it's a normal entry (marked as "H") or unmerged
> entry ("M") as far as I can tell. Junio may give more detail
> explanation about this command.

Sorry, I won't.  I refuse to take responsibility for some "features" in
this command ;-).

My recollection is that the "-t for quick status" were primarily added to
support a scripted Porcelain that is now defunct, while I was looking the
other way, eh, rather, back when I was not yet in control of the project.

Some of the options of this command are not useful anymore, not in the
sense that they no longer work as advertised, but more in the sense that
there are better ways to do what they were originally invented for.

For example, the options "-[mdt]" under discussion in this thread were
primarily invented as poor-mans' substitute for diff-files when the diff
infrastructure was not mature enough.  It could have been that people who
added these flags did not understand diff---I do not remember.  You would
notice the apparent inconsistency of its choice of the "status" letters,
compared with the rest of the system---it is a sign that the "-t" feature
was never taken seriously by core git developers.

So I wounld't be surprised if there were bugs lurking around "-t" family.
Patches to fix them are welcome; people's scripts depend on them.

I have to say that ls-files currently is in an unfortunate position. It is
a building block for scripts and it will be kept maintained for that
purpose.  But people still use it even from the command line.

Some options are still the only way to get certain information out of the
system, e.g. "-v" to see the assume-unchanged bit.  "-u" unfortunately is
still the quickest way to list the conflicted paths, even though the new
"git status -s" may change this situation.  "-o/-i" is the kosher way for
scripts to get the list of untracked and/or ignored paths, but some people
seem to have learned to use that from the command line.  While there is
nothing _wrong_ in doing so per-se, these days from the command line use
for human consumption I tend to think it is much handier to view output
from "git clean -n".
