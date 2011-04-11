From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 15:20:03 +0530
Message-ID: <20110411095001.GG28959@kytes>
References: <20110411084229.GW5146@genesis.frugalware.org>
 <20110411091919.GE28959@kytes>
 <20110411093114.GY5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, timar74@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Dlt-0003us-Hi
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757730Ab1DKJu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 05:50:57 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58936 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab1DKJu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 05:50:56 -0400
Received: by iwn34 with SMTP id 34so5454765iwn.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 02:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WBSU2MF9+24UvTBwfyyM73/VYOl0xwPTieVTZ962kCQ=;
        b=az2jk6DD07HUhnbPgITvfRKmXSiadJjmGhdVSRBuKopGtqrHOQ+kY0zINlrB1RoWuy
         MINRsSOwAZW8ptXAHf2yzA81BnNAW6e9umJqFswnYxuoHOQHyVW6PmP5unyvgvr6P7u1
         fFDW9t9KG5n6GiKO1YF4hfEpmUwU2kN25wb/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cdHYKb0M9d30953njxrpt8TW6vJ6vEVnijcu0Zfp4g4ebSSnESWyRITSRfhD7jUyeI
         n73n7/U2NLZXtX3RLXiAWmp5LdP5FjsaBFXH2H5Md3/EwuRpUe5P5U+ySTWgYd2bPBUq
         Il+yd8h9xwjZMNokqz7gFrpBEgLlsVTXuCigc=
Received: by 10.43.56.20 with SMTP id wa20mr8301911icb.302.1302515455500;
        Mon, 11 Apr 2011 02:50:55 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id uf10sm3861705icb.17.2011.04.11.02.50.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 02:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110411093114.GY5146@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171322>

Hi Miklos,

Miklos Vajna writes:
> On Mon, Apr 11, 2011 at 02:49:21PM +0530, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> > > Is this a bug? I don't exactly understand why this would be necessary.
> > 
> > From config.txt:
> > - 'clean' is "The command which is used to convert the content of a
> > worktree file to a blob upon checkin".
> > - 'smudge' is "The command which is used to convert the content of a
> > blob object to a worktree file upon checkout."
> > 
> > According to the documentation, 'smudge' is *supposed* to be invoked
> > on a clone/ pull, since it involves a checkout.  I don't see how you
> > can avoid running these filters on every checkin/ checkout unless you
> > cache the result somewhere.
> 
> That's not a problem - the issue I pointed out is that the 'clean' one
> is invoked on pull/clone, and it takes time if it's applied to several
> files.
> 
> 'smudge' is just a 'cat', I don't care about it. :)

Ah, sorry about that.  There actually seems to be a bug :|

-- Ram
