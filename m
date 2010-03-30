From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Subversion integration with git
Date: Wed, 31 Mar 2010 01:05:10 +1100
Message-ID: <52A6E51B-058C-4B06-A271-26219B388BE7@cordelta.com>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>  <40aa078e1003250731y2c900605k9c681475621a1ff2@mail.gmail.com>  <E560EF9A-AF07-4316-9047-6D1A1802F743@cordelta.com> <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 30 16:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwc4Q-0004Fk-OZ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Mar 2010 16:05:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab0C3OFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 10:05:21 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:6943
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754615Ab0C3OFU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 10:05:20 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAGOisUvLWHsF/2dsb2JhbACbLXG3FYhFhQAEigk
X-IronPort-AV: E=Sophos;i="4.51,334,1267362000"; 
   d="scan'208";a="159920531"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 31 Mar 2010 01:05:11 +1100
Received: (qmail 26053 invoked from network); 31 Mar 2010 01:05:11 +1100
Received: from d122-109-106-179.mit3.act.optusnet.com.au (HELO ?192.168.1.8?) (122.109.106.179)
  by node2.alpha.aussiehq.net.au with SMTP; 31 Mar 2010 01:05:10 +1100
In-Reply-To: <f3271551003251052j5863af46i3066f0f42788ba3b@mail.gmail.com>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143565>

Hi,

>> I think it falls very close to the native-git-svn Google SoC
>> project[1], and if you are able to share what you have I'm sure
>> Ramkumar (I hope you don't mind me CC'ing you, and that I spelled your
>> name right) would appreciate having a look.
> 
> Yes. Thank you for CC'ing me, Erik.
> 
>> Is it worthwhile to start a new project - or would it be better to grok the internals of existing projects and try to make them scale?
> 
> ... if my proposal gets accepted, I
> could work with you to get it integrated into the remote helper that
> I'll be building. Depending on the complexity of your project, this
> might only be possible at the end of my GSoC term.
> 
> 
> 
> -- Ram

I've started looking at the first piece of the pipeline, reading from a
remote subversion URL. I stumbled upon rsvndump[2], which is
GPLv3+ licensed and promises to produce a Subversion dump from
a remote repository. This could be piped to my utility,
svn-dump-fast-export[3], to produce suitable input for git fast-import.
I believe this would address the first two components of Ram's.
proposal and allow more focus to be given to the interesting ones.
That's presuming that I have a feature-complete release by the time
the GSoC project begins.

My project is currently under a two-clause BSD style license.
This is primarily because the two projects it derives from were
distributed under the same license, rather than any preference.

As I've included a reference to my project, I'll emphasise that it is a
work in progress, with a handful of known bugs.
At present, symlinks are damaged on update and some files
disappear late in the history of my test repository.
I'm planning a rewrite of the parser once symlinks are complete.

[1] http://thread.gmane.org/gmane.comp.version-control.git/142623
[2] http://rsvndump.sourceforge.net/
[3] http://github.com/barrbrain/svn-dump-fast-export/
