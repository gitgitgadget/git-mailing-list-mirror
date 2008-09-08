From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use GIT_COMMITTER_IDENT instead of hardcoded values in
 import-tars.perl
Date: Mon, 8 Sep 2008 16:51:45 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0809081649040.13830@pacific.mpi-cbg.de.mpi-cbg.de>
References: <7v3arixm8h.fsf@gitster.siamese.dyndns.org> <1220777531-28934-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:47:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kci1X-0008HU-3r
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbYIHOqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbYIHOqR
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:46:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:57014 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751254AbYIHOqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:46:16 -0400
Received: (qmail invoked by alias); 08 Sep 2008 14:46:14 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 08 Sep 2008 16:46:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19y+BQqjVJynKx7KUC99bqQy4Ew+4WGs7luYzaKyv
	2zMU6F3IQ3iyZF
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <1220777531-28934-1-git-send-email-mh@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95255>

Hi,

On Sun, 7 Sep 2008, Mike Hommey wrote:

> -my $committer_name = 'T Ar Creator';
> -my $committer_email = 'tar@example.com';
> +chomp(my $committer_ident = `git var GIT_COMMITTER_IDENT`);
> +die 'You need to set user name and email'
> +	unless ($committer_ident =~ s/(.+ <[^>]+>).*/\1/);

I have at least one script that will be broken by this change in behavior.

To me, the issue is just like git-cvsimport, which sets the committer not 
to the actual committer, so that two people can end up with identical 
commit names, even if they cvsimported independently.  I'd like the same 
behavior for import-tars.  I actually use it that way.

Ciao,
Dscho
