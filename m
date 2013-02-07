From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 01:07:04 +0530
Message-ID: <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Schubert <mschub@elegosoft.com>
X-From: git-owner@vger.kernel.org Thu Feb 07 20:37:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3XI4-0005qg-Hv
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 20:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759095Ab3BGTh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Feb 2013 14:37:26 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:61253 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab3BGThZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Feb 2013 14:37:25 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so3280156oag.14
        for <git@vger.kernel.org>; Thu, 07 Feb 2013 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=D6Pbgmc+PRlyaeCAFNsqknbiA0V7DgbeGuOmaOMIy74=;
        b=LHvl6ext15HnannRw8ogh+WedaGDwqXCFldR9Fqz269SILfzjXCs2VZAGSNp++XYEl
         vOW0UbIo7+b9zfDgGgMTox+A8Vq73weQ1IadsioLtftcbt3sH5gI+OOoLKv/vJv066ZW
         jLL3Rp1HOmvN5qyb+dRSzq28+AxUsd1FaX9PHPNAsbO8TwqV8l0w57xo69Pl0CGzEf3u
         NgEx4Fb99q0E6PtGk8dooT97rP1DUiMBxoiPz2ZnOhglGPaIZj4H1OHwm5ZZQlaqDHMn
         rfLeQJUhf5zS69bC5At82/+LRGwia038VgsFNjosEvZKU4RVwVV0LB+R3U+W9a0523Fc
         6+NQ==
X-Received: by 10.60.169.203 with SMTP id ag11mr2085840oec.124.1360265844607;
 Thu, 07 Feb 2013 11:37:24 -0800 (PST)
Received: by 10.76.128.79 with HTTP; Thu, 7 Feb 2013 11:37:04 -0800 (PST)
In-Reply-To: <5113E849.8000602@elegosoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215717>

There's a reason why remote.<name>.pushurl feels wrong.  If one remote
has a different push from pull, there should be something
corresponding to refs/remotes/* for push (and the equivalent of fetch
for updating it).  Second, I can't even diff between a branch on my
push URL and a local branch: the [ahead 1, behind 1] in status output
really doesn't make sense if the repository you're pushing to is
different from the one you're pulling from.  In contrast, if you take
what I proposed, refs/remotes/{upstream, mine}/* already exist, and
it's easy to diff them with the corresponding local branch.

And yes, a regular `git push origin refs/for/master` is just retarded.
 I don't personally use Gerrit, but the people who do should not have
to suffer.
