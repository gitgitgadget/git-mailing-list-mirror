From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: git cvsimport and case-insensitive config
Date: Wed, 31 Mar 2010 00:17:31 +0200
Message-ID: <cb7bb73a1003301517r29aed329j4a5f38fbc9b515ca@mail.gmail.com>
References: <hoscv7$hmn$1@dough.gmane.org> <7vy6h9vhuk.fsf@alter.siamese.dyndns.org> 
	<cb7bb73a1003301105v691624sdcdadf6809c50b89@mail.gmail.com> 
	<7vr5n1v74x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 00:20:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwjn2-0003bV-76
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 00:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592Ab0C3WRx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Mar 2010 18:17:53 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:25124 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab0C3WRw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Mar 2010 18:17:52 -0400
Received: by ey-out-2122.google.com with SMTP id d26so1330396eyd.19
        for <git@vger.kernel.org>; Tue, 30 Mar 2010 15:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=pskPF2H6My85uUv1Fv98B9vGsx49NLFcjChX2Sj5z3E=;
        b=bb4XSYVZ9j73ort9/QzQF7EpDP4h6pFeh2fU84TPBV3uYdeOGUrrY1pE7tbvhclz9K
         Unl/awoKFbLNfgp8L7eZiSJnsY1gOdJiZjuIsjzIEGhV1aMaX/f/jHyo6SBgMUnDU33v
         5khVQPDo3mDGARGfRM8hCAOnLTkPld012/guk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=QsSjZ4lqCkSgLZkUypdXFBuHpWKHXR4tj40cfy/f0K+UQSnxbzGoVx0UPng1ZRypmt
         XgI2VDfKLYWeE367fCrKiA5IQWdJFtwu6WM5eytKsHsm0puK9nsk8fXn6Q7zXQum55w7
         h1ErnB89K2zJvkBwwu+ff9DACgXetRLXF+nkA=
Received: by 10.213.114.132 with HTTP; Tue, 30 Mar 2010 15:17:31 -0700 (PDT)
In-Reply-To: <7vr5n1v74x.fsf@alter.siamese.dyndns.org>
Received: by 10.213.39.197 with SMTP id h5mr563972ebe.35.1269987471158; Tue, 
	30 Mar 2010 15:17:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143611>

On Tue, Mar 30, 2010 at 11:20 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> We might be able to skip (2) by relying on the fact that if the
>> lowercase is boolean, the uppercase isn't, and conversely.
>
> That was the idea I wrote in an earlier draft of my response that I l=
ater
> scrapped. =A0I started with "cvsimport.a? =A0If it is 'true' then tha=
t is -a;
> if it names an existing file, then it is -A." =A0I continued the draf=
t up to
> '-p' vs '-P' (the former would begin with a hyphen, the latter likely
> wouldn't). =A0But I don't think you can reliably guess -s/-S (both st=
rings).

(-s likely has a single character, -S more than one. -S is likely to
have * or ?, -s not.)

> A bigger reason is that, if you have _any_ combination that you canno=
t
> reliably guess, you would either need the user to ask for help, or yo=
u
> need to convert by reading the configuration file case-sensitively
> yourself to come up with a reliable conversion. =A0I opted for the la=
tter.

Would such a configuration work at all?

--=20
Giuseppe "Oblomov" Bilotta
