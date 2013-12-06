From: Junio C Hamano <gitster@pobox.com>
Subject: Next cycle may be for 1.9 ...
Date: Thu, 05 Dec 2013 16:06:47 -0800
Message-ID: <xmqqr49q3krs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 06 01:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Voiwa-0005SZ-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 01:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756403Ab3LFAGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 19:06:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752963Ab3LFAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 19:06:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A2F558771;
	Thu,  5 Dec 2013 19:06:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=d
	j5hIfyu6pytsd/Db39FKOqr+Os=; b=WBIqDCQmhc6SDK/64OW6Q88hRrXuWcYy3
	XZ4dgWrrAjI9vTkIgpDMIplBap3ZBz22qusnuq87jI0dQafDNQqqBUR7wIY79Zv3
	z2WKWnVBMus+gQavjUDAbCZDU8/e5UXC9FDVDDM9aGiDFGXxEUg/BhN3vFp8qHIk
	H2aMo1O17s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=MVw
	Ay4ZNv6dVoU4UX7pagwKOVnQLplgsjJ7MGJw0yxM+bZEjgnK6LbmOF5YuU1lM0vY
	P7SkjyloBcGl7P0S6ww2U6rfA8K+lq1d53OSDS1uXrRhae8lKxSNl3hDjjFaE2Dj
	F0vJqwkPMpMyEDRn1AoqKmGJKDjQW+jNGNydlPCw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BA5158770;
	Thu,  5 Dec 2013 19:06:51 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 640BA5876F;
	Thu,  5 Dec 2013 19:06:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4E18A5D8-5E0A-11E3-A729-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238919>

... instead of 1.8.6 (which would have been the name if we were on
auto-pilot), so that the version that comes after it will logically
be 2.0.  Distro people may want to make sure that they are not
hardcoding "three-dewey-decimal are feature releases,
four-dewey-decimal are maintenance releases" heuristics in their
build system.

I haven't rewound 'next', but plan to drop three topics when I do
so:

 * aa/transport-non-positive-depth-only
  + transport: catch non positive --depth option value

 My understanding is that Duy sent out a replacement ($gmane/238841)
 for this one.

* cc/remote-remove-redundant-postfixcmp
 + Rename suffixcmp() to has_suffix() and invert its result
 + builtin/remote: remove postfixcmp() and use suffixcmp() instead

 This is superseded by cc/starts-n-ends-with topic.

* th/reflog-annotated-tag (2013-10-28)
 + reflog: handle lightweight and annotated tags equally

 This needs to be reworked, as it is incomplete and merely sweeping
 the real problem (i.e. there is no code to handle the case) under
 the rug.

Also, contrary to what I said earlier, I am tempted to include the
removal of the ancient deprecated commands in the next release.

* jk/remove-deprecated
 + stop installing git-tar-tree link
 + peek-remote: remove deprecated alias of ls-remote
 + lost-found: remove deprecated command
 + tar-tree: remove deprecated command
 + repo-config: remove deprecated alias for "git config"

Thanks.
