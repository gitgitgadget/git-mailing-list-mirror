From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Wed, 20 Jan 2016 07:23:19 +0700
Message-ID: <CACsJy8Aj+_Qra312EWRsjmebd67EFQt4RP4LWFUyXUB-QCnKvQ@mail.gmail.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
 <CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
 <xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com> <CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
 <xmqqwpr56ste.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 01:23:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLgZ1-0006Xu-2d
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 01:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933373AbcATAXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 19:23:51 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:36629 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414AbcATAXu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 19:23:50 -0500
Received: by mail-lf0-f42.google.com with SMTP id h129so155105281lfh.3
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 16:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VtH+TBTQ8mJf+2KgEVUodPykYgB/rubLxUiMhbxf5eI=;
        b=DybGNjKqLdwN1KhSojoYrYYG/Nnsrb9f5KwcC9733RAv2XvrD9ikeWM8SQCFTdP2Q+
         PEGPjaKJ9HB4++J5HHT3SFuBnP4c050pmc6XI916U2aM15VM0THz6OJ3Bv+LzjwwzT2Z
         bqAfkl1s+bJaoJm0rDr//4gqQKlUcBLPxIuVj/gh7Hz5qu2n7/5w10BX/6rGbtNbP69k
         cuMaEp8qpI3w4xWga8VMxILvIVimIdr+TXYV93lI4ZtTxCtYYeVZcgCh4uxtT/CCnXoN
         88OQDqdtG8npRu6R2Vs9J7xhpQPILcQh7+3uN5mFrr1deMqElet8O1cKXMqW4rGCujD6
         kkrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=VtH+TBTQ8mJf+2KgEVUodPykYgB/rubLxUiMhbxf5eI=;
        b=NxaPBQR9ShEhHmxclUXzn75CHh90F+6mvA76S6cmUn+Rc2U+8i2+BaYbVux1YfEUik
         fowapHBBg11/EVhK4uZZw4mwdhYfWs2Dqo9I2V2g5D95pmPE62wE30KwCKjtbjgZM+ph
         ezgP461ZeeuGWeqUXD0kcx4x/pF40cK3lWg/8LO17rLzJhgTsGZUOBRTyelB2lr41BEC
         t2jh9Oq3Xpa+Pm3jpwPf7mwH1U6/lu+wa5FX6AK0ApEoxX38OHNOAsImhqFV9c0J3t5m
         zMfVfriGCwyYGeK+eLC9E1XauADgzXaJxnfoEcdjloZOt5sYBcvMXtdY9wzz3mLCyNRB
         65sA==
X-Gm-Message-State: ALoCoQkdvN/Y/eFxEDtsBp5HUi4oCqwTdoHPsJ4z3Wgg3jpd8gBCxezv3mrkYTSbhf+Ws7ZPWd+D+raWC4xBAkPXFyBn3+lhcw==
X-Received: by 10.25.208.213 with SMTP id h204mr12482153lfg.112.1453249428706;
 Tue, 19 Jan 2016 16:23:48 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 19 Jan 2016 16:23:19 -0800 (PST)
In-Reply-To: <xmqqwpr56ste.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284402>

On Wed, Jan 20, 2016 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Jan 20, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Duy Nguyen <pclouds@gmail.com> writes:
>>>
>>>> I think it's the intended behavior.
>>>
>>> Yeah, pre-commit was designed for inspecting and rejecting, not for
>>> tweaking and munging.  Perhaps "git commit" can be tightened to make
>>> sure that pre-commit that returns successfully did not muck with the
>>> working tree and the index?
>>
>> That was my impression from the docs, but then I saw this comment,
>>
>> /*
>> * Re-read the index as pre-commit hook could have updated it,
>> * and write it out as a tree.  We must do this before we invoke
>> * the editor and after we invoke run_status above.
>> */
>>
>> which comes from 2888605 (builtin-commit: fix partial-commit support -
>> 2007-11-18) that admits "the hook can modify it (the index)". And I
>> was about to update the docs, but the other way around, about updating
>> index and side effects.
>
> I do not think the comment is wrong per-se, but the code we have,
> either back then or even today, is insufficient to allow pre-commit
> hook that mucks with the fake index that is shown to it.
>
> Re-reading the in-core index at that point may help creating a
> commit whose tree matches what the hook did, but the extra change
> made by the hook is not ported forward in the real index that the
> user will use after a partial commit (and there is no easy way to do
> so cleanly--the change the hook makes may even overlap the change in
> the real index that are added but left uncommitted, and you would
> end up needing to run a threeway merge).
>
> The only sensible thing we can do at that point in the code after
> re-reading the index is to make sure that hasn't been changed by the
> pre-commit hook and complain loudly to die if we find it modified, I
> think.

OK. Two more points

 - do we catch index changes for partial commit case only? Because
when $GIT_DIR/index is used, we do not have this problem.

 - is Niek's use case still valid? If so, what do we do to support it
(at least in partial commit case)?
-- 
Duy
