From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sun, 3 Sep 2006 09:46:21 -0400
Message-ID: <9e4733910609030646k6c722068m30f0e05fccc9c3c5@mail.gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
	 <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
	 <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
	 <ede6in$b9u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 03 23:26:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJzTF-000326-2m
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 23:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbWICVZY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 17:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbWICVZY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 17:25:24 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:10446 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751092AbWICNqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 09:46:55 -0400
Received: by py-out-1112.google.com with SMTP id n25so2175363pyg
        for <git@vger.kernel.org>; Sun, 03 Sep 2006 06:46:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MLMjvRPZ+DWeA+TdhCd6Of8zKVZFG0AK6EvRkgBQ122NL0pT9VNrSZ9DSHQl250W4qYYVLfuf3RtsGXDBiec4ZiNq6xy1pLqsRw1KgOjl0gFtcYiESOCeHHRWjPy6jRUUDAa1UzABKLJQZkn0tiAC9dQrrI+uNTRZwgKl/xKHCU=
Received: by 10.35.129.1 with SMTP id g1mr5316366pyn;
        Sun, 03 Sep 2006 06:46:21 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Sun, 3 Sep 2006 06:46:20 -0700 (PDT)
To: "Jakub Narebski" <jnareb@gmail.com>
In-Reply-To: <ede6in$b9u$1@sea.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26378>

On 9/3/06, Jakub Narebski <jnareb@gmail.com> wrote:
> Jon Smirl wrote:
>
> >> Oh, and "partial tree pulls for localisers". Perhaps git-cvsserver can
> >> help there? Localisers can just use TortoiseCVS and get a checkout of
> >> the language pack subdir.
> >
> > Partial repo pulls and an issue to. The mozilla repo has much more
> > than a browser in it, it also has a large mail/news program. A partial
> > repo pull may not be what is needed for git, instead git needs a
> > partial repo checkout.
>
> Or better support for subprojects.
>
> I think you can fake subproject support using separate repositories
> for subprojects, in the directory matching the one in the whole project,
> and the project repository, where we pull/push subprojects into.

You can't really fake it. Many of the projects in Mozilla are
dependent on each other. If you break them up into separate
repositories you lose the ability to do a cross project commit. This
is common when you are changing an interface between the subprojects.

Would it make sense for git to treat a tree of projects like you
describe as a single entity? So a commit would transparently commit to
all of the subprojects. Maybe the commit entry's sha1 could be set up
so that it would be identical in all subprojects. That would let you
string them back together.

> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
>
> --
> VGER BF report: U 0.877495
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com

-- 
VGER BF report: S 0.995201
