From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v8 4/5] Implement line-history search (git log -L)
Date: Thu, 28 Feb 2013 20:32:55 +0100
Message-ID: <87fw0g6xp4.fsf@pctrast.inf.ethz.ch>
References: <cover.1362069310.git.trast@student.ethz.ch>
	<9af548b2a7e4a4da9eb30e99b0223f20788b4fc1.1362069310.git.trast@student.ethz.ch>
	<7vbob4iaxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Bo Yang <struggleyb.nku@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Will Palmer <wmpalmer@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:33:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UB9EP-0005aT-7Z
	for gcvg-git-2@plane.gmane.org; Thu, 28 Feb 2013 20:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757647Ab3B1TdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 14:33:03 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:26843 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab3B1TdC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 14:33:02 -0500
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Feb
 2013 20:32:57 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.209.233) by
 CAS11.d.ethz.ch (172.31.38.211) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 28 Feb 2013 20:32:59 +0100
In-Reply-To: <7vbob4iaxh.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 28 Feb 2013 09:51:38 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.209.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217252>

Junio C Hamano <gitster@pobox.com> writes:

>> +/*
>> + * NEEDSWORK: manually building a diff here is not the Right
>> + * Thing(tm).  log -L should be built into the diff pipeline.
>
> I am not sure about this design, and do not necessarily agree that
> wedging this to the diff pipeline is the right future direction.
>
> I have a feeling that "log -L" should actually be built around
> "blame".  You let blame to hit the first parent to take the blame,
> and then turn around to show a single "diff-tree" between the child
> and the parent with whatever other diff pipeline gizmo the user can
> give you from the command line.  The blame also tells you what the
> "interesting" line range were at the first parent commit you found,
> so you can re-run the same thing with an updated range.

Hrm, now that you mention it, this is actually a brilliant idea.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
