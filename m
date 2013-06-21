From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t/t5800-remote-testpy: skip all tests if not built
Date: Fri, 21 Jun 2013 12:07:50 +0530
Message-ID: <CALkWK0ky+zYk+7s8yK6VeA+2xyQ41TfoREym2jq3L77q5MTpzA@mail.gmail.com>
References: <1371586006-16289-1-git-send-email-artagnon@gmail.com>
 <7vip1b40zb.fsf@alter.siamese.dyndns.org> <CALkWK0=6ot9ZXEyMmO1ZtEXPi5H1JXXvG5j6yvBeE56H9zQBwg@mail.gmail.com>
 <20130621053112.GA9634@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 21 08:38:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpuzT-0004KU-JF
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 08:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422945Ab3FUGib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 02:38:31 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:44199 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652Ab3FUGia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 02:38:30 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so18715932iea.4
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lsGVkxIQigBuqc9iMhpWWnWUqyQMgDJT7ud/kxisUKM=;
        b=I+wixbHAszTe4VutZMimfjjHnDQfeoAg63EoZAxJw7hYL0fqrixuzxe/lCqOgU6mgk
         x/snT66AHSbv2JDhC1jTgkl0w3CwCFjM45rbdCKLrbH9l87p9VloSylmBErp3kZtUmP+
         tYku5OO9riZpWPJcj+tVRfy7p0mNj0JUWnbHsR9Ighe8Anv8gubP6T02e37KFPOG/sJI
         Co25nDoQBshYWKv36M3fDYZsl5kvz/REMBuX55ihZPWDoOeSQFT3tjY470Extt8G5sfp
         euFg23D3B+TbUsKyRWKqPXyhk6qVrV/Vyk5ypkQmBTcUbIFDBUvRXXygzcQT4G4tl9bG
         IetQ==
X-Received: by 10.50.47.105 with SMTP id c9mr1393215ign.50.1371796710333; Thu,
 20 Jun 2013 23:38:30 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Thu, 20 Jun 2013 23:37:50 -0700 (PDT)
In-Reply-To: <20130621053112.GA9634@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228577>

Jeff King wrote:
> So I do not see any problem with the current Makefile. Running "make" or
> "make test" should let t5800 pass. Can you describe how you are
> triggering the issue in more detail?

master, at the time of reporting the issue:

  artagnon|master=:~/src/git$ make -j 8
  artagnon|master=:~/src/git$ rm git-remote-testpy
  artagnon|master=:~/src/git$ make -j 8
  artagnon|master=:~/src/git$ cd t
  artagnon|master=:~/src/git$ sh t5800-remote-testpy.sh
  # failure

Yesterday's jc publish fixed it: 6c473a5 (build: generate and clean
test scripts, 2013-06-07) graduated to master; it adds $NO_INSTALL to
the target "all", among other things.

> [...]

Yes, I agree that it is convoluted and can be cleaned up.
