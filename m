From: "Long, Martin" <martin@longhome.co.uk>
Subject: Re: Git commit generation numbers
Date: Fri, 15 Jul 2011 16:33:31 +0100
Message-ID: <CANfMb_-cfAWBECGcUqQA3JCObRF+dSsx_Z2iCigYeKMdh7J7Zg@mail.gmail.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
	<20110714183710.GA26820@sigill.intra.peff.net>
	<CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com>
	<20110714190844.GA26918@sigill.intra.peff.net>
	<CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com>
	<20110714200144.GE26918@sigill.intra.peff.net>
	<69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com>
	<20110714203141.GA28548@sigill.intra.peff.net>
	<CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
	<m3fwm7aox1.fsf@localhost.localdomain>
	<CANfMb_-ZxGGzpKDnhG46HK+DZ1UN+_kxccKuSrZtO41N0EFy6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 17:33:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhkOZ-0006i4-3j
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 17:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177Ab1GOPdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 11:33:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54170 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1GOPdd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 11:33:33 -0400
Received: by vxh35 with SMTP id 35so426289vxh.19
        for <git@vger.kernel.org>; Fri, 15 Jul 2011 08:33:32 -0700 (PDT)
Received: by 10.52.21.42 with SMTP id s10mr1302435vde.223.1310744011898; Fri,
 15 Jul 2011 08:33:31 -0700 (PDT)
Received: by 10.220.185.204 with HTTP; Fri, 15 Jul 2011 08:33:31 -0700 (PDT)
X-Originating-IP: [192.165.213.18]
In-Reply-To: <CANfMb_-ZxGGzpKDnhG46HK+DZ1UN+_kxccKuSrZtO41N0EFy6Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177198>

>
> Firstly, I presume the generation number would not form part of the
> SHA1 calculation? No? Cool.

I suspect this may be where my suggestion falls down. Though I suspect
there is a case for object metadata which doesn't form part of the
SHA. Would generation number tampering be a concern?

Caching offers the ability to store that metadata, to provide the same
performance gain, but maintain the integrity of the SHA chain.
However, it does still leave the generation number liable to
tampering, meaning a generic non-SHA metadata solution might be
better.

TBH, there are few situations where historical generations are useful
- finding gen numbers of tags is one of them. Most cases are going to
be for new commits, and in that case, a few new commits at the tip of
each branch will very quickly reduce the number of traversals. What
use case would really create enough traversals that it should be a
performance concern?
