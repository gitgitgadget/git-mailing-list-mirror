From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] revert: separate out parse errors logically
Date: Tue, 10 Jan 2012 13:03:11 -0600
Message-ID: <20120110190311.GD22184@burratino>
References: <1326025653-11922-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-1-git-send-email-artagnon@gmail.com>
 <1326212039-13806-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:58:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkgtp-0003JR-IP
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:58:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756720Ab2AJS6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:58:14 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40280 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664Ab2AJS6M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:58:12 -0500
Received: by ghbg21 with SMTP id g21so2314260ghb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 10:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=svbF1DOevG9sp1EM2qyHGBxuJUeasZJ5ileqBIUEA8E=;
        b=on3oEExd61W/blkMjE0pJbaf+6b+ZvNeFh2dFFGRO8B9sE8nrpx3aPDdmG+/MTBtzj
         vQryvBRgn5wx6Z29nXrqc1Do+6bAbdvUaFgI8FMXPbK9bOIR78j5dkJXG2E0W3KYasrv
         JOaMgYgZQ6tLUnVMZeOjSkQQKLnKU5+y0I2FI=
Received: by 10.101.117.14 with SMTP id u14mr3728598anm.63.1326221891609;
        Tue, 10 Jan 2012 10:58:11 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id i12sm1405648anm.6.2012.01.10.10.58.10
        (version=SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 10:58:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1326212039-13806-5-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188280>

Ramkumar Ramachandra wrote:

>                 For the first kind of error, it is insufficient to
> check if the buffer beings with a "pick" or "revert", otherwise the
> following insn sheet would be interpreted as having a malformed object
> name:

> pickle a1fe57~2
>
> In reality, the issue is that "pickle" is an unrecognized instruction.
> So, check that the buffer starts with ("pick " or "pick\t") and
> ("revert " or "revert\t").

Sorry, the above description just leaves me more confused than before.

What _actual impact_ does this patch have?  And why do we want it?
And what could be the bad side effects?  Everything else is just
irrelevant.

Before reading the above description, I thought this was just a code
cleanup.  So either the description or my reading is completely
confused.
