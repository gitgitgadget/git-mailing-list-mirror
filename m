From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Re: Pull is Evil
Date: Thu, 01 May 2014 16:21:42 -0400
Message-ID: <5362ACD6.50505@xiplink.com>
References: <536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com> <536152D3.5050107@xiplink.com> <5361598f8eaf7_4781124b2f02b@nysa.notmuch> <536173F5.7010905@xiplink.com> <53617877b41a9_41a872f308ef@nysa.notmuch> <20140501094610.GB75770@vauxhall.crustytoothpaste.net> <5362664C.8040907@xiplink.com> <20140501175623.GY6227@odin.tremily.us> <53628CB1.8010302@xiplink.com> <20140501183008.GZ6227@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu May 01 22:21:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfxTq-0005rq-GM
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 22:21:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbaEAUVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 16:21:14 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:48274 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbaEAUVO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 16:21:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp31.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 9D3433A837A;
	Thu,  1 May 2014 16:21:13 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp31.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 3AEE83A8375;
	Thu,  1 May 2014 16:21:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <20140501183008.GZ6227@odin.tremily.us>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247836>

On 14-05-01 02:30 PM, W. Trevor King wrote:
> 
> I find a local branch useful to mark the amount of the upstream branch
> that I've reviewed.  The reflog helps a bit, but I may go several
> fetches between reviews.  For newbies, I recommend avoiding detached
> HEADs, where possible, so they don't have to rely on the reflog if
> they accidentally commit and then checkout something else (ignoring
> Git's warning).

All sound practices that I think are perfectly fine.

I may be mistaken, but I think "git pull" evolved to try to address the
detached-HEAD risk (at least in part).  This risk was pretty real before the
reflog came about (I'm under the impression -- and too lazy to check -- that
"git pull" predates the reflog; please forgive me if I'm mis-perceiving the
timeline).

But these days there's hardly any risk to using a detached HEAD.  Plus
nowadays I think it's commonly accepted that using topic branches is a git
best practice.  The notion of doing work on a generically-named branch like
"maint" seems archaic.

So what benefit does "git pull" provide?

In your particular case, you're using "git pull" to help you track your
reviews of the upstream branch.  To me this seems more like you taking
advantage of a "git pull" side-effect than using the command as it is
intended to be used.  Certainly there are other ways that git can track this
for you.  A simple, aliasable, "git tag -f LastReviewPoint upstream/branch"
seems just as effective to me (but then, I'm not you).

		M.
