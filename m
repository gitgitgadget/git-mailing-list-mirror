From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: performance problem: "git commit filename"
Date: Mon, 14 Jan 2008 15:53:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801141552090.2806@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0801121426510.2806@woody.linux-foundation.org> <alpine.LFD.1.00.0801121735020.2806@woody.linux-foundation.org> <1200352558.488.10.camel@gaara.boston.redhat.com> <7vodbohstl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 00:54:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEZ8f-00013w-RL
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 00:54:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751888AbYANXyS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 18:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbYANXyS
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 18:54:18 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:51083 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751440AbYANXyR (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Jan 2008 18:54:17 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0ENrZbt031716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 14 Jan 2008 15:53:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0ENrZFC021710;
	Mon, 14 Jan 2008 15:53:35 -0800
In-Reply-To: <7vodbohstl.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.721 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70491>



On Mon, 14 Jan 2008, Junio C Hamano wrote:
> 
> Yeah, the breakage was not about the correctness, and because I
> almost never do partial commit I did not notice it until Linus
> brought it up.

I wouldn't have noticed it either, if it wasn't for the fact that my 
kernel tree was out-of-cache for other testing reasons. When cached, the 
difference was still quite noticeable, but I would probably not have 
noticed the difference between half a second and a second and a half.

But a commit that took over a minute due to IO was very noticeable 
indeed..

		Linus
