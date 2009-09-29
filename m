From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: clone from url with email address as username?(escaping @
 symbol)
Date: Tue, 29 Sep 2009 22:38:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.0909292228120.23903@tvnag.unkk.fr>
References: <970bc7c80909290720i1c5566fer1c1a3db744edc609@mail.gmail.com> <fabb9a1e0909290725w616c3ea9vcb1d2c53950f7788@mail.gmail.com> <vpq1vlp962h.fsf@bauges.imag.fr> <fabb9a1e0909290732h5119170ew133d906b67e49f99@mail.gmail.com>
 <970bc7c80909290831l59b7fc4at4ec0082f42f3ef87@mail.gmail.com> <vpq63b1u1p6.fsf@bauges.imag.fr> <alpine.DEB.2.00.0909291946520.23903@tvnag.unkk.fr> <vpqws3hpqr1.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Ben Bennett <benbennett@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 29 22:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MsjT1-00029y-Ox
	for gcvg-git-2@lo.gmane.org; Tue, 29 Sep 2009 22:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZI2Ui0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Sep 2009 16:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZI2Ui0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Sep 2009 16:38:26 -0400
Received: from giant.haxx.se ([83.168.254.42]:57465 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100AbZI2Ui0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Sep 2009 16:38:26 -0400
Received: from giant.haxx.se (giant.haxx.se [83.168.254.42])
	by giant.haxx.se (8.14.3/8.14.3/Debian-9) with ESMTP id n8TKcJxJ002163;
	Tue, 29 Sep 2009 22:38:19 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <vpqws3hpqr1.fsf@bauges.imag.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129326>

On Tue, 29 Sep 2009, Matthieu Moy wrote:

>> Exactly. So curl is not "wrong", it just can't work around this user-error.
>
> It may not want work around user-errors, but you can hardly say that
> it _can't_.

It can't work around this error. In theory we could make it GUESS that one of 
the @-letters are actually supposed to be %40, but I won't. It could also 
guess that @ was accidentally a '2' with alt-gr pressed when using a nordic 
keyboard layout. Guessing here is crazy.

> Many tools do in this case, Firefox is one of them.

So what if you had that @ in your password and not in your user name?

> And anyway, trying to connect to email.com@server.com is probably the worst 
> thing it can do.

I understand that you're saying that as a git user and someone who's not into 
curl and libcurl details, but I'm in the opposite corner mostly and I claim 
that isn't at all such a bad outcome from that input. curl has that approach 
through-out its entire URL parser. It gets what it needs and then uses the 
rest unparsed. That way it is very liberal in what it accepts and it doesn't 
reject bad URLs as long as it only can extract the parts it needs.

If curl had a strict parser it would of course bluntly reject that URL at 
once.

> At least, it could warn about two @ in the URL and say it can't handle it

It could, sure. But curl has no such strict parser so it accepts all sorts of 
various violations.

I don't think this is the proper place to discuss what curl (or libcurl) 
should or shouldn't do with given URLs - but you're most welcome to bring your 
ideas and patches to the curl project and we can debate their virtues over 
there.

-- 

  / daniel.haxx.se
