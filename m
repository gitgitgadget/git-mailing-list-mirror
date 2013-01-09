From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 16/19] reset [--mixed] --quiet: don't refresh index
Date: Wed, 9 Jan 2013 11:38:59 -0800
Message-ID: <CANiSa6jm-6Jw1kwx3h=ct302YkuE7yntj6gV8ZDraG9gtX6CZw@mail.gmail.com>
References: <1357719376-16406-1-git-send-email-martinvonz@gmail.com>
	<1357719376-16406-17-git-send-email-martinvonz@gmail.com>
	<20130109170119.GA5332@sigill.intra.peff.net>
	<CANiSa6joBuAJVHkMfNbVMHFJ6BFOh7sGRw_txRO81CKudRwsfA@mail.gmail.com>
	<7v7gnm6uhm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 20:39:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt1Uh-0002UP-T5
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 20:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932449Ab3AITjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 14:39:01 -0500
Received: from mail-ia0-f179.google.com ([209.85.210.179]:56646 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932106Ab3AITi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 14:38:59 -0500
Received: by mail-ia0-f179.google.com with SMTP id o25so1857258iad.10
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 11:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=W32leIkF2lPjgNczQGxDT4/QhAqw5xwRqci3JscDnJA=;
        b=zqVVo8idxPHa7dbDTzGhUhlT40doZJYrKX6HS/IZvRIEt1sFdjFtf7OefuPycgdjAj
         Bd4Yaa6NcwIYGBmU0EAqgiZzFxe8MjSuqFmj/wYrTBYukf2auhbpaoX3U6WPE/Mn1iKL
         FH9A09GdduPGyGC9JNlc33OifrH6i8Ahi/0LRZuVk9c/wcsFfMH/htI5SWp0E2dhLDl3
         KMYOiqtYmmVkNM55mjP1sMh96VEycZT1npw5Ixo0mYb2xZWswhZ1KY4hcU3Saweojmym
         LDCBQaJwLl72uMCD/HzZiXRY9pGcINef7SMADZQBLZbm3PaZTHBdFSBAbVAPTD2iHsUa
         +x+w==
X-Received: by 10.50.196.198 with SMTP id io6mr2696587igc.39.1357760339416;
 Wed, 09 Jan 2013 11:38:59 -0800 (PST)
Received: by 10.64.86.68 with HTTP; Wed, 9 Jan 2013 11:38:59 -0800 (PST)
In-Reply-To: <7v7gnm6uhm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213085>

On Wed, Jan 9, 2013 at 11:12 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Martin von Zweigbergk <martinvonz@gmail.com> writes:
>
> And as a Porcelain, I would rather expect it to leave the resulting
> index refreshed.

Yeah, I guess you're right. Regular users (those using only porcelain)
shouldn't notice, but it does make sense to think that the index would
be refreshed after running a porcelain. And the risk of breaking
people's scripts seems real too. I'll drop patch this from the re-roll
(which I'll also make sure I'll sign off)

(FYI, the reason I wrote this patch was because I was surprised that
"git reset" did anything with the worktree at all.)
