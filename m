From: Josef Wolf <jw@raven.inka.de>
Subject: Re: What about SHA-1 collisions?
Date: Tue, 6 Nov 2012 23:09:38 +0100
Message-ID: <20121106220938.GH28437@raven.wolf.lan>
References: <20121106202643.GF28437@raven.wolf.lan>
 <loom.20121106T223000-502@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 06 23:10:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVrLp-00052v-5z
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 23:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277Ab2KFWKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2012 17:10:13 -0500
Received: from quechua.inka.de ([193.197.184.2]:57949 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141Ab2KFWKN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2012 17:10:13 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1TVrLX-0003HK-Nb; Tue, 06 Nov 2012 23:10:11 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
	id 82BFD760D5; Tue,  6 Nov 2012 23:09:38 +0100 (CET)
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <loom.20121106T223000-502@post.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209125>

On Tue, Nov 06, 2012 at 09:41:29PM +0000, John McKown wrote:
> Josef Wolf <jw <at> raven.inka.de> writes:
> > Just for curiosity: what would happen if such a collision would occur within
> > one repository?

> In a sense, this cannot happen.

In the scenario you described, contents of this version of file "b" are lost
and replaced by the contents of file "a". So file "b" is broken.

What happens when files "a" and "b" are added into different repositories?
File "a" is added to repos "A", and file "b" is added to repos "B". Now it
depends from which repository you fetch the collided blob first. If you fetch
it from "A", file "b" will be broken. If you fetch first from "B", your "a"
will be broken.

It becomes even more interesting, if some commit or tree object would have
the same SHA1 as some other object. I guess, in such a case the repository
would be completely hosed?
