From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Intoducing the .git file (again)
Date: Sun, 17 Feb 2008 23:29:31 +0100
Message-ID: <8c5c35580802171429m1091492dgd65e13c94de08bd4@mail.gmail.com>
References: <1203286456-26033-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802172219190.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 23:30:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQs1O-0007ub-9R
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbYBQW3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbYBQW3c
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:29:32 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:25532 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753891AbYBQW3b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:29:31 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2447190wah.23
        for <git@vger.kernel.org>; Sun, 17 Feb 2008 14:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=fPa8oRROEPRZ3XHRc1GE45WxZ6vAUtzIFWLKRADxQwc=;
        b=N13um4lqyZenb1rH0xFrEto2L2Ud7j5DCZTarKWN++GoxDTme4PAwDtM5WPzuqUUoJGoyTt35ADsnecN94D6jo9nn/XcUjnlH82O4k0KgK0Tybkr3cEmo7F/SthOwkbgWptkAT7wUJ5qDI/rxoWD/dL+vJUDhmTy4thBKTSfmOc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BpWpqUVYppHu3yv6EN/TQBHrLH+Be0uXmWGbESjJg76/tBNvE05Cb/J4+beCWrNkENvTcW1k0VsOn1//+8mTL6EAp0aHJnQ6WR4r5WOnCmqMWBFflAecCT5TNR0udNKR7Xmnr/wqW1xQXF2V8jhd2StfxqJAbwXsgKR2zJfYLzc=
Received: by 10.114.184.7 with SMTP id h7mr300179waf.28.1203287371188;
        Sun, 17 Feb 2008 14:29:31 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Sun, 17 Feb 2008 14:29:31 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802172219190.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74199>

On Feb 17, 2008 11:20 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 17 Feb 2008, Lars Hjemli wrote:
>
> > PPS: If included, the .git file should probably be used by git-submodule
> > to clone submodule repositories into something like
> > $GIT_DIR/submodules/<name>, as that would make local submodule changes
> > more resistant to dataloss due to checkout/reset in the containing
> > repository.
>
> I don't buy that argument.  For the moment, the submodules are
> self-contained repositories.  The superproject does not even have to have
> a single object contained in a submodule.  I'd try to keep that
> separation.

They would still be separated and self-contained repositories, but
with my suggestion the submodule repository would be moved out of the
working tree of the containing repository. Which I believe is a good
thing, especially when you switch from one branch in the containing
repository which had the submodule in './foo' to another branch where
the submodule is located in './lib/foo'.

--
larsh
