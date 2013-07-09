From: Phillip Susi <psusi@ubuntu.com>
Subject: Diff colorizer confused by dos newlines
Date: Tue, 09 Jul 2013 14:28:32 -0400
Message-ID: <51DC5650.1070708@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 09 20:28:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwceU-0002g8-VL
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 20:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131Ab3GIS2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 14:28:34 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:57486 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab3GIS2e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 14:28:34 -0400
X-Authority-Analysis: v=2.0 cv=f9nK9ZOM c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=3ukmKKXcZEAA:10 a=XwUEbpEYZ8AA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=KGjhK52YXX0A:10 a=vYm7gKTzoVUA:10 a=QfKxxUxMAAAA:8 a=wBPmFdZR7Ha5zAbtcV8A:9 a=wPNLvfGTeEIA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Authenticated-User: 
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:51254] helo=[10.1.1.236])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id F7/CA-05415-0565CD15; Tue, 09 Jul 2013 18:28:32 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229975>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When I try to look at a color diff of a file using dos newlines, the
output gets an odd sequence of ansi escapes and a stray carriage
return showing up only on the + lines, but not the -.  The normal
looking - lines look like this:

\r\n ( from previous line ), ansi color escape, '-', whitespace, text,
terminating ansi escpae ( [m ), \r\n.

The broken + lines look like this:

\r\n ( from previous line ), ansi color sequence, '+', terminating
ansi escape ( [m ), whitespace, ansi color sequence, text, terminating
ansi escape, ansi color sequence, stray \r, terminating ansi escape, \n.

Any suggestions on how to resolve this?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR3FZQAAoJEJrBOlT6nu75mvIIAKVKcK2GeVNHKRBkkljqE1U5
2piftz+CO6sVZGba8DUxMdbA5tCDQrz11yzowuKXDtyr1hxhgjBoXcsN36RZhYdu
gijE6qF5w/na6MdPgJ7LMizHo8xOeVGhrDr+qhM/5nD77rVumtEnGAdoEqdY+uY3
mYfHaz2dHAG3W7mOlfvycb4HhRBao64pGh5JnuyvvnZKSXkOyJozjzTEzC7tuNU8
b9qofVKnTMse7Ek6jGp64GNaxxtcQCt1J8cd2uOJtROUK2g9KgVhy2QSRFqoZ1yO
zEtTD28bj7nWJubsgVyOdtx0ClxiO1RHQRqQH2/zQM6NlfntAljD15bHcPNJaKo=
=g3R+
-----END PGP SIGNATURE-----
