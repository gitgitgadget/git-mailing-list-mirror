From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Thu, 13 Nov 2014 11:38:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com>
 <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 11:38:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XornT-000163-5L
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 11:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932452AbaKMKie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 05:38:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:58777 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932174AbaKMKid (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 05:38:33 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MAQMg-1XiqAy19Gk-00BfHI;
 Thu, 13 Nov 2014 11:38:26 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:to+epf4oHOCsXIToZZZvTk+d7jhrydyyPDLkiVxystLPc69FI3k
 2D2pFnNsa5mPjpokaD8rou+YYQGcKmuOqM2MOlQim/E0gMQdNEWAXMxEar0yrtzGD/i8jiV
 3ampeNMHDRqhaAOTDH4Be4QaEBwRdHa6hLsb3kaHYVe3N7np4zWXqaGWgr8fj/fQBoRJNjr
 idDP/in/OitGeiv6vIQWg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Nov 2014, Johannes Schindelin wrote:

> Due to that experience, the documentation also states pretty clearly that
> `updateInstead` succeeds only in updating the current branch if the
> working directory is clean.

To clarify why `updateInstead` is stricter than the `merge` scenario: when
pushing into a remote repository with attached working directory, we
cannot simply clean up merge conflicts or other problems introduced by a
merge. Indeed, it is even possible to push without having any option to
fix files in the working directory afterwards. Therefore, the
`updateInstead` feature really needs to be adamant about the working
directory being clean.

Ciao,
Johannes
