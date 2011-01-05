From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: False positives in git diff-index
Date: Wed, 5 Jan 2011 06:07:35 +0000
Message-ID: <AANLkTimQCMr+emw=rXdBKKnD_W9G981zCkboKgiDWxPF@mail.gmail.com>
References: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
 <AANLkTinDSCPz-oukxzn24hj94d9WpzZ8_64TBHeNTmoG@mail.gmail.com> <20110105054825.GC5884@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 05 07:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaMXS-0004Ol-51
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 07:08:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219Ab1AEGH5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jan 2011 01:07:57 -0500
Received: from mail-qy0-f194.google.com ([209.85.216.194]:57123 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948Ab1AEGH4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jan 2011 01:07:56 -0500
Received: by qyk4 with SMTP id 4so4599749qyk.1
        for <git@vger.kernel.org>; Tue, 04 Jan 2011 22:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=+fgQYLgo4lxJribCK938utNHEkNqVtOwvrrRQOnwXWk=;
        b=oOu7RpwAqe4Lp5fTblicEEUL59uOHQE/ltYY4mnadG/jGO6r9ceeXLksMkR2c0iX4e
         EtA1xxAkQYpqzILoBPt+IuAzTHLIbILLjgSb2mVcRC50VlFuqbSpA6bEffL5IIIamX4N
         G1ZNImbmwsBIKOCIAywNA69lWrfAQLngZ+j2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Pnzt6QrUVUvg/zY4n631p8SKjthODYhvRjWUB+ppz4Z4vL9nRUKOHQpTZDw2fDYyIW
         IiVSeOXn6DWYloDiRE2BDAsJKQ8J8oBCJTS5HfcqOf07IeeQXOo/ntEFbMjYAmOhm3/I
         hyjdrC8a9EjGN5enTBcuS2YsnE/84nK3GWnH0=
Received: by 10.229.95.211 with SMTP id e19mr20034628qcn.53.1294207675925;
 Tue, 04 Jan 2011 22:07:55 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Tue, 4 Jan 2011 22:07:35 -0800 (PST)
In-Reply-To: <20110105054825.GC5884@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164548>

On Wed, Jan 5, 2011 at 05:48, Jeff King <peff@peff.net> wrote:
> On Tue, Jan 04, 2011 at 12:45:33PM +0300, Alexander Gladysh wrote:
>> > Anyway, I'm ready to debug this issue if someone will guide me.

> If adding a sleep makes it work, that sounds like a race condition in
> git. But from the description of your workflow, it should be easy to
> make a minimal example:

> -- 8< --

> Basically, we generate random data which has a 20% chance of
> being the same as what's there. When it is, we should get "not bothering
> to commit", but in your error case, we would try to commit (and get "no
> changes").

> But using that script, I can't replicate your problem. Can you try
> running it on the same box you're having trouble with? That might at
> least tell us if it's your environment or something more complex going
> on.

Thank you. I tried it, and, unfortunately, it does not reproduce the problem.

Alexander.
