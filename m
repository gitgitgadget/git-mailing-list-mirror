From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] tag: do not show ambiguous tag names as "tags/foo"
Date: Sun, 24 Jan 2016 18:39:05 -0500
Message-ID: <CAPig+cTq0j0ss=qw9Dx8-PqFA5WJwP0mpvoO+5=NXtOt2EUNww@mail.gmail.com>
References: <CAAB=nN=RSQuDPdg6Y2heeBXpQVdWSwFAcDDTfxE=XRSOu5gGEg@mail.gmail.com>
	<20160124071234.GA24084@sigill.intra.peff.net>
	<20160124071815.GB24084@sigill.intra.peff.net>
	<xmqqvb6iboxj.fsf@gitster.mtv.corp.google.com>
	<20160124222736.GA29115@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Pete Harlan <pgit@tento.net>,
	Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jan 25 00:39:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNUG4-0001In-IP
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 00:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbcAXXjJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 18:39:09 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33605 "EHLO
	mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbcAXXjH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 18:39:07 -0500
Received: by mail-vk0-f46.google.com with SMTP id e64so66268921vkg.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 15:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wt4eoAhuBQWOFnYq9gBJbo82qBsWdJ+P/ZbpFCkYkW0=;
        b=FnA5COWPPOPgm0NijgWe0S8vlmd3blligShjH05NFuOaDf4O0d2D+uVPsb0y7MxnDW
         D8irhTbjavBMpYrNVh5H0EVdf/Fim9rC5P9CPW3a17g8xu3jhOaDiXgMT37c9GHfEeES
         Rpq90u4wihEK7+Nq4yWI7mlAo7n5zDNwXghPnix+jPdtUyeDpTvKn65G4CF06v9W7NA+
         BtXqp2lPOSIlPh0XjKXvbbAYgO7rrEXmU0iPk2aVPc1/r+OZiEQQaAO912aKUtq8t4YB
         SyMCn9LjaPEjExOxk5UvMOk/DDyGjYSb7eE/4OkeZ4bd4OTx1jglsgR0zBW/jrNhkkl7
         LSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wt4eoAhuBQWOFnYq9gBJbo82qBsWdJ+P/ZbpFCkYkW0=;
        b=QT9FyM0Mz5qArQPt5mp78ryiKlfd6XufoM/+Ph0qZ9coeT/zAErGUn2QQv08SL2XC6
         s6syVpiYu+kxu4b66E3wCKg7P8vG5JtTYntmBsezU6m8tTGqZOBQEwUmpoDrsU92iDGU
         00zpOknpN65vYu3qIDuDgiLDXfMdtkyja84uGVchnwSQmPLE0vqSGiN890JK/nU7uVIF
         YWY4rXAfLKTIE/2HvpoMsEtWe3oVhZFGDSAL41e53oXlbN97yKOFLYGoAZfbJq68FX+f
         nOdJC/IM4DljvQTKFkAsfjk07Sqs438eavadE5SOQPezlaGa2gOotx2UnfivK9KOixJC
         /7+Q==
X-Gm-Message-State: AG10YOS8GpRcLM/rGTJMWSGCXO9oL6kLOISuoDgU9kCoWnbFzhpBOmiDBC2eCdiU3oRlBxm/rJ3U3sBVjUdYFw==
X-Received: by 10.31.47.135 with SMTP id v129mr8857710vkv.115.1453678745693;
 Sun, 24 Jan 2016 15:39:05 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sun, 24 Jan 2016 15:39:05 -0800 (PST)
In-Reply-To: <20160124222736.GA29115@sigill.intra.peff.net>
X-Google-Sender-Auth: ukygqGz-SRc0b0Ly5mHwCnDQqwk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284704>

On Sun, Jan 24, 2016 at 5:27 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jan 24, 2016 at 02:19:52PM -0800, Junio C Hamano wrote:
>> Perhaps strip=2 can be defined to "strip 2 levels of
>> hierarchy prefix no matter what that is", and strip refs/tags/foo,
>> refs/heads/foo and refs/remotes/origin/foo to foo, foo, origin/foo,
>> respectively?  The filtering natively done by the listing mode of
>> "branch" and "tags" would ensure the prefixes are always what we
>> implicitly expect, so the case we need to worry about how we should
>> signal errors becomes "what if there are not enough levels".  That
>> may be simpler to handle.
>
> Yeah, "strip=2" would also get the job done, and extends more naturally
> to the branch case.
>
> To be honest, I cannot imagine anybody using anything _but_ strip=2, but
> maybe there are special cases, like:
>
>   git for-each-ref --format='%(refname:strip=3)' refs/heads/jk/
>
> to get my list of topics, sans initials.

What if the option was named ":stripprefix=" in its most general form:

    %(refname:stripprefix=refs/tags/)

with plain:

    %(refname:stripprefix)

shorthand for ":stripprefix=refs/*/" or something?
