From: James Pickens <jepicken@gmail.com>
Subject: Re: 'git status' on NFS performance regression in 1.7.0
Date: Wed, 17 Feb 2010 14:35:06 -0700
Message-ID: <885649361002171335r74295d34l9a5ed9557059dbc6@mail.gmail.com>
References: <885649361002171208j41405b9exdfc34034c905e96c@mail.gmail.com> 
	<7vy6irligs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 22:35:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhrYU-0003Q3-Vt
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 22:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756739Ab0BQVf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 16:35:29 -0500
Received: from mail-yx0-f180.google.com ([209.85.210.180]:56124 "EHLO
	mail-yx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab0BQVf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 16:35:28 -0500
X-Greylist: delayed 5215 seconds by postgrey-1.27 at vger.kernel.org; Wed, 17 Feb 2010 16:35:28 EST
Received: by yxe10 with SMTP id 10so402035yxe.33
        for <git@vger.kernel.org>; Wed, 17 Feb 2010 13:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=/11vseuiOgF/JJl9J/4vXIzFFK488t+brBYN5/nUffE=;
        b=dFGvZBL25s52R0bf2MbUlV32ZbNjB6ZNVhbckviUFXUSdcZ41y3JTvl5gX7QfDnMsm
         b011zlaod7Sg/hZaewVZLsImIoOG56HBe5s4V/FnmpQUgDcz79NwzMAzNDkXKneraDkv
         Wqhldk/sqsQJHJXB1zASuXAb4fEtyTgweNGoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=vuB/8BZScD35GkGsm5paTstC/QSBLHNFaKWm1qGopTQGpKInc36YQuAkhy5HckEzOy
         C2+SnUTf9Wpi+WsZQvByNNuy23Da4908VdBNXWlKg6q5UJH83biMXgdN6JPq2F4BNKet
         nAtoGI8Lja/YaAQXIYa6duD4c+0wR3Q9GmHww=
Received: by 10.90.21.11 with SMTP id 11mr2208295agu.97.1266442526250; Wed, 17 
	Feb 2010 13:35:26 -0800 (PST)
In-Reply-To: <7vy6irligs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140264>

On Wed, Feb 17, 2010, Junio C Hamano <gitster@pobox.com> wrote:
> There might be subtle breakage for doing this, but it would be worth a try
> ;-)

Thanks, with that patch Git 1.7.0 is faster than 1.6.2.5 - ~2 seconds
average runtime vs. ~3 seconds (1.6.2.5 got slower since my original test
last night; must be more network and/or file server traffic right now).

I'm not sure how to interpret the "subtle breakage" comment with the
winking smiley.  Do you mean that preload_index in 1.7.0 is not well tested
and may be broken?  FWIW, I didn't notice any breakage, but I didn't do
much testing.

James
