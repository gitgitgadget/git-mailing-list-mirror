From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 14:28:45 +0300
Message-ID: <20100222112845.GE10191@dpotapov.dyndns.org>
References: <1266599485.29753.54.camel@ganieda>
 <1266687636-sup-7641@ben-laptop>
 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
 <20100221063433.GA2840@coredump.intra.peff.net>
 <1266754646.12035.23.camel@ganieda>
 <20100222051748.GB10191@dpotapov.dyndns.org>
 <1266832607.31769.37.camel@ganieda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Jelmer Vernooij <jelmer@samba.org>
X-From: git-owner@vger.kernel.org Mon Feb 22 13:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjWTA-0008S6-Hc
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 12:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab0BVL2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 06:28:51 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:49329 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773Ab0BVL2u (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 06:28:50 -0500
Received: by bwz1 with SMTP id 1so1517552bwz.21
        for <git@vger.kernel.org>; Mon, 22 Feb 2010 03:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VmBLsz9yrG/5udAXQc4IeVvdelmYFwMuJVMQ2dYkmug=;
        b=j+bQMM2YKh5EuaJz6AKthwl1FC1WH2pB6+1jeoAD2d7/j/0n66n401EBBN7eyvJyU1
         p+OkJnb4qytfcwMkjS4qgjh2o4kVgJXjWuxDaKExyoSn9t6xQ3j/ksTSa17lTC/BvuBH
         1LboGbbrGhOxWUgU3e2n7Hfrw/3cOqekoWFbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QYmI6pmZcOnDGaKJn8bF778c490L7N/jYSmb1wwahFcREcsmAhpcTaGEd6IEk77Dtw
         8hH2HGHVgKcXcF13PqS5Z4Agvg1Gc4t2yFoZ+GJG/kL/e+ADl4eJVhXSTwiQ5RWC7Oa3
         SK6kM5F9et/sknhUWXzKj0io3m1LNkdob3D/I=
Received: by 10.204.38.77 with SMTP id a13mr1743330bke.26.1266838128864;
        Mon, 22 Feb 2010 03:28:48 -0800 (PST)
Received: from localhost (ppp91-77-227-64.pppoe.mtu-net.ru [91.77.227.64])
        by mx.google.com with ESMTPS id 15sm1049648bwz.8.2010.02.22.03.28.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 22 Feb 2010 03:28:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1266832607.31769.37.camel@ganieda>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140674>

On Mon, Feb 22, 2010 at 10:56:47AM +0100, Jelmer Vernooij wrote:
> 
> There is no need for that data to be added later for revisions that did
> not originate from Bazaar. All of the metadata that has to be stored
> will be known at the time the commit is created. Those commits that were
> made in Git later will not have any metadata that can not be represented
> in Git (they were made with Git, after all).

If so, I do not see why any metadata should be stored in Git at all. If
you can work without them then why do you want to add to Git? And then
how about commit that originated in Git then exported to Bazaar and then
imported back at Git? It is still originated in Git and thus should not
have any metadata despite being imported from Bazaar.

> Having a bzr/master ref means that the extra metadata will not always be
> copied around (unless git is patched), so if I push my work from Bazaar
> into Git, somebody works on it in Git and pushes a derived branch and
> then somebody else clones that derived Git branch into Bazaar again, I
> will not be able to communicate with that person's branch.

No matter how many times a branch was cloned, it is exactly same branch
(i.e. it consists of commits having exactly the same id). So, if you can
work with the original branch, you can work with any cloned branch. So,
I see no need to copy this data around for people who do not work with
Bazaar directly.


Dmitry
