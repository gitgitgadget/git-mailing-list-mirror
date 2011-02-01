From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Features from GitSurvey 2010
Date: Tue, 01 Feb 2011 13:27:27 -0800
Message-ID: <7vy65zzbr4.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com>
 <20110129231310.GA11088@burratino> <201102011451.17456.jnareb@gmail.com>
 <AANLkTinPAL2rEUMe-tRGFxSQ0-gfAJvSO7WW+f+2Fd2u@mail.gmail.com>
 <AANLkTi=oTL2_ObcyKRb7bf7ZMPZoa1BU7uNH5pJRQtVC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:27:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNlR-000526-W5
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab1BAV1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:27:46 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51255 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab1BAV1p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:27:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7CE57459D;
	Tue,  1 Feb 2011 16:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=64Fz/4XlVbXEfbCwur47mm3pMME=; b=DyUZJT
	RyNkJiT99spqjrBW9paC9KiE7BcS0/RuRjW+XG06AkLHYUFPKdiSmNlUAHSwic25
	dxQUv6a4npnBOS8zlA7nN+4P+UhYKH56Rdhx9GL2s65lcaT8/yzl0R2voHJy9uJn
	QeEfxp3Icz4BrBn9auZp3HS0t3rjR67/akSTI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=whq+LtFlOPt+uGxZDpHNwKyc31UrHzRW
	JGha/gY8lDfNY7zAfCAS3uGwssdpd6MjFrY5y9oUTAlN+Z8Dz6qglNcICMPOsNtk
	tiW0CXlQZaEDnwpBFgF72QFnhDJPairtlbVr/2RCVqCXrT8cWWwVD6adPU57KFry
	8Kqjy9xPubo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C0D84598;
	Tue,  1 Feb 2011 16:28:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5F6EC4586; Tue,  1 Feb 2011
 16:28:21 -0500 (EST)
In-Reply-To: <AANLkTi=oTL2_ObcyKRb7bf7ZMPZoa1BU7uNH5pJRQtVC@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Wed\, 2 Feb 2011 00\:05\:55 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 36127060-2E4A-11E0-97B6-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165858>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Tue, Feb 1, 2011 at 11:27 PM, Shawn Pearce <spearce@spearce.org> wrote:
> ...
>> I think Junio has already started thinking about this one.
>
> I need to get nd/pathspec right and implement negative pathspecs
> before returning to this feature.

I don't think we need negative pathspecs before going forward.

I wanted a unified "We have a path; is it inside this set of pathspecs?"
(and its sibling, "We have a leading path and a name_entry taken from that
tree; is it inside this set of pathspecs?"), and with that we can run:

	$ git clone git://k.org/pub/scm/git/git.git -- Documentation '*.sh'

that would limit the clone (not just checkout) to the given parts of the
tree.  By recording the pathspecs in the repository (and initially making
it frozen---we can design extending the scope in later rounds), we can
limit "fsck", "unpack-trees", "log", etc. all using the unified pathspec
API.

We may later want to add negative or imaginary pathspecs to the mix, but
as long as the unified pathspec API understands that, the narrow-clone
part should be able to be unaware of that.

So I think that is (or at least _should be_ if the pathspec API is done
right) pretty much orthogonal.
