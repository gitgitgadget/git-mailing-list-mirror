From: Ted Zlatanov <tzz@lifelogs.com>
Subject: CodingGuidelines Perl amendment (was: [PATCH 1/3] Add contrib/credentials/netrc with GPG support)
Date: Wed, 06 Feb 2013 10:10:08 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <871ucto4vj.fsf_-_@lifelogs.com>
References: <2f93ce7b6b5d3f6c6d1b99958330601a5560d4ba.1359486391.git.mina86@mina86.com>
	<7vvcafojf4.fsf@alter.siamese.dyndns.org>
	<20130130074306.GA17868@sigill.intra.peff.net>
	<7v7gmumzo6.fsf@alter.siamese.dyndns.org>
	<87pq0l5qbc.fsf@lifelogs.com>
	<20130131193844.GA14460@sigill.intra.peff.net>
	<87k3qrx712.fsf@lifelogs.com>
	<20130203194148.GA26318@sigill.intra.peff.net>
	<87sj5cvxnf.fsf_-_@lifelogs.com>
	<7vk3qo2dsc.fsf@alter.siamese.dyndns.org>
	<87k3qoudxp.fsf@lifelogs.com>
	<7vvca7291z.fsf@alter.siamese.dyndns.org>
	<87lib3uats.fsf@lifelogs.com>
	<7v7gmn1xqi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 16:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U36du-0004F0-W7
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 16:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754869Ab3BFPKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 10:10:12 -0500
Received: from z.lifelogs.com ([173.255.230.239]:50678 "EHLO z.lifelogs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754496Ab3BFPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 10:10:10 -0500
Received: from heechee (c-65-96-148-157.hsd1.ma.comcast.net [65.96.148.157])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: tzz)
	by z.lifelogs.com (Postfix) with ESMTPSA id 8B053DE0E3;
	Wed,  6 Feb 2013 15:10:09 +0000 (UTC)
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
In-Reply-To: <7v7gmn1xqi.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 04 Feb 2013 15:10:45 -0800")
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.3.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215586>

On Mon, 04 Feb 2013 15:10:45 -0800 Junio C Hamano <gitster@pobox.com> wrote: 

JCH> Ted Zlatanov <tzz@lifelogs.com> writes:
JCH> I thought that we tend to avoid Emacs/Vim formatting cruft left in
JCH> the file.  Do we have any in existing file outside contrib/?
>> 
>> No, but it's a nice way to express the settings so no one is guessing
>> what the project prefers.  At least for me it's not an issue anymore,
>> since I understand your criteria better now, so let me know if you want
>> me to express it in the CodingGuidelines, in a dir-locals.el file, or
>> somewhere else.

JCH> Historically we treated this from CodingGuidelines a sufficient
JCH> clue:

JCH>     As for more concrete guidelines, just imitate the existing code
JCH>     (this is a good guideline, no matter which project you are
JCH>     contributing to). It is always preferable to match the _local_
JCH>     convention. New code added to git suite is expected to match
JCH>     the overall style of existing code. Modifications to existing
JCH>     code is expected to match the style the surrounding code already
JCH>     uses (even if it doesn't match the overall style of existing code).

JCH> but over time people wanted more specific guidelines and added
JCH> language specific style guides there.  We have sections that cover
JCH> C, shell and Python, and I do not think adding Perl would not hurt.

The following is how I have interpreted the Perl guidelines.  I hope
it's OK to include Emacs-specific settings; they make it much easier to
reindent code to be acceptable.

I will submit as a patch if you think this is reasonable at all.

The org-mode markers around the code are just a suggestion.

For Perl 5 programs:

 - Most of the C guidelines above apply.

 - We try to support Perl 5.8 and later ("use Perl 5.008").

 - use strict and use warnings are strongly preferred.

 - As in C (see above), we avoid using braces unnecessarily (but Perl
   forces braces around if/unless/else/foreach blocks, so this is not
   always possible).

 - Don't abuse statement modifiers (unless $youmust).

 - We try to avoid assignments inside if().

 - Learn and use Git.pm if you need that functionality.

 - For Emacs, it's useful to put the following in
   GIT_CHECKOUT/.dir-locals.el, assuming you use cperl-mode:

#+begin_src lisp
((nil . ((indent-tabs-mode . t)
              (tab-width . 8)
              (fill-column . 80)))
 (cperl-mode . ((cperl-indent-level . 8)
                (cperl-extra-newline-before-brace . nil)
                (cperl-merge-trailing-else . t))))
#+end_src
