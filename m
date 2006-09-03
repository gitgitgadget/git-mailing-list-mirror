From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Mozilla version control requirements and git
Date: Sat, 2 Sep 2006 23:29:23 -0400
Message-ID: <9e4733910609022029q9cb9ba9m87cbc37e8d6f4ad7@mail.gmail.com>
References: <9e4733910609020731k25ce3a0aw7a84542f8cd516f6@mail.gmail.com>
	 <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 03 05:30:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GJigX-0001az-Kc
	for gcvg-git@gmane.org; Sun, 03 Sep 2006 05:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWICD36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Sep 2006 23:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbWICD36
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Sep 2006 23:29:58 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:36731 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1752000AbWICD35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Sep 2006 23:29:57 -0400
Received: by py-out-1112.google.com with SMTP id n25so1980034pyg
        for <git@vger.kernel.org>; Sat, 02 Sep 2006 20:29:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fODNsHA1blpxwrRFLbMWIEJK0GaYdc2d8vFpImyZZNIx9sd88bDlYcPj2SmPPI9Ih7xKWhvGW1R2S/mr/53cxK3bM58T3Z5T3n4GWF6QdESDG9LkgVdpFnfZ+pz/r7sy2mTsiPWeVRf/w9drpU70KeZWvA+ose1ArUg9OmZ4jdY=
Received: by 10.65.51.16 with SMTP id d16mr4177495qbk;
        Sat, 02 Sep 2006 20:29:23 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Sat, 2 Sep 2006 20:29:23 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90609021819v6d427f0eh69bc13b30ef6b692@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26362>

On 9/2/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 9/3/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> > The Mozilla people have a web page describing what they are looking
> > for in a new version control system. How does git stack up?
>
> Hi Jon,
>
> you've been playing with GIT quite a bit by now, so I guess you know
> the answer ;-) Is there anything in particular you are wondering
> about?

Shallow clones are a big problem. We have Mozilla down to 450MB is
git, but that is still gigantic for anyone doing an initial check out,
especially if they don't have good broadband. It is over 10x the data
that CVS brings down. Even without doing shallow clones git still
needs to be modified to restart an interrupted pack transfer.

>
> The one item that sticks out for me as not there is ACLs, but access
> controls can be implemented in hooks for direct pushes. Maintain an
> .htaccess-like file and have a perl script to check it on pushes to
> the repo.

I don't see ACLs as that big an issue. If you convert to model where
everyone has their own repo and you just push changesets at each
other, ACLs are much less important. You need ACLs when 2,000 people
have commit privs.

>
> Oh, and "partial tree pulls for localisers". Perhaps git-cvsserver can
> help there? Localisers can just use TortoiseCVS and get a checkout of
> the language pack subdir.

Partial repo pulls and an issue to. The mozilla repo has much more
than a browser in it, it also has a large mail/news program. A partial
repo pull may not be what is needed for git, instead git needs a
partial repo checkout.

-- 
Jon Smirl
jonsmirl@gmail.com

-- 
VGER BF report: U 0.827771
