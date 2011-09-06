From: Nix <nix@esperi.org.uk>
Subject: Re: [PATCH 1/2] Add strtoimax() compatibility function.
Date: Tue, 06 Sep 2011 10:14:16 +0100
Message-ID: <87pqjejamv.fsf@spindle.srvr.nix>
References: <1315223155-4218-1-git-send-email-nix@esperi.org.uk>
	<7v62l6b3bt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 11:14:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0rjk-0000PK-Bb
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 11:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441Ab1IFJOX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 05:14:23 -0400
Received: from icebox.esperi.org.uk ([81.187.191.129]:51358 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709Ab1IFJOV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 05:14:21 -0400
Received: from esperi.org.uk (nix@spindle.srvr.nix [192.168.14.15])
	by mail.esperi.org.uk (8.14.4/8.14.3) with ESMTP id p869EHkJ011654;
	Tue, 6 Sep 2011 10:14:17 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.14.4/8.12.11/Submit) id p869EGR2012578;
	Tue, 6 Sep 2011 10:14:16 +0100
Emacs: resistance is futile; you will be assimilated and byte-compiled.
In-Reply-To: <7v62l6b3bt.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 05 Sep 2011 23:19:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-DCC-URT-Metrics: spindle 1060; Body=2 Fuz1=2 Fuz2=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180781>

On 6 Sep 2011, Junio C. Hamano spake thusly:

> Nix <nix@esperi.org.uk> writes:
>
>> Since systems that omit strtoumax() will likely omit strtomax() too,
>> and likewise for strtoull() and strtoll(), we also adjust the
>> compatibility #defines from NO_STRTOUMAX to NO_STRTOMAX and from
>> NO_STRTOULL to NO_STRTOLL, and have them cover both the signed and
>> unsigned functions.
>
> What would happen to people who know their systems lack strtoumax and have
> happily using NO_STRTOUMAX in their config.mak already? Do their build
> suddenly start breaking after this patch is applied and they all have to
> adjust to the new name?

Uh. Yeah. Oops.

> Even though "no strtoumax() likely means no strtoimax()" may be a good
> heuristics, I am not sure what we would gain by renaming these Makefile
> variables. Can't you get the same effect by making existing NO_STRTOUMAX
> imply not having strtoimax(), and if you did so, wouldn't it be much less
> likely that you would break existing people's build?

Yes, but I thought that might be too confusing (and having four
variables for this one case seemed ridiculous). I'm happy to rename it
back.

-- 
NULL && (void)
