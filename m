From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Intricacies of submodules
Date: Thu, 17 Apr 2008 12:06:06 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0804171158360.2879@woody.linux-foundation.org>
References: <47F15094.5050808@et.gatech.edu> <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com> <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com> <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com> <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org> <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com> <7v63uqz265.fsf@gitster.siamese.dyndns.org> <1207859579.13123.306.camel@work.sfbay.sun.com> <7vd4oxufwf.fsf@gitster.siamese.dyndns.org>
 <46dff0320804110904w531035f4w79c1889bc90c09ee@mail.gmail.com> <7vmyo0owep.fsf@gitster.siamese.dyndns.org> <1207970038.10408.8.camel@ginkgo> <7vlk3jlkrr.fsf@gitster.siamese.dyndns.org> <1208202740.25663.69.camel@work.sfbay.sun.com> <7vd4or7wdt.fsf@gitster.siamese.dyndns.org>
 <1208317795.26863.91.camel@goose.sun.com> <87lk3c4ali.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Roman V. Shaposhnik" <rvs@sun.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ping Yin <pkufranky@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Thu Apr 17 21:31:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmZSD-0001O9-FF
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 21:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbYDQTGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 15:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753139AbYDQTGe
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 15:06:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53255 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752859AbYDQTGe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Apr 2008 15:06:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HJ682A021042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 17 Apr 2008 12:06:10 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3HJ66jA023365;
	Thu, 17 Apr 2008 12:06:07 -0700
In-Reply-To: <87lk3c4ali.fsf@jeremyms.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.47 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79812>



On Thu, 17 Apr 2008, Jeremy Maitin-Shepard wrote:
> 
> There is a huge difference: if you allow in-tree .gitconfig by default,
> then git clone <some-repository> becomes an unsafe operation.

I have to agree.

The git config file is rather powerful, with things like aliases etc that 
can be used to run external programs (and with the external diff 
functionality that includes it for very basic and default operations), and 
ways of subtly (and not so subtly) rewriting repository information etc 
etc.

So if we do end up doing a "tracked config file", I'd personally very much 
prefer it be limited in some way. For example, we obviously track the 
.gitignore and .gitattributes files, but they are much more limited in 
their effects. Maybe we could have a "limited config file" that allows for 
*some* config options to be set?

		Linus
