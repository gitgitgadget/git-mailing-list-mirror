From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 00/48] Libifying git apply
Date: Thu, 10 Mar 2016 16:26:40 +0700
Message-ID: <CACsJy8Bn1+zbALH347SNgGqSLR0ixCL0acW+DuUZH1g2HRS0ZA@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:27:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adwsK-0005Jh-1E
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 10:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbcCJJ1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 04:27:16 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:33012 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753988AbcCJJ1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 04:27:12 -0500
Received: by mail-lb0-f179.google.com with SMTP id k15so104395343lbg.0
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oGaTYWEIF4q+zy14/tSB4sNXOjHWtTWHfvrDcCXO1sI=;
        b=Qzz6GqmRIA9B3Ie4GC/kbDLrnZ236g7WIjr188SLMo9JD0AUXq0/FJyxJWFYFsinK8
         OaufT+B3qJcgjVmmwNGQtTrFXtZ8FN9tDQnZB4faXmc7lXKAhZntYcLBCoaFkkQhT/Pi
         m/QbzIo51wJEVqBN7S8o45XlU+jUefhaVafQM/xVMFiN8h0OfxpXhSrPpk6sAJdsZMsq
         UzgyeriEmO3CaiNd1FxxH0n7uU+iqllq9iJ17sfwM17+MbYFZM6rwsslnSLNvzd5sXrH
         zJiWoLuhnPiNRBzb5ySpKOBNDpT5L/YT8t85b80jsvkzHVHYRsKVvO4UnUoduW3+3aie
         tIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oGaTYWEIF4q+zy14/tSB4sNXOjHWtTWHfvrDcCXO1sI=;
        b=ea9qzivtVIMRAZCGmEhX3nAAd/Y4hynIedf66Rpt2RcnvB57uL97jDwaFWG5W0Ku6s
         VkUQ0E9ED6bK7RnnXhXAB4VNLeQ2L3lkWq9HJ/tWDaDJabH0w0RH0U5G4+rPROR4YrgH
         dyxUUs2hnkOl3f/7gwEg7V3epShhnEjZ5dLoaAWnkWH1C3hekurfjhkyUijeMw5Tl5wD
         d6Sl4i/fxdI+cry3D4SK9mAcbWAq+6HxjJIFjQrltsspFu3n1w7dAJh8pLHAU+nlni3K
         5JTBReobe6JLRCi3oAhpZX1imzg0Jteju+XOdr/xQ04w87kczGCr2wFWkwR8Znr5l2TH
         Q1IQ==
X-Gm-Message-State: AD7BkJKYBw5nohCn0KjWYfBB+TMVIPJpHD4bjQqSvsXb4ECdTYwn9v3YI9F2Mfht73rCz/Ppg23BLG+zkTaRTw==
X-Received: by 10.112.150.133 with SMTP id ui5mr801253lbb.12.1457602030210;
 Thu, 10 Mar 2016 01:27:10 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Thu, 10 Mar 2016 01:26:40 -0800 (PST)
In-Reply-To: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288605>

On Thu, Mar 10, 2016 at 12:48 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> This is a patch series about libifying "git apply" functionality, to
> be able to use this functionality in "git am" without spawning new
> processes. This should make "git am" and "git rebase" significantly
> faster.
>
> This has been discussed in the following thread:
>
> http://thread.gmane.org/gmane.comp.version-control.git/287236/
>
> This RFC patch series for now just gets rid of the global variables
> and refactors the code around a bit.
>
> As suggested by Junio the global variables in builtin/apply.c are just
> thrown into a single "apply_state" structure that is passed around the
> callchain. A new parameter called "state" that is a pointer to the
> "apply_state" structure comes at the beginning of the helper functions
> that need it.
>
> Before I make further changes to handle erroneous input and make the
> libified functions not die() and properly clean things up, I'd be
> happy to get some feedback.

I didn't review individual patches. Instead I redid the whole thing
(in a slightly different way) and compared my end result to yours. In
general it looks good but..

1) I think you should focus the series on moving global vars to struct
apply_state only. You can save code move patches for the later phase.
Easier to review.

2) Given that there are only four local variables shadowing global
ones, p_value, linenr and options, I think it's ok to drop 1/48 and
2/48 and keep the good old names. You just need to mention about them
and what function they are declared in in the relevant "move global
..." patch so the reviewer is aware of it.

3) Moving lock_file to struct apply_state, then putting the whole
struct on stack, could be problematic. I believe there's a global
linked list keeping references of all lock_file variables until the
end of time, so we can't destroy lock_file/apply_state until we are
certain it's safe to do so. We could simply leave lock_file as a
global var for now (with a note in struct apply_state so we don't
forget). We can always do fancy stuff like malloc() later on if we
need to.

4) I noticed on the interdiff that there are translatable strings in
this file but not marked as such. You're going to spend lots of time
reading this file and are in a very good positioin to determine if a
string should be translated (i.e. wrap _() around it) or not. So maybe
you can have a look at this in the next series too. It's absolutely ok
if you say "no" here.

5) Minor detail, but we can rename prefix_ to prefix in
init_apply_state(). There trailing underscore was there in cmd_apply
because there's the global "prefix", but it's gone now.

Looking forward to seeing you double, triple git-rebase's speed.
-- 
Duy
