From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: bisect / history preserving on rename + update
Date: Tue, 14 Aug 2007 11:33:57 +0200
Message-ID: <20070814093357.GA14010@diana.vm.bytemark.co.uk>
References: <1187080681.12828.174.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
X-From: git-owner@vger.kernel.org Tue Aug 14 11:34:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKsnW-00043o-Sd
	for gcvg-git@gmane.org; Tue, 14 Aug 2007 11:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbXHNJek convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 14 Aug 2007 05:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755812AbXHNJej
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Aug 2007 05:34:39 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2880 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXHNJeh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2007 05:34:37 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IKsmj-0003fZ-00; Tue, 14 Aug 2007 10:33:57 +0100
Content-Disposition: inline
In-Reply-To: <1187080681.12828.174.camel@chaos>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55821>

On 2007-08-14 10:38:01 +0200, Thomas Gleixner wrote:

> is there a built in way to handle the following situation:
>
> file A is renamed to B
> file A is created again and new content is added.
>
> I found only two ways to do that, which both suck:
>
> 1)
>       git-mv A B
>       git-add A
>       git commit
>
>       results in a copy A to B and lost history of B

What exactly do you mean by "lost history of B"? You do know that git
doesn't record renames? So you could just as well do

  $ mv A B
  $ create a new A
  $ git add A B
  $ git commit

> 2)
>       git-mv A B
>       git commit
>       git-add A
>       git commit
>
>       preserves the history of B, but breaks bisection because A is
>       needed to compile

Yes. I wouldn't recommend this option for that reason.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
