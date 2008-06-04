From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Wed, 4 Jun 2008 15:24:03 -0700 (PDT)
Message-ID: <469507.93901.qm@web31804.mail.mud.yahoo.com>
References: <7v3ant213k.fsf@gitster.siamese.dyndns.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	git@vger.kernel.org, Lea Wiemann <lewiemann@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 00:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K41Ph-0000s7-4m
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 00:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755192AbYFDWYH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 18:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbYFDWYG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 18:24:06 -0400
Received: from web31804.mail.mud.yahoo.com ([68.142.207.67]:26258 "HELO
	web31804.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753371AbYFDWYF (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Jun 2008 18:24:05 -0400
Received: (qmail 94453 invoked by uid 60001); 4 Jun 2008 22:24:03 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=AJXpnlXyR8uIMg4r/tr77oZ26BUCXRStrI1Zbu9eC4mWPAETGdmt4Lx38gEe/BX7MjOTZR/qW2ZaUukETCG95NGcNtD+iKOrg1F/KLKyNxzGslfky+sXJnnWx1wLh9A/p/42OcShf7/dGknNirFdKC15ul75GUpuQtdkZZ1y0c8=;
Received: from [99.159.44.58] by web31804.mail.mud.yahoo.com via HTTP; Wed, 04 Jun 2008 15:24:03 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <7v3ant213k.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83835>

--- On Tue, 6/3/08, Junio C Hamano <gitster@pobox.com> wrote:

> Another breakage is even though $full_rev^ _may_ exist
> (iow, $full_rev
> might not be the root commit), the file being blamed may
> not exist there
> (iow $full_rev might have introduced the file).  Instead of
> running
> "rev-parse $full_rev^", you would at least need
> to ask "rev-list -1
> $full_rev^ -- $path" or something from the Porcelain
> layer, but
> unfortunately this is rather expensive.

Yes, I've seen this too, but saw no advantage to bring it up
at the time.

> Because blame already almost knows if the commit the final
> blame lies on
> has a parent, it would be reasonably cheap to add that
> "parent or nothing"
> information to its --porcelain (and its --incremental)
> format if we wanted
> to.

Yes, I agree.  At the moment those "checks" are left to be
deduced by the person data-mining with blame.  (Which isn't /that/
bad.)

   Luben
