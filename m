From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Wed, 05 Feb 2014 10:22:18 +0100
Organization: Organization?!?
Message-ID: <87r47hvrqt.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
	<xmqqd2j28w3h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 05 10:22:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAygo-0006m1-Eh
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 10:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbaBEJWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 04:22:31 -0500
Received: from plane.gmane.org ([80.91.229.3]:41066 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751390AbaBEJW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 04:22:29 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAyge-0006ia-2W
	for git@vger.kernel.org; Wed, 05 Feb 2014 10:22:28 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 10:22:28 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 10:22:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:SxDoVTdLwWt0Iqn8TzAsklG7FKo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241600>

Junio C Hamano <gitster@pobox.com> writes:

> which I think is the prevalent style in our codebase.  The same for
> the other loop we see in the new code below.
>
>  - avoid assignments in conditionals when you do not have to.

commit a77a48c259d9adbe7779ca69a3432e493116b3fd
Author: Junio C Hamano <gitster@pobox.com>
Date:   Tue Jan 28 13:55:59 2014 -0800

    combine-diff: simplify intersect_paths() further
[...]

+       while ((p = *tail) != NULL) {

Because we can.

At any rate, I am not going to put any more work into this patch as it
is decidedly not worth the bad taste this discussion leaves in my mouth.
And I don't want any code marked as written by me that does not
correspond to what I'd be willing to write.  So please make sure to put
any rewrites in a separate commit with different authorship.

Thanks

-- 
David Kastrup
