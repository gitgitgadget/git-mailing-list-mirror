From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Hash algorithm choice
Date: Sun, 9 Aug 2009 11:35:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0908091133420.3288@localhost.localdomain>
References: <f448a46a0908090907v68542e4dw1f1c4f610cb46ca2@mail.gmail.com>  <f448a46a0908090917s102b4c83pbad6f298a8e127cc@mail.gmail.com>  <alpine.LFD.2.01.0908091038300.3288@localhost.localdomain>  <7vljls986b.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0908091116y6012caa7j6865d5fcd5d9888c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Jerome Baum <jerome@jeromebaum.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 20:35:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaDEk-00054l-6m
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 20:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbZHISfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZHISfI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 14:35:08 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41426 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752640AbZHISfH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 14:35:07 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79IZ2OE026171
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Aug 2009 11:35:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n79IZ1Rv026519;
	Sun, 9 Aug 2009 11:35:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <fabb9a1e0908091116y6012caa7j6865d5fcd5d9888c@mail.gmail.com>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.465 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125362>



On Sun, 9 Aug 2009, Sverre Rabbelier wrote:
>
> Wouldn't the transport code also have to be modified? I assume git's
> integrity checking would yell at if you gave it commits with
> non-sha1-hashes and have no way to tell it that that hash was
> calculated with a non-sha1-hash at clone time?

Well, if you start introducing new hashes, the assumption is that all 
git's that access it would have to be updated.

You certainly could never pull/push between git versions that don't know 
about each others hashes. But you _can_ autodetect the hash mechanism 
(simple: just try them all on the first object you encounter)

		Linus
