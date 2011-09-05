From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Dropping '+' from fetch = +refs/heads/*:refs/remotes/origin/*?
Date: Mon, 5 Sep 2011 13:53:42 -0700
Message-ID: <CAJo=hJtvU+ujYBMvrgVJpBdaTUq+NOsQwVFkL-A4pHv-CRPdDg@mail.gmail.com>
References: <7vliu8w25g.fsf@alter.siamese.dyndns.org> <20110902000039.GB9339@sigill.intra.peff.net>
 <4E6088F9.5070102@drmicha.warpmail.net> <20110902152947.GB19213@sigill.intra.peff.net>
 <7v4o0uncq0.fsf@alter.siamese.dyndns.org> <20110902162524.GC19690@sigill.intra.peff.net>
 <CAJo=hJtuUe1ajjW9dNU4JzjE+P94a42W7ZvC+iQBQTeGXVvS8Q@mail.gmail.com> <20110905204729.GB4221@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 22:54:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0gBG-0005fo-Tx
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 22:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753910Ab1IEUyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 16:54:05 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:59681 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891Ab1IEUyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 16:54:03 -0400
Received: by yie30 with SMTP id 30so3596600yie.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 13:54:02 -0700 (PDT)
Received: by 10.43.44.66 with SMTP id uf2mr4302304icb.495.1315256042151; Mon,
 05 Sep 2011 13:54:02 -0700 (PDT)
Received: by 10.42.163.70 with HTTP; Mon, 5 Sep 2011 13:53:42 -0700 (PDT)
In-Reply-To: <20110905204729.GB4221@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180761>

On Mon, Sep 5, 2011 at 13:47, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 05, 2011 at 11:15:26AM -0700, Shawn O. Pearce wrote:
>> Maybe instead of getting a project policy from the server, we observe
>> the server's behavior over time from the client's reflog.
>
> Hmm. That would probably work most of the time in practice. But it seems
> like it would be quite confusing when the heuristic is wrong (e.g.,
> Junio rewinds next once every few months, and other than that, it always
> fast forwards). On the other hand, if the failure mode of the heuristic
> is only a slightly bigger warning, then it's not that big a deal.

Right. Its probably a bigger failure not to warn than to warn here too.

>> The main reason to alert the user that a branch rewound is to give
>> them a chance to correct their client if they need to. If a branch
>> normally doesn't rewind (e.g. next) but then suddenly does (e.g.
>> release cycle), but I haven't used this client in 3 weeks, its nice to
>> give me more of a "HEY STUPID FIX YOUR TOPICS" warning than just the
>> little quiet "force update" we give.
>
> Sure. I'm totally open to the idea of making the non-fast-forward
> warning more obvious. Suggestions for wording (though I am tempted by
> "HEY STUPID" above ;) )?

I'm not suggesting all non-fast-forward should issue a bigger warning.
pu updates daily with a non-fast-forward. That isn't useful.

But if the local reflog hints that this reference almost never does a
non-fast-forward, and then it does, that should be a big warning.

-- 
Shawn.
