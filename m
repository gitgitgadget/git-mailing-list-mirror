From: Wincent Colaiuta <win@wincent.com>
Subject: [PATCH v2] Add line-wrapping guidelines to the coding style documentation
Date: Wed, 14 Nov 2007 12:32:58 +0100
Message-ID: <1037166E-C1B1-43A9-9B12-5866632CADCC@wincent.com>
References: <A18FC90C-5874-445A-93CE-9E05D02C614F@wincent.com>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 14 12:33:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsGUj-0002p5-GU
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 12:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbXKNLdC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Nov 2007 06:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbXKNLdB
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 06:33:01 -0500
Received: from wincent.com ([72.3.236.74]:35340 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751092AbXKNLdB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2007 06:33:01 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAEBWxaQ010641
	for <git@vger.kernel.org>; Wed, 14 Nov 2007 05:32:59 -0600
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64981>

Help new contributors by providing some advice about line-wrapping; the
advice basically boils down to "use 80-characters minus some slop as a
rule of thumb", but also "use common sense", and "avoid gratuitous
rewrapping".

Signed-off-by: Wincent Colaiuta <win@wincent.com>
---

El 14/11/2007, a las 11:37, Junio C Hamano escribi=F3:

> Wincent Colaiuta <win@wincent.com> writes:
>
>> A statistician could probably make some interesting comments about =20
>> the
>> results, but the basic trend is that, while there are plenty of
>> examples of isolated long lines in the source tree (the longest is a
>> 287-character line in one of the perl scripts), the frequency starts
>> to drop off pretty rapidly once you pass 70 columns and start =20
>> climbing
>> towards 80.
>
> Gaah.  287???

Actually, not true. The longest line in a perl script is 209 chars =20
(217 columns if you expand the leading tab), in file git-=20
cvsexportcommit.perl.

The 287-char line was actually in builtin-update-index.c; this and =20
most of the other really huge lines are usage strings.

>> + - In the case of documentation, mixing excessively long and short
>> +   lines may make the AsciiDoc source harder to read, so try to
>> +   keep line lengths consistent.
>> +
>> + - When submitting patches use common sense to decide whether to
>> +   rewrap, avoiding gratuitous changes.
>
> Hmph.  The last item applies only to the documentation because
> it uses the word "rewrap", but otherwise applies equally well to
> the sources (re-indenting).  So probably "whether to rewrap or
> reindent" would be a good change there.

Updated patch follows.

Documentation/CodingGuidelines |   22 ++++++++++++++++++++++
1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/=20
CodingGuidelines
index 3b042db..3eecb64 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -110,3 +110,25 @@ For C programs:
    used in the git core command set (unless your command is clearly
    separate from it, such as an importer to convert random-scm-X
    repositories to git).
+
+Line wrapping:
+
+ - While there are no official hard limits for line wrapping, we
+   generally try to keep shell scripts, C source files and AsciiDoc
+   documentation within the range of "80-characters minus some
+   slop".
+
+ - We assume that everyone has terminals that are at least 80
+   columns wide.
+
+ - In practice, we try to keep lines somewhat narrower than 80
+   columns to accommodate diff change marks [-+ ] and quoting ">> "
+   in emails.
+
+ - In the case of documentation, mixing excessively long and short
+   lines may make the AsciiDoc source harder to read, so try to
+   keep line lengths consistent.
+
+ - When submitting patches use common sense to decide whether to
+   rewrap (or reindent), avoiding gratuitous changes.
+
--=20
1.5.3.5
