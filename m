From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 05/12] refs.c: pass NULL as *flags to read_ref_full
Date: Tue, 22 Jul 2014 14:44:20 -0700
Message-ID: <CAL=YDWnBKavodqxeECYAwWpx-wqUDAp7QPWEaZfB819BS70fiw@mail.gmail.com>
References: <1405549392-27306-1-git-send-email-sahlberg@google.com>
	<1405549392-27306-6-git-send-email-sahlberg@google.com>
	<xmqqd2d2l2o7.fsf@gitster.dls.corp.google.com>
	<CAL=YDWnoCqEAN8+XPiVgPqUazAbzKG2oedLGBtEwPGCJMm_ctg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:44:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9hrN-0002R0-Ii
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jul 2014 23:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756875AbaGVVoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2014 17:44:23 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:48986 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbaGVVoV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2014 17:44:21 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so552586vcb.31
        for <git@vger.kernel.org>; Tue, 22 Jul 2014 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tEHvxep3LWJKQYT2UPGjcc53Fns9TjiQCww21hwt7Ag=;
        b=YsRigvLAdmpNb1j3kjzVTywkv5tSi0KrnRq28ZajHk26700UUN1k2iCAtOYiaQRodg
         D09R+KGj9FUPLbUqTD+X0+0P3KtzmLRpxtkWczL4U0XWvStFgObTnMwg03zNuE2I/hFW
         h6T8HJg5SBU5zEk9laUDz1I+WEbTSAWaAFsnbkgprMIdc4LAQkZYXWUUcVfcmavRH6mJ
         iU1SAUfRCBawdX4QRsbbU+hv6hSN7aq0MPQhs6CkGJ61n5zDnE8ppd0G5SyaPFecAtOF
         TM7krw2KwmXkWUTFuo/h4aVyN6SMyhXB0Okt7wn5ibPrTtZXotwpr8wkmQ+/BxXaRgko
         oQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tEHvxep3LWJKQYT2UPGjcc53Fns9TjiQCww21hwt7Ag=;
        b=Gjhwl6ZMiuZP7JDaq9dnrr4ShptNwNJ2nDyPdXKuyIZbuEb89Q0YlwgR7zxuFTIhcT
         1L+4nU3IDuLrirEPD8AhArCXe0drQcQrkZSVJMZY5khw2Y3jfjZYe5+eEOb/BIqV8YXc
         jnf/Vw0wkPJMk543cbAkpvNZhS4p3pydptPN8QDSdomcGcQczHSNg7MWnptOdIKCFl3k
         NS5JhqXSDhK2KRnqWHsL8OVNk2vFKtz90nMesclMrOXQsijfx6M3pJ3Ej5n1nXnC3+o7
         zEdrGxkPQ53SEUEKA1r3Kdn6iSWhsYOmwdFvy8SoTIjrFw4w7oY4v6uZ2RhrIxRSNg7X
         /OSQ==
X-Gm-Message-State: ALoCoQk6Og6NkDNneg7wDxtf7XcYOR5LlwypIGMkflpPpNR9lLO4OyO+UVdsu/zr5RD07hrwXGg5
X-Received: by 10.220.196.207 with SMTP id eh15mr17284122vcb.78.1406065460612;
 Tue, 22 Jul 2014 14:44:20 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Tue, 22 Jul 2014 14:44:20 -0700 (PDT)
In-Reply-To: <CAL=YDWnoCqEAN8+XPiVgPqUazAbzKG2oedLGBtEwPGCJMm_ctg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254045>

On Tue, Jul 22, 2014 at 11:19 AM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> On Fri, Jul 18, 2014 at 3:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Ronnie Sahlberg <sahlberg@google.com> writes:
>>
>>> We call read_ref_full with a pointer to flags from rename_ref but since
>>> we never actually use the returned flags we can just pass NULL here instead.
>>
>> Sensible, at least for the current callers.  I had to wonder if
>> rename_ref() would never want to take advantage of the flags return
>> parameter in the future, though.  For example, would it want to act
>> differently when the given ref turns out to be a symref?
>
> I don't know.
>
> We have a check if the old refname was a symref or not since the old
> version did not have code for how to handle renaming the reflog.
> (That check is removed in a later series when we have enough
> transaction code and reflog api changes so that we no longer need to
> call rename() for the reflog handling.)
>
> I can not think of any reason right now why, but if we need it we can
> add the argument back when the need arises.
>
>> Would it
>> want to report something when the ref to be overwritten was a broken
>> one?
>
> Good point.
>
> There are two cases where the new ref could be broken.
> 1) It could either contain a broken SHA1, like if we do this :
> $ echo "Broken ref" > .git/refs/heads/foo-broken-1
> 2) or it could be broken due to having a bad/invalid name :
> $ cp .git.refs.heads.master .git/refs/heads/foo-broken-1-\*...
>
> For 2) I think this should not be allowed so the rename should just
> fail with something like :
> $ ./git branch -M foo foo-broken-1-\*...
> fatal: 'foo-broken-1-*...' is not a valid branch name.
>
> For 1)  if the new branch already exists but it has a broken SHA1, for
> that case I think we should allow rename_ref to overwrite the existing
> bad SHA1 with the new, good, SHA1 value.
> Currently this does not work in master :
> $ echo "Broken ref" > .git/refs/heads/foo-broken-1
> $ ./git branch -m foo foo-broken-1
> error: unable to resolve reference refs/heads/foo-broken-1: Invalid argument
> error: unable to lock refs/heads/foo-broken-1 for update
> fatal: Branch rename failed
>
>
> And the only way to recover is to first delete the branch as my other
> patch in this series now allows and then trying the rename again.
>
> For 1), since we are planning to overwrite the current branch with a
> new SHA1 value, I think that what makes most sense would be to treat
> the "branch exist but is broken" as if the branch did not exist at all
> and just allow overwriting it with the new good value.
>
>
>
> Currently this does not work in master :
>
> $ echo "Broken ref" > .git/refs/heads/foo-broken-1
> $ ./git branch -m foo foo-broken-1
> error: unable to resolve reference refs/heads/foo-broken-1: Invalid argument
> error: unable to lock refs/heads/foo-broken-1 for update
> fatal: Branch rename failed
> so since this is not a regression I will not update this particular
> patch series but instead I
> can add a new patch to the next patch series to allow this so that we can do :
> $ echo "Broken ref" > .git/refs/heads/foo-broken-1
> $ ./git branch -m foo foo-broken-1
> <success>
>

I have a patch to make it possible to delete a broken ref that can not
be resolved in :
https://github.com/rsahlberg/git/commit/763ab16e1874d58a4fc5c37920abc1ea40ccd814

This patch is scheduled at the end of the next patch series (use
transactions for all reflog updates) I plan to send out tomorrow.
