From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: StGit: kha/safe and kha/experimental updated
Date: Mon, 24 Mar 2008 19:26:47 +0100
Message-ID: <20080324182647.GD23337@diana.vm.bytemark.co.uk>
References: <20080319012804.GA28781@diana.vm.bytemark.co.uk> <20080319013832.GB28781@diana.vm.bytemark.co.uk> <b0943d9e0803200825y18971975qd79bf51157a97684@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alex Chiang <achiang@hp.com>,
	Angus Salkeld <ahsalkeld@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:27:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdrOa-0005nX-F5
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 19:27:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349AbYCXS1B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2008 14:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757638AbYCXS1B
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 14:27:01 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4533 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757575AbYCXS1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 14:27:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JdrNf-0008Df-00; Mon, 24 Mar 2008 18:26:47 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0803200825y18971975qd79bf51157a97684@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78072>

On 2008-03-20 15:25:04 +0000, Catalin Marinas wrote:

> We can even add aliases for 'undo' and 'redo'.

It's not entirely clear (to me at least) exactly what undo and redo
should do. Something like this maybe:

  undo: If the log begins with k "undo" entries (k >=3D 0), reset to
        log~(2k+1).

  redo: Find the most recent "undo" entry that hasn't been cancelled
        out by a "redo". If this is the most recent log entry (except
        the cancelled-out ones), reset to it; otherwise, complain that
        the last command was not an undo or redo.

I _think_ this does what one naively expects undo and redo to do.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
