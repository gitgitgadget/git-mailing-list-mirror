From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] git-checkout: Test for relative path use.
Date: Fri, 9 Nov 2007 19:14:44 +1100
Message-ID: <ee77f5c20711090014qfed56e7y446c014399e47a82@mail.gmail.com>
References: <11945685673280-git-send-email-dsymonds@gmail.com>
	 <11945685732608-git-send-email-dsymonds@gmail.com>
	 <47340895.6000403@viscovery.net>
	 <ee77f5c20711082324s39a9d441tc05c5a27e6d39f3e@mail.gmail.com>
	 <7v7ikrx2st.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 09:15:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqP12-0006BN-LW
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 09:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbXKIIOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 03:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXKIIOq
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 03:14:46 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:41820 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbXKIIOp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 03:14:45 -0500
Received: by rv-out-0910.google.com with SMTP id k20so402471rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 00:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ePYqZnQEf708IulUlcoayw1bWWI6KCm381tpzOrDSvs=;
        b=p7mtQgCPd/6k5RD6bQOUr9x2Coz1/RT870TKzVrUmJJcP5VggPpZxoD6lrwwOTyCi9mVfpP91IbykWoj9aMfJu2ZLFzV9U3qyoEnmyVvaHPLeuVuqZQyojlRBdkwCVeOkJfMf3oxlAzhTCpWDTzpXf8Foy3Xt/ATxq+H7a+Wu38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PuOKMsgYr4W7+tv6cEARppH/nTwm5A8wumqQXM9RWH4oszF1wJC7JuJopPld5rFjiwMDweCHx17A0+zwto7sAs2OUYcuXZfZ4GE1ep4Mr1pG1CRNLgq5YOQmaVNlFlbWZMESVpZUK02HKsxblHo7nZ8Lz0s3hNomcl8E9WRspjE=
Received: by 10.141.197.8 with SMTP id z8mr800317rvp.1194596084980;
        Fri, 09 Nov 2007 00:14:44 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Fri, 9 Nov 2007 00:14:44 -0800 (PST)
In-Reply-To: <7v7ikrx2st.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64141>

On Nov 9, 2007 7:04 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
>
> > Looking at the existing tests which, when they change directories,
> > don't cd back to where they were; they "cd .." at the start of the
> > next test. I'll add a "cd .." to the relevant bits of my tests.
>
> Do not follow the bad examples, please.

So what would you prefer? Bracketing the whole test in parentheses
looks ugly, but I can do that if that's the only option. If I look at
t5510-fetch.sh (one of yours, Junio), there is no directory
restoration in the case of test failure, as in my original patch.

Perhaps test_ok_ and test_failure_ in test-lib.sh should restore the directory?


Dave.
