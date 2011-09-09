From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: git-rebase skips automatically no more needed commits
Date: Fri, 9 Sep 2011 09:06:36 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1109090900301.12564@debian>
References: <CAC9WiBg9+30NjO+NKXVdBiWjR-HU2689JQqVY7Rk5+DM7MiNBg@mail.gmail.com> <7v1uvta97o.fsf@alter.siamese.dyndns.org> <CAC9WiBjrfJeJ854dkJMPwRSwuujRsYLnAd7QX7C_oU8_FdOvQA@mail.gmail.com> <4E676F6A.3060906@drmicha.warpmail.net>
 <CAC9WiBi_bkLNJZckq2fr3eb6ie+KVfauE_PyA3GcaW5Ga-isFw@mail.gmail.com> <7vk49k48q4.fsf@alter.siamese.dyndns.org> <CAC9WiBjMUg3SUOP9AJw6qCKrGVLs6Qy_O2fQa_SHX30NkjAEdw@mail.gmail.com> <alpine.DEB.2.00.1109080753460.12564@debian>
 <CAC9WiBiMYUfaPtrXyW=W7qaZnJqLeFO-B3od7X4u8wUrb8hfUA@mail.gmail.com> <alpine.DEB.2.00.1109082123300.12564@debian> <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 15:06:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R20n7-00057o-Ll
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 15:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933640Ab1IINGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Sep 2011 09:06:41 -0400
Received: from mail-vw0-f43.google.com ([209.85.212.43]:60891 "EHLO
	mail-vw0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424Ab1IINGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Sep 2011 09:06:40 -0400
Received: by vws10 with SMTP id 10so1385363vws.2
        for <git@vger.kernel.org>; Fri, 09 Sep 2011 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=MIUhUlT4OXhT4jZbS2iqVgCf2WRleKvZL/c6LA0IlF8=;
        b=PKO7XopEUBRHE9ojnLSRaMpY+7JDAcjM0T0V1AijZflLcSBqWAREN6qvns/WrclVHv
         0qMbSBtArnsUV0oPWKFCb8wQ5Ts/HqT0rrhtYBi3zoLj6kIhVDSpdtGxdY3ghCmWRcV4
         2nIOx0iG0NWc+0qYe7AF2/eKYCNMMPP2g8XWI=
Received: by 10.220.9.132 with SMTP id l4mr523894vcl.185.1315573599385;
        Fri, 09 Sep 2011 06:06:39 -0700 (PDT)
Received: from [192.168.1.102] (modemcable094.77-37-24.mc.videotron.ca [24.37.77.94])
        by mx.google.com with ESMTPS id ch2sm4658080vdc.19.2011.09.09.06.06.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Sep 2011 06:06:37 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <CAC9WiBhApjEr-NYm9NkyXaZPNCivoJ65c=xx2bg5Li60kfZMTQ@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181060>

On Fri, 9 Sep 2011, Francis Moreau wrote:

> On Fri, Sep 9, 2011 at 4:23 AM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
> 
> > you are right that
> > "git rebase --onto master foo~10 foo" could potentially filter out
> > patches already in foo..master, without calculating patch-ids for all
> > commits in master..foo for that matter. I think that would make sense
> 
> you meant master..foo~10, didn't you ?

Yes. (I actually did mean "all commits in master..foo", but "_any_
commits in master..foo~10" is more clear and exact.)

> please let me know when you submitting your work, I'm interested to see it.

Will do. It's not really that much work, but I'm not sure when I will
have time for it. If you or anyone else is interested in doing it, you
are of course welcome.

> > necessary, we could have a flag to disable the filtering e.g. when the
> > user knows that master is part of a completely separate history from
> > foo.
> 
> Can't git figure this out itself ? (I'm not saying the switch is useless)

Yes, but this hypothetical flag would only be to speed things up by
avoid going to the roots to find out that the histories are disjoint.

Martin
