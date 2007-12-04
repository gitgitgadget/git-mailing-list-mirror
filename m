From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git-svn: .git/svn disk usage
Date: Tue, 4 Dec 2007 09:29:40 +0100
Message-ID: <20071204082940.GA24630@diana.vm.bytemark.co.uk>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com> <4753A43F.9060303@obry.net> <20071203064603.GA18583@old.davidb.org> <65dd6fd50712030935p242895fvc2e4576448868403@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pascal Obry <pascal@obry.net>, git@vger.kernel.org
To: Ollie Wild <aaw@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 04 09:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzTAV-0001je-Q2
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 09:30:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbXLDI34 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2007 03:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbXLDI34
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 03:29:56 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4162 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXLDI3z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 03:29:55 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IzT9w-0006Uo-00; Tue, 04 Dec 2007 08:29:40 +0000
Content-Disposition: inline
In-Reply-To: <65dd6fd50712030935p242895fvc2e4576448868403@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67020>

On 2007-12-03 09:35:22 -0800, Ollie Wild wrote:

> I'm seeing the following breakdown:
>
> 4.3G index
> 77M  unhandled.log
> 5.5G .rev_db.138bc75d-0d04-0410-961f-82ee72b054a4
>
> What exactly are the index and .rev_db files used for?

The indexes are just normal git index files, one for each branch and
tag. They're used to speed up importing new commits to the branch or
tag.

My guess is that the performance impact of deleting them between
git-svn runs would be very small, since recreating an index is cheap,
and we'd still get the speed benefit when importing several revisions
to a branch in the same run. And it'd be a very small code change too,
I think.

If nothing else, it's insane to keep the index for the tags. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
