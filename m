From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 19:32:32 -0000
Organization: OPDS
Message-ID: <E4A75513C64F43B5A03A05B043426F55@PhilipOakley>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com> <CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: "Stefan Beller" <sbeller@google.com>,
	"Thomas Schneider" <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 20:32:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ2ed-0004bl-HI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:32:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbbCTTcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Mar 2015 15:32:14 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:9309 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750990AbbCTTcN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2015 15:32:13 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2C3CgB+dAxVPAu8BlxcgwZSWoMOhBqvRI9JHQqFbwEDAQGBNU0BAQEBAQEGAQEBATggG4QPBQEBAQEDCAEBGQ8BBRYIAQEWCwsCAwUCAQMOBwMCAgUhAgIUAQQIEAIGBwMUBgEHCwgCAQIDAQMJBId6AxUJsVGGU44nDYVCIIEhigCCRoFLZIJvL4EWBZBPYYMNhDOBTYEaOoVPhl+GJoIkHIFQPjEBgQGBQQEBAQ
X-IPAS-Result: A2C3CgB+dAxVPAu8BlxcgwZSWoMOhBqvRI9JHQqFbwEDAQGBNU0BAQEBAQEGAQEBATggG4QPBQEBAQEDCAEBGQ8BBRYIAQEWCwsCAwUCAQMOBwMCAgUhAgIUAQQIEAIGBwMUBgEHCwgCAQIDAQMJBId6AxUJsVGGU44nDYVCIIEhigCCRoFLZIJvL4EWBZBPYYMNhDOBTYEaOoVPhl+GJoIkHIFQPjEBgQGBQQEBAQ
X-IronPort-AV: E=Sophos;i="5.11,438,1422921600"; 
   d="scan'208";a="545826870"
Received: from host-92-6-188-11.as43234.net (HELO PhilipOakley) ([92.6.188.11])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 20 Mar 2015 19:32:11 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265955>

=46rom: "Stefan Beller" <sbeller@google.com>
> On Fri, Mar 20, 2015 at 4:23 AM, Thomas Schneider <thosch97@gmail.com=
>=20
> wrote:
>> Signed-off-by: Thomas Schneider <thosch97@gmail.com>
>> ---
>> dblatex does print some warnings, but they seem to be irrelevant.
>> Besides, first patch I submit to git or even to any project using a
>> mailing list =E2=80=A6 let=E2=80=99s hope I did everything right :)
>
> Welcome to the git community!
>
> The patch itself applies cleanly and the generated pdfs look
> really great, though how would I read man pages in pdf
> format? I tried searching the web and all I can find is how
> to convert the a man page to pdf. So is there a conveniant
> way to tell `man` to prefer opening pdfs when available?

My remembering of the help code (from when I added help's ability to=20
list the guides), there isn't currently a mechanism to fire up a pdf=20
reader of whatever hue. The MsysGit version encodes --web (html) as it'=
s=20
preferred reader.

So if anyone wants to have a go it shouldn't be that hard to add a --pd=
f=20
option ;-)

>>
>>  Documentation/Makefile | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/Makefile b/Documentation/Makefile
>> index 3e39e28..158cbd9 100644
>> --- a/Documentation/Makefile
>> +++ b/Documentation/Makefile
>> @@ -38,6 +38,7 @@ MAN7_TXT +=3D gitworkflows.txt
>>  MAN_TXT =3D $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
>>  MAN_XML =3D $(patsubst %.txt,%.xml,$(MAN_TXT))
>>  MAN_HTML =3D $(patsubst %.txt,%.html,$(MAN_TXT))
>> +MAN_PDF =3D $(patsubst %.txt,%.pdf,$(MAN_TXT))
>>
>>  OBSOLETE_HTML +=3D everyday.html
>>  OBSOLETE_HTML +=3D git-remote-helpers.html
>> @@ -223,7 +224,7 @@ man7: $(DOC_MAN7)
>>
>>  info: git.info gitman.info
>>
>> -pdf: user-manual.pdf
>> +pdf: user-manual.pdf $(MAN_PDF)
>>
>>  install: install-man
>>
>> @@ -248,6 +249,7 @@ install-info: info
>>  install-pdf: pdf
>>         $(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir)
>>         $(INSTALL) -m 644 user-manual.pdf $(DESTDIR)$(pdfdir)
>> +       $(INSTALL) -m 644 $(MAN_PDF) $(DESTDIR)$(pdfdir)
>>
>>  install-html: html
>>         '$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
>> @@ -328,6 +330,11 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
>>         $(QUIET_XMLTO)$(RM) $@ && \
>>         $(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
>>
>> +%.pdf: %.xml
>> +       $(QUIET_DBLATEX)$(RM) $@+ $@ && \
>> +       $(DBLATEX) -o $@+ -p=20
>> $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.xsl -s=20
>> $(ASCIIDOC_DBLATEX_DIR)/asciidoc-dblatex.sty $< && \
>> +       mv $@+ $@
>> +
>>  %.xml : %.txt asciidoc.conf
>>         $(QUIET_ASCIIDOC)$(RM) $@+ $@ && \
>>         $(TXT_TO_XML) -d manpage -o $@+ $< && \
>> --
>> 2.1.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
