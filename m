From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Any way to "flatten" a series of changes in git
Date: Fri, 23 Oct 2009 07:48:44 +0200
Message-ID: <4AE143BC.7040507@viscovery.net>
References: <26ae428a0910221303n493fb7s701269d694110685@mail.gmail.com>	 <m3hbtrdu1r.fsf@localhost.localdomain> <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Fri Oct 23 07:48:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1D1A-00055e-5V
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 07:48:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824AbZJWFsm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 01:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbZJWFsm
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 01:48:42 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:58433 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJWFsl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 01:48:41 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1N1D12-0001si-L6; Fri, 23 Oct 2009 07:48:44 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5D560BC81; Fri, 23 Oct 2009 07:48:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <26ae428a0910221411l73aa7cbak5c060925ccdf4cea@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131088>

Howard Miller schrieb:
> Actually thinking some more.... I don't understand something about
> this. I don't actually want to merge or rebase with anything. I just
> want to say "make those commits a series of commits on a branch into
> just one commit with a new message". I seriously suspect I'm missing
> the point somewhere but what has that got to do with merging or
> rebasing?

The easiest way (IMHO) to achieve this is certainly:

  # start a new branch at the tip of the series
  $ git checkout -b all-in-one the-series

  # squash 17 commits
  $ git reset --soft HEAD~17
  $ git commit

Now you have a new branch 'all-in-one' that has the same contents as the
original series 'the-series', but with only one commit:

  $ git diff the-series..all-in-one  # must show no differences

-- Hannes
