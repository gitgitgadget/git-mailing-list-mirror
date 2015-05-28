From: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
Subject: [PATCH/RFC] send-email: allow multiple emails using --cc --to and --bcc
Date: Thu, 28 May 2015 12:42:12 +0200
Message-ID: <1432809733-4321-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Cc: Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>,
	Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 28 12:42:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxvGu-0008Do-5G
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 12:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753660AbbE1Kmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 06:42:40 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:46832 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752290AbbE1Kmi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2015 06:42:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 6B34648850;
	Thu, 28 May 2015 12:42:35 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KdoZlo1iGtCl; Thu, 28 May 2015 12:42:35 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr (zm-smtpauth-1.grenet.fr [130.190.244.122])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 5068A48849;
	Thu, 28 May 2015 12:42:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTP id 4B8DB20D6;
	Thu, 28 May 2015 12:42:35 +0200 (CEST)
Received: from zm-smtpauth-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q-qUHk8K03tz; Thu, 28 May 2015 12:42:35 +0200 (CEST)
Received: from Groseille.grenet.fr (wificampus-031226.grenet.fr [130.190.31.226])
	by zm-smtpauth-1.grenet.fr (Postfix) with ESMTPSA id 3260320D4;
	Thu, 28 May 2015 12:42:35 +0200 (CEST)
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270134>

Hello,

I've corrected an old patch from an Ensimag student.
(http://thread.gmane.org/gmane.comp.version-control.git/228182). This
patch allows multiple email addresses for options --cc, --to and
--bcc. As said in the commit message, this patch doesn't handle commas
in name, and the only possibility for using commas in name is to use the
rfc2047 syntax:

To: =?ISO-8859-1?Q?Ex=2C_ample?= <to@a.com>

I would like to add the possibility to use the following command lines:

    git send-email --to '"Ex, am ple" <to@a.com>'

    git send-email --to '"Ex, am" "ple" <to@a.com>'

    git send-email --to "\"Ex, am ple\" <to@a.com>"

    git send-email --to "\"Ex, am\" \"ple\" <to@a.com>"


Here are my questions :
Is this a good idea to handle commas in name ?
Do you have any suggestion about proposed syntaxes ?
