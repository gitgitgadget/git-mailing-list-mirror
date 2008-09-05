From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
 backward compatibility.
Date: Fri, 05 Sep 2008 00:29:51 -0700
Message-ID: <7v3akfxd74.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
 <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
 <20080904123046.GX10544@machine.or.cz>
 <7v63pb3emm.fsf@gitster.siamese.dyndns.org> <vpqaben6r3n.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 05 09:32:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbVmn-000679-6K
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 09:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbYIEHaE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008 03:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbYIEHaE
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 03:30:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37043 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbYIEHaB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008 03:30:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3FE95CB86;
	Fri,  5 Sep 2008 03:29:57 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A8F135CB85; Fri,  5 Sep 2008 03:29:53 -0400 (EDT)
In-Reply-To: <vpqaben6r3n.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 05 Sep 2008 08:31:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71073FE0-7B1C-11DD-A8B8-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94999>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
> Hm, right. Someone used to "$scm annotate" will probably try
> "git=C2=A0an<TAB>" and not finding anything there would be misleading
> (probably why svn has "annotate" as an alias for "blame").
>
>> Mentioning that we support both names for findability in both annota=
te and
>> blame manual pages (not just annotate page) might be a better thing =
to do.
>
> git-blame.txt already somehow has it in the documentation for "-c". I
> can't think of a good wording to improve it.

When somebody is reading git-blame.txt (or git-annotate.txt) for the fi=
rst
time, I think the message we would like to send is:

 (1) Here is why you would want to use this command, what it can do
     (perhaps more than what you would have expected from "$scm blame")=
,
     and how you tell it to do what it does.

     This is obvious.

 (2) You might have heard of the command with the other name.  There is=
 no
     difference between the two, except they differ in their default
     output formats.  For historical reasons, we will continue supporti=
ng
     both.

     This is essential to squelch noises about "git has both?  how are
     they different?"

 (3) We tend to encourage blame over annotate for new scripts and new
     people, but there is no reason to choose one over the other.

     This is not as important as (2), but would be useful to squelch
     noises about "when will we start deprecating this?"

The mention of "annotate" in the description of "-c" hints almost nothi=
ng
in (2) except that the output format might be different (otherwise we
would not have "-c" command to begin with), but I guess that's Ok.  As
long as we describe (2) on git-annotate page clearly enough, people who
are really curious could refer to git-annotate page.

So based on your wording, how about doing it like this?  I chose to onl=
y
hint (3) subtly in this version instead of being overly explicit.

diff --git c/Documentation/git-annotate.txt w/Documentation/git-annotat=
e.txt
index 8b6b56a..78dc5e2 100644
--- c/Documentation/git-annotate.txt
+++ w/Documentation/git-annotate.txt
@@ -14,6 +14,11 @@ DESCRIPTION
 Annotates each line in the given file with information from the commit
 which introduced the line. Optionally annotate from a given revision.
=20
+The only difference from this command and linkgit:git-blame[1] is that
+they use slightly different output formats, and this command exists on=
ly
+for backward compatibility to support existing scripts, and provide mo=
re
+familiar command name for people coming from other SCM systems.
+
 OPTIONS
 -------
 include::blame-options.txt[]
