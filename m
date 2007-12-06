From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 21:15:32 -0800
Message-ID: <1196918132.10408.85.camel@brick>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J095Q-0006WX-3j
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbXLFFPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXLFFPa
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:15:30 -0500
Received: from rv-out-0910.google.com ([209.85.198.185]:2304 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbXLFFP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:15:29 -0500
Received: by rv-out-0910.google.com with SMTP id k20so110929rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 21:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=TPRW56OZLgu1BObJxJ0JHQzoH5S+eM/80PJpVbychwA=;
        b=ib1tKvvP7eBsjixrefZUObOBl7ZYg1WpTEpAGat0GyxEyO5AENQIDcIl4zrsxbk11Ikv7fABLBgai3JHwRblYbAlh3Xligjzhwv4nkX4Uql7jc/MA3nk8RKYgb0bJBAnJ3vgCIdK/ZiAPgMePaEVZeXq9qS3E7cuYHhP1+vBQ0I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Syz8g2C5QtCQcCrbV8CQo4/FuCKrpighE/Kt5F/9rMHcrHrIDyUJWJgBmC15tUvksm/uQaYcd8hvCu/fgSKhIVvfdk0ouUpN0CAYbKRTUR5Kzy0zEgAe44HfUItf/D0R+uPu5208XXTkBYNs78jKpQYzvkP1haDVDGlU/Y7djV8=
Received: by 10.141.50.17 with SMTP id c17mr1735198rvk.1196918128334;
        Wed, 05 Dec 2007 21:15:28 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id 2sm278541rvi.2007.12.05.21.15.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 21:15:27 -0800 (PST)
In-Reply-To: <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67240>

On Thu, 2007-12-06 at 00:11 -0500, Daniel Berlin wrote:
> On 12/5/07, David Miller <davem@davemloft.net> wrote:
> > From: "Daniel Berlin" <dberlin@dberlin.org>
> > Date: Wed, 5 Dec 2007 23:32:52 -0500
> >
> > > On 12/5/07, David Miller <davem@davemloft.net> wrote:
> > > > From: "Daniel Berlin" <dberlin@dberlin.org>
> > > > Date: Wed, 5 Dec 2007 22:47:01 -0500
> > > >
> > > > > The size is clearly not just svn data, it's in the git pack itself.
> > > >
> > > > And other users have shown much smaller metadata from a GIT import,
> > > > and yes those are including all of the repository history and branches
> > > > not just the trunk.
> > > I followed the instructions in the tutorials.
> > > I followed the instructions given to by people who created these.
> > > I came up with a 1.5 gig pack file.
> > > You want to help, or you want to argue with me.
> >
> > Several people replied in this thread showing what options can lead to
> > smaller pack files.
> 
> Actually, one person did, but that's okay, let's assume it was several.
> I am currently trying Harvey's options.
> 
> I asked about using the pre-existing repos so i didn't have to do
> this, but they were all
> 1. Done using read-only imports or
> 2. Don't contain full history
> (IE the one that contains full history that is often posted here was
> done as a read only import and thus doesn't have the metadata).

While you won't get the git svn metadata if you clone the infradead
repo, it can be recreated on the fly by git svn if you want to start
commiting directly to gcc svn.

Harvey
