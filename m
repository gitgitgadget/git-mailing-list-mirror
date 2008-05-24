From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 2/2] graph API: don't print branch lines for
	uninteresting merge parents
Date: Sat, 24 May 2008 21:25:30 +0300
Message-ID: <20080524182530.GB2997@mithlond.arda.local>
References: <7vk5hkpjj5.fsf@gitster.siamese.dyndns.org> <1211595851-11992-1-git-send-email-adam@adamsimpkins.net> <1211595851-11992-2-git-send-email-adam@adamsimpkins.net> <1211595851-11992-3-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Sat May 24 20:26:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzyRm-0007Zs-Cs
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 20:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760741AbYEXSZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 14:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759783AbYEXSZf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 14:25:35 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:38065 "EHLO
	jenni1.rokki.sonera.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759449AbYEXSZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 14:25:34 -0400
Received: from mithlond.arda.local (80.220.180.181) by jenni1.rokki.sonera.fi (8.5.014)
        id 482C7E62006FA5EC; Sat, 24 May 2008 21:25:32 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JzyQs-0004tf-SD; Sat, 24 May 2008 21:25:30 +0300
Content-Disposition: inline
In-Reply-To: <1211595851-11992-3-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82821>

Adam Simpkins wrote (2008-05-23 19:24 -0700):

> Previously, the graphing code printed lines coming out of a merge commit
> for all of its parents, even if some of them were uninteresting.  Now it
> only prints lines for interesting commits.
> 
> For example, for a merge commit where only the first parent is
> interesting, the code now prints:
> 
>   *  merge commit
>   *  interesting child
> 
> instead of:
> 
>   M  merge commit
>   |\
>   *  interesting child

I'd rather show merge commits always with M. They are still conceptually
merges even if the current log view shows only one parent. This patch
changes symbols * and M to be visual symbols, not logical symbols which
I'd prefer.

For example user may be interested in finding certain merge but chooses
to limit the output with a commit range. It helps if user can always
trust the symbols * and M to have this conceptual difference.
