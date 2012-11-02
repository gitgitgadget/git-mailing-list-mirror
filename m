From: Jeff King <peff@peff.net>
Subject: Re: Wishlist: git commit --no-edit
Date: Fri, 2 Nov 2012 08:45:22 -0400
Message-ID: <20121102124522.GA6817@sigill.intra.peff.net>
References: <nntxt8ice9.fsf@stalhein.lysator.liu.se>
 <vpqfw4sgx33.fsf@grenoble-inp.fr>
 <20121102095954.GB30221@sigill.intra.peff.net>
 <CACnwZYe-za3Q0qvkfQ=qatB1-8eLUFA6ZzfS41yeqrV=8rVzGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 13:45:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUGd0-0007BD-Po
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 13:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab2KBMp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 08:45:26 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54377 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab2KBMpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2012 08:45:25 -0400
Received: (qmail 3797 invoked by uid 107); 2 Nov 2012 12:46:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Nov 2012 08:46:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Nov 2012 08:45:22 -0400
Content-Disposition: inline
In-Reply-To: <CACnwZYe-za3Q0qvkfQ=qatB1-8eLUFA6ZzfS41yeqrV=8rVzGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208925>

[+cc git@vger; please keep discussion on list]

On Fri, Nov 02, 2012 at 10:37:27AM -0200, Thiago Farina wrote:

> >> >   git commit --amend --no-edit
> [...]
> > Yup, should be working since 1.7.9.
> [...]
> I doesn't appear in the help either:
> 
> $ git version
> git version 1.8.0.rc2
> 
> $ git commit -h 2>&1 | grep edit
>     -c, --reedit-message <commit>
>                           reuse and edit message from specified commit
>     -e, --edit            force edit of commit

Yeah, parse_options doesn't advertise negative forms of boolean options,
as they are implied. I don't think it's a big deal, especially now that
it is covered in more detail in the manpage.

I think changing it would probably involve adding "--no-edit" as a
separate entry in the options struct.

-Peff
