From: James Pickens <jepicken@gmail.com>
Subject: Re: 'git clone' doesn't use alternates automatically?
Date: Sat, 31 Jan 2009 18:32:06 -0700
Message-ID: <885649360901311732t6e4f8651p6c3955f018b9a36c@mail.gmail.com>
References: <885649360901301412jd5c6b0dne1eff1ff00dd043e@mail.gmail.com>
	 <20090131071238.GC3033@coredump.intra.peff.net>
	 <885649360901311208s4bc17ae3me2062b07b302291e@mail.gmail.com>
	 <7vtz7f2cy6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 02:33:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTRDM-0003fv-45
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 02:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbZBABcL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 20:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZBABcJ
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 20:32:09 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:15956 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751644AbZBABcG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 20:32:06 -0500
Received: by rv-out-0506.google.com with SMTP id k40so990128rvb.1
        for <git@vger.kernel.org>; Sat, 31 Jan 2009 17:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FcZzgsng6KoF6Fv8H0RC/isq4z1fEbyiEcAX3VsrCPk=;
        b=mXzu8SybScm/Vpumps0U2Pv9SAdK0lJRu5c6QIF425J6odA3SjlIrB5b3h8SvjQfHB
         oFEPIIKqvziYWxvsCfG6SYtOpyG0HYclUjZkrrXe9F9PnKxZxU+40UJNhqFrC522+e1i
         uQWvTOF237io1kXO57x9kbf90dFU6B2HwTCzs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YugeAbhZS5hBFarl7NCB7e8pigk1Hc1KZLH0CEi6LI0c90JambmIdRzUhiugQpIZJx
         EV7rWnObqcUI7kgkp9h9JX6PY5plU5lSaApo+9etNxSfiQCANWVYltLOthrUqUqh5Bmi
         Vc8dLDKn7L6c1xT7nn6cKm1AaKzdfXFKvs28Q=
Received: by 10.114.122.9 with SMTP id u9mr1858358wac.129.1233451926095; Sat, 
	31 Jan 2009 17:32:06 -0800 (PST)
In-Reply-To: <7vtz7f2cy6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107963>

On Sat, Jan 31, 2009, Junio C Hamano <gitster@pobox.com> wrote:
> When you say "git clone" without -s, you are saying "I do not want to use
> the repository I am cloning from as my alternate, because I do not know if
> will stay stable.  I do not trust it."

Yes, I'm aware of the caveats of -s.  I was talking about what
happens when I *don't* use -s.

> Now, if you are cloning from a local filesystem, by default we will copy
> the objects/info/alternates from the source repository to the new one.  It

Crap, I didn't realize the alternates were only copied when you
clone from the local filesystem.  I wanted to use this when
cloning over ssh from site A to site B, to automatically add a
mirror at site B as an alternate.  Sounds like I have no choice
but to use --reference for that.

> I suspect you are trying to improve the other extreme end: trusting all
> the other repositories involved in the cloning process a lot more than the
> code currently does.

What I was suggesting did not involve trusting anything any more
than the current code does.  It just meant taking immediate
advantage of the trust that was already there.

Thanks for your input,
James
