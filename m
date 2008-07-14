From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH] Fix relative built-in paths to be relative to the command invocation
Date: Mon, 14 Jul 2008 10:47:06 +0200
Message-ID: <1216025226.487b128a031fd@webmail.eunet.at>
References: <7v1w1yupn4.fsf@gitster.siamese.dyndns.org> <1215981083-10815-1-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-2-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-3-git-send-email-johannes.sixt@telecom.at> <1215981083-10815-4-git-send-email-johannes.sixt@telecom.at> <alpine.DEB.1.00.0807132141130.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 10:48:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIJjA-0002QV-9Y
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 10:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528AbYGNIrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 04:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755337AbYGNIrN
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 04:47:13 -0400
Received: from smtp1.srv.eunet.at ([193.154.160.119]:56116 "EHLO
	smtp1.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289AbYGNIrM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 04:47:12 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp1.srv.eunet.at (Postfix) with ESMTPS id E9CCB34A26;
	Mon, 14 Jul 2008 10:47:08 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6E8l6sL008398;
	Mon, 14 Jul 2008 10:47:06 +0200
Received: from cm56-163-160.liwest.at (cm56-163-160.liwest.at [86.56.163.160]) 
	by webmail.eunet.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon, 14 Jul 2008 10:47:06 +0200
In-Reply-To: <alpine.DEB.1.00.0807132141130.8950@racer>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 86.56.163.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88400>

Zitat von Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Sun, 13 Jul 2008, Johannes Sixt wrote:
>
> > diff --git a/Makefile b/Makefile
> > index 4796565..2bdb9bf 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1301,7 +1301,7 @@ remove-dashes:
> >  ### Installation rules
> >
> >  ifeq ($(firstword $(subst /, ,$(template_dir))),..)
> > -template_instdir = $(gitexecdir)/$(template_dir)
> > +template_instdir = $(shell cd '$(bindir_SQ)/$(template_dir_SQ)' && pwd)
>
> What is this for?  Did the original line stop working?

Hmpf! This new line doesn't work in the intended way if the installation
destination does not exist. I'll have to find a better solution...

-- Hannes
