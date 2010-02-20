From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: Fix indentation problem in
 git-commit(1)
Date: Fri, 19 Feb 2010 21:28:38 -0800
Message-ID: <7vr5og4gs9.fsf@alter.siamese.dyndns.org>
References: <201002151008.31980.trast@student.ethz.ch>
 <1266237186-8065-1-git-send-email-jacob.helwig@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jacob Helwig <jacob.helwig@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 06:29:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nihti-0006ra-MQ
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 06:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111Ab0BTF2x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 00:28:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41675 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab0BTF2w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 00:28:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E99C89BCB5;
	Sat, 20 Feb 2010 00:28:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=jm67lAVsWltyOgNo8HfIuvbgV7w=; b=ci5pbMMkX3bE4p2DvigATRO
	+dbg2oBaok6BYoOHqQ4CKusVhN6gDuwfb91FTUDaNqaryxMfavhdy8BDWcxFOlRf
	pP8VLD06L39GMBtSKJ6nuO1ITnq28xFk7yD1dygd96MgOGAc7nsCB4sawlUMK1Yy
	MRLh+AvrlsnkF5YPIcd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IOjpVJAHgvbnpr81HsIPDODmRrMREtNRrM2pjQXMDBIbfUw4V
	JaqsRpKK2boeNmffklFGhbfUMyvV9lnI75fUPFZutUvXmXfpMM7as5+1miCxLoO5
	miF7pkWoItMcW6WJ6j+xgpNrL6nT+Bcskq441nXsyfvqZN+o/UmXrHdT2o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF7489BCB3;
	Sat, 20 Feb 2010 00:28:45 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B2D629BCB2; Sat, 20 Feb
 2010 00:28:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D0C521DC-1DE0-11DF-B166-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140514>

Jacob Helwig <jacob.helwig@gmail.com> writes:

> Ever since the "See linkgit:git-config[1]..." paragraph was added to the
> description for --untracked-files (d6293d1), the paragraphs for the
> following options were indented at the same level as the "See
> linkgit:git-config[1]" paragraph.  This problem showed up in the
> manpages, but not in the HTML documentation.

I've never noticed it myself, but options after -u do align incorrectly in
the manpage rendered on FC11 (asciidoc 8.2.5, xmoto 0.0.22) or on FreeBSD8
(asciidoc 8.4.5, xmlto 0.0.21) without your patch, and your patch seems to
fix it on both of them.

Your patch does not make any difference in my primary environment (Debian
5 with asciidoc 8.2.7, xmlto 0.0.20), by the way.  The options have the
same indentation level, with or without your patch.  Your patch does not
make things worse, so that is Ok.

The "See git-config(1)" paragraph itself is indented too deeply, to align
the last bullet item (all). which does look wrong.  This is true on all
machines I tried, and your patch does not improve nor worsen this.

When output on Debian 5 (but not FC11 nor FBSD) is rendered to ps/pdf, the
bullets alone align with '-u', which is also wrong.  Your patch does not
improve nor worsen this.
