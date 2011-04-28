From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Thu, 28 Apr 2011 12:15:19 +1000
Message-ID: <BANLkTikbcpzF203rUVB05OYyYhLmu3+n6w@mail.gmail.com>
References: <4DB80747.8080401@op5.se>
	<BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
	<4DB82D90.6060200@op5.se>
	<7vbozr8uo8.fsf@alter.siamese.dyndns.org>
	<7vpqo77dlr.fsf@alter.siamese.dyndns.org>
	<1303930175.25134.38.camel@drew-northup.unet.maine.edu>
	<20110427194233.GA16717@gnu.kitenet.net>
	<7vwrif5q93.fsf@alter.siamese.dyndns.org>
	<20110427220748.GA19578@elie>
	<7vsjt35l84.fsf@alter.siamese.dyndns.org>
	<20110427234224.GA26854@elie>
	<7viptz5j82.fsf@alter.siamese.dyndns.org>
	<BANLkTi=w0aKH6dxu84i4DjkL-vNCWQi8pw@mail.gmail.com>
	<alpine.DEB.2.00.1104271751300.940@asgard.lang.hm>
	<BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>, david@lang.hm,
	Pau Garcia i Quiles <pg
X-From: git-owner@vger.kernel.org Thu Apr 28 04:15:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFGlO-0002fF-ER
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 04:15:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967Ab1D1CPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 22:15:23 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57630 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab1D1CPV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 22:15:21 -0400
Received: by ewy4 with SMTP id 4so689076ewy.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 19:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=Y7Q7DdnEuKHc8vZ416QxgA+GSSebUl2Psypy5TT1QVk=;
        b=WdTBkbBnUWbjLDZTvSK0qA+D4Oq1fNj+JvYA1M3hf+9qhwJfv3il1QYnsO6IBDVl0K
         wQpJPhp2j10M5AsOAAxfywm/tXFF88eUdIpEw0GVj6xrLC71F7hTQ4TsK2oI29lVZnlh
         g6GHbiHdpj7h/jaiCxoVhJdNCgX6vjJOe4Pb8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=IOEda8oGKA6ZsDiiKvg9FNKB1ns7haMRmyua+tJ8tc94psvw2KaB7I/KvdnuzoAjHh
         TYv7p/9RlalIJj+w5pXJG+YmVvUzOHcyLPr1c5o/csHb0xoItn4G2vUL7aGF6AJh7ZYR
         QxZWgyo5+p1f+8EBbuMBwgoTdvT1bMioAmQxw=
Received: by 10.14.50.15 with SMTP id y15mr1291675eeb.149.1303956919825; Wed,
 27 Apr 2011 19:15:19 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Wed, 27 Apr 2011 19:15:19 -0700 (PDT)
In-Reply-To: <BANLkTimnkBMRH7Spj1ByQRa9YdV9w+bwtQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172310>

Assuming for the moment that the concept of a managed plugin is accepted, then.

The relationship between distribution managers and the git-plugin
architecture would be as follows:

- distributions would know how to locate the git instance it manages
- distributions would know how to install their own packages that
contain plugins into plugins/ subdirectory of this git instance
- distributions would know how to run git plugin activate and properly
handle non-zero return codes from same

make install scripts would act like a kind of distribution in this regard.

Now consider this:

* suppose that git-core defined a git install _interface contract_ but
did not define an implementation.

Then, a distribution could install its own implementation of the
git-install plugin into git installations it manages.

Then a command like:

    git install gitwork

would trivially work across all distributions precisely because the
distribution has provided the implementation of the git install
interface contract that git-core has helpfully mandated.

jon.
