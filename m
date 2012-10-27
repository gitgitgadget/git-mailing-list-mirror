From: Enrico Weigelt <enrico.weigelt@vnc.biz>
Subject: Re: Workflow for templates?
Date: Sat, 27 Oct 2012 20:45:45 +0200 (CEST)
Message-ID: <3190de06-2eaf-4a39-91aa-9cc34c20fc8e@zcs>
References: <20121025211522.GA28437@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Josef Wolf <jw@raven.inka.de>
X-From: git-owner@vger.kernel.org Sat Oct 27 20:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSBOk-0007rC-0z
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 20:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759473Ab2J0Spt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Oct 2012 14:45:49 -0400
Received: from zcs.vnc.biz ([83.144.240.118]:18981 "EHLO zcs.vnc.biz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758808Ab2J0Spr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Oct 2012 14:45:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by zcs.vnc.biz (Postfix) with ESMTP id 8FEE962288E;
	Sat, 27 Oct 2012 20:45:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at vnc.biz
Received: from zcs.vnc.biz ([127.0.0.1])
	by localhost (zcs.vnc.biz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jvLHFj1fpipp; Sat, 27 Oct 2012 20:45:45 +0200 (CEST)
Received: from zcs.vnc.biz (zcs.vnc.biz [172.17.1.118])
	by zcs.vnc.biz (Postfix) with ESMTP id 28F9C622270;
	Sat, 27 Oct 2012 20:45:45 +0200 (CEST)
In-Reply-To: <20121025211522.GA28437@raven.wolf.lan>
X-Originating-IP: [91.43.179.174]
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC20 (Linux)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208513>

Hi,

<snip>

I'd suggest a 3 level branch hierachy (IOW: the lower level
is rebased ontop of the next higher level):

* #0: upstream branch
* #1: generic local maintenance branch
* #2: per-instance cutomization branches

Normal additions go to the lowest level #2. When you've got
some generic commit, you propagate it to the next level
(cherry-pick) and rebase layer #2 ontop of it.
Now you can send your layer #1 to upstream for integration.

When upstream updated his branch, you simply rebase #1
ontop of it, do your checks etc, then proceed to rebasing #3.

You could also introduce more intermediate layers (eg when you've
got different groups of similar instance that share certain changes)


cu
--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Kind regards=20

Enrico Weigelt=20
VNC - Virtual Network Consult GmbH=20
Head Of Development=20

Pariser Platz 4a, D-10117 Berlin
Tel.: +49 (30) 3464615-20
=46ax: +49 (30) 3464615-59

enrico.weigelt@vnc.biz; www.vnc.de=20
