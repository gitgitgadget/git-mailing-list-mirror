From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH/RFC 2/2] git rebase -i: Warn removed or dupplicated
 commits
Date: Wed, 27 May 2015 15:19:19 +0200 (CEST)
Message-ID: <579982712.39028.1432732759119.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1432676318-22852-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <1432676318-22852-2-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 27 15:19:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxbF0-0006wp-3S
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 15:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbbE0NTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 09:19:21 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:36673 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751307AbbE0NTU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2015 09:19:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 8198C276D;
	Wed, 27 May 2015 15:19:16 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQOV7d+2+yFe; Wed, 27 May 2015 15:19:16 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 6FCA52497;
	Wed, 27 May 2015 15:19:16 +0200 (CEST)
In-Reply-To: <CAPig+cQJMSjS=fiwMHE93efSsa2QYQ8TphyyfcLg7kAXRi_+cw@mail.gmail.com>
X-Originating-IP: [130.190.242.137]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git rebase -i: Warn removed or dupplicated commits
Thread-Index: c19mjbdxyIq62ZKnBNuiRVFLAHqWdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270043>

Thank you for reviewing the code. 

Eric Sunshine<sunshine@sunshineco.com> writes:
> > +       # To uppercase
> > +       checkLevel=$(echo "$checkLevel" | tr '[:lower:]' '[:upper:]')
> 
> Is there precedence elsewhere for recognizing uppercase and lowercase
> variants of config values?

It seems to be commonly used when parsing options in the C files
through strcasecmp.  For exemple, in config.c:818 :
if (!strcmp(var, "core.safecrlf")) {
	if (value && !strcasecmp(value, "warn")) {
		[...]
However we didn't see any precedence in shell files. Do you think we
should remove it?
