From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 3 Mar 2014 17:04:27 +0700
Message-ID: <CACsJy8CPhTQxpnY70PxD9zFSipaJCTQPBsmReD8E9tmEgsvTRg@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
 <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-3-git-send-email-pclouds@gmail.com>
 <CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
 <CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
 <vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu> <vpq7g8bfws8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:05:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKPkC-0007Dh-Cn
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 11:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbaCCKFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 05:05:00 -0500
Received: from mail-qg0-f51.google.com ([209.85.192.51]:58592 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678AbaCCKE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 05:04:58 -0500
Received: by mail-qg0-f51.google.com with SMTP id q108so10793259qgd.10
        for <git@vger.kernel.org>; Mon, 03 Mar 2014 02:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0QAYuz9DTQzm+WLu9oEPcypTL/afHKjldTrcz0j8Ih8=;
        b=NfnInlyxQzsdtHAmCwSpKmrCIUL+pfTrSf0HeaROTRPQ7EpAZUSuPWhHyznSS04+9p
         W05tgqx1WX1OtGSiyaAIoraHU3c/D6vIhM8ga04Ci+Hc5ap1Dma0OxmibW3eU+grhGxO
         UUPMYDxXU6zuJaXH4+WAE25J40n7JcILLG5B+VERUqY5cxE9qinz53I9joDzzmFpoOa5
         rFPofjbaxKu03Gy48sTnAuKpC5A9Ozyae7N3KOLla8paJ+jhtR38hRVf1rvHqkOMapI1
         Iq573e5I+tuGxYpxiTUBVxguKyVERKgBrZhA0QTMYMG/JI5c69fVwzqDGlUo/K+1MlwG
         1zKg==
X-Received: by 10.140.40.5 with SMTP id w5mr21136476qgw.65.1393841097832; Mon,
 03 Mar 2014 02:04:57 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 3 Mar 2014 02:04:27 -0800 (PST)
In-Reply-To: <vpq7g8bfws8.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243209>

On Mon, Mar 3, 2014 at 4:37 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Or perhaps "-NUM" should fail with an error message if any of the last
>> NUM commits are merges.  In that restricted scenario (which probably
>> accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".
>
> Makes sense to me. So, -NUM would actually mean "rebase the last NUM
> commits" (as well as being an alias for HEAD~NUM), but would fail when
> it does not make sense (with an error message explaining the situation
> and pointing the user to HEAD~N if this is what he wanted).

Agreed, but..

> This would actually be a feature for me: I often want to rebase "recent
> enough" history, and when my @{upstream} isn't well positionned, I
> randomly type HEAD~N without remembering what N should be. When N is too
> small, the rebase doesn't reach the interesting commit, and when N is
> too big, it reaches a merge commit and I get a bunch of commits I'm not
> allowed to edit in my todo-list. Then I have to abort the commit
> manually. With -N failing on merge commits, the rebase would abort
> itself automatically.

would "git rebase -i --fork-point" be what you need instead? It's a
new thing, but may be what we actually should use, not this -NUM..
-- 
Duy
