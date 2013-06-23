From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2 11/14] t/t5505-remote: test multiple push/pull in remotes-file
Date: Sun, 23 Jun 2013 13:58:45 +0530
Message-ID: <CALkWK0nFySj_Xztfwjp=FAhz=dBxgmwZ9YG=PY=7HZLfw0P8aw@mail.gmail.com>
References: <1371887901-5659-1-git-send-email-artagnon@gmail.com>
 <1371887901-5659-12-git-send-email-artagnon@gmail.com> <7vobaxfdx9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 10:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqffz-0001xQ-Ps
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 10:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157Ab3FWI3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 04:29:31 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54305 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159Ab3FWI32 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 04:29:28 -0400
Received: by mail-ie0-f180.google.com with SMTP id f4so22677576iea.11
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e7ZuLKqGHrDraoZrKDVZQaVCiZG6V0QlDQA//lhcZ3A=;
        b=hVPtlAcrJEjiU5oAo1mUzSC4/Wo6CY4VCzP09nEGDSNcE8/34E9p31vCP37ipoOcwD
         z9qy30Y1AluSLOoOh5up3NW9AVMjgoNNtCtMjHExqz4DAhSbo0sdGKFM3nNCgSs3usFR
         8muaVRMIhe2VZxRL8SVk5Q8H+U6ruuup9HR2o/IWRwEBgqxT+O7W53cn7w+ejbIGmYyR
         p0yJ4wxrvQGE6nsvIQ+abmNBkfID73qs6lJcrs408PgxSoMA7ujKZ9G+SRX+evlgzEnU
         kvKDzff1j+cwyHmb0LPJMc3gAQg8Prxxu673V1QQVQFVi3Qr7bbvIZdgc04iNChcJ7qq
         997A==
X-Received: by 10.42.190.74 with SMTP id dh10mr9402967icb.35.1371976166898;
 Sun, 23 Jun 2013 01:29:26 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 23 Jun 2013 01:28:45 -0700 (PDT)
In-Reply-To: <7vobaxfdx9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228733>

Junio C Hamano wrote:
> I'll reject 04/14 and tweak this patch to use 'next' for the new ref
> mappings, not duplicated 'master'.

It's a matter of taste: I don't like "realistic" (albeit misleading)
values when I'm testing configuration variables, while you think they
make the tests more readable.  Fine.

> Patches 07/14, 12/14, 13/14, and 14/14 are bad idea (these will not
> be queued on tonight's pushout of 'pu'; neither 04/14 will be).  We
> may not be encouraging, but that is very different from deprecating
> the original mechanisms.  The tests that depend on them to work
> should be kept.  Otherwise, we will never know when we break them
> like we did at df93e33c accidenally.
>
> If we want to have tests that exercise the equivalents spelled with
> the modern in-config mechanism, they should be added as new tests,
> not by replacing the existing ones.

I disagree.  It is trivial to prove that the tests in t/remote will
break if this fringe feature breaks: I don't know where "we will never
know when we break them" is coming from.  Why should I know about this
fringe feature when I'm reading/writing tests for fetch-merge-logic?
And what is _advantage_ of depending on this fringe feature when
testing fetch-merge-logic?  More tests break?

But whatever.  I've already spent more time discussing (bikeshedding?)
this series than writing it.  I regret having written a stupid cleanup
series with no real consequence now; I'll be less likely to make the
same mistake again in the future.

Thanks.
