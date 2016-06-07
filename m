From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] Resurrect "diff-lib.c: adjust position of i-t-a
 entries in diff"
Date: Tue, 7 Jun 2016 19:04:26 +0700
Message-ID: <CACsJy8DO+KU59LbQ0ZtTax6DZKqYmZVT6MHLmNK73GkO9qHf_w@mail.gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com> <20160606111643.7122-3-pclouds@gmail.com>
 <xmqqtwh6uk0k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 14:06:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFl2-0007bT-6j
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 14:05:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbcFGMFN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2016 08:05:13 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34551 "EHLO
	mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbcFGME4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2016 08:04:56 -0400
Received: by mail-it0-f66.google.com with SMTP id r205so7325288itd.1
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 05:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zDMrBLvVisVYhhSVxquErnJ4/NBcDH002mkX1HLYrVw=;
        b=bCT9CJpqUndBpVnTAJAqStHUoQvdrVNM77hl0Jt+pJ0v69Wxpub9NPV8FYa1FM9YIm
         k8S1d7aJFYrxjkUoZbTwHnyKxzm5HMwcV1rEr9wjROfem43zUEBKjEynH5jP4DbW39xz
         0tOgnJU2XLqUS0gT8jyvc50UZFfXkc51oZtX5MEnRiQl5tGikvCYVsvUofRiYIBFZoSK
         OIl4DM3+cPpbxlxo9O2E0YcENu4oHp+rkjLByW7LOSphadLbjH6CKxbOPGpxe0QRKwwy
         3wkEUgLNrbiBLLSv8A3W62/kjU28EOsHl82MBy6tj3m2Umk1Ib17HsZMMpJdFxHLLPIS
         Akcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zDMrBLvVisVYhhSVxquErnJ4/NBcDH002mkX1HLYrVw=;
        b=Nz39Q9VSHTwcjCfzgUsT5L99W32kGH5Pa4Hv1Y6xoH9diAeAGytAn6gIPFlZIBNfcd
         qXP5gMwz3cg2/BEiu4cnpmuea6HB+NepuK/ZPqMTqVMsa72e0K1ITtCTkrRc8UHGhZSD
         c5YDugZv8pEhg863zlgHdY9hpSguLYW8qpnTWWnvUIRX469+1ZDFST9SDgGZZiRq6146
         dQpvqkC0NdqQQNYBs0GivjQQ/PCHQ7wMgKhf/DnkV5gK+PIO+PIb+NUDY3Hxrq60iPGe
         vzgneJSmhZLvOgUv1rnxMqZ7gSVMp7lbOzzgZ62WUcv2MvF/6Ip/BJpDQ8+xejjaz5bg
         UmQw==
X-Gm-Message-State: ALyK8tI+QJnLCsmSr7S13qwp0qLBqfx7dXHv1NpKazQdA6AGctzml0qIGrkk5uJkvvaHqNK1Zn1SUMN3lLb7xw==
X-Received: by 10.107.8.220 with SMTP id h89mr13368965ioi.95.1465301095447;
 Tue, 07 Jun 2016 05:04:55 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Tue, 7 Jun 2016 05:04:26 -0700 (PDT)
In-Reply-To: <xmqqtwh6uk0k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296667>

On Tue, Jun 7, 2016 at 3:42 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> +--shift-ita::
>> +     By default entries added by "git add -N" appear as an existing
>> +     empty file in "git diff" and a new file in "git diff --cached"=
=2E
>> +     This option makes the entry appear as a new file in "git diff"
>> +     and non-existent in "git diff --cached".
>
> I do not think this should exist at the UI level,

I need it. I do "git diff --stat" and "git diff --cached --stat" a lot
more often than "git status". Without this option, I'm stuck with the
old behavior.

> even though the
> use of it in wt-status.c (below) makes a very good sense at least
> as a temporary band-aid.
>
> At the philosophical level, I however think this "I-T-A does not
> logically exist in the index (yet)" is a mistake, and "an option
> controls if I-T-A does or does not exist depending on who calls it"
> is even worse; it is a road to insanity.

i-t-a entries have dual personality (perhaps because it's implemented
as an index entry). Although I think the "does not exist" aspect will
win in most cases. The intention behind the revert is we have more
time to examine case by case and gradually convert them. Maybe in the
end one behavior wins and we no longer need another. A thought of
keeping i-t-a entries in an index extension instead crossed my mind.
It may simplify things a bit (e.g. there's no "ghost" entries any more
and active_nr in 3/4 can remain "the number of _real_ entries"). The
few parts that do need to know about i-t-a entries need explict
modification (probably git-reset and git-diff). But I don't know yet
if it would just lead to another nightmare.

> For example, because I-T-A does not logically exist in the index,
> "git reset --hard" should not remove it but make it untracked again
> (but I do not think it does). After "git add -N foo", because "foo"
> does not exist in the index, "git clean" should remove it for the
> definition of what's in the index to be logically consistent, but
> the whole intent of "add -N" is that the user meant it is worth
> checking into sometime in the future, which contradicts with its
> removal upon "clean".

I think we should fix them. I started that and so far only 4d55200
(grep: make it clear i-t-a entries are ignored - 2015-12-27) has made
it to 'master'.

> So, I dunno.

I just remembered why the old behavior (abort to commit if i-t-a
entries are present) bugged me: it does not work well with splitting
changes in worktree into multiple commits (e.g. with "git add -p").
Even though I want git remind me to commit an i-t-a entry in the end,
it does not necessarily mean I have to do it in the next commit, which
may cover a bunch of files except that i-t-a file. I don't see any way
around that except ignoring i-t-a entries at commit time. If there's
another way, I'm all ears.
--=20
Duy
