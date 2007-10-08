From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Trying to use git-filter-branch to compress history by removing large, obsolete binary files
Date: Mon, 8 Oct 2007 15:01:06 +0200
Message-ID: <20071008130106.GA10784@diana.vm.bytemark.co.uk>
References: <51419b2c0710071423y1b194f22gb6ccaa57303029d1@mail.gmail.com> <20071007213817.GJ31659@planck.djpig.de> <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com> <20071007221920.GF2765@steel.home> <51419b2c0710071524q16e9c593s2722dffc826e560d@mail.gmail.com> <20071007234346.GA29433@potapov> <51419b2c0710071722k576c06d9i2f4dce730eae2059@mail.gmail.com> <20071008010648.GB29433@potapov> <4709F805.8050704@op5.se> <20071008124017.GA22129@potapov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Ericsson <ae@op5.se>, Elijah Newren <newren@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:01:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesEn-0005qW-Na
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:01:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbXJHNBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 09:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753919AbXJHNBP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:01:15 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1150 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754421AbXJHNBO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:01:14 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IesEM-0002qQ-00; Mon, 08 Oct 2007 14:01:06 +0100
Content-Disposition: inline
In-Reply-To: <20071008124017.GA22129@potapov>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60317>

On 2007-10-08 16:40:17 +0400, Dmitry Potapov wrote:

> On Mon, Oct 08, 2007 at 11:27:33AM +0200, Andreas Ericsson wrote:
>
> > A clone only fetches revs reachable from a ref, so pruning
> > immediately after a clone is completely pointless.
>
> Not true. git-clone copies the whole pack, so it can contain
> unreachable objects.
[...]
> git-clone -l test/.git test2

Try without the -l option and with a file:// URL:

  git clone file:///path/to/test/.git test2

=46rom the git-clone man page:

--local::
-l::
        When the repository to clone from is on a local machine, this
        flag bypasses normal "git aware" transport mechanism and
        clones the repository by making a copy of HEAD and everything
        under objects and refs directories. The files under
        `.git/objects/` directory are hardlinked to save space when
        possible. This is now the default when the source repository
        is specified with `/path/to/repo` syntax, so it essentially is
        a no-op option. To force copying instead of hardlinking (which
        may be desirable if you are trying to make a back-up of your
        repository), but still avoid the usual "git aware" transport
        mechanism, `--no-hardlinks` can be used.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
