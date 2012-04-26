From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH 2/2] gitweb: Option to not display information about
 owner
Date: Thu, 26 Apr 2012 17:07:21 +0200
Message-ID: <20120426150721.GG16489@camk.edu.pl>
References: <20120403132735.GA12389@camk.edu.pl>
 <20120416213938.GB22574@camk.edu.pl>
 <201204180136.08570.jnareb@gmail.com>
 <201204191807.32410.jnareb@gmail.com>
 <20120424174114.GC15600@camk.edu.pl>
 <xmqqy5pj9kew.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 17:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNQNt-0006QL-8T
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 17:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757271Ab2DZPHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 11:07:36 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:55054 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757199Ab2DZPHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 11:07:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id B6E505F004A;
	Thu, 26 Apr 2012 17:08:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id g7aDUqj5d9IE; Thu, 26 Apr 2012 17:08:14 +0200 (CEST)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id CDD8D5F0049;
	Thu, 26 Apr 2012 17:08:14 +0200 (CEST)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id 35A534671C; Thu, 26 Apr 2012 17:07:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqy5pj9kew.fsf@junio.mtv.corp.google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196372>

On Wed, Apr 25, 2012 at 09:39:03PM -0700, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > In some setups the repository owner is not a well defined concept
> > and administrator can prefer it to be not shown. This commit add
> > and an option that enable to reach this effect.

> > Signed-off-by: Kacper Kornet <draenog@pld-linux.org>

> Among your recent three patches, this one seems to break t9500; has it
> been tested?

> [Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in string comparison (cmp) at /srv/git/t/../gitweb/gitweb.perl line 5551.
> [Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in string comparison (cmp) at /srv/git/t/../gitweb/gitweb.perl line 5551.
> [Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in hash element at /srv/git/t/../gitweb/gitweb.perl line 5401.
> [Thu Apr 26 04:32:36 2012] gitweb.perl: Use of uninitialized value in hash element at /srv/git/t/../gitweb/gitweb.perl line 5401.

> I am guessing both #5401 and #5551 are $it->{'category'} of @projects[]
> elements.

Yes, I have tested the tree with:

gitweb: Improve repository verification
gitweb: Option to omit column with time of the last change
gitweb: Option to not display information about owner

applied on top of v1.7.10. And all tests except 't91??' are passed.
Could you write on top of which revision have you applied these three
patches?

-- 
  Kacper Kornet
