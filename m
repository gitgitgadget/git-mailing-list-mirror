From: David Turner <dturner@twopensource.com>
Subject: Re: git segfaults on older Solaris releases
Date: Thu, 07 Apr 2016 14:56:40 -0400
Organization: Twitter
Message-ID: <1460055400.5540.3.camel@twopensource.com>
References: <5706A489.7070101@jupiterrise.com>
	 <xmqqoa9lz2uw.fsf@gitster.mtv.corp.google.com>
	 <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>,
	"Tom G. Christensen" <tgc@jupiterrise.com>
X-From: git-owner@vger.kernel.org Thu Apr 07 20:56:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoF6p-0002h4-7J
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 20:56:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757493AbcDGS4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2016 14:56:44 -0400
Received: from mail-qg0-f53.google.com ([209.85.192.53]:36620 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491AbcDGS4m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2016 14:56:42 -0400
Received: by mail-qg0-f53.google.com with SMTP id f52so71546341qga.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2016 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=VHEG9T2IH7ZC3gw9Vs6LX5tJ2GxMlxulIgY8tzyOf0M=;
        b=KiiRDD8DnhamBubvqDNZqmn/nMU5aaZCTtuLkSR4gw1OwmMA8ZJSeIPfUKZBobUW1B
         C/DEYBilurehF1unfjizy+9LHY9hNyANQh5GXeR1xnwbvw9ZGP2k3BcAvXcflH1mkeSv
         Rz4HV64q5WeQPZFxlQNxQ6USrNk4zrfKHiZafQdSyyLRty54qpdcNj16VEZUhIwmKmI0
         2BNDkiKyusZXBnDL8VcYiP1SqlDIGL3OESXc21udiEjNuQ2/mJXANKgWCgJmDju1ymWF
         ESWWyhIaozB5NTEHmjdjL86q8u6SyVqTJ6fgkk/xpjndz7zfKEwX6jquS1J3AJ1e2OFi
         /BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=VHEG9T2IH7ZC3gw9Vs6LX5tJ2GxMlxulIgY8tzyOf0M=;
        b=T+7Puc4ggFeKmcQlfcf9aPlXNl1gNxsQ6Wds0fJJ+wGnAhYNU24F8pcuvjekBDVhpF
         UfwaANbHXO4NeEplNTMgkYiNgH1Dx2vTtJD9KX6eb+Egx9UOvktdzw0zp8BFsPXEaacX
         UHY5ME6M07xWzjXnq2IP2WymYCMMPxXIqatHHYu2uWchvCUlyn2Ygk2PcCFNTXfsQjCg
         bs28Qs4+nBH9L6ra6xFIsq68OLzn+sFlhIO+CWxSYMKCcpebWKuOWM0OYyrZxupS23yd
         GbhWFE2eaEzxHhnE61q7VBYscuo1U06RTvPJ26ceyKe++o49z+nAVH7UxK4+uBk2WwAv
         myfg==
X-Gm-Message-State: AD7BkJICpJQzNLPnPsC405DWBH46mBzJ3ZGSAJStxZfdw26o5u8u/C3AZiQVChYhcmr1KA==
X-Received: by 10.140.32.100 with SMTP id g91mr5987271qgg.47.1460055401756;
        Thu, 07 Apr 2016 11:56:41 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id f24sm3992981qkf.6.2016.04.07.11.56.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 07 Apr 2016 11:56:41 -0700 (PDT)
In-Reply-To: <xmqqk2k9z20p.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290947>

On Thu, 2016-04-07 at 11:50 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "Tom G. Christensen" <tgc@jupiterrise.com> writes:
> > 
> > > The reason for the crash is simple, a null value was passed to
> > > the 's'
> > > format for the *printf family of functions.
> > > ...
> > > Passing a null value to the 's' format is explicitly documented
> > > as
> > > giving undefined results on Solaris, even on Solaris 11(2).
> > 
> > Do you mean
> > 
> > 	*printf("...%.*s...", ..., 0, NULL, ...)
> > 
> > i.e. you saw a NULL passed only when we use %.*s with width=0?
> 
> So, I've looked at places where we use "%.*s" with "prefix" nearby,
> and it seems that this is the only place.
> 
> The "prefix" being a NULL is a perfectly valid state throughout the
> system and means a different thing than it being an empty string, so
> it is valid for callers of prefix_path() and prefix_path_gently() to
> pass prefix=NULL as long as they pass len=0.

TIOLI: The code below does not reflect the "as long as they pass len=0"
condition.  Maybe add an assert for that?  
