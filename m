From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] setup.py: fix error message when running with python-2.3
Date: Sat, 12 Jul 2008 07:19:37 +0200
Message-ID: <20080712051937.GA17996@diana.vm.bytemark.co.uk>
References: <20080711200735.GK10347@genesis.frugalware.org> <1215806972-18713-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Petr Baudis <pasky@suse.cz>,
	Git Mailing List <git@vger.kernel.org>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 12 07:22:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHXZH-0006xY-WE
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 07:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbYGLFU3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jul 2008 01:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbYGLFU3
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 01:20:29 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2239 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbYGLFU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 01:20:29 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KHXWD-0004lX-00; Sat, 12 Jul 2008 06:19:37 +0100
Content-Disposition: inline
In-Reply-To: <1215806972-18713-1-git-send-email-vmiklos@frugalware.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88220>

On 2008-07-11 22:09:31 +0200, Miklos Vajna wrote:

> When setup.py tries to check the python version, the check actually
> won't give a usable error message but it'll raise a SyntaxError. Fix
> this by not using generator expressions.

> -    pyver =3D '.'.join(str(n) for n in sys.version_info)
> +    pyver =3D '.'.join(map(lambda x: str(x), sys.version_info))

Thanks. And by not using a list comprehension, you stay compatible
with pre-2.0 versions as well (though I guess we'd need to test that,
since there may be other 2.0 things we rely on in this code path).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
