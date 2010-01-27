From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-format-patch should include a checksum
Date: Wed, 27 Jan 2010 01:50:57 +0100
Message-ID: <fabb9a1e1001261650r18e04e3cw2efade6072a426b@mail.gmail.com>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr> <7vljfkxxj9.fsf@alter.siamese.dyndns.org> 
	<fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com> 
	<alpine.LFD.2.00.1001261639550.17519@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Juliusz Chroboczek <jch@pps.jussieu.fr>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 01:51:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZw7v-00035d-7d
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 01:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964Ab0A0AvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 19:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753498Ab0A0AvS
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 19:51:18 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:55114 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753390Ab0A0AvR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 19:51:17 -0500
Received: by pxi12 with SMTP id 12so3961600pxi.33
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 16:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=MTB0nWgh7Ji/fMW+QFR9C4F8eQo63qpqvYlWj96IZq0=;
        b=fMk4m+iCycbEWMEI0Mr2ANJYCsk8ZTXO1WplNnIWfXUU/6ec/aICLmCreHbGqLyRk3
         Jfep1PORwrCRqk95QU29WMBg0oCCGlQ35gDDXwPAhDo2QCsJDdYWPt5DJQzrIBuqKZqh
         Xyh7vazDl9ZW9jhAWSdmoKCdOEsp01nW1wQ/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=oCRjy/cHrBsTJl7DbirzNAsXlUrqgEp1MDBPSKHWT6WOmaQd6HUzGBDzhzCnAmj1JJ
         ukUgTQuTfhaJJhLQj8LFfXfvgHM8LmB3syO0gLkSe5AbXY5b9NAkU1sUovYt0xpAOgKJ
         6jBg7ox674MpGBRRIhE618e2s2Jg67uoNxk0k=
Received: by 10.142.56.13 with SMTP id e13mr6001819wfa.119.1264553477142; Tue, 
	26 Jan 2010 16:51:17 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001261639550.17519@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138094>

Heya,

On Wed, Jan 27, 2010 at 01:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> That wouldn't work either. People can, should, and do add extra things to
> the message before applying it.

Ah, that's a fair point.

> In short, it might make sense to have some anti-corruption logic, but I
> suspect it needs a lot of thought.

Perhaps it makes sense to make it a separate mode to git am, such that
it only checks that the patch is not corrupted, but does not apply it.
That way it would be possible to download the patch, check that it
arrived unscathed, and then do your usual patch handling. Those who do
not edit patches before applying it would be convenient to set a
configuration option that automatically does it when applying the
patch, either warning about it or aborting (as Juliusz suggested).

-- 
Cheers,

Sverre Rabbelier
