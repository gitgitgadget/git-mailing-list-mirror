From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [RFC] pull/fetch rename
Date: Wed, 21 Oct 2009 19:19:02 +0200
Message-ID: <20091021171902.GA27495@localhost>
References: <200910201947.50423.trast@student.ethz.ch> <alpine.LNX.2.00.0910201912390.14365@iabervon.org> <20091021030608.GA18997@atjola.homenet> <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 19:26:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0exX-000203-GN
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 19:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754558AbZJUR0n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 13:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754506AbZJUR0n
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 13:26:43 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:35699 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753762AbZJUR0l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 13:26:41 -0400
Received: by fxm18 with SMTP id 18so8014938fxm.37
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 10:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Di8R+WmatDx4u5U45BLhL5TXQB+7fbjUbKs/XteLQ7A=;
        b=Yy1ic+tkPtsBZJmyALrxlJIRTctfYdsY4VeIyPcas0gHNAJ1bHExy/KL5qFPszJTXw
         7YqJWMr0gjBi9mnjYKWla3c8cPNuSJAy4Qviikb1/V3zh7efQ/OwOlvP7DueZ5ekO2Gx
         u/bjaEkdrsADtkmKE8QUtt9Wdrklk6VWbd3rs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=L65b+l2D8XDArj0yTx21Q8lyMbsCuuXpxW+zlArunHJN1CSjQagNPjfkyfVngNhBqd
         qpi6dkFSYtpoA8FWY8A807Qu3feAb/ULyiqLxzS4Yd0jh+eXl1H2zm3nBv86AvzWj39r
         4/kQmXdcDtqf05vKLKtHHQe1jk6Mm5ALqKFL4=
Received: by 10.204.23.193 with SMTP id s1mr8181247bkb.25.1256145545522;
        Wed, 21 Oct 2009 10:19:05 -0700 (PDT)
Received: from darc.lan (p549A742E.dip.t-dialin.net [84.154.116.46])
        by mx.google.com with ESMTPS id 9sm551059fxm.58.2009.10.21.10.19.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 10:19:04 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1N0epy-0007Rh-4s; Wed, 21 Oct 2009 19:19:02 +0200
Content-Disposition: inline
In-Reply-To: <7vk4ypb71j.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130942>

On Tue, Oct 20, 2009 at 11:22:16PM -0700, Junio C Hamano wrote:

> For example, I am in favor of deprecating the "pull $there $src:$dst"
> notation.  Before we standardized on the separate remote layout, it was
> sometimes handy to be able to use $dst that is a local branch, but these
> days, especially when repository $there has remote.$there.fetch mapping
> configured so that we can compute from $src what remote tracking branch we
> should store the fetched commit, the flexibility is more confusing than it
> is useful.

I emphatically agree. I was always uncomfortable with the refspec syntax,
because it is too flexible. Why would I ever want to access branch refs
other than refs/heads/ on the remote, and why would I ever want to write
directly to the local refs/heads/ namespace (in a non-bare repo), as opposed
to refs/remotes/<name>? Unless he wants to do something unusual, the user
should not be confronted with questions like that.

Clemens
