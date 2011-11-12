From: Junio C Hamano <gitster@pobox.com>
Subject: Re: old git reference manuals & release notes
Date: Fri, 11 Nov 2011 23:37:45 -0800
Message-ID: <7vty69pz92.fsf@alter.siamese.dyndns.org>
References: <j9kq3r$jk9$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Neal Kreitzinger" <neal@rsss.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 08:45:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP8HM-0001ml-Aa
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 08:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171Ab1KLHht (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 02:37:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52587 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750951Ab1KLHhs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 02:37:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C871A168B;
	Sat, 12 Nov 2011 02:37:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t8t/B/PkqBbrRZ83VLRnce7RoLo=; b=w5pVsI
	Yd0FdDRyJlLibS4oTk2MKbAd58sw5cdZmDLjVWnyiLKNNJjJKgoyqdkLFgiRgjsU
	eeyFg+r2AobjewFbMgu8aKuZvmFn2Xd0IfbGffzT8XcyHHqaR//1Ti8cksuZY1nr
	07O7ke3pg+IgXMtto0Dkpx1ZW8bjOg7bQBRnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLHZ+teKyzuVp7Kd35KZQMqN0eYSbT3C
	F1W40j3URstqul4qvZctXiGrOx8P5BXBHq9+bHoxsSxOLcXIcy+GxjEd+oISielk
	bsKIs1jJYNXA27WXs3M5Luc3v92oROnugHkHpGYNhj3GT2Upif/cY6BafMolnmwj
	Bd2d4+HtI7o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C058C168A;
	Sat, 12 Nov 2011 02:37:47 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22AC01689; Sat, 12 Nov 2011
 02:37:47 -0500 (EST)
In-Reply-To: <j9kq3r$jk9$1@dough.gmane.org> (Neal Kreitzinger's message of
 "Fri, 11 Nov 2011 21:44:57 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3749A098-0D01-11E1-932C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185302>

"Neal Kreitzinger" <neal@rsss.com> writes:

> Before the git-scm.com link to the reference manual went down last month, 
> the reference manual used to list the links to the manuals for all the major 
> git versions and the release notes for all git versions.  This made it easy 
> to review release notes and manuals.  Now the link only shows the latest git 
> manual.  Is there a way I can access older manuals and release notes?

The HTML version of git documentation pages k.org used to serve were
specifically formatted to be served at that site, and sadly it is not
likely they will return anytime soon.

The k.org site kept these files under /pub/software/scm/git/docs/. The
in-development "master" version of pages were placed directly underneath
that directory, and the documentation pages for older versions were kept
in vX.Y.Z subdirectory of that directory.

The "master" version of the documents were formatted with a special macro
defined, and in that section, there were a bunch of links pointing at
vX.Y.Z/git.html. These links _knew_ about this directory layout to have
the current one at the top-level with stale ones in versioned directories.

I am not involved in the git-scm.com site that shows the documentation,
but I am guessing that it keeps an up to date copy of the preformatted
git-htmldocs repository and shows blob contents directly from the tip of
the history. The preformatted documents in git-htmldocs repository are
meant to be installed in machines of the end users, and do not expect that
end users would keep a forest of documents for all versions next to each
other. For that reason, they are not formatted with the links to older
versions.

So if you are asking for a way to access older versions without any effort
on your part, the answer is no, there is no way to do so. At least, not
that I know of.

If you are willing to do some work, you can keep a forest of documentation
pages for older versions yourself, and format the latest one with the
special macro defined to have the links that point to older versions. If
you can host that result somewhere on the net to help others, it would be
even better. I can tell you how to drive asciidoc to enable the links to
older versions if you are volunteering ;-)
