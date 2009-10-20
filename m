From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Update working copy on push without touching several files
Date: Tue, 20 Oct 2009 18:45:59 +0200
Message-ID: <200910201846.00650.trast@student.ethz.ch>
References: <4ADDCC7A.8080607@amiryan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Alex Amiryan <alex@amiryan.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 18:46:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0Hr8-0007lF-Mo
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 18:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685AbZJTQqc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 12:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZJTQqc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 12:46:32 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:23241 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643AbZJTQqc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 12:46:32 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 18:46:35 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Tue, 20 Oct
 2009 18:46:34 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <4ADDCC7A.8080607@amiryan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130811>

Alex Amiryan wrote:
> Online versions of websites are maintained with git
> too. I need to have working copy of my remote git repository (online
> version of the site) updated by git push (which I do locally). The
> problem is that I have some files there (like database config) that have
> to be different from local ones and they must not be updated on git
> push.

My best results so far were with special config branches that are
auto-merged in post-receive.  As a simple example, post-receive might
simply be

  #!/bin/sh

  git checkout -f master^0
  git merge config

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
