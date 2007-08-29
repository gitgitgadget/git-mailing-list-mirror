From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: New to git, related multi-projects
Date: Wed, 29 Aug 2007 21:52:16 +0200
Message-ID: <20070829195216.GB11824@steel.home>
References: <7F6E024B-253E-40C6-9012-9CF1B2F374D8@yahoo.ca>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?Q?Jean-Fran=E7ois?= Veillette 
	<jean_francois_veillette@yahoo.ca>
X-From: git-owner@vger.kernel.org Wed Aug 29 21:52:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQTaR-0006Om-8k
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 21:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969AbXH2TwU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 29 Aug 2007 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbXH2TwU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 15:52:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:12712 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871AbXH2TwT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 15:52:19 -0400
Received: from tigra.home (Fc9fa.f.strato-dslnet.de [195.4.201.250])
	by post.webmailer.de (klopstock mo33) (RZmta 12.1)
	with ESMTP id c0349cj7TI2Uth ; Wed, 29 Aug 2007 21:52:16 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9FD83277BD;
	Wed, 29 Aug 2007 21:52:16 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 73D65BE06; Wed, 29 Aug 2007 21:52:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7F6E024B-253E-40C6-9012-9CF1B2F374D8@yahoo.ca>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAciAx4=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56975>

Jean-Fran=E7ois Veillette, Wed, Aug 29, 2007 20:18:14 +0200:
> The company currently use cvs, it has a cvs tree where the first =20
> directory level is per client, the second directory level is the =20
> project, then inside it we have the many artifacts, like :
> cvsserver/Shared/Documentation/PresentationTemplate.doc
> cvsserver/Shared/Documentation/AnalysisTemplate.doc
> cvsserver/Shared/Devel/CommonLib/*
> cvsserver/ClientA/ProjectA/Doc/Presentation.doc
> cvsserver/ClientA/ProjectA/Doc/Analysis.doc
> cvsserver/ClientA/ProjectA/Dev/ApplicationA/*
> cvsserver/ClientA/ProjectA/Dev/ApplicationB/*
> cvsserver/ClientA/ProjectA/Dev/ApplicationC/*
> cvsserver/ClientA/ProjectA/Dev/LibraryA/*
> cvsserver/ClientA/ProjectA/Dev/LibraryB/*
>=20
> What would be the best way to represent a similar setup in git ?
> I was thinking of having a repository at the project level, and add =20
> atomic  subdirectories (code for applications and libraries for =20
> example)  as submodules.
> If submodule are the right way to go, ...

not necessarily. I'd try plain branches first, unless the client's
projects have lots of applications (or libraries, IOW, modules) and
many of them are optional for your development process. "Optional"
better fits what submodules are: their presence is supermodule is
optional too. Many fixes after introduction of the submodules was just
ignoring them :)

> ... can a submodule, include a   submodule, for example,
> ApplicationA use LibraryA and CommonLib ?

yes.
