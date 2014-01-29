From: David Kastrup <dak@gnu.org>
Subject: C standard compliance?
Date: Wed, 29 Jan 2014 21:33:08 +0100
Organization: Organization?!?
Message-ID: <87iot25y0r.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 21:33:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8bp8-0000ZF-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 21:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaA2UdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 15:33:22 -0500
Received: from plane.gmane.org ([80.91.229.3]:57434 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbaA2UdV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 15:33:21 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W8bp2-0000X1-IM
	for git@vger.kernel.org; Wed, 29 Jan 2014 21:33:20 +0100
Received: from x2f43172.dyn.telefonica.de ([2.244.49.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 21:33:20 +0100
Received: from dak by x2f43172.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 21:33:20 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f43172.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:LevO88SoSX73gCkSUaoYpCYrYg4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241224>


Hi, I am wondering if I may compare pointers with < that have been
created using different calls of malloc.

The C standard does not allow this (inequalities are only allowed for
pointers into the same structure) to allow for some cheapskate sort of
comparison in segmented architectures.

Now of course being able to _sort_ pointers also allows to _collate_
them.  It totally does not matter just _what_ their ordering relation is
as long as it yields to a sorting function (namely obeys some basic
relations).

The question is whether this kind of undefined behavior (which almost
never is implemented in unexpected ways) is frowned upon in the Git
codebase or not.

-- 
David Kastrup
