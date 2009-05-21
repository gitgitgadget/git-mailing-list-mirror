From: Tony Finch <dot@dotat.at>
Subject: Re: git archive, cygwin, and --git-dir vs --remote
Date: Thu, 21 May 2009 14:32:25 +0100
Message-ID: <alpine.LSU.2.00.0905211431060.23478@hermes-2.csi.cam.ac.uk>
References: <e664dae0905180737mae29811ie4cae889b3e3904f@mail.gmail.com> <4A151A15.6040609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1870870024-690524581-1242912745=:23478"
Cc: Bob Kagy <bobkagy@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu May 21 15:32:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M78O1-0005lF-F9
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 15:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054AbZEUNcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 09:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752958AbZEUNcY
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 09:32:24 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:56720 "EHLO
	ppsw-1.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbZEUNcY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 09:32:24 -0400
X-Cam-AntiVirus: no malware found
X-Cam-SpamDetails: not scanned
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Received: from hermes-2.csi.cam.ac.uk ([131.111.8.54]:39891)
	by ppsw-1.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.151]:25)
	with esmtpa (EXTERNAL:fanf2) id 1M78Nl-0000cD-3w (Exim 4.70)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 21 May 2009 14:32:25 +0100
Received: from fanf2 (helo=localhost) by hermes-2.csi.cam.ac.uk (hermes.cam.ac.uk)
	with local-esmtp id 1M78Nl-0008FS-6b (Exim 4.67)
	(return-path <fanf2@hermes.cam.ac.uk>); Thu, 21 May 2009 14:32:25 +0100
X-X-Sender: fanf2@hermes-2.csi.cam.ac.uk
In-Reply-To: <4A151A15.6040609@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119680>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1870870024-690524581-1242912745=:23478
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 21 May 2009, Ren=C3=A9 Scharfe wrote:
>
> That's strange.  It seems that poll() reports that there is data to read
> from the child (which is running git-upload-archive), even though it
> already called exit().

Poll reports an FD is readable when it reaches EOF.

> The following patch works around this issue by terminating the otherwise
> endless loop after read() returned nothing for the thousandth time in a
> row.

You should stop reading the first time read() returns 0 i.e. EOF.

Tony.
--=20
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
GERMAN BIGHT HUMBER: SOUTHWEST 5 TO 7. MODERATE OR ROUGH. SQUALLY SHOWERS.
MODERATE OR GOOD.
--1870870024-690524581-1242912745=:23478--
