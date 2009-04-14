From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: add -e, was Re: What's cooking in git.git (Apr 2009, #02; Sun, 12)
Date: Tue, 14 Apr 2009 19:48:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de>
References: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtmjV-0003yC-F0
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 19:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755191AbZDNRqM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 13:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753769AbZDNRqL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 13:46:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:57706 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753080AbZDNRqK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 13:46:10 -0400
Received: (qmail invoked by alias); 14 Apr 2009 17:46:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp039) with SMTP; 14 Apr 2009 19:46:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gY5Q8P83gd0gJ/aB1apPJcnMlkrCrWdQcqKB0OB
	HWdw7PTMJ/LgOC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116548>

Hi,

On Sun, 12 Apr 2009, Junio C Hamano wrote:

> * js/add-edit (Wed Apr 8 23:30:24 2009 +0200) 1 commit
>  - git-add: introduce --edit (to edit the diff vs. the index)
> 
> I am Ok with the general idea, but the error detection needs to be more 
> robust than merely relying on --recount.

You mean something like saving an extra copy of the patch, and checking if 
common or removed lines were either removed or kept intact?

That might turn out to be _very_ tricky.

Example:

@@ <some numbers>
 common line
+added line
 common line
-removed line
 common line

Now, edit it, and come up with

@@ <some numbers>
 common line
+removed line
 common line

It is obvious what is meant, but is there a clear semantics a _computer_ 
could understand?  I do not think so.

If you had some other error checking in mind, please let me hear it.

Ciao,
Dscho
