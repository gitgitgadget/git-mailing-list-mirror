From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Fri, 21 Dec 2007 09:50:34 -0800
Message-ID: <7vbq8k7x91.fsf@gitster.siamese.dyndns.org>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201>
	<20071218204623.GC2875@steel.home>
	<200712182224.28152.jnareb@gmail.com>
	<20071218222032.GH2875@steel.home>
	<Pine.LNX.4.64.0712182239500.23902@racer.site>
	<56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com>
	<alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org>
	<56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
	<Pine.LNX.4.64.0712191334460.23902@racer.site>
	<fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Dana How" <danahow@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Alex Riesen" <raa.lkml@gmail.com>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 21 18:51:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5m1f-0004zI-55
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 18:51:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753181AbXLURus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 12:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbXLURus
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 12:50:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38754 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751316AbXLURur (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 12:50:47 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58F823321;
	Fri, 21 Dec 2007 12:50:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A58D0295B;
	Fri, 21 Dec 2007 12:50:36 -0500 (EST)
In-Reply-To: <fcaeb9bf0712210617x2bafa33cp15815a59fc631f45@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Fri, 21 Dec 2007 21:17:45 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69080>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

>> Note that this patch does not handle "../", and neither do I plan to.
>
> Junio's rc1 announcement got me to read this. It would be indeed
> useful as I usually work in deep subdirs. However, from my user
> perspective, the right approach is to make <treeish>:path always be
> relative to current directory. If you want absolute path, use
> <treeish>:/path. More intuitive but it breaks current behavior.

I do not know if you followed the discussion thread, but the
<treeish>:relative-path has been shown to be broken semantics,
so even if it may be "intuitive", it is intuitive only to people
who do not understand the brokenness.  Please read the one that
Dscho talks about windows drive letter and Linus agrees that is
a good analogy.

It might be possible to do <commit>:relative and apply that only
to direct user input, but I do not think it is worth the
compatibility and complexity hassle.
