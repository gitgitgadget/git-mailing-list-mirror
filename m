From: "Dongsheng Song" <dongsheng.song@gmail.com>
Subject: Re: Why gitweb commitdiff NO diff output ?
Date: Tue, 10 Oct 2006 14:36:04 +0800
Message-ID: <4b3406f0610092336v5ab58134i280f64223a272b0b@mail.gmail.com>
References: <4b3406f0609280032y77cb5961i220b3cfd741ebfd4@mail.gmail.com>
	 <eft8u4$un0$2@sea.gmane.org> <20061003095250.GJ2871@admingilde.org>
	 <7vwt7hnvsk.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610080122r17a10ea4h2c71a399fb8398a@mail.gmail.com>
	 <7v64et9fjq.fsf@assigned-by-dhcp.cox.net>
	 <4b3406f0610091851i593f3e53v5d5fef891edb6d48@mail.gmail.com>
	 <7v1wpgapew.fsf@assigned-by-dhcp.cox.net>
	 <7viris9a6g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 08:36:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXBDm-0003un-PZ
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 08:36:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWJJGgH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 02:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965001AbWJJGgH
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 02:36:07 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:29204 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964993AbWJJGgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Oct 2006 02:36:05 -0400
Received: by py-out-1112.google.com with SMTP id n25so2675417pyg
        for <git@vger.kernel.org>; Mon, 09 Oct 2006 23:36:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gYCPBceARWinuX9FaIAVeNVoxVXfowqH3Wm2QJ+JJY84cH0tmnpzxbgzrohZvWG72TmfIlPOoJ7a1iQTUZGaZicXe//01Bwa5VtOnGhkzD60rhGBhmwNkoOxrzNK1jxjeKc3zPj3Gbr8hXuQGoDU4f5RAkiNYvwLdrLG3tJQwmw=
Received: by 10.35.18.18 with SMTP id v18mr14648242pyi;
        Mon, 09 Oct 2006 23:36:04 -0700 (PDT)
Received: by 10.35.106.3 with HTTP; Mon, 9 Oct 2006 23:36:04 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7viris9a6g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28609>

There is the result:

www-data@ab:/home/repository/git/gcc$ for blob in \
>          a34d77e47bf1561db1ade4f6b247598b880f80d5 \
>          7625c494df01d4745e67bd4423e2fdbe9fc43799 \
>          b207fe30a5430f97d27d398d89c974b068694c7a \
>          57b07ace4bb6352416bbf9436b9f2642b3273257
>          do
>                git cat-file -t $blob || echo $blob does not exist
>          done
blob
blob
blob
blob
www-data@ab:/home/repository/git/gcc$ git cat-file commit
c977ee1b2e54d67bb379ce476f784431c32136d7 |
>          grep 'parent '
parent b693aceaba66f741cd6735d4ecd16fe59394a2cf
www-data@ab:/home/repository/git/gcc$ git diff-tree -p
c977ee1b2e54d67bb379ce476f784431c32136d7 | wc
     37     137    1179


I have the SAME problem with ALL commits,  ONLY the 2.4.x machine, but
git-core/cg tools is OK. All git/cg/gitweb is good for other 2.6.x
machines.

you can browse the two gitweb site:

2.4.27 http://www.foresee.com.cn:8888/git/?p=gcc/.git;a=shortlog
2.6.16 http://www.foresee.com.cn:9999/git/?p=gcc/.git;a=shortlog


2006/10/10, Junio C Hamano <junkio@cox.net>:
> Junio C Hamano <junkio@cox.net> writes:
>
> > "Dongsheng Song" <dongsheng.song@gmail.com> writes:
> >
> >> NO.
> >>
> >> When I change the repository's owner to gitweb process,  no diff output yet.
> >>
> >> $ chown -R www-data:www-data  cauchy/ gcc/ mph/
> >>
> >> 2006/10/10, Junio C Hamano <junkio@cox.net>:
> >>> The site does not return any of these four blobs that are part
> >>> of the commitdiff when a=blob is requested on them.
> >>>
> >>>         file:a34d77e47bf1561db1ade4f6b247598b880f80d5 ->
> >>>         file:7625c494df01d4745e67bd4423e2fdbe9fc43799
> >>>
> >>>         file:b207fe30a5430f97d27d398d89c974b068694c7a ->
> >>>         file:57b07ace4bb6352416bbf9436b9f2642b3273257
> >>>
> >>> I would first suspect if the repository actually have them _and_
> >>> with an appropriate mode protection to be readable by your
> >>> gitweb process.
> >
> > And does the repository have these four blob objects?
>
> Sorry, the follow-up question was not very helpful to guide
> another person over e-mail.  Let's try again with more specific
> questions.
>
> What do these say in that repository when run as the webserver
> user?
>
>         $ for blob in \
>           a34d77e47bf1561db1ade4f6b247598b880f80d5 \
>           7625c494df01d4745e67bd4423e2fdbe9fc43799 \
>           b207fe30a5430f97d27d398d89c974b068694c7a \
>           57b07ace4bb6352416bbf9436b9f2642b3273257
>           do
>                 git cat-file -t $blob || echo $blob does not exist
>           done
>         $ git cat-file commit c977ee1b2e54d67bb379ce476f784431c32136d7 |
>           grep 'parent '
>         $ git diff-tree -p c977ee1b2e54d67bb379ce476f784431c32136d7 | wc
>
> The first one tries to make sure you have those four blob
> objects in the repository, the second tries to make sure the
> commit is a single parent commit as your gitweb output suggests,
> and the last one is to obtain the diff text.
>
> Also do you have the same problem with other commits, or is this
> the only commit your gitweb is having trouble with showing
> commitdiff?
>
>
