From: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
Subject: Re: Generalised bisection
Date: Wed, 11 Mar 2009 22:15:59 +0000
Message-ID: <efe2b6d70903111515p2b9f656bp186d0b3cc7ae483d@mail.gmail.com>
References: <efe2b6d70903081840v18e77aa7w2dac2bed553d0d6a@mail.gmail.com>
	 <200903100808.15875.chriscool@tuxfamily.org>
	 <efe2b6d70903110159h78de744yc141effaf5aa0821@mail.gmail.com>
	 <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git List <git@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 23:22:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWk2-0001E9-5j
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 23:17:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbZCKWQG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Mar 2009 18:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753288AbZCKWQE
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 18:16:04 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:31903 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbZCKWQC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2009 18:16:02 -0400
Received: by fk-out-0910.google.com with SMTP id f33so81862fkf.5
        for <git@vger.kernel.org>; Wed, 11 Mar 2009 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=993+OWv2dk36UkPvjd1b7uU44NLs7+GeB2vomboncpg=;
        b=VOos0MRVqQHpGOrppe0w/Yd7b6LsbnGWkcfOP6j7i0bgViV5J9RgB21iBeJ6nISjss
         6Pf2e4FpWJ0glsHzDyYFGX/vN+QVam9a9b6lJ2GL3k0V1S1qOhIF/rWLp/QaXmmivzLb
         DP9+MJkg4pHTX8Vq7djxDGFl3i9D+eC0Im7vo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BOcdz9U/QzWt6y9IKrpNViqYkNCIVG2GDFz0bqQHHBLC99rfMIJSMRIc7EBv2MyaLX
         YP+NIwTUp5VzDuBip/xJco+ok2xxx+T214/pfPaMHwuBvleVHritGnJQ+mSHsOJPt1/6
         txkdi0AsmPyin4adr++xI7q1zfXbOX2IJq/RI=
Received: by 10.204.62.68 with SMTP id w4mr258898bkh.122.1236809759740; Wed, 
	11 Mar 2009 15:15:59 -0700 (PDT)
In-Reply-To: <43d8ce650903110235q5e2a59f6t201d5e65a4937476@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112984>

[John will get this twice, sorry; not used to this mail interface yet.]

On Wed, Mar 11, 2009 at 9:35 AM, John Tapsell <johnflux@gmail.com> wrot=
e:

> mpmath might be the more annoying dependency - what functions do you
> use from it? =A0Could they trivially be reimplemented?

What I use is the multiprecision floating point number class. doubles
don't seem to be long enough.
The reason for using mpmath rather than the more  widespread GMP (and
its python wrapper gmpy) is that the latter only supports
integer powers, whereas BBChop needs fractional powers.

So, it might be possible to switch to gmpy,  or some other widespread
library,  by implementing a pow() which supports fractional powers.
I think I only use the normal arithmetic operators, log, and pow, so
in principle those could be reimplemented, to eliminate the dependency
altogether.
It seems a little bit of a waste of time, though.

Ealdwulf
