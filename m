From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 7 Sep 2006 19:09:21 -0400
Message-ID: <9e4733910609071609o50e5dacm53323e023e90358f@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <edpuut$dns$1@sea.gmane.org>
	 <9e4733910609071341u7e430214j71ddcbefa26810ca@mail.gmail.com>
	 <7vlkovtjd1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 01:09:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLSzu-0003uy-NT
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 01:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWIGXJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 19:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWIGXJX
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 19:09:23 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:37354 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1422687AbWIGXJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 19:09:21 -0400
Received: by py-out-1112.google.com with SMTP id n25so532491pyg
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 16:09:21 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GfDeAYDwzMNF4iYXw+pDjfUrWYHTkayAtCIRFZr4g+XjUVov4M2HbSCDuOuXmKNciB3R/5i1KxTKoZledrNvAW2ZHwwm3qGch9XF4jA4kbJnhRziqilEd4Ctzmfc1cpC22jevH7vwWR8fW19hv+VzAni3G0R6aPP/LuTr0sZMm0=
Received: by 10.35.96.11 with SMTP id y11mr2240205pyl;
        Thu, 07 Sep 2006 16:09:21 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 16:09:21 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vlkovtjd1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26664>

On 9/7/06, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Does an average user do these things? The shallow clone is there to
> > address the casual user who gags at a five hour download to get an
> > initial check out Mozilla when they want to make a five line change or
> > just browse the source for a few minutes.
> >...
> > Maybe the answer is to build a shallow clone tool for casual use, and
> > then if you try to run anything too complex on it git just tells you
> > that you have to download the entire tree.
>
> For that kind of thing, "git-tar-tree --remote" would suffice I
> would imagine.  The five line change can be tracked locally by
> creating an initial commit from the tar-tree extract; such a
> casual user will not be pushing or asking to pull but sending in
> patches to upstream, no?

>From my observation the casual user does something like this:

get a shallow clone
look at it for a while
pull once a day to keep it up to date

decide to make some changes
start a local branch
commit changes on local branch

push these changes to someone else for review
maybe pull changes on the branch back from the other person

keep pulling updates from the main repository
merge these updates to the local branch
browse around on the recent logs to see who changed what

finally push the branch to a maintainer
pull it back down from the main repository after the maintainer puts it in
abandon work on local branch

Some people can't figure out the branch step and just copy the repository.

-- 
Jon Smirl
jonsmirl@gmail.com
