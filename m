From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Implement a new patch identification scheme and id command
Date: Mon, 16 Jun 2008 16:08:57 +0200
Message-ID: <20080616140857.GA24433@diana.vm.bytemark.co.uk>
References: <20080614072833.7899.91460.stgit@localhost.localdomain> <20080614094714.GC14282@diana.vm.bytemark.co.uk> <b0943d9e0806160300q55dde16fg90de0fa12e3d5dc0@mail.gmail.com> <b0943d9e0806160630m12f5bc7x39053e6c81d983c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 16:10:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8FPL-0001Jw-TA
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 16:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753749AbYFPOJM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jun 2008 10:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753715AbYFPOJL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 10:09:11 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4612 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYFPOJK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 10:09:10 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K8FOD-0006O9-00; Mon, 16 Jun 2008 15:08:57 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0806160630m12f5bc7x39053e6c81d983c0@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85190>

On 2008-06-16 14:30:32 +0100, Catalin Marinas wrote:

> What about supporting patch ranges with the new id format, something
> like:
>
>   branch:patch1..patch2,patch3
>
> or
>
>   branch:patch1..patch2 branch:patch3

Yes, that's a good idea; the endpoints of a range have to be on the
same branch no matter what, so having the branch: prefix apply to both
of the endpoint patches in "branch:patch1..patch2" is a good idea.

I'm not sure if the comma notation is worth it. And if it turns out to
have been useful, we can just advise users to write

  $ stg foo branch:{p1..p2,p3}

which the shell will expand to

  $ stg foo branch:p1..p2 branch:p3

> This way we could get rid of many --branch options.

Indeed.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
