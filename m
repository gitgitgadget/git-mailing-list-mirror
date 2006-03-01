From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: bug?: stgit creates (unneccessary?) conflicts when pulling
Date: Wed, 1 Mar 2006 17:53:53 +0000
Message-ID: <b0943d9e0603010953iccf64a4v@mail.gmail.com>
References: <20060227204252.GA31836@diana.vm.bytemark.co.uk>
	 <44037A5C.6080409@gmail.com>
	 <b0943d9e0602281445w7160d915y@mail.gmail.com>
	 <4405DC41.8020700@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 18:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEVWQ-0000gV-UK
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:54:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCARxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbWCARxz
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:53:55 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:43974 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932239AbWCARxy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 12:53:54 -0500
Received: by xproxy.gmail.com with SMTP id h31so129806wxd
        for <git@vger.kernel.org>; Wed, 01 Mar 2006 09:53:53 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=X/Q8vER/EifI+gkDYKnOMua+9X3sh/3+pnMgwLLauSosPIDQPcZ3SiYKGq7wn4jHU4Ms5BlcyOeX13jfPvQlg6nFBTiZKqvq7vORDZGipTZsM5KDJ6I1UBx7VK1ph+M8Ewlavkgm6vKrMVaWLq2+3iKsDj5T8EdPD3E9w7iDkX0=
Received: by 10.70.65.5 with SMTP id n5mr707163wxa;
        Wed, 01 Mar 2006 09:53:53 -0800 (PST)
Received: by 10.70.31.16 with HTTP; Wed, 1 Mar 2006 09:53:53 -0800 (PST)
To: cel@citi.umich.edu
In-Reply-To: <4405DC41.8020700@citi.umich.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16998>

On 01/03/06, Chuck Lever <cel@citi.umich.edu> wrote:
> Catalin Marinas wrote:
> > I attached another patch that should work properly. It also pushes
> > empty patches on the stack if they were merged upstream (a 'stg clean'
> > is required to remove them). This is useful for the push --undo
> > command if you are not happy with the result.
>
> if maintainer X takes a patch "a" from developer Y, but modifies patch
> "a" before committing it, then your nifty automated mechanism will still
> have trouble merging developer Y's stack when Y pulls again.
>
> the convention might be that maintainers who accept patches will always
> accept exactly what was sent, and then immediately apply another commit
> that addresses any issues they have with the original commit.

This won't solve the problem since testing whether patch "a" was
merged upstream will fail because its reverse won't apply cleanly onto
the upstream HEAD. Of course, you can try combination of upstream
commits and local patches but it's not really feasible.

As I said, this method doesn't solve all the upstream merge situations
but it is OK for most of them.

--
Catalin
