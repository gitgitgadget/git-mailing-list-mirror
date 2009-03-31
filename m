From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH 6/8 v2] sh-tools: add a run_merge_tool function
Date: Wed, 1 Apr 2009 00:11:09 +0200
Message-ID: <200904010011.10296.markus.heidelberg@web.de>
References: <1238400684-14881-1-git-send-email-davvid@gmail.com> <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 00:13:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LomCm-0003VT-Qp
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 00:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbZCaWLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 18:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763667AbZCaWLL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 18:11:11 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:47695 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760649AbZCaWLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 18:11:09 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8854AF9C6BF0;
	Wed,  1 Apr 2009 00:11:05 +0200 (CEST)
Received: from [89.59.106.150] (helo=.)
	by smtp08.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LomAj-00007d-00; Wed, 01 Apr 2009 00:11:05 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <885649360903311115o6131988emdcba6ef215ec0ab0@mail.gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX18qNk4sQIMLoT/5LZv05hJZHbAEc1paANqQhpZr
	ztdJVbwqAVPhMnuS0ddaaH68vXIYJghZQ0YZsMjBaZxsVdxaO5
	Cimxu8xihzhovIGUMYFw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115322>

James Pickens, 31.03.2009:
> On Mon, Mar 30, 2009 at 1:11 AM, David Aguilar <davvid@gmail.com> wrote:
> > This function launches merge tools and will be used to refactor
> > git-(diff|merge)tool.
> 
> Thanks for writing difftool; I find it quite useful.  I tried it with
> tkdiff, and noticed that it shows the 'merge preview' window even though it
> isn't doing a merge.  If a user with unstaged changes were to carelessly
> click the 'save and exit' button, his changes could be lost.  So I think
> it's a good idea to stop the merge preview window from showing up under
> difftool.  To do that I think you just have to remove the '-o "$MERGED"'
> option to tkdiff.

This mail made me see an issue with your patch series. Sorry, I haven't
seen this earlier, my review was just scratching the surface, I merely
applied it and looked through it, but didn't actually test it. Lack of
time.

The invocations seem to be appropriate only for mergetool, it is just
the invocations from the old git-mergetool.sh, not from the old
git-difftool-helper.sh. This means, git-difftool opens 3 files instead
of 2.

I think there are preset diff tools, which opened 3 files instead of 2
before this series (I just tested kdiff3, it opened 3 files). Seems to
be originated from the fact, that they were initially copied from
git-mergetool.sh.

Markus
