From: Pierre Habouzit <madcoder@debian.org>
Subject: Bring parse_options to the shell
Date: Fri,  2 Nov 2007 16:09:18 +0100
Message-ID: <1194016162-23599-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com, torvalds@linux-foundation.org
X-From: git-owner@vger.kernel.org Fri Nov 02 16:09:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iny9Z-0004YH-9P
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 16:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754226AbXKBPJ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 11:09:26 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754163AbXKBPJ0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 11:09:26 -0400
Received: from pan.madism.org ([88.191.52.104]:50884 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754217AbXKBPJZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 11:09:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8495F28147;
	Fri,  2 Nov 2007 16:09:23 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7C71F347A4B; Fri,  2 Nov 2007 16:09:22 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1458.g2aa13-dirty
In-Reply-To: alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org
References: alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63127>

This is also something that itches me, so here is a proposal for a
git-parseopt helper that can be used in shell scripts as an option
normalizer like getopt(1) does.

I migrated the discussed git-clean.sh to use it as a proof of concept.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@d=
ebian.org
OOO                                                http://www.madism.or=
g
