From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Thu, 2 Oct 2014 10:35:51 -0700
Message-ID: <20141002173551.GA12591@google.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
 <20141002161006.GB2505@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 02 19:36:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZkIQ-0002Jy-CE
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 19:36:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091AbaJBRgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 13:36:01 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35772 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbaJBRgA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 13:36:00 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so2970561pab.16
        for <git@vger.kernel.org>; Thu, 02 Oct 2014 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZhIirpAkQyI5FTFicD7eCMwuUEQUCAdqco2BDURIT1w=;
        b=IVMGf1ca1Cn6OxeMdpQEhrkaN3lM2gOWe2gOTiQqyq+/c6y0H6cDlmG/i+tAcYUyTJ
         CqFDRpr193mcCKHjWNBfdRcjoBcn+ylT+wp0/hspPSxAmkn/8IlEObnc+mZWzQRS6i1j
         WViRqa6R+2hLq9Byl/4ZZsOr4JV+iERDBX2x+DjkiD64jLTIZYuqEOtAj2R2LKfDNW0i
         r7D+7sBVpJyEwgC49ckXtbkgtaEvoTkLTVglrowiX42jaYbbeA5cFlPISOXbSPBlF1xN
         KzDb1sMs4XO0WKIPB8ZIFM0JdSZjoNiqtiyhTT0wUY6TH1JwZ4fm8yJ+KgcdsNGSWL9n
         v5mA==
X-Received: by 10.68.191.134 with SMTP id gy6mr647175pbc.2.1412271359919;
        Thu, 02 Oct 2014 10:35:59 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id qx4sm4331043pbc.14.2014.10.02.10.35.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 Oct 2014 10:35:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002161006.GB2505@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257813>

Jeff King wrote:

> But I think Christian is arguing that the client side should complain
> that $sha1 is not a remote ref, and therefore not something we can
> fetch.  This used to be the behavior until 6e7b66e (fetch: fetch objects
> by their exact SHA-1 object names, 2013-01-29). The idea there is that
> some refs may be kept "hidden" from the ref advertisement, but clients
> who learn about the sha1 out-of-band may fetch the tips of hidden refs.
>
> I'm not sure it is a feature that has been particularly well-used to
> date, though.

I use it pretty often.  The commits I'm fetching are pointed to
directly by refs, but I don't care about what the ref is called and I
want exactly that commit.

The context is that the commit is mentioned in the gerrit web UI.
Fetching by commit name feels simpler than getting the
refs/changes/something ref, since I think in terms of commits instead
of in terms of change numbers.

Thanks and hope that helps,
Jonathan
