From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest builtin-commit series
Date: Tue, 18 Sep 2007 15:25:35 -0700
Message-ID: <7vbqbzvcf4.fsf@gitster.siamese.dyndns.org>
References: <1190129009.23692.24.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 00:26:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXlW1-0003UF-0U
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 00:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbXIRWZo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Sep 2007 18:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbXIRWZn
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 18:25:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:37042 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750820AbXIRWZn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2007 18:25:43 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id DF995137A0E;
	Tue, 18 Sep 2007 18:25:59 -0400 (EDT)
In-Reply-To: <1190129009.23692.24.camel@hinata.boston.redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Tue, 18 Sep 2007 11:23:29 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58641>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> Better late than never:
>
>       * rebase to Pierres strbuf changes.  Note, there is still some
>         strbuf tweaking required, to let stripspace work on a strbuf.
>         Also, I changed the semantics of stripspace to always add a
>         newline if the last line doesn't have one.  I believe the
>         current odd semantics (always remove the last newline) comes
>         from not being able to easily add a newline, but now that it'=
s a
>         strbuf, that's easy.

I do not find the "remove trailing newline" so odd.  Didn't it
come because you sometimes needed to _not_ add it?

>       * Set the test suite default editor to '/bin/true' instead of '=
:'.
>         Since we're not exec'ing the editor from shell anymore, ':'
>         won't work.  Maybe we should special case ':' in launch_edito=
r
>         or perhaps make launch_editor use system(3).  Not sure.

We've had a few threads on the list about what to do with:

	GIT_EDITOR=3D'emacs -nw'

I think David's 08874658b450600e72bb7cb0d0747c1ec4b0bfe1
(git-sh-setup.sh: make GIT_EDITOR/core.editor/VISUAL/EDITOR
accept commands) is a sensible to deal with this issue, and
prefer to see the same semantics kept in the C version.
