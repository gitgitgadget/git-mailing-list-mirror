From: David Kastrup <dak@gnu.org>
Subject: Consistency question
Date: Wed, 15 Jan 2014 11:37:08 +0100
Organization: Organization?!?
Message-ID: <8761pl8raj.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 11:37:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3Nqu-0007yM-FE
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 11:37:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaAOKhh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jan 2014 05:37:37 -0500
Received: from plane.gmane.org ([80.91.229.3]:37814 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751214AbaAOKhY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 05:37:24 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W3Nqc-0007SI-7L
	for git@vger.kernel.org; Wed, 15 Jan 2014 11:37:22 +0100
Received: from x2f3b11f.dyn.telefonica.de ([2.243.177.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 11:37:22 +0100
Received: from dak by x2f3b11f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 11:37:22 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3b11f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:sMBQyikH3WJlicd/oaUPFzuB+CI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240449>


Hi,

I am in the process of rewriting the core logic of git blame (the
current speed of which is quite an impediment to some workflows).
I=A0currently have one question I don't see an answer to right away, an=
d
that question arises in doing a reasonably robust traversal of commits
without determining topology first:

The question is what guarantees I have with regard to the commit date o=
f
a commit in relation to that of its parent commits:

a) none
b) commitdate(child) >=3D commitdate(parent)
c) commitdate(child) > commitdate(parent)

Obviously, I can rely on c) being true "almost always": it's definitely
good for a heuristic used for improving performance (meaning as an
ordering criterion for a commit priority queue).  The problem is how
much I should cater for graceful behavior for the cases where it's not.

Does git do any actual checks before pushing?

--=20
David Kastrup
