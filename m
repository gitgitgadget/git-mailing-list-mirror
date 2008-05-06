From: Sean Estabrooks <seanlkml@sympatico.ca>
Subject: Re: how to git-archive ignore some files?
Date: Tue, 6 May 2008 14:56:47 -0400
Message-ID: <BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Tue May 06 20:58:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtSMW-0005uw-JA
	for gcvg-git-2@gmane.org; Tue, 06 May 2008 20:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbYEFS5Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2008 14:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbYEFS5Q
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 14:57:16 -0400
Received: from bay0-omc2-s30.bay0.hotmail.com ([65.54.246.166]:29543 "EHLO
	bay0-omc2-s30.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755660AbYEFS5P (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2008 14:57:15 -0400
Received: from BAYC1-PASMTP02 ([65.54.191.162]) by bay0-omc2-s30.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 6 May 2008 11:57:14 -0700
X-Originating-IP: [70.54.4.86]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([70.54.4.86]) by BAYC1-PASMTP02.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 6 May 2008 11:57:14 -0700
Received: from bud.attic.local ([10.10.10.20])
	by linux1.attic.local with esmtp (Exim 4.43)
	id 1JtTHU-0004TY-FE; Tue, 06 May 2008 15:56:56 -0400
In-Reply-To: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
X-OriginalArrivalTime: 06 May 2008 18:57:14.0676 (UTC) FILETIME=[FF8C8740:01C8AFAA]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81375>

On Tue, 06 May 2008 15:15:31 -0300
Victor Bogado da Silva Lins <victor@bogado.net> wrote:

> I want to use git-archive to create source packages, but my git
> repository has a .gitignore that I don't want to be pushed into the
> archive. So is it possible to keep the .gitignore file in the repository
> and create an archive(*) without it? 
> 
> *) using git-archive, off course. 
> 

Hi Victor,

You can do something like:

git archive HEAD  | \
	tar --delete .gitignore .mailmap .gitattributes | \
	bzip2 -c > archive.tar.bz2

HTH,
Sean
