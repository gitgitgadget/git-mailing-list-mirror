From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH] update-index: add --swap to swap index and worktree content
Date: Wed, 17 Aug 2011 21:01:35 -0400
Message-ID: <CAOeW2eG5LsNLCpdXvphRqkDZZMTRrHiA1-82ckkfWntKvQ7XFg@mail.gmail.com>
References: <1313158058-7684-1-git-send-email-pclouds@gmail.com>
	<7vippxgm6y.fsf@alter.siamese.dyndns.org>
	<20110816210108.GA13710@sigill.intra.peff.net>
	<7vbovpggva.fsf@alter.siamese.dyndns.org>
	<20110816222212.GA19471@sigill.intra.peff.net>
	<7vzkj9eza2.fsf@alter.siamese.dyndns.org>
	<20110816230654.GA21793@sigill.intra.peff.net>
	<CACsJy8Ad4xPz79jT3O64c3XsCeM8XETJ9bnjK0aisagrYN0CMA@mail.gmail.com>
	<20110817021727.GA29585@sigill.intra.peff.net>
	<CAOeW2eFx-ETS+1a5b2bUXeT8JJ0WGudKGyF6mxuqyK2OM35qQA@mail.gmail.com>
	<20110817194621.GA352@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 18 03:01:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtqzN-0002AT-Lc
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 03:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640Ab1HRBBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Aug 2011 21:01:36 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:59606 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab1HRBBg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2011 21:01:36 -0400
Received: by iye16 with SMTP id 16so2912247iye.1
        for <git@vger.kernel.org>; Wed, 17 Aug 2011 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kIwPRCQotk1SzcAzVtaGIY+cKITj0DbfGHIMGiYbQY8=;
        b=ZnYnVMkaN2VLWcoyseLQTRHrVICR9Yhat1riAyANIj7TCwY+AJqYDdx0TImojUDABk
         6p5nh7HFIMMR1du7WyOA4sb+A3wbO3M4LZioPEy9ih7224gRM5VBbyvS3Sx+Pazja6mO
         g81U2HM/e9t3fy4+J9eYrnG4nVdboWLBJzrls=
Received: by 10.231.65.73 with SMTP id h9mr280817ibi.21.1313629295328; Wed, 17
 Aug 2011 18:01:35 -0700 (PDT)
Received: by 10.231.158.71 with HTTP; Wed, 17 Aug 2011 18:01:35 -0700 (PDT)
In-Reply-To: <20110817194621.GA352@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179545>

On Wed, Aug 17, 2011 at 3:46 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 17, 2011 at 10:13:08AM -0400, Martin von Zweigbergk wrote:
>
>> >> Two reasons. I already mentioned the ability to quickly checkout index
>> >> for a quick test (though there could be more problems down that road).
>> >
>> > That's a good thought. However, in practice, I find I also need other
>> > files from the index to do a successful test. So I end up just
>> > committing what I think is right, and then afterwards do:
>>
>> Maybe a stupid question, but "update-index --swap" would swap all
>> files, right? So what "other files from the index" would there be?
>
> Hmm. I hadn't really considered swapping everything.

Ah, then I see where the misunderstanding lay. I didn't read the
patch; maybe it would have been clear if I did (and understood it).

> I suppose that
> would work, though I do worry about getting into a confused state when
> you have swapped one or more files individually, and then want to swap
> the rest out for testing.

I have a feeling that I would get confused if I started swapping more
than one individual file, so to me it feels like it's more the
possibility of swapping individual files that could cause confusion,
whether or not it is possible to swap all.

I think stashing the work tree feels more right, though. All you
really want is to get the work tree version out of the way for a
while, you don't really want it in the index.

Martin
