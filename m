From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] Introduce new configuation option to override committer information
Date: Tue, 11 Jan 2011 15:42:14 +0100
Message-ID: <201101111542.15185.trast@student.ethz.ch>
References: <igadki$4tb$2@dough.gmane.org> <1294568989-5848-1-git-send-email-artagnon@gmail.com> <20110109172431.GA7718@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Stephen Kelly <steveire@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 15:42:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcfQV-0001FN-RY
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 15:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756039Ab1AKOmS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 09:42:18 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:33097 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753837Ab1AKOmR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 09:42:17 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 15:42:13 +0100
Received: from pctrast.inf.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Tue, 11 Jan
 2011 15:42:15 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-desktop; KDE/4.5.4; x86_64; ; )
In-Reply-To: <20110109172431.GA7718@burratino>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164949>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
> 
> > The 'user.name' and 'user.email' configuration
> > options set both author and committer information. To solve this,
> > introduce 'user.committername' and 'user.committeremail' configuration
> > options to override committer name and email respectively.
> 
> Predictably, I don't like this idea at all.  How would we explain this
> to a new user that is reading over gitconfig(5) for the first time?
> It makes the semantics of the committer and author name (that are mostly
> meant for giving credit and a contact address) much more murky.

Well, now that I'm rethinking it, the weird thing is that it does not
override in the way that the user intuitively might expect.

Assume we also had user.authoremail for completeness, and you do

  git config --global user.authoremail author@example.com
  git config --global user.committeremail committer@example.com
  git config user.email user@example.com

Probably the user would expect this to result in a uniform
user@example.com identity for the current repo, but I don't think we
can twist it that way with the current config infrastructure.  The
obvious option of having user.{author,committer}* override the more
generic user.* would be contrary to that intuition.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
