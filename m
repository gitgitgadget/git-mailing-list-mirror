From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Tue, 22 Nov 2005 10:22:46 +0100
Message-ID: <cda58cb80511220122r76ca69a2y@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <cda58cb80511170236p4a7e2baay@mail.gmail.com>
	 <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	 <cda58cb80511171347yef4f090g@mail.gmail.com>
	 <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
	 <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
	 <Pine.LNX.4.64.0511190953520.13959@g5.osdl.org>
	 <7vzmo04dpl.fsf@assigned-by-dhcp.cox.net>
	 <cda58cb80511211211l2ff6ff12j@mail.gmail.com>
	 <7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 10:24:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeUMW-0000PT-Ph
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 10:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbVKVJWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 04:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVKVJWt
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 04:22:49 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:39586 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751287AbVKVJWs convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 04:22:48 -0500
Received: by zproxy.gmail.com with SMTP id 14so1083497nzn
        for <git@vger.kernel.org>; Tue, 22 Nov 2005 01:22:48 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HKqqE/Q1CrREmYLDiQJiL/c5JP+OibwtXaCTgBkJIFEm30vVodEOOelsiJp2iiXtsYDDv21v3WUDwbAs4IcFE/QRCmgkeogO/1bzUEfztjrvcFEtDSkeTx+TQYRrDvwDPkGw/LG9g3HPH3LVKiGmWt2w97lxMwa0Eplq3hEOic8=
Received: by 10.36.247.9 with SMTP id u9mr670819nzh;
        Tue, 22 Nov 2005 01:22:47 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Tue, 22 Nov 2005 01:22:46 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhda5pw6l.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12540>

2005/11/21, Junio C Hamano <junkio@cox.net>:
> Franck <vagabon.xyz@gmail.com> writes:
>
> > ... But since I used grafting to "cut"
> > my light repo and .git/info/grafts file is not copied during
> > push/pull/clone operations it's not going to work. Is it a scheme that
> > could work ?
>
> If you tell your downloaders that your repository is incomplete
> and they need to have at least up to such and such commits from
> another repository, they should be able to slurp from you.
>

What do you mean by "have at least up to such and such commits" ? I
can see only one commit that they need: the one I used to create my
public repository...

> It might be possible to teach upload-pack (that is run when your
> downloaders run git-fetch or git-clone against your repository)
> to somehow send a customized error message to the client when it
> finds the other end needs certain objects that you yourself do
> not even have. In that message you could say something like "due
> to space constraints this repository is an incomplete one, and
> you can only use it on top of a clone of such and such
> repository, found at this URL: ...".
>

That's a good idea. We get the same thing when cloning linux
repository. BTW how is it done in that case ?

> > Moreover, I'm wondering if my public repository really needs to store
> > big repo's pack files as it is described in git tutorial ?
>
> What you are trying to do is to keep your public repository
> fsck-objects *un*clean and still let downloaders work with it;
> so I suspect following that section of the tutorial procedure
> defeats the purpose your experiments.
>

Absolutely.  My question was not accurate sorry. It should have been
"can I have a public repository wiith fsck-objects unclean and with a
grafts file that should be downloaded when cloning it.

Thanks
--
               Franck
