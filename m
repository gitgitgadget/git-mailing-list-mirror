From: John Keeping <john@keeping.me.uk>
Subject: Re: Should "git help" respect the 'pager' setting?
Date: Thu, 30 May 2013 18:14:31 +0100
Message-ID: <20130530171431.GF17475@serenity.lan>
References: <CAKtB=OCyoN8ECYiAzXc3UiCrLfWn7Pq7_5CSQUjJ2dhbzQ2RsQ@mail.gmail.com>
 <vpqtxlko1vn.fsf@anie.imag.fr>
 <CALkWK0=RUy6=4k9uGpy2efdL8DhOnNO52rHZWSmHP3C=2a4SUw@mail.gmail.com>
 <vpqhahko0ub.fsf@anie.imag.fr>
 <CALkWK0ns3iVATnPwZ4OFJUxefyE6j-ayV3-iwh3Wr9FBZJyt1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael Campbell <michael.campbell@gmail.com>,
	git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 19:14:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui6R6-0003mQ-Bw
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 19:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965208Ab3E3ROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 13:14:45 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49675 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964940Ab3E3ROn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 13:14:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 2A6E0CDA5B7;
	Thu, 30 May 2013 18:14:43 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ORUawlMVEUCN; Thu, 30 May 2013 18:14:42 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id C5A6BCDA599;
	Thu, 30 May 2013 18:14:41 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id B929E161E0B3;
	Thu, 30 May 2013 18:14:41 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id K3Npt4s6XkvC; Thu, 30 May 2013 18:14:39 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id B35F8161E40D;
	Thu, 30 May 2013 18:14:33 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0ns3iVATnPwZ4OFJUxefyE6j-ayV3-iwh3Wr9FBZJyt1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226026>

On Thu, May 30, 2013 at 10:38:59PM +0530, Ramkumar Ramachandra wrote:
> Matthieu Moy wrote:
> > I find it a bit weird that Git sets the configuration for external
> > commands, but it may make sense. No strong opinion here.
> 
> I don't mean a setenv() kind of thing: how would we unset it after
> that?  Perhaps something like execvpe(), passing in the environment as
> an argument?

Overriding PAGER might make sense, but I'd be quite annoyed if Git
decided to override MANPAGER without providing some way to override it.

If a user sets MANPAGER then it's because they want a specific pager
when reading man pages - invoking man through "git help" shouldn't cause
it to behave differently in this case.
