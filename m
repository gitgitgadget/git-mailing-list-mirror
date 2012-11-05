From: "Valentin Spreckels" <Valentin.Spreckels@Informatik.Uni-Oldenburg.DE>
Subject: git log --follow --reverse ignores --follow
Date: Mon, 05 Nov 2012 23:51:46 +0100
Message-ID: <50984302.4000807@Informatik.Uni-Oldenburg.DE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Uli Schlachter <Uli.Schlachter@Informatik.Uni-Oldenburg.DE>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 00:11:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVVpZ-0002sE-NP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 00:11:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243Ab2KEXL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 18:11:27 -0500
Received: from arbi.Informatik.Uni-Oldenburg.DE ([134.106.1.7]:56686 "EHLO
	arbi.Informatik.Uni-Oldenburg.DE" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752168Ab2KEXLY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 18:11:24 -0500
X-Greylist: delayed 1167 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Nov 2012 18:11:24 EST
Received: from taifun.Informatik.Uni-Oldenburg.DE ([134.106.11.36])
	by arbi.Informatik.Uni-Oldenburg.DE (Exim 4.72)
	id 1TVVWM-0004G0-TK; Mon, 05 Nov 2012 23:51:54 +0100
Received: from [192.168.88.151] ([178.3.22.196])
	by taifun.Informatik.Uni-Oldenburg.DE (Exim 4.72)
	id 1TVVWM-00071l-H2; Mon, 05 Nov 2012 23:51:54 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110922 Lightning/1.0b3pre Thunderbird/3.1.12
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209091>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I found something looking like a bug:

The following lines prepares a small exmaple:
# create git repo
git init
# create file a and commit it
touch a && git add a && git commit -m first
# rename a to b and commit it
git mv a b && git commit -m second

After this git log's behavior differs from my expectations, when run
like this:
git log --follow --reverse b

Expected result:
A list of both commits starting with second or a error message if git
log cannot run with --follow and --reverse combined.

Actual result:
A list showing only the second commit.

It looks like git log silently ignores --follow when run with --reverse.

Observed with git versions 1.7.8.6 and 1.7.11.2

Valentin
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQmEL/AAoJEANdk65I57uzbE0P/i0p8mlBcGWI+WyPqU7dhAmO
3jHLMmqNV12bm9zeNKuKxQPDS5IzMWRwDpO6GXdn8BQauQtpwB0POLXBIWl9pP2g
TOGJjIUL/Rd7+G4FF1vcSUxd9LESlPDQTL+J2F3B7+KRMRzxxsbNv/5826w7HQHg
ck6XfrmkFxoIn6w6CH6pCncRFl6cb7EqrMZIhGclJvDqXKi4DHRa3XpPRCle/Xa1
2P65kb0va+LzX2nUdfKR/WeH0V0XPURyObr/NN0ecVIrLj3roV/0OZBg/AsQwu3Z
Zw4CM5nL0DsgD81FEc8cToe5eJwi5/VH56+CbDyr+wcLj4BO4niS3eQqQKmyiJS7
2/Pny+IZOZmIJzh5+6d0puufKut877PIRoJTs0P8l+dXU9xIbzwVTTcWDpKQt5Mx
Mzi6oSpCLDuvBo+WCjanqtF2oNoLnbfq9nD/KgmIH/XTLKsryL48PFXx1b+7vGuG
hmzlcRies3Xpkx0cegzqSngl3/I1Rq8hEbJhcJA4SrJFS2sVj8lGALPgFQdhif2L
N0c5DNUD9F5pH/U11a0YnOxtkFyB+LjXqE2zN9Mz+t0TZ69+y6qZMrxHbAoeNDMX
Do22J9jgSc80VE3Cdn8Cwe/xVLoJCvc7wSUpBbTQjDhOZbv7Zbtjl1venS3/q4fk
wcOSFLYb0Heqm8Qxwf+d
=D+B2
-----END PGP SIGNATURE-----
