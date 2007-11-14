From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH v3] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 20:00:45 +0100
Message-ID: <622166FD-0727-47D4-B26C-8A01788FD1EA@wincent.com>
References: <56A87A65-3C2E-4E10-84D4-4470879EE466@wincent.com> <Pine.LNX.4.64.0711141717570.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 20:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsNUd-0000PG-0R
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 20:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762931AbXKNTAw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 14:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761445AbXKNTAw
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 14:00:52 -0500
Received: from wincent.com ([72.3.236.74]:37888 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760042AbXKNTAv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 14:00:51 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAEJ0kot029861;
	Wed, 14 Nov 2007 13:00:47 -0600
In-Reply-To: <Pine.LNX.4.64.0711141717570.4362@racer.site>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64997>

Help new contributors by providing some advice about line-wrapping; the
advice basically boils down to "use 80 columns minus some slop as a
rule of thumb", but also "use common sense", and "avoid gratuitous
rewrapping".

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

El 14/11/2007, a las 18:19, Johannes Schindelin escribi=F3:

> On Wed, 14 Nov 2007, Wincent Colaiuta wrote:
>
>> Help new contributors by providing some advice about line-wrapping; =
=20
>> the
>> advice basically boils down to "use 80-characters minus some slop =20
>> as a
>> rule of thumb", but also "use common sense", and "avoid gratuitous
>> rewrapping".
>
> We already have this:
>
> - We try to keep to at most 80 characters per line.

Ah, didn't see that. It's in the "C programs" section and I was trying =
=20
to provide a guideline that applied to all source types (given that =20
this all started with a doc patch to an AsciiDoc source file).

> Besides, is it really necessary to be as explicit as you word it?  =20
> IOW is
> this patch needed?

I was basically just trying to help new people from making the same =20
mistake that I did; ie. not knowing if there was an official limit, =20
looking at the maximum line length in a file, making sure my patch =20
didn't exceed that length (and re-wrapping to avoid exceeding it), and =
=20
then getting reprimanded for gratuitous re-wrapping.

As for the explicitness, I was just paraphrasing the guidelines as =20
Junio expressed them.

> Because if we go down that road, we might very well end up with a
> CodingGuidelines document that is larger than git's source code.

134 lines down (the current length of CodingGuidelines with that =20
patch), about 100,000 lines to go (the rest of the codebase). So if we =
=20
try very hard, we could indeed get there.

Here follows a revised patch which is more concise, and keeps all =20
wrapping references at a single place. I lose your "at most 80 =20
characters" in favor of Junio's "80-characters minus some slop", and =20
in fact state "80 columns" rather than "80 characters", because that's =
=20
what we're really talking about, isn't it?

Cheers,
Wincent

  Documentation/CodingGuidelines |   13 +++++++++++--
  1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/=20
CodingGuidelines
index 3b042db..d2d1f32 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -58,8 +58,6 @@ For C programs:
   - We use tabs to indent, and interpret tabs as taking up to
     8 spaces.

- - We try to keep to at most 80 characters per line.
-
   - When declaring pointers, the star sides with the variable
     name, i.e. "char *string", not "char* string" or
     "char * string".  This makes it easier to understand code
@@ -110,3 +108,14 @@ For C programs:
     used in the git core command set (unless your command is clearly
     separate from it, such as an importer to convert random-scm-X
     repositories to git).
+
+Line wrapping:
+
+ - We generally try to keep scripts, C source files and AsciiDoc
+   documentation within the range of "80 columns minus some slop"
+   to accommodate diff change marks [-+ ] and quoting ">> " in
+   emails.
+
+ - When submitting patches use common sense to decide whether to
+   rewrap (or reindent), avoiding gratuitous changes.
+
--=20
1.5.3.5
