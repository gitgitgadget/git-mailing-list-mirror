From: Patrick Schleizer <patrick-mailinglists@whonix.org>
Subject: git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature
Date: Thu, 04 Dec 2014 17:21:06 +0000
Message-ID: <54809802.6030609@whonix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org, Mike Gerwitz <mikegerwitz@gnu.org>,
	Whonix-devel <whonix-devel@whonix.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 18:21:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwa5s-0000Lb-6P
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 18:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbaLDRVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 12:21:21 -0500
Received: from whonix.org ([92.243.7.197]:55818 "EHLO whonix.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932453AbaLDRVU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 12:21:20 -0500
Received: from 127.0.0.1 (nchinda2.mit.edu [18.239.0.140])
	by whonix.org (Postfix) with ESMTPSA id CB1F038;
	Thu,  4 Dec 2014 18:21:14 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260768>

Dear git mailing list,
Dear Mike Gerwitz,

according to http://mikegerwitz.com/papers/git-horror-story#script-trust
the output of:

git log --pretty="format:%H$t%aN$t%s$t%G?" --show-signature

should look like this:

-----

f72924356896ab95a542c495b796555d016cbddd       Mike Gerwitz    Yet
another foo
gpg: Signature made Sun 22 Apr 2012 01:37:26 PM EDT using RSA key ID
8EE30EAB
gpg: Good signature from "Mike Gerwitz (Free Software Developer)
<mike@mikegerwitz.com>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the
owner.
Primary key fingerprint: 2217 5B02 E626 BC98 D7C0  C2E5 F22B B815 8EE3 0EAB
afb1e7373ae5e7dae3caab2c64cbb18db3d96fba       Mike Gerwitz    Modified
bar    G

-----

But when I run that command, spaces are missing. (Using a user that does
not know my gpg public key for testing purposes.) See output:

-----

user2@host:/home/user/testrepo$ git log
--pretty="format:%H$t%aN$t%s$t%G?" --show-signature
gpg: Signature made Thu 04 Dec 2014 04:37:58 PM UTC using RSA key ID
77BB3C48
gpg: Good signature from "Patrick Schleizer <adrelanos@riseup.net>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the
owner.
Primary key fingerprint: 916B 8D99 C38E AF5E 8ADC  7A2A 8D66 066A 2EEA CCDA
     Subkey fingerprint: 6E97 9B28 A6F3 7C43 BE30  AFA1 CB8D 50BB 77BB 3C48
529bbc076f05c13023580ea7be7ba63aba3e9672Patrick Schleizersigned commit 2U
gpg: Signature made Thu 04 Dec 2014 04:29:32 PM UTC using RSA key ID
77BB3C48
gpg: Good signature from "Patrick Schleizer <adrelanos@riseup.net>"
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the
owner.
Primary key fingerprint: 916B 8D99 C38E AF5E 8ADC  7A2A 8D66 066A 2EEA CCDA
     Subkey fingerprint: 6E97 9B28 A6F3 7C43 BE30  AFA1 CB8D 50BB 77BB 3C48
ea1615ac1a9fe9f957f91f54a33a60d57828a32fPatrick Schleizersigned commitU
75e79a211963907afd3a6d2f28c3571d37140231Patrick Schleizerreal long
commit msg Please enter the commit message for your changes. Lines
starting with '#' will be ignored, and an empt
30096d1633ef22463c1a770288755ae5325f1242Patrick Schleizer2N
e7be12378d2805bebe531bd01cbec9dec1f79032Patrick Schleizerinitial commitN
(END)

-----

Any idea? Am I doing something wrong?

I am asking, because therefore Mike Gerwitz's Quote "Signature Check
Script With Web Of Trust" verification script (
http://mikegerwitz.com/papers/git-horror-story#script-trust ) does not
work for me.

Mike, could you please put your various git commit verification helper
scripts into a publicly visible?

By the way, any chance that these useful helper scripts could make their
way into the official distribution of git as a stopgap until native git
commit verification support gets improved?

Cheers,
Patrick
