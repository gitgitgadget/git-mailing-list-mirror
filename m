From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: What's cooking extra
Date: Sat, 22 May 2010 15:09:16 +0200
Message-ID: <20100522130916.GA28452@localhost>
References: <7vsk5o9d1f.fsf@alter.siamese.dyndns.org>
 <20100519170656.GA30161@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Sat May 22 15:09:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFoSG-0005Um-QU
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 15:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314Ab0EVNJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 09:09:24 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:63575 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab0EVNJX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 May 2010 09:09:23 -0400
Received: by wwb13 with SMTP id 13so25142wwb.19
        for <git@vger.kernel.org>; Sat, 22 May 2010 06:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=iQB7OwYhB4Gh05Gjwi/6uUrwvMX4Dc6A8dsokDi4+6Q=;
        b=xoprttY/ccMN7jIy/tDn1sGMkUGk4m4nnPrfWgxjA6t3P170MBNhVDUwxuOkfdJxUx
         7HhY8Uw9iQpykAYaiwTJyoa1Orz+sIi0mLkyFyGlMgtR7fEDhUURu934UmbMzeORrP7h
         a7hAJqJgZz8rOYsG0LVr6n7OnoDBX2DlRkL2Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=xaDM7hlCqdxJi+0ZaKmYVU+VEfQbpGE1kiKxVVNalkM7LsjCmn40PagKdIzYVaewvm
         qfh4915wt9sbCL7k85BcLJbB8XP0Z0H3hOB9vybwd1ph1Myz1R5muIbDGkvEb0fSCZn7
         T4giIUADZ3AO3VKH5/hVtidzYc1YlnixdB2pk=
Received: by 10.227.68.144 with SMTP id v16mr2640134wbi.156.1274533761734;
        Sat, 22 May 2010 06:09:21 -0700 (PDT)
Received: from darc.lan (p549A3CF7.dip.t-dialin.net [84.154.60.247])
        by mx.google.com with ESMTPS id h22sm15362089wbh.9.2010.05.22.06.09.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 22 May 2010 06:09:21 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OFoS4-0007Xa-FI; Sat, 22 May 2010 15:09:16 +0200
Content-Disposition: inline
In-Reply-To: <20100519170656.GA30161@pvv.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147523>

On Wed, May 19, 2010 at 07:06:56PM +0200, Finn Arne Gangstad wrote:
> On Wed, May 19, 2010 at 07:33:32AM -0700, Junio C Hamano wrote:
> 
> >  * (Eyvind Bernhardsen and Linus) Fixing the behaviour of crlf attribute;
> >    ignoring them when core.autocrlf is not in effect was a wrong design
> >    decision.
> > 
> >    I agree with what Linus said in the thread; I haven't yet looked at the
> >    discussion in the past few days.  Also I don't know where '[PATCH v2]
> >    Add "core.eol" config variable' fits in the picture.
> 
> I think this one is pretty much discussed by now, with the latest
> changes this should do pretty much what Linus wanted.

That is not the impression I got. Linus was objecting to the idea of new
attribute and configuration variables, which essentially do the same thing
but with slightly different semantics.

As soon as the existing crlf attribute is given priority over core.autocrlf,
all the problems discussed originally go away. So what exactly are the new
attributes supposed to do?

Also, could you post a truth table for all the parameters involved (eol,
crlf, core.autocrlf, core.eol). The documentation in the patches is too
confusing for me to understand even that.

And, renaming the crlf attribute to text? Where did Linus suggest that? If
we do that, we don't even have to talk about backwards compatibility any
more.

Clemens
