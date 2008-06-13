From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH 1/2] git-svn: don't append extra newlines at the end of commit messages.
Date: Fri, 13 Jun 2008 12:23:46 -0400
Message-ID: <32541b130806130923x4c66f6ddybaaa5d7b00f6dead@mail.gmail.com>
References: <1213312251-8081-1-git-send-email-apenwarr@gmail.com>
	 <48522055.6060006@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:24:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7C4z-0006Nj-Qr
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 18:24:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757343AbYFMQXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 12:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756989AbYFMQXv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 12:23:51 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:37698 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbYFMQXv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 12:23:51 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2138184fkq.5
        for <git@vger.kernel.org>; Fri, 13 Jun 2008 09:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=eqIOKJAqs3FHqHj+mVvISY3wLCB0CI4J+H0ysBIZfVo=;
        b=uD9kRi7KqRw/BIZND3PC/srOr4OE+VDpBlTfX8X6yPUMz3YBRj83UY88es3eFIVp3S
         lQJ81EXRtTkqVkCZNoeJ1IM5IW5OQZlcpDvjvmu3GZ6I92d6WY52M6TGknP1X4hQFV8w
         ZPxY38Moj6hYyhaR+uY06u2v6ytQ7BHpSJMKU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=uWkJa6EuihfqtHHc8pvcZ5pncOM9HfFNkGtgUFAIOzbeCK6Z9szblwibuRQFAhQpkc
         2dosM4O5z+fYzDOBdLS3tMxM1YrUTEVNcKSMBHZDOT9kknDKftBih7doShrvUWnY7y2R
         nJyKW1amM3UtIu9Hah2g8M7i/DRieD2ly+Emc=
Received: by 10.82.152.9 with SMTP id z9mr180921bud.57.1213374226950;
        Fri, 13 Jun 2008 09:23:46 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 13 Jun 2008 09:23:46 -0700 (PDT)
In-Reply-To: <48522055.6060006@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84897>

On 6/13/08, Andreas Ericsson <ae@op5.se> wrote:
>  I'm not familiar with git-svn, and my perl is pretty weak as it is.
>  Are you proposing to remove extra whitespace from git commits when they are
>  sent back to svn via dcommit? If so, wouldn't it be better to always strip
>  extra newlines when importing from svn so they're never there in the first
>  place?

I thought of doing it that way (in fact, I *did* do it that way the
first time).  But I figured it would be too bad if you couldn't always
reconstruct the precise svn commit message from the git commit
message.  Currently you can, even though you sometimes have to remove
multiple newlines.  Interestingly, the addition of the git-svn-id:
line seems to be the only reason the commit messages aren't corrupted,
since git normally trims whitespace from the end of its own commits.

So for the record, whether the sha1's would be affected after my patch
didn't even occur to me.  But it's very convenient that they're not.

Avery
