From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Wed, 17 Aug 2011 10:13:08 -0400
Message-ID: <CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
	<7vippxgm6y.fsf@alter.siamese.dyndns.org>
	<20110816210108.GA13710@sigill.intra.peff.net>
	<7vbovpggva.fsf@alter.siamese.dyndns.org>
	<20110816222212.GA19471@sigill.intra.peff.net>
	<7vzkj9eza2.fsf@alter.siamese.dyndns.org>
	<20110816230654.GA21793@sigill.intra.peff.net>
	<CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
	<20110817021727.GA29585@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 17 16:13:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qtgrs-0005zg-VE
	for gcvg-git-2@lo.gmane.org; Wed, 17 Aug 2011 16:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812Ab1HQONL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 10:13:11 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62312 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753728Ab1HQONJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 10:13:09 -0400
Received: by iye16 with SMTP id 16so1972851iye.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=H0EhuRqJyRqeE7PZlLwByPmEZq94aCE50RDDbGTo0Ow=;
        b=DpZJrmRe9TzkURQ3Uva1voeJ7kE2j9+yYO5fP1Fl85fUBgnXPSw3Ir7qaD5RI10Gr7
         470kZkGU2YqbJN9do1XRSpB405Q3xLMiO0k66pSnHQ9Hb9wS6PAFN2G0qyXOm5ac/655
         6giiwhK0x0XeNGieOVOc8WM/qRpBuTTtZvn3w=
Received: by 10.231.2.67 with SMTP id 3mr2295329ibi.8.1313590388804; Wed, 17
 Aug 2011 07:13:08 -0700 (PDT)
Received: by 10.231.158.71 with HTTP; Wed, 17 Aug 2011 07:13:08 -0700 (PDT)
In-Reply-To: <20110817021727.GA29585@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179511>

Hi,

On Tue, Aug 16, 2011 at 10:17 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 17, 2011 at 09:11:32AM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> Two reasons. I already mentioned the ability to quickly checkout index
>> for a quick test (though there could be more problems down that road).
>
> That's a good thought. However, in practice, I find I also need other
> files from the index to do a successful test. So I end up just
> committing what I think is right, and then afterwards do:

Maybe a stupid question, but "update-index --swap" would swap all
files, right? So what "other files from the index" would there be?

Maybe the above shows that I'm missing something. Still, would it be
possible to achieve the use case with something like the following?

git stash --keep-index
# fix up files, test etc.
git add ....
git commit
git cherry-pick --strategy=theirs stash && git stash drop

Martin
