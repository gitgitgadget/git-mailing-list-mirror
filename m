From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 13:55:57 +0200
Message-ID: <1309262157.2497.416.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <4E08DCB1.3080503@web.de>
	 <1309211840.2497.401.camel@Naugrim.eriador.com>  <4E0981F0.6040507@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 28 14:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWz7-00042X-NL
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 14:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757436Ab1F1L5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jun 2011 07:57:04 -0400
Received: from mail14.surf-town.net ([212.97.132.54]:52254 "EHLO
	mailgw5.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757411Ab1F1Lxb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 07:53:31 -0400
Received: by mailgw5.surf-town.net (Postfix, from userid 65534)
	id 60C3A200EF; Tue, 28 Jun 2011 13:53:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw5.surf-town.net (Postfix) with ESMTP id 3D0FF1FD44;
	Tue, 28 Jun 2011 13:53:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw5.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw5.surf-town.net ([127.0.0.1])
	by localhost (mailgw5.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gR9LJkAtNtel; Tue, 28 Jun 2011 13:53:25 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-48-227.w92-141.abo.wanadoo.fr [92.141.183.227])
	by mailgw5.surf-town.net (Postfix) with ESMTPSA id 8A282200CA;
	Tue, 28 Jun 2011 13:53:22 +0200 (CEST)
In-Reply-To: <4E0981F0.6040507@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176396>


> >>>
> >>> That is what I called "there is no direct way". Wouldn't it be nicer if
> >>> the .gitmodules file in the superproject said something like
> >>>
> >>> 	[module "project one"]
> >>> 		path = project1
> >>>         	url = ...
> >>>                 depends = lib1
> >>> 	[module "lib1"]
> >>>         	path = lib1
> >>>                 url = ...
> >>>
> >>> and then "git submodule init project1" run by the end user implied running
> >>> also "git submodule init lib1"?
> >>
> >> And if lib1 happens to have another dependency, that will be initialized
> >> too? That would make life much easier for users who only want certain
> >> submodules populated to work on, as they won't have to chase compile
> >> errors anymore until they found all necessary submodules ... very nice.
> >>
> > 
> > That is right.
> > But could also be done with the .gitmodules in project1 containing
> > 
> > 	[module "lib1"]
> >         	path = ../lib1
> >                 url = ...
> > 
> > and making implicite if the module is describe in .gitmodules that
> > mean ./ depend on it.
> 
> But that would be much more complicated than just recording that in the
> superproject's .gitmodules. In a Git repo everything lives in a directory
> tree, if you want to reference something outside of that tree things will
> get very complicated ... and I'm not sure the benefit is worth the hassle.
> 

I am actually working on the git source code to give it a try and see if
I can managed to make a patch without breaking anything else.

	Henri GEIST
