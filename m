From: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
Subject: Re: Forcing CRLF for files in a directory
Date: Thu, 1 Jul 2010 15:37:03 +0200
Message-ID: <84784AAD-6276-4736-A04C-EDF55986C346@gmail.com>
References: <4C2C8644.4060208@ryanmccue.info>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Ryan McCue <me@ryanmccue.info>
X-From: git-owner@vger.kernel.org Thu Jul 01 15:44:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUK3y-0005US-Kh
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 15:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755330Ab0GANoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 09:44:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55944 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483Ab0GANoQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jul 2010 09:44:16 -0400
Received: by wyf23 with SMTP id 23so727752wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 06:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=cpzGMJsMXQSJPEx8z1M2e0OP3jkg8to9Qg2tJMZStkM=;
        b=htdXyfy/nYGH4GVFI+rVtdDx4MqKsKsB717VKNuPJbfCERXfZM31/hPLS8qYSwVAB9
         +v0Pse9N6jigTOWM1YpzLZ4dMcl8WNjdL+rgL2khSNFCA097EBGhQXpd7x3YoDkJTWR6
         lRvg8oyKikJILfcP3nQ2iKkykDKirdrEyDK74=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=q4GBYz2UjpdIlhSgMnY/q0qH1Z6WfIMKDuHp/AuVNIqr88JeRwrRZ925M8/P7dJ3nj
         iHOsCLWlw5I7XrTpXjC0xIABOdyfKuhkPoU8GqXgaVppkkqLhoOpudvtEM0VOxLZwRF3
         zZcirqWm01qHGl9teVmBnxcYlP/MacFDn8y0M=
Received: by 10.213.25.145 with SMTP id z17mr2356700ebb.62.1277991426906;
        Thu, 01 Jul 2010 06:37:06 -0700 (PDT)
Received: from [10.36.80.159] ([62.113.137.5])
        by mx.google.com with ESMTPS id v8sm9231985eeh.20.2010.07.01.06.37.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 06:37:06 -0700 (PDT)
In-Reply-To: <4C2C8644.4060208@ryanmccue.info>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150036>

On 1. juli 2010, at 14.12, Ryan McCue wrote:

> Hi there,
> 
> I'm working on a project at the moment which stores raw HTTP header data along with bodies for use during testing. As each header line must be separated by a CRLF, these need to remain so in the repository.
> 
> My question is: Do I need to do anything special to ensure these CRLFs aren't converted to LFs during checkout?

No.  As long as you don't set any attributes, git will by default leave your line endings alone on Linux.

You might get into trouble on Windows, because git defaults to converting line endings to CRLF on checkout (core.autocrlf=true) and gets confused when files are already checked in with CRLFs.  This problem is fixed in the upcoming 1.7.2 release.
-- 
Eyvind
