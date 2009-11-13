From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/3] gitweb: Refactor 'log' action generation, adding git_log_body()
Date: Sat, 14 Nov 2009 00:59:07 +0100
Message-ID: <200911140059.08084.jnareb@gmail.com>
References: <1258074134-27011-1-git-send-email-jnareb@gmail.com> <1258074134-27011-2-git-send-email-jnareb@gmail.com> <20091114081050.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 00:58:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N962T-0008Cq-Pl
	for gcvg-git-2@lo.gmane.org; Sat, 14 Nov 2009 00:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbZKMX6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 18:58:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbZKMX6h
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 18:58:37 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46878 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478AbZKMX6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 18:58:36 -0500
Received: by bwz27 with SMTP id 27so4040239bwz.21
        for <git@vger.kernel.org>; Fri, 13 Nov 2009 15:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BLqxlToyI1jIf6dp4L9/ulpkia94Jm98WWC42THASpc=;
        b=VOAOlirLnZksYARXEuqgNy4bxNuEO2/X8EydhvFfmbMfrvFxq0+QnLhkBUXXHkSy3i
         pIPvqzvgoaJmG1ln3HAzEmGuM8Pq362OXGAa1huvPM4fkGWcmM3gCIuKVfpqtnP4mtuq
         ehvRZwDJP6iXzVWvtWpuY0N8W5JGsZaIYi6U0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=mBe9JEZIIXPpr5GaQThE7XtinUdRW6+/ifBgBUCjp9ktotDTCAwT0gHijc65o/nVQs
         TcO7pEZyXyzNxaIwRqLqfjN+KuQGcqvOGjJQSUYQgFepbDek82Gz92LXRnSOhhgkOjZN
         WyyV3f9dPofpgoTvdF6xh0jJOdv4jyyJ1khQo=
Received: by 10.204.156.210 with SMTP id y18mr6013081bkw.80.1258156721546;
        Fri, 13 Nov 2009 15:58:41 -0800 (PST)
Received: from ?192.168.1.13? (abwf143.neoplus.adsl.tpnet.pl [83.8.229.143])
        by mx.google.com with ESMTPS id 13sm1309517bwz.14.2009.11.13.15.58.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Nov 2009 15:58:39 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20091114081050.6117@nanako3.lavabit.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132851>

On Sat, 14 Nov 2009, Nanako Shiraishi wrote:
> Quoting Jakub Narebski <jnareb@gmail.com>
> 
> > Put the main part of 'log' view generation into git_log_body,
> > similarly how it is done for 'shortlog' and 'history' views (and
> > also for 'tags' and 'heads' views).
> >
> > This is preparation for extracting common code between 'log',
> > 'shortlog' and 'history' actions.
> >
> > Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> > ---
> > This is pure refactoring: output should change.
> 
> Did you mean "should not change"?

Yes, of course, it should be "output should not change" (as opposed
to later patches, which unify not only code but some of looks).

-- 
Jakub Narebski
Poland
