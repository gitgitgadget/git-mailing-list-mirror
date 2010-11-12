From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Newbie:  Restore messed up code from local or remote repository
Date: Fri, 12 Nov 2010 16:08:39 +0530
Message-ID: <20101112103836.GB20053@kytes>
References: <1289550163511-5731540.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: gzoller <gzoller@hotmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 12 11:38:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGr1w-0002yg-9l
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 11:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756623Ab0KLKie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 05:38:34 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58827 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756525Ab0KLKid (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 05:38:33 -0500
Received: by yxt33 with SMTP id 33so276587yxt.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pXo9X79410t34WwQY9cNE/hy/GLiqgjukMjpTmfVa0k=;
        b=fZqZ1GoYV2e3T45n9h5/5G0sCX4vCOtvVa+2y7bRDmBYBy1YxYqSMGxqc1Bfwz2cWH
         2SW6kWnoGG4AF8/QsC1zQNJZOLJ3U2jYuoMghZKY0ERv6X2Tk9N53N2UuP6dj9nwA85V
         /gkwed1/V50/sIbbH6/5mPFcSyk96sfyz2ilU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BRfFq1ZQ8WdxInsUoPjCEhP0FDdojv7QREnC9Og90kbfav/vih/ewOZXOq/jDMqbql
         /+rhmBY0knJmXle0q7kPy5oRyklYH7B9BiUFFtYfc5jw3EKqmbqPp4E9BNOp2wXMxuvJ
         bLUTqpzSSeRWPs97ApvTObl85dtES5a5C+zkk=
Received: by 10.91.103.1 with SMTP id f1mr2949609agm.182.1289558312962;
        Fri, 12 Nov 2010 02:38:32 -0800 (PST)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id c39sm3539415anc.21.2010.11.12.02.38.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 02:38:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289550163511-5731540.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161333>

Hi Greg,

gzoller writes:
> git checkout
> git pull -f /path/to/remote/repos
> git fetch -f /path/to/remote/repos
> 
> None of the above did the trick.  The two remote commands reported that
> everything was Already up-to-date! (even though I'd deleted a lot of local
> working files)

Yes, there's really nothing to download. Everything that needs to be
fetched has already been fetched :)

> What am I missing?  How can I restore my previous state from last commit?

See `--hard` switch of `git reset`. Use with extreme caution.

To throw *everything* all your local work away and go back to the
state of the remote repository, switch to `master` branch and do `git
reset --hard origin/master` where `origin` is the name of your remote
and `master` is the name of your remote branch.

To reset to the last commit without looking at the remote, run `git
reset --hard`.

Note: Again, please understand what it's doing first; don't run it
blindly.

-- Ram
