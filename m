From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "git reflog expire --all" very slow
Date: Mon, 30 Mar 2009 22:51:34 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0903302250500.4093@localhost.localdomain>
References: <alpine.LFD.2.00.0903301803190.4093@localhost.localdomain> <7vk5668g55.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0903302154000.4093@localhost.localdomain> <alpine.LFD.2.00.0903302231370.4093@localhost.localdomain>
 <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:55:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWwY-0001fU-I1
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864AbZCaFx5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 01:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755788AbZCaFx4
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:53:56 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60200 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235AbZCaFx4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:53:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5pZf8005346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 Mar 2009 22:52:06 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n2V5pYh8024019;
	Mon, 30 Mar 2009 22:51:35 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.00.0903302244580.4093@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.44 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115221>


That made no sense. It should have been:

On Mon, 30 Mar 2009, Linus Torvalds wrote:
> 
> but we care about the commits that are younger than 'expire_total' (older 
> than that, and they are pruned unconditionally), but older than 
> 'expire_unreachable' (younger than that and the date doesn't matter).
                                                  ^^^^
                                                 reachability

but other than that the commentary stands.

		Linus
