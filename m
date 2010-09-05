From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Sun, 5 Sep 2010 15:11:43 -0500
Message-ID: <20100905201142.GE14497@burratino>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100905174105.GB14020@burratino>
 <20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:13:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLb3-00078N-04
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab0IEUNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:13:39 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40375 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754519Ab0IEUNi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:13:38 -0400
Received: by gxk23 with SMTP id 23so1413996gxk.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=intVv/+iL/jcLBGVsnZ86scP0+9tXW1pIc1K8D0sKeY=;
        b=AwWE7UaS17VP87TyRorkHJBiYxfk3LQFtQ3Xt/jz2LZBWS6L6s7FTq1GOBZWJc40JV
         iiGMZSINhUBTp90k7Ai2JaYivM/ApbQd6aOVoEFwNFpgN58QlSZs8YEYDL3XE8iMx1My
         lz6020RGhRGE7G2hNo/7TjH93AzWsaiCbCqsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uu+fM+t81tki5mEcJL+F843KNwCgzTPQEiKdiSIkZiVKN8PD/iUc4mwEzXsbtfqSFy
         RF1nemZ8bqDOuZaJF6JhLCk73KF4THiVJFABVa93pXpHPgX429nBgHiPFOQepeOs6ajZ
         Rg2uAy95vgmGWkt8GNEpwtskavKF6TjHmILGA=
Received: by 10.100.119.14 with SMTP id r14mr2359485anc.156.1283717617760;
        Sun, 05 Sep 2010 13:13:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t30sm7621305ann.7.2010.09.05.13.13.36
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:13:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905184929.GA32735@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155484>

Ilari Liusvaara wrote:
> On Sun, Sep 05, 2010 at 12:41:06PM -0500, Jonathan Nieder wrote:
 
>> For this specific error, why can't gitolite use an HTTP response code?
>> Should http-backend be using ERR is some places, too, a la [1]?
[...]
> AFAIK, HTTP errors don't have descriptions printed.

Thanks for the explanation.  Makes sense.

 $ git clone http://example.com/nonsense.git
 fatal: http://example.com/nonsense.git/info/refs not found: did you run git update-server-info on the server?
