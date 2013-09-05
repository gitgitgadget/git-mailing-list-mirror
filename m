From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 09:06:06 +0100
Message-ID: <20130905080606.GE2582@serenity.lan>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com>
 <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
 <CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
 <xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
 <20130904081047.GB2582@serenity.lan>
 <xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
 <7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
 <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 10:06:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHUaB-0002yM-QT
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 10:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763471Ab3IEIGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 04:06:23 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:55202 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757216Ab3IEIGU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 04:06:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 773FECDA5BA;
	Thu,  5 Sep 2013 09:06:19 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7UlnMu6u9fDs; Thu,  5 Sep 2013 09:06:17 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 9CC80CDA58C;
	Thu,  5 Sep 2013 09:06:16 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 8FEEB161E1B0;
	Thu,  5 Sep 2013 09:06:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ma5i62CwGgXW; Thu,  5 Sep 2013 09:06:16 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 77A02161E46B;
	Thu,  5 Sep 2013 09:06:08 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233939>

On Wed, Sep 04, 2013 at 03:59:18PM -0700, Junio C Hamano wrote:
> Are there cases where you do not want to either rebase nor merge?
> If so what do you want to do after "git pull" fetches from the other
> side?  Nothing?

One other thing that I can see being useful occasionally is:

    git rebase @{u}@{1} --onto @{u}

which allows local commits to be replayed onto a rewritten upstream
branch.

Although I agree with your side note below that people doing this may be
better off fetching and then updating their local branch, particularly
if @{1} is not the correct reflog entry for the upstream when they
created the branch.

> 	Side note: a knee-jerk response to a "yes" answer to the
> 	last question from me has always been "then why are you
> 	running 'git pull' in the first place. The next paragraph is
> 	my attempt to extend my imagination a bit, stepping outside
> 	that reaction.
