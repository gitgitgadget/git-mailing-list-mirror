From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [regression] Re: git-cat-file --batch reversion; cannot query
 filenames with spaces
Date: Fri, 2 Aug 2013 09:14:45 -0700
Message-ID: <CA+sFfMdeGCfWbXfv7YqZi4zZj6RhDaugVgHJNu_Fhmx35wi=8Q@mail.gmail.com>
References: <20130801201842.GA16809@kitenet.net>
	<20130802064003.GB3013@elie.Belkin>
	<20130802105402.GA25697@sigill.intra.peff.net>
	<20130802115906.GA9183@sigill.intra.peff.net>
	<20130802152713.GA23548@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Fri Aug 02 18:14:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5I0B-00040O-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 02 Aug 2013 18:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754477Ab3HBQOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Aug 2013 12:14:48 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:51949 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab3HBQOr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Aug 2013 12:14:47 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so665842wes.23
        for <git@vger.kernel.org>; Fri, 02 Aug 2013 09:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6wb/w3rPJ0VEz6Hm5/Ha9emqzs+wj7Zdf+ZF8FhximA=;
        b=nyfgBCl6o72Gb278nEAIGliv55F2Pq2Ll2u9o1G9RWSDUimoXskynrDLn4uK4NM3SL
         LFqbhoa3+WyISp1b6Qy6Hxp8aL/GT6bZMByIzaf6pU74gqMp7rbK7vye1hAp382AA0Hq
         jn0XP4bv9hUdQXJeybhljpEESrnaJ1Rn25z+EAbalXTnFBqqGoOrm/GhlW+i+I8BlDYV
         9SKPOjBIQdr95IVsapl3FO5guG3a+6NUe+f8XI1rzPpcWEEh/+IhNf7a2D0pXPKKHpU7
         ERKaHrEJeJHvBz4wbGwc2oIasODAWBgBT2/oXJWJOO5/zE7f5hH5k2RR2geCcNVbSbbr
         An6A==
X-Received: by 10.180.19.2 with SMTP id a2mr2387203wie.42.1375460085910; Fri,
 02 Aug 2013 09:14:45 -0700 (PDT)
Received: by 10.194.81.102 with HTTP; Fri, 2 Aug 2013 09:14:45 -0700 (PDT)
In-Reply-To: <20130802152713.GA23548@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231527>

On Fri, Aug 2, 2013 at 8:27 AM, Joey Hess <joey@kitenet.net> wrote:
> Jeff King wrote:
>> By the way, Joey, I am not sure how safe "git cat-file --batch-check" is
>> for arbitrary filenames. In particular, I don't know how it would react
>> to a filename with an embedded newline (and I do not think it will undo
>> quoting). Certainly that does not excuse this regression; even if what
>> you are doing is not 100% reliable, it is good enough in sane situations
>> and we should not be breaking it. But you may want to double-check the
>> behavior of your scripts in such a case, and we may need to add a "-z"
>> to support it reliably.
>
> Yes, I would prefer to have a -z mode. I think my code otherwise handles
> newlines.
>
> Thanks for the quick fix. I agree that only enabling the behavior with
> %{rest} makes sense.
>
> --
> see shy jo

/methinks we've identified a gap in our test coverage.  Care to add a
test that covers the functionality that git-annex depends on?

-Brandon
