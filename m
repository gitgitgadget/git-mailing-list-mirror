From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge/pull: verify GPG signatures of commits being merged
Date: Fri, 22 Mar 2013 16:14:30 -0700
Message-ID: <20130322231430.GK12223@google.com>
References: <514CD26C.2070702@physik.tu-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Sebastian =?iso-8859-1?Q?G=F6tte?= <jaseg@physik.tu-berlin.de>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:15:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJBAs-0001eG-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423458Ab3CVXOg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Mar 2013 19:14:36 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34859 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423395Ab3CVXOf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 19:14:35 -0400
Received: by mail-pa0-f41.google.com with SMTP id kx10so134015pab.28
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 16:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SnWXD/zCl9WYd7PDH74aTqvUV48/goNnFgyJLIWHZdA=;
        b=dbSzBBWjArFgqdae99Lx5hxKS+vyONaV3KPxJVJiVkMptYDrH/cWxmcntgcPmcWr2R
         pn6Qynif1sZtc+dC7bBxldSZXMJ+++r0yL8cLUunkkVFRVcHxZVZzbXjJa5HLClQYidr
         sWLhhEK1siQgftCCsfQ3pJMg8yyOGvkGlk8zwnQRMkl8/fbzaUjEti6CQJFuqIpm05Tk
         FZuueU9xpeeYuJcQPsGiMWdUdvj2gqjeSlcs8GRPnipYK4rAoU9IWBPjeRTfy2oVc9gb
         kQ7UnAgSWa44BUVLKtMl4O+GY7Gwq/gqYh1nBEwTt6adHMLiKn/T/TCEQGo1Nl7WfwmC
         27RQ==
X-Received: by 10.66.190.104 with SMTP id gp8mr6054384pac.84.1363994074849;
        Fri, 22 Mar 2013 16:14:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id in5sm3878957pbc.20.2013.03.22.16.14.32
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 16:14:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <514CD26C.2070702@physik.tu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218868>

Hi,

Sebastian G=F6tte wrote:

> git merge/pull:
> When --verify-signatures is specified on the command-line of git-merg=
e
> or git-pull, check whether the commits being merged have good gpg
> signatures and abort the merge in case they do not. This allows e.g.
> auto-deployment from untrusted repo hosts.

This leaves me pretty nervous.  Is there an argument to pass in to
specify a keyring with public keys to trust?  Without that, it is
presumably using ~/.gnupg/trustdb.gpg, which is about trust of
identity rather than trust to provide code to run on my machine. :(

If there's a good way to avoid that, this looks like a good thing to
do, though.

Hope that helps,
Jonathan
