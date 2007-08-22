From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Fix break in git-rev-list.txt
Date: Wed, 22 Aug 2007 12:58:45 +0200
Message-ID: <86fy2besyi.fsf@lola.quinscape.zz>
References: <11877706831306-git-send-email-qtonthat@gmail.com> <7vbqczkhvb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 22 12:59:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INnvX-0002rH-SZ
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 12:59:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756481AbXHVK66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 06:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755825AbXHVK66
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 06:58:58 -0400
Received: from main.gmane.org ([80.91.229.2]:42433 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbXHVK65 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 06:58:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INnvK-0006xC-Ip
	for git@vger.kernel.org; Wed, 22 Aug 2007 12:58:54 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 12:58:54 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 22 Aug 2007 12:58:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:HLyRTIZQOMTAewmBUBe1fjoF1gc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56370>

Junio C Hamano <gitster@pobox.com> writes:

> So it looks as if the only place that needs the ugly '+'
> continuation marker is between the first and the second
> paragraph.  And it also appears that the manpage backend does
> not pay attention to the paragraph break there (HTML backend
> places a <br /> before "With <em>--pretty</em>").
>
> Is it just me, or the more we look at it, everybody doubts if
> AsciiDoc was such a good choice?

I don't think you should overgeneralize right now.  Every input format
will need some massaging, possibly resulting in ugliness.

AsciiDoc _can_ be converted to plain text without markup.  Whether
this is worth doing depends on just how many people actually access
the .txt files, and how much they are disturbed by things that are
just there for leading AsciiDoc on the right path.

One can also cater for particular patterns in the configuration files
rather than in the source files.

However, there are some things which can't be ironed out: adding
useful indexing information will certainly disturb perusing the .txt
files as text.  And I consider good indexing important.

There also is the problem that AsciiDoc works with a format _chain_
that makes it painful to achieve a certain result.

However, the resulting quality of this format chain is good: proper
Docbook output, even proper Texinfo output, well-formatted manual
pages, nice-looking HTML.  In most of those areas, the Texinfo
toolchain, in contrast, falls on its face.

If one does not want to sacrifice quality, it might still make sense
to cut Asciidoc out of the equation and use Docbook instead.
Markup-free .txt-files can presumably generated from Docbook.  I think
it should also be possible to generate manpages from it, and it
converts nicely into Texinfo.

As long as we have no dedicated Asciidoc wizard working for git, this
might make changing the structure of the documentation or adding new
features much easier.

But it might frighten people from correcting the straight text of the
documentation.

It is certainly a multi-edged sword, and without doing an extensive
poll among those who contribute to documentation, a change in policy
would not appear appropriate.

I know that the combined Asciidoc/Docbook challenge has kept me up to
now from succeeding in a restructuring that would include the manual
pages in the user manual as an appendix.

I have no doubt from the Docbook and Asciidoc documentation I have
digged through that this is possible, and with not too many lines of
code, but it is still quite beyond me given the time I can spend on
it.

The question is how often Asciidoc will keep people from contributing
useful changes, and how often Docbook would.

I have no idea how the numbers would turn out.  I consider it more
likely that people will contribute text changes to Asciidoc
documentation, but structural changes are likely quite easier to do
with Docbook.

-- 
David Kastrup
