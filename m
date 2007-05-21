From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 13:39:15 +0200
Message-ID: <20070521113915.GA3090@diana.vm.bytemark.co.uk>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net> <20070520211103.17468.21373.stgit@lathund.dewire.com> <20070521074838.GA32510@diana.vm.bytemark.co.uk> <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com> <20070521101540.GB32510@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 21 13:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq6Gl-0002kb-Du
	for gcvg-git@gmane.org; Mon, 21 May 2007 13:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140AbXEULlg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 07:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756114AbXEULlg
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 07:41:36 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1116 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756140AbXEULlf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 07:41:35 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hq6EN-0000rO-00; Mon, 21 May 2007 12:39:15 +0100
Content-Disposition: inline
In-Reply-To: <20070521101540.GB32510@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48010>

On 2007-05-21 12:15:40 +0200, Karl Hasselstr=F6m wrote:

> We might consider having plumbing written in C or something, and
> make sure that the plumbing can be called directly if there's need,
> but it's going to complicate things greatly compared to pure Python.

What I'm (foggily) envisioning here is to rewrite parts of StGIT (as
little as possible) as a C library (libstgit.so?), and call the
library both from the Python code, and from a "plumbing" C program
(stgit-helper?). We should not try to make the library API stable,
just like the current git library.

There are two kinds of things we'd want to have in the library: (1)
things that are too slow to do in Python, and (2) things that need to
be available from stgit-helper in order to avoid Python's startup
cost, such as top/applied/unapplied for the bash completion and bash
prompt.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
