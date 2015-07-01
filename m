From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] worktree: replace "checkout --to" with "worktree new"
Date: Wed, 1 Jul 2015 14:18:53 -0400
Message-ID: <CAPig+cQ7yT6mGY=hFC5gKE7GSch-_tL0u8H+haJFr3FPXjjhqw@mail.gmail.com>
References: <1435640202-95945-1-git-send-email-sunshine@sunshineco.com>
	<xmqqr3orakex.fsf@gitster.dls.corp.google.com>
	<CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 20:19:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAMb7-0000yP-8H
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 20:19:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbbGASSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 14:18:55 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33839 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072AbbGASSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 14:18:54 -0400
Received: by ykfy125 with SMTP id y125so46741381ykf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=68gZEAjPVROH6HpVAMngz0sBQoDseO8IavYonf80MXw=;
        b=Cymh4L6kUCUkEgvLKgKIhynCTLWcqmuQpClHAFnpnkyIc9OEU64s02OsBSIqdDXkwp
         NpnPQBBhnr6X9w129M0+YgXd3OW8BSPhQhxU6rQsyxTHAxB0u6gc+VJ+XTD4wLnusZPI
         T10JwadJhCGz7oceW3vKH9Bl1Ir9ygatBVXMD6LyMyezofvHfFbov9tIJQujLqtO5w9f
         S/wYjUrV4AHTgABzdsPKWR/iVOUqIJeSdb6LQpv/3bUOK2wrgY/ZgNdtXppQKdez9IFp
         CiQj+GdOkDuuBr7jjohCw17zBDfGBKAJx9ZTU7wfjhtugR64oD6k3SGuiVPGudNxlpv7
         fGkA==
X-Received: by 10.129.70.69 with SMTP id t66mr19974403ywa.4.1435774734007;
 Wed, 01 Jul 2015 11:18:54 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Wed, 1 Jul 2015 11:18:53 -0700 (PDT)
In-Reply-To: <CAPig+cRLpJK-C7MApH1vigZS=gmHNeo6RL3S2wXv4B-TFfnq4g@mail.gmail.com>
X-Google-Sender-Auth: NTo3KfKXXC4HfA_27GJyWaKRxYw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273176>

On Wed, Jul 1, 2015 at 1:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 1, 2015 at 12:53 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>  * Duy seems to think "worktree add" is coming, too, so here is a
>>    trivial tweak of your patch from the last month, with test
>>    adjustments to 7410 I sent earlier squashed in.
>
> Thanks. I was planning on re-rolling to use the new name ("add" rather
> than "new") and to squash in the t7410 fix. Plus, I think the changes
> I had to make to prepare_linked_checkout() in order to move it to
> worktree.c should become separate preparatory patches so that the
> actual relocation can become pure code movement (as much as possible).
>
> Also, I was planning on including Duy's patch in the re-roll since it
> missed a s/prune --worktrees/worktree prune/ in
> Documentation/git-checkout.txt.

Hmm, I see that Duy's patch is already in 'next'. Would it be better
if I fixed the 's/prune --worktrees/worktree prune/' git-checkout.txt
oversight via an incremental patch rather than including a corrected
version of his patch with my re-roll?
