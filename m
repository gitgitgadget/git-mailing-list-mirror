From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] Reset terminal attributes when terminating git
 send-email
Date: Fri, 17 Aug 2007 18:35:44 -0400
Message-ID: <20070817183544.f2897cb3.seanlkml@sympatico.ca>
References: <11873867051906-git-send-email-seanlkml@sympatico.ca>
	<11873867051589-git-send-email-seanlkml@sympatico.ca>
	<7vr6m1g5y4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 18 00:36:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMAQl-0001vr-H8
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 00:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994AbXHQWgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Aug 2007 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbXHQWgb
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Aug 2007 18:36:31 -0400
Received: from bay0-omc1-s33.bay0.hotmail.com ([65.54.246.105]:40507 "EHLO
	bay0-omc1-s33.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752705AbXHQWgb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Aug 2007 18:36:31 -0400
Received: from BAYC1-PASMTP09.bayc1.hotmail.com ([65.54.191.182]) by bay0-omc1-s33.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 15:36:30 -0700
X-Originating-IP: [64.231.205.174]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.174]) by BAYC1-PASMTP09.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 17 Aug 2007 15:38:14 -0700
Received: from guru.attic.local ([10.10.10.28])
	by linux1 with smtp (Exim 4.43)
	id 1IMAQe-00007c-Sy; Fri, 17 Aug 2007 18:36:28 -0400
In-Reply-To: <7vr6m1g5y4.fsf@gitster.siamese.dyndns.org>
X-Mailer: Sylpheed 2.4.2 (GTK+ 2.10.13; i686-pc-linux-gnu)
X-OriginalArrivalTime: 17 Aug 2007 22:38:14.0343 (UTC) FILETIME=[4C48E570:01C7E11F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56094>

On Fri, 17 Aug 2007 15:19:15 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> I wonder if this is something Term::ReadLine when not using
> FakeTerm should and does provide...  Is this the standard
> workaround all the applications that use Term::ReadLine need to
> implement themselves?

Unfortunately Term::ReadLine (at least here with perl 5.8.8) does
not properly reset the terminal even when used in a test script
without FakeTerm.   I don't know anything about perl and couldn't
turn up any answers to this problem with Google, but maybe there
is still a better solution known.  It would sure be much nicer if
ReadLine just took care of this detail itself.

Sean
