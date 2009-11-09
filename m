From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 00:06:31 +0300
Message-ID: <20091109210631.GJ27126@dpotapov.dyndns.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: B Smith-Mannschott <bsmith.occs@gmail.com>, git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:06:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7bRf-00009b-SO
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 22:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbZKIVG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 16:06:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754259AbZKIVG2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 16:06:28 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33375 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149AbZKIVG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 16:06:27 -0500
Received: by bwz27 with SMTP id 27so3928375bwz.21
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 13:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=onEQWwJEfK1ObjBmMs1Dq2K2l4u3kv5s6otNkrZHg64=;
        b=wLvOrToy3gbcUAXl0kQoKIuPlwveV8RJVIS4PSYHobHlurQbEywWcza7yPRgBgYU0X
         qgQaBi53hO8xPyhxLJA1m21RQBLuLOtLFdVsmcUrRgnxcuoXMkGtUqXv64GJ8hZXA86H
         QjrzLPD8L0btmBQjzm/Ws9fwrr36bJSnXJRi8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cVN0qNOD6h0PVFm16DPb+O/obeoy8VeLnvXGBK/Vm9wXeargdn0FZG90jcxuEikA07
         3VHaxN/IPaIPNF2sGWsS4GBAIrvFcfUUxAfbG9oJGxdrBfy6vsVdGwDGcvEMlISaM011
         dzHzW5lE9hkPOblcIH4FpmoV1ADG3qHWhPMgM=
Received: by 10.103.80.25 with SMTP id h25mr3302493mul.15.1257800792234;
        Mon, 09 Nov 2009 13:06:32 -0800 (PST)
Received: from localhost ([91.78.51.65])
        by mx.google.com with ESMTPS id 23sm227519mun.1.2009.11.09.13.06.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 13:06:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <28c656e20911091047r353e9451hd856b99541fbd5ff@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132522>

On Mon, Nov 09, 2009 at 07:47:08PM +0100, B Smith-Mannschott wrote:
> 
> You don't have to wait to comitting to your own branches, but do make
> sure to run your usual builds and tests before pushing or asking
> another to pull changes from you.

Yes, it is one most useful feature of Git that you can commit (save)
your changes immediately but amend them later. This helps a lot to
make changes smaller, cleaner and easier to review.

With many other VCS, a typical policy is that you do not commit your
changes unless you have finished and tested them. But it means that
your changes are not committed and stored only in the work tree for
a long time. Moreover, when you eventually decide that they are good
enough to commit, you will produce a huge patch, which will be difficult
to review or to bisect history later.

With Git you do not have to worry about testing when you can commit your
changes. Typically I would commit some my changes as I progress to my
goal, but later I will review all commits. Probably, squash some changes
with fixes, clean up some other, add better explanations of what is done
and why, etc... But I do not have to worry about all those trifles as
I write code to see if some feature is worth or not, if this solution
works or I should try something else...

So, you can always commit your changes as your progress to your goal and
review amend them later before publishing. This means that you can have
as many work-in-progress branches as you wish, and you do not need a
separate work tree for each of them -- everything can be stored in the
repository, and you can go to another computer, issue 'git fetch' and
continue your work at the exact point where you left it. So, it is very
flexible.


Dmitry
