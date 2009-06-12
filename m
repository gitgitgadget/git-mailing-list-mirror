From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH 1/2] http.c: prompt for SSL client certificate password
Date: Fri, 12 Jun 2009 18:31:11 -0400
Message-ID: <ca433830906121531m6955da77we455136c6e9d0785@mail.gmail.com>
References: <1243480563-5954-1-git-send-email-lodatom@gmail.com>
	 <ca433830906111600n2d45b5bdg3fb6e7c0a537ec78@mail.gmail.com>
	 <7vocsue354.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 00:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFFHL-0003kO-VN
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 00:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbZFLWbL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Jun 2009 18:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752401AbZFLWbL
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 18:31:11 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36041 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253AbZFLWbK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Jun 2009 18:31:10 -0400
Received: by bwz9 with SMTP id 9so2355275bwz.37
        for <git@vger.kernel.org>; Fri, 12 Jun 2009 15:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lHJTl4FaK2DdgQvhfvmpVIw0fcqRaPN7TPOQbKijF0Q=;
        b=LSmFIef2yXzZ+0plCBh0E/vbXk7FiQLonrOxJQ6oXfegk5O7g9lSgsSZt+mKTQXncF
         /DKXGIx8YKFZ4jFW5+4X7ng8C8cERIPFMsKkN5tmfws7WyhN5x+j3wnUdVOPcSgnf4Y9
         cHYdu3NqZEcKFupZH3pIvFwZkuf/WgowDSTy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q55bUjvMwMeVR6eyJu0SD4vgodt8ltWUIxcbXOMcqi3nQqj0Yjrg12GKMWLLcV+YMR
         hmBQBPLcnTWyD4GdMwH5SPomq7QactBJd1UlvFprCccJnx8Exi7aBVIrjfHSOeJcXnts
         0w9KbvP2UDWFYIU/9LxnUsAvPkbOevVqk6meY=
Received: by 10.223.111.211 with SMTP id t19mr3046432fap.64.1244845871129; 
	Fri, 12 Jun 2009 15:31:11 -0700 (PDT)
In-Reply-To: <7vocsue354.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121459>

Thanks for reviewing the patch.

On Thu, Jun 11, 2009 at 7:56 PM, Junio C Hamano<gitster@pobox.com> wrot=
e:
> Mark Lodato <lodatom@gmail.com> writes:
>
>>> The user is always prompted, even if the certificate is not encrypt=
ed.
>>> This should be fine; unencrypted certificates are rare and a securi=
ty
>>> risk anyway.
>
> Hmm, "rare" is in the eyes of beholder. =C2=A0For automated settings,=
 I would
> imagine that it is a necessary feature that we need to keep working. =
=C2=A0Of
> course the local box that keeps an unencrypted certificate used this =
way
> must be well protected to make it _not_ a security risk, but that is =
not
> an issue you are addressing with your patch anyway, so it is not nice=
 to
> dismiss possible usability issues like this.

Sorry about that wording - it probably is a more common case than I
imagine.  But patch 2/2 addresses this issue with an option to disable
the password prompt.  This does require one-time work for existing
users who use an unencrypted certificate, but overall I think the
patch series is a big win since encrypted certificates are not usable
at all currently.

>>> I did not create any tests because the existing http.sslcert option=
 has
>>> no tests to begin with.
>
> Again, not nice. =C2=A0Not having tests in this particular patch may =
be Ok, as
> long as you or other people fix that deficiency with follow-up patche=
s,
> but please don't be proud that you are following a bad example.


Again, sorry about the wording.  I meant the above as an explanation
of why I did not include a test - I was not sure how to write one.  I
would be happy to write such a test if someone could give me some
guidance.


Thanks again!
Mark
