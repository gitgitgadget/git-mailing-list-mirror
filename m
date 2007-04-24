From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Apr 2007 17:58:18 +0200
Message-ID: <81b0412b0704240858w6121430fj624582539f14ceee@mail.gmail.com>
References: <7vodly0xn7.fsf@assigned-by-dhcp.cox.net>
	 <7vr6qlxexe.fsf@assigned-by-dhcp.cox.net>
	 <7v647tcjr6.fsf@assigned-by-dhcp.cox.net>
	 <7vejmdq63w.fsf@assigned-by-dhcp.cox.net>
	 <7v647ninbq.fsf@assigned-by-dhcp.cox.net>
	 <81b0412b0704231007i81ee20cx9a37f1c8a3df62b1@mail.gmail.com>
	 <7vvefnf1wb.fsf@assigned-by-dhcp.cox.net>
	 <20070423211658.GA21404@steel.home>
	 <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 24 17:58:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNPL-0005O1-7X
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 17:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092AbXDXP6U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbXDXP6U
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 11:58:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:55545 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092AbXDXP6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 11:58:18 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1991539wra
        for <git@vger.kernel.org>; Tue, 24 Apr 2007 08:58:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XWnW4ERzphOcmQGvXbqT5miFpz6p4/sjuVDsn7nJEaHieNaZGnQrPR7U17gwZat2NggLgRqNCY960OJSS5a7QjHH5aYrPActS+w+JsD5OJECUO/4287sXoVYXpz79oUvY2DLeD2RBtzwevHikRO8TQshAZxvtQQoyHlah1QdQdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UjK4HfJb5AjIsTv8esE7eCMYLQvm3ItRamK0GAH1gM0nnH7biy3ZVyAWKiVc9im9hm+wkA19vaQYzP83nqduJ0unPineIeBGeu+mcMDtl17GHGXnjHobDEUbOzfgH85W96w0VEf/fX+87bRD+pG7CHxLUe9EvdE1HGU9ADJxegs=
Received: by 10.90.78.9 with SMTP id a9mr6232030agb.1177430298174;
        Tue, 24 Apr 2007 08:58:18 -0700 (PDT)
Received: by 10.100.86.19 with HTTP; Tue, 24 Apr 2007 08:58:18 -0700 (PDT)
In-Reply-To: <7v4pn6ep41.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45462>

On 4/23/07, Junio C Hamano <junkio@cox.net> wrote:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
> > Imagine a project which started using the attributes at some point of
> > time. And imagine developers whose repos suddenly start breaking
> > because of clueless integrator created a filter which does not work
> > anywere but his system (typical, really) and didn't tell anyone to
> > update their configuration (whereas .gitattribute files are in working
> > trees already).
>
> That's one of the reasons why only the filter names are assigned
> to paths using gitattributes mechanism and what action to take
> when a specific filter name is attached to a path is determined
> by the config.  Missing filter driver definition in the config
> is not an error but makes the filter a no-op passthru.

Fragile. What if content is useless without filter? How does
the user know about the fact so he can work the problem
around?

What if you have multiple filters matching the same path?
(does not seem to be possible. Someone will ask you why)

> The content filtering is to massage the content into a shape
> that is more convenient for the platform/filesystem/the user to
> use.  The keyword here is "more convenient" and not "usable"; in

how can "not usable" be "more convenient"?

> > How do you suggest to distribute filter configurations, BTW?
>
> The same project description message the participant learn about
> the project that says the public repository locations and such,
> and perhaps in-tree READ.ME file.

But there seem to be no way to notice that the READ.ME should
be reread by project participants downstream.

> The earlier example I gave would fit this pattern rather well.
> If somebody (me) cannot deal with UTF-8 encoded Japanese text
> very well, that user personally can mark such a file in
> $GIT_DIR/info/attributes as 'filter=utf8-japanese-text' and
> define the iconv based filtering driver in $GIT_DIR/config in
> the repository that he (me) uses for editing.

which will be a PITA to setup in each and every clone of the
repository, unless it is cloned with the repo.
