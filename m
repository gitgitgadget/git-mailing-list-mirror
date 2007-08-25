From: "Dan Chokola" <dan@chokola.com>
Subject: Re: how do you "force a pull"?
Date: Sat, 25 Aug 2007 07:31:45 -0400
Message-ID: <61e816970708250431s1a05a30u992cfcde4f956e85@mail.gmail.com>
References: <20070825111946.GA7122@falcon.digizenstudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 25 13:31:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOtrq-00058f-Qf
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 13:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933456AbXHYLbr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 07:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933416AbXHYLbq
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 07:31:46 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:21862 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933298AbXHYLbq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 07:31:46 -0400
Received: by wa-out-1112.google.com with SMTP id j4so1318796wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 04:31:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cJRnGiPc8igUFkWJ+vycw+fF5JIfw/Ypo00wq0sMsQulQ+cljU2ug9l7ndKRVmwJp4htf5+H2Blz4NgNoj8Zz3jrJOe2OYZQtjLj7kec3jpMr3x6b6SCK79w3ouGDp+iuT3jzCWoJqfP6awNRtPUiUQ6ogYV5MQmiqJj3GWzffE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=EoXTNZVHM5lxmS6liNGtPTp5ODzqqbSTzYYZVyagfaQzrGWu/MDfGMe71R7kxHULHnz7KsZpaE8nWFjWQKZ+8CuUouVPlkt3kzdU+0+C6UvjRoUIa1Ei8J1R8o8kOxYL5OScYTQpQmvc9tlMyPmji1VZ/kYRwcMmJiPTCfJ8XAQ=
Received: by 10.114.144.1 with SMTP id r1mr687864wad.1188041505492;
        Sat, 25 Aug 2007 04:31:45 -0700 (PDT)
Received: by 10.114.208.19 with HTTP; Sat, 25 Aug 2007 04:31:45 -0700 (PDT)
In-Reply-To: <20070825111946.GA7122@falcon.digizenstudio.com>
Content-Disposition: inline
X-Google-Sender-Auth: 6aa877f64a311c63
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56631>

On 8/25/07, Jing Xue <jingxue@digizenstudio.com> wrote:
> I am working in repo1, and make a savepoint commit and pack up and leave.
>
> On another machine, I have a clone of repo1 (repo2). So I pull from
> repo1, "git reset --soft HEAD" to get rid of the savepoint commit, and start working in repo2.
>
> A while later I realize the earlier commit was actually a good commit
> point. But I can no longer pull it again from repo1. It keeps giving me
> the "Cannot merge" fatal error. "-f" doesn't help.
>
> So in general my question is "how do you force pulling from a remote
> repository?"  (short of, you know, recloning the repo...)
>
> I have a feeling that either I'm still stuck in the traditional central-repository
> mentality, or missing something real simple.
>
> Thanks.
> --
> Jing Xue
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I've had the same trouble and it also brings up the question, why
can't one fetch into the current branch? To work around git pull's
behavior, I generally either:
- git reset --hard HEAD^^^^^^^ && git pull
 or
- git checkout someotherbranch && git fetch -f origin master

So why doesn't pull -f understand that it should force an update to
the history? And is there some reason I'm missing for why fetch won't
fetch on the current branch?

-- 
Dan Chokola
