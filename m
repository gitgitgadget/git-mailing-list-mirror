From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Do not mess-up with commit message formatting when sending email
Date: Mon, 4 Aug 2008 16:16:40 +0200
Message-ID: <20080804141640.GB12232@diana.vm.bytemark.co.uk>
References: <20080731125005.894.10592.stgit@dawn.rfc1149.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Catalin Marinas <catalin.marinas@gmail.com>
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Aug 04 15:55:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ0XM-0003Zx-NO
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 15:55:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbYHDNyp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Aug 2008 09:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753545AbYHDNyp
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 09:54:45 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2537 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752750AbYHDNyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 09:54:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KQ0rY-0003Yx-00; Mon, 04 Aug 2008 15:16:40 +0100
Content-Disposition: inline
In-Reply-To: <20080731125005.894.10592.stgit@dawn.rfc1149.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91352>

On 2008-07-31 14:50:05 +0200, Samuel Tardieu wrote:

> The short description, which will be used as the email subject, gets
> its leading and trailing whitespaces removed.

OK, good.

> The long description only gets its trailing whitespaces removed to
> preserve commit message formatting, e.g. in the case of a
> ChangeLog-style commit message, as well as empty leading lines.

I'd like a better description of this change, please. If I'm not
mistaken, we used to do _only_ left stripping of the body. You change
that to left stripping of only newlines, but also add right stripping
for each line. I'm all for these changes, but the commit message
confused me a lot.

> -    long_descr =3D '\n'.join(descr_lines[1:]).lstrip()
> +    long_descr =3D '\n'.join([l.rstrip() for l in descr_lines[1:]]).=
lstrip('\n')

We require Python 2.4 or later, so you can skip the square brackets
here.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
