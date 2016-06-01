From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 6/6] worktree: add "unlock" command
Date: Wed, 1 Jun 2016 20:10:26 +0700
Message-ID: <CACsJy8Bt=eqOu0sifpGmKkJqSkravoVmd07zFUNk1LDQjfaM2w@mail.gmail.com>
References: <20160522104341.656-1-pclouds@gmail.com> <20160530104939.28407-1-pclouds@gmail.com>
 <20160530104939.28407-7-pclouds@gmail.com> <xmqqzir63xlg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Reto_Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 15:11:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b85vb-0006e6-Tr
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 15:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758300AbcFANLO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 09:11:14 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:38818 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758266AbcFANK5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 09:10:57 -0400
Received: by mail-it0-f48.google.com with SMTP id i127so18928265ita.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 06:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I6JZU1Up1GDGD9u/QTHfYwfO6gSv9kRP4aBN4++v7W4=;
        b=cO7NL+p2hB7ADPaUe7FpoQ5NNtfcd3pYfjMLqK2btjsYVS9/5qn954deUzQyGL0nLX
         W2x80bNr7QC+PNL7+oU3W0euwlwyNkApe7claMMI9wCQIic3nUfR3PMMdk0OxEzzAgH1
         33NbYNYfK8ra8VgYkRx7TVOHlVyn38844BUzIqW8oPpYIUWzwvBSe1Dp2wiRWz4jCSOS
         FAnyMjF3GOdSO1scyQMw/Ki6s24oXXdKPUG+DpMY5WRzueXxzj+7nd3JsRZoxDGK3lNo
         MRkQQHWhJRGaABkMpkLIutSuCbeT2ermwdMJhy9TdoTZyT07wNbnj0M5qeyGsn5CiEzN
         NAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I6JZU1Up1GDGD9u/QTHfYwfO6gSv9kRP4aBN4++v7W4=;
        b=lBatyEbnQRDxBhSjFcAyZ+5SZFGCJnrQusZ2LRJcUcUAjrLoHlA2PcxdcZCOSh4nvz
         30oHMxEv58f48aveHUjqEil8qTdvSpg0oTOO/jmfFGoSyk8+eihSNvBxk2IwbalLIIDW
         gMQ9QXrdy1YpSaBgyGjXpGpEVPj/rF+BTF5KdtnYodjoXKI/ce7UPQRTUJ+InfoU3056
         od5A48HYwTRVms+SNQ1T/MQigaqkmgvn8g+h0e1EudIAsLfa+5GjTOOTKNk2TXfXAEhL
         6z6dSp8ZMzlo0Di+V19inALu8ZZ9fxh/Z9CD35DZT/o1HK48mz/hMIpTH8J3F4GNyp+l
         8/Aw==
X-Gm-Message-State: ALyK8tIBv24bUJDwyNnqKhWJ+eTC7OiY5G5j1Qdlb4zvYqLy7e10ZCCE/ytU7KCj1kd8O04Oz/RwuhvzrijGlQ==
X-Received: by 10.36.130.130 with SMTP id t124mr21067923itd.42.1464786656351;
 Wed, 01 Jun 2016 06:10:56 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Wed, 1 Jun 2016 06:10:26 -0700 (PDT)
In-Reply-To: <xmqqzir63xlg.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296083>

On Wed, Jun 1, 2016 at 1:12 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +     if (is_main_worktree(wt))
>> +             die(_("'%s' is a main working directory"), av[0]);
>> +     if (!wt->lock_reason)
>> +             die(_("'%s' is not locked"), av[0]);
>
> Exactly the same comment about the lack of need for lock_reason
> field as 5/6 appiles here.  Also, as "lock" does not allow you to
> lock the primary tree, do you even need is_main_worktree() check?
>
> That is:
>
>         if (!worktree_is_locked(wt, &reason))
>                 die(_("'%s' is not locked), av[0]);
>
> should be sufficient, no?

It crossed my mind but I went for separate checks anyway because it
gives better explanation.

Assigning either lock or unlock status to main worktree does not work
well either. If you assume worktree is always unlocked, you still need
to check main worktree in lock, move and remove as all of them would
only proceed if it's an unlocked linked worktree. If you assume the
opposite, you need is_main_worktree() check here and "worktree list"
may print the confusing "locked" status on main worktree (I assume we
may add that later).
--=20
Duy
