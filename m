From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Diff format in packs
Date: Mon, 31 Jul 2006 22:29:57 -0400
Message-ID: <9e4733910607311929j189eb6b9r6a804cc744290fdc@mail.gmail.com>
References: <9e4733910607311408i10e17dse776920de7c5076a@mail.gmail.com>
	 <ealruh$sq9$1@sea.gmane.org>
	 <9e4733910607311420n8537b76lbde4d60062195403@mail.gmail.com>
	 <46a038f90607311747j947c786s6af2fe637dbde89d@mail.gmail.com>
	 <9e4733910607311813l78791e40l1234cf0e458db66f@mail.gmail.com>
	 <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 04:30:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7k1H-00078a-IW
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 04:30:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWHACaB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 22:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030394AbWHACaA
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 22:30:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:34574 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030389AbWHAC37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 22:29:59 -0400
Received: by nf-out-0910.google.com with SMTP id o25so107464nfa
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 19:29:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r2yCJK8t4zkIuNNk5IgyW9meAzwuG+wp7o57F1AAwIg+ErP9RE+gUFCJo5SVPoPIFOJfjTf9vGdRRLp0Or8Ymdo/AzLewwySVrG635m4/q3M10RljLfA8roOeSPqceoPpMwMyxnFKpza4noH8KSQvxRx2h0DN3pWlZFYVvIhkEs=
Received: by 10.78.185.16 with SMTP id i16mr105419huf;
        Mon, 31 Jul 2006 19:29:58 -0700 (PDT)
Received: by 10.78.149.8 with HTTP; Mon, 31 Jul 2006 19:29:57 -0700 (PDT)
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90607311916k5d130f70gc0ac26eb8f15fec0@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24567>

On 7/31/06, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > would be to use cvs2svn to build the changeset database and then use
> > cvsps to simply read the changesets out of it and build the git
> > repository.
>
> Once cvs2svn has the db built, it should be easy to write a
> perl/python script that mimics the output of cvsps.

This is an efficiency problem. My strategy instead is to build the git
objects for the revisions when the CVS file is initially parsed and
then track the sha-1 of the object. Otherwise I end up needing to use
CVS to pull each revision out after the changeseta are computed and
that's a slow process since it involves 1M forks of a cvs process.

People on the Python list have been giving me some pointers on how to
build the revision files efficiently. That's what I am working on
right now.


-- 
Jon Smirl
jonsmirl@gmail.com
