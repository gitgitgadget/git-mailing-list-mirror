From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: fix cases ignoring core.commentchar
Date: Sun, 18 Aug 2013 16:36:08 -0400
Message-ID: <CAPig+cR0k5c1PLxpDYCFLH=9QchhYbeB1kPNk4uRkxv5Jy5cRQ@mail.gmail.com>
References: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cTRc1-W7vJX52gb5S0ge4kZgKMBkHJjqWFRDgpuzTfM2g@mail.gmail.com>
	<CAPig+cSFoKb+v5fEXnwr=94B6uo2b57vgHTRgtFMj25M+R9dUw@mail.gmail.com>
	<7v38q6oi9a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 18 22:36:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VB9i1-0003b8-0n
	for gcvg-git-2@plane.gmane.org; Sun, 18 Aug 2013 22:36:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755818Ab3HRUgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Aug 2013 16:36:13 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35922 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3HRUgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Aug 2013 16:36:09 -0400
Received: by mail-lb0-f179.google.com with SMTP id v1so2561172lbd.10
        for <git@vger.kernel.org>; Sun, 18 Aug 2013 13:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4UHFYCzt5hTRH7CGhjDKBbR/4afuiV+CbipZaLcrRzI=;
        b=RN0If8E5YhjjwdNVIMVkowRehxwSXO2kY1/wfJlx72JUo3aK7G/iWz+lobYOOBgDTh
         BECX8HDT+JsDvHobtffwXOe3XOOQSmaLcvu8O9WXwDoqQ+BmkRb/NPIgtyw+glLqx7sK
         Xdr+m69z7oMXssOsfwPOE6dyvhj3nEGEqID8pnGfs/lWIdABfSD/KPtC6RRrB1KM6JNg
         9ur5/DSUPZmWIigHmMdHlXaEQ82qq1uRKLCwRcqBU+oszDj0iG1zLPK9QWiBmKQLJW5S
         t4sBfstE3nBs52cFUGqiseDRwPQ6QML8tMhu07e3b6rBOE5/JsNJa4KS8pAWz1cHD8QK
         CS4g==
X-Received: by 10.152.30.74 with SMTP id q10mr3334055lah.27.1376858168334;
 Sun, 18 Aug 2013 13:36:08 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 18 Aug 2013 13:36:08 -0700 (PDT)
In-Reply-To: <7v38q6oi9a.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: WXNL9Huvrl5XaHR10rA_wwC15As
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232516>

On Sun, Aug 18, 2013 at 4:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> One of the fixes in this patch addresses an oversight in
>> 180bad3d10fe3a7f (rebase -i: respect core.commentchar, 2013-02-11)
>> which is already in 'maint'. Should I split this patch in two so that
>> the one fix can be applied to 'maint'?
>
> We are so close to 1.8.4 final and I do not think it makes much
> difference in practice, but if we were shooting for the ideal, yeah,
> as that part of the patch could make core.commentchar useful for
> rebase-i users who are still on 1.8.3.X maintenance track.

I sent a v2 [1] of this submission which does split the patch into two
parts: one for 'maint' and one for 'next', with appropriate commit
messages. The actual changes to git-rebase--interactive.sh are
identical between v1 and v2.

[1]: http://git.661346.n2.nabble.com/PATCH-v2-0-2-fix-cases-of-rebase-i-ignoring-core-commentchar-td7594009.html
