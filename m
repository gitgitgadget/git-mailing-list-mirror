From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Sat, 24 Sep 2011 23:25:58 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109242148570.24369@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com> <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com> <alpine.DEB.2.00.1109090900301.12564@debian> <alpine.DEB.2.00.1109122139110.12564@debian>
 <7vwrdaqxpk.fsf@alter.siamese.dyndns.org> <alpine.DEB.2.00.1109151956040.12564@debian> <alpine.DEB.2.00.1109201254020.12564@debian> <CALkWK0mggSNoxxqzUaGp1-AxGWSpCb0HnRmBxSkcVrHnhwMr1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Sep 25 05:26:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7fMF-0002Nj-5J
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 05:26:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1IYD0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Sep 2011 23:26:09 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:34339 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709Ab1IYD0H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Sep 2011 23:26:07 -0400
Received: by qyk30 with SMTP id 30so8659868qyk.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 20:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=wZnW9xoIu5WLm6xLz0HkSTGASAqxPqV2sJgauHOj0bs=;
        b=Zn+fpZFgaaCycU0ZWDVb52FyiqMJxONIPJlkVhpRqj1Lsb0D3Ez7d7AmQVeRjfXU1x
         8ictORtnU31w0cyD9jnAeERwsjZXW+U61rUu6ZLavVnTkGuJzeSLS8F59LojgG2o21Za
         mFUGV5wmwEtYegYPe51DDpFFoo6r7tUhOsXeI=
Received: by 10.224.198.198 with SMTP id ep6mr3736427qab.348.1316921166477;
        Sat, 24 Sep 2011 20:26:06 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca. [24.37.77.94])
        by mx.google.com with ESMTPS id f15sm11321814qac.9.2011.09.24.20.26.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 24 Sep 2011 20:26:05 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <CALkWK0mggSNoxxqzUaGp1-AxGWSpCb0HnRmBxSkcVrHnhwMr1Q@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182054>

Hi Ram and Thomas,

On Sat, 24 Sep 2011, Ramkumar Ramachandra wrote:

> Martin von Zweigbergk writes:
> > [...] We also want it to
> > work with --root, so we can not use git-cherry.

I think I was confused here; git-cherry should work just fine. Simply
leaving out the limit, or setting it to $onto, makes the walk go all
the way to the roots. After thinking a bit more about this, I'm
instead wondering what the purpose of the --root flag to git-rebase
is. Thomas introduced it in 190f532 (rebase: learn to rebase root
commit, 2009-01-05).

If I understand correctly, it was introduced to solve exactly the same
reason problem that made Francis start this thread -- to avoid
re-applying patches that are already in $onto. In Thomas's patch,
git-rebase started passing $onto..$orig_head instead of
$upstream..$orig_head to git-format-patch. It also started passing
--root to git-format-patch, but that was made unneccessary a few days
later in 68c2ec7 (format-patch: show patch text for the root commit,
2009-01-10).

After my patches (that are not yet ready) that calculate revisions as
"git cherry $onto $orig_head $upstream", I don't think there should be
any need for the --root flag. The only place the flag is checked now
(in my current work tree, that is) is when deciding how to interpret
the remaining arguments. Although I have not tried (temporarily)
rewriting all the test cases from

  git rebase --root --onto upstream branch

to

  git rebase upstream branch

, I think it should work. What do you think, Thomas? I saw that
"--root" is also passed to the hook. Should that value be passed to
the hook also when the old base is not explicitly a root (by "rebase
--root"), but only implicitly so (by an $onto that is disjoint from
$branch)?

Martin
