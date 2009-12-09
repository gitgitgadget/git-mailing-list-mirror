From: Aaron Cohen <remleduff@gmail.com>
Subject: Re: [PATCH 0/3] Add a "fix" command to "rebase --interactive"
Date: Tue, 8 Dec 2009 23:41:01 -0500
Message-ID: <727e50150912082041l4c4c1b73s30b64be7369adc21@mail.gmail.com>
References: <cover.1259934977.git.mhagger@alum.mit.edu>
	 <7vws12r5v2.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0912041945161.21557@intel-tinevez-2-302>
	 <20091205062708.6117@nanako3.lavabit.com>
	 <7vd42t6f9i.fsf@alter.siamese.dyndns.org>
	 <20091208121314.6117@nanako3.lavabit.com>
	 <7viqchhl7h.fsf@alter.siamese.dyndns.org>
	 <20091208093515.GA32655@sigill.intra.peff.net>
	 <fabb9a1e0912080551s32295cfahf05bdc715360360@mail.gmail.com>
	 <20091209125555.6117@nanako3.lavabit.com>
Reply-To: aaron@assonance.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 05:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIEMP-0001y1-N0
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 05:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756838AbZLIEk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 23:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756824AbZLIEk5
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 23:40:57 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:33907 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756364AbZLIEk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 23:40:56 -0500
Received: by fxm5 with SMTP id 5so7057092fxm.28
        for <git@vger.kernel.org>; Tue, 08 Dec 2009 20:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=+ZqyyUosrfRZOmEcgwEm4lHoAhfbc64gitpuLuoWoaQ=;
        b=a+ix3I09r+h6UaPYnIBCWjOxXB8VcDKv7FnZ0WGDHDUSgMn6etD4tien5TYGrlXhXx
         Z4dzgwLhJApznt/pbJZSZGv69SorP7IT9IL9q2wjTuIb9qYm48/Ku+qydCaOBckEIofM
         J75SNayeAXgUZZAI8xUC6wZCTPqHytjIcoNQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=j5OEu2mrdwEMVgYADH7qJMu4hdt/XYyXJkHF3wE72hmyujkUp0bcA0U6Zy15apxhJT
         8kMjK7Kdfss6mnAYSx6zUQiFl7wlQ/vIiefoRf3ZXHOrYy4/I1i/0ywODow/FzL2q8DM
         E1Nj23kdg2bR2T1oXfPBhoi09ewtVQGGbi2aM=
Received: by 10.223.4.144 with SMTP id 16mr1392350far.36.1260333661941; Tue, 
	08 Dec 2009 20:41:01 -0800 (PST)
In-Reply-To: <20091209125555.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134933>

On Tue, Dec 8, 2009 at 10:55 PM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> Quoting Sverre Rabbelier <srabbelier@gmail.com>
>
>> Heya,
>>
>> On Tue, Dec 8, 2009 at 10:35, Jeff King <peff@peff.net> wrote:
>>> $ bash
>>> $ echo "!fixup commit"
>>> bash: !fixup: event not found
>>> $ echo "fixup! commit"
>>> fixup! commit
>>
>> Speaking of which, must we use that annoying bang? I hate how bash
>> gets in my way when I try to write a commit message with a a bang in
>> it, I'd much rather use a different character that is not in risk of
>> being mistreated by my shell. (Although it seems that bash does do TRT
>> in the 'fixup!' case.)
>>
>> --
>> Cheers,
>>
>> Sverre Rabbelier
>
> There was a strong objection (I think from Johanes) against not
> using 'unusual' letters during the initial round back in June
> 2009. Even when explicitly giving '--auto-squash' from the
> command line, there can be commits with confusing titles
> like "fixup the ancient bug in cat-file" in addition to
> the ones you wanted to mark with the "fixup!" marker.
>
> --

I'm sorry to pipe in with my perhaps half-baked idea from lurkerdom,
but would autosquash make more sense designed as a hook rather than as
a special case behavior of git-rebase?

I think this feature could be implemented by having git-rebase call a
hook if supplied the --autosquash command. The hook script would be
supplied with the id of the blobs being fixed up on standard input,
and it could do whatever it wanted internally (including looking for
magic !commands in the commit messages of the blobs).

The result of the script should be the list of blobs to be commited as
a result of the script's munging, on standard output.
