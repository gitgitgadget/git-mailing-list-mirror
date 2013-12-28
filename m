From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: git:// protocol over SSL/TLS
Date: Sat, 28 Dec 2013 22:00:07 +0200
Message-ID: <20131228200007.GA13655@LK-Perkele-VII>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
 <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
 <7viouaj5p0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 28 21:09:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx0CD-0005Yy-4j
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 21:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025Ab3L1UJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 15:09:11 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:46626 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3L1UJK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 15:09:10 -0500
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Dec 2013 15:09:10 EST
Received: from LK-Perkele-VII (a88-112-44-140.elisa-laajakaista.fi [88.112.44.140])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id D8F6169978;
	Sat, 28 Dec 2013 22:00:07 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7viouaj5p0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239787>

On Fri, Dec 27, 2013 at 02:21:31PM -0800, Junio C Hamano wrote:
> Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:
> >
> > The Git protocol does not implement it itself but you can channel it
> > over a TLS tunnel (via stunnel for instance).  Unfortunately, this
> > means a specialized software and setup on both ends so if the question
> > was about a general client using stock Git then the answer is no, it's
> > impossible.
> 
> Hmph, I somehow had an impression that you wouldn't need anything
> more complex than a simple helper that uses git-remote-ext on the
> client side. On the remote end, you'd need to have something that
> terminates the incoming SSL/TLS and plugs it to your git daemon.

If you have some tool that can do cleartext I/O from stdin/stdout
and establishes ciphertext connection itself, you can use it with
git-remote-ext. It was written for cases exactly like that.

To do git:// inside, use the %G pseudo-argument.

-Ilari
