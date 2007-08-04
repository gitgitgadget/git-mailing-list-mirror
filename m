From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [ANNOUNCE] GIT 1.5.3-rc4
Date: Sat, 4 Aug 2007 04:48:56 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200708040448.56611.ismail@pardus.org.tr>
References: <7vzm18jg7p.fsf@assigned-by-dhcp.cox.net> <200708040341.36147.ismail@pardus.org.tr> <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Is9sGrKGhYR2LXg"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 03:48:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH8kz-00049p-Rm
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 03:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758811AbXHDBs0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 21:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756985AbXHDBs0
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 21:48:26 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:53736 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752018AbXHDBsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 21:48:25 -0400
Received: from ninjamobile.local (unknown [85.96.18.47])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 04F9460B5808;
	Sat,  4 Aug 2007 04:48:23 +0300 (EEST)
User-Agent: KMail/1.9.7
In-Reply-To: <7vsl70jdcr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54785>

--Boundary-00=_Is9sGrKGhYR2LXg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 04 August 2007 04:30:12 Junio C Hamano wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > Can't build manpages, same error as ...
>
> Sigh...
>
> The asciidoc toolchain used by us (either AsciiDoc 7 nor 8) does
> not seem to work well with docbook-xsl 1.72 and 1.73, it seems.
>
> If you can investigate where the breakage is to come up with
> patches to make it format with newer docbook-xsl, without
> breaking 1.71 (which k.org uses to make the preformatted
> documentation in html and man branches), it would be very much
> welcomed and appreciated.
>
> I however have a slight suspition that the patch might end up to
> be against either asciidoc or docbook-xsl package, not our
> documentation...

Attached patch from Fedora against docbook-xsl 1.73 fixes the issue.

Regards,
ismail

=2D-=20
Perfect is the enemy of good

--Boundary-00=_Is9sGrKGhYR2LXg
Content-Type: text/x-diff;
  charset="utf-8";
  name="docbook-xsl-manpages-charmap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="docbook-xsl-manpages-charmap.patch"

--- docbook-xsl-1.73.0/manpages/docbook.xsl.manpages-charmap	2007-07-23 16:24:23.000000000 +0100
+++ docbook-xsl-1.73.0/manpages/docbook.xsl	2007-07-23 16:25:16.000000000 +0100
@@ -37,6 +37,7 @@
   <xsl:include href="lists.xsl"/>
   <xsl:include href="endnotes.xsl"/>
   <xsl:include href="table.xsl"/>
+  <xsl:include href="../common/charmap.xsl"/>
 
   <!-- * we rename the following just to avoid using params with "man" -->
   <!-- * prefixes in the table.xsl stylesheet (because that stylesheet -->

--Boundary-00=_Is9sGrKGhYR2LXg--
