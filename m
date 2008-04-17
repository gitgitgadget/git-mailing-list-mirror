From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 15:32:21 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804171530460.2879@woody.linux-foundation.org>
References: <47F15094.5050808@et.gatech.edu> <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com> <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com> <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com> <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org> <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com> <7v63uqz265.fsf@gitster.siamese.dyndns.org> <1207859579.13123.306.camel@work.sfbay.sun.com> <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com> <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo> <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org> <1208202740.25663.69.camel@work.sfbay.sun.com> <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
 <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com> <1208461808.26863.129.camel@goose.sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeremy Maitin-Shepard <jbms@cmu.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Roman V. Shaposhnik" <rvs@sun.com>
X-From: git-owner@vger.kernel.org Fri Apr 18 00:33:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmcfZ-0003vy-Sd
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 00:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754383AbYDQWco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 18:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbYDQWco
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 18:32:44 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52127 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754264AbYDQWcn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 18:32:43 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HMWNeL001952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Apr 2008 15:32:24 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HMWLvd031097;
	Thu, 17 Apr 2008 15:32:22 -0700
In-Reply-To: <1208461808.26863.129.camel@goose.sun.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.468 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79841>



On Thu, 17 Apr 2008, Roman V. Shaposhnik wrote:
> 
> Are you saying that a *remote* in-tree .gitconfig would be capable of
> affecting *local* system before the end of the clone operation?

No. But what do you do after a "git clone".

Do you, for example, do something like "git log -p" to actually see the 
commits?

And what happens if that runs an external diff viewer script that just 
happens to do a "rm -rf $HOME"?

See? The .git/config file allows you to set those kinds of things. They 
should *not* be things you download!

		Linus
