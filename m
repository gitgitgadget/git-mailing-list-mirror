From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 6/6] clone: print advice on checking out detached HEAD
Date: Tue, 10 Jan 2012 08:54:22 +0700
Message-ID: <CACsJy8CuYkzFVrEG6T2HUAwJGnjit2xWt3VSN-9USt7h+B_CBw@mail.gmail.com>
References: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
 <1326023188-15559-1-git-send-email-pclouds@gmail.com> <1326023188-15559-6-git-send-email-pclouds@gmail.com>
 <7v4nw4cs1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 02:55:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkQvX-0003y1-7U
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 02:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641Ab2AJBy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 20:54:56 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53943 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab2AJByy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 20:54:54 -0500
Received: by bkvi17 with SMTP id i17so78818bkv.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 17:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Z70o5H+K+V+/MH6zuyekZ+5Swmpx6Qj0i1qXivjpFLo=;
        b=Xe1+6ySy4Z+FDryvwSuK18SCYx9BOAa2ROdyWEDgdQS6iEMyo/INH6XQ0817GI6oAR
         kuSOX0lIyY5wIJIObJE2+xugw8by03wzlo+sfJTHXqdSalcO/ZlH02/QGRhqjl/p+2NI
         keIyeJbw3WLg6RSQtQzRLmu5gj7SzMhViYQkQ=
Received: by 10.205.132.14 with SMTP id hs14mr8217547bkc.130.1326160493167;
 Mon, 09 Jan 2012 17:54:53 -0800 (PST)
Received: by 10.204.66.77 with HTTP; Mon, 9 Jan 2012 17:54:22 -0800 (PST)
In-Reply-To: <7v4nw4cs1x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188207>

2012/1/10 Junio C Hamano <gitster@pobox.com>:
> This patch makes 100% sense _if_ we let clone result in a repository with
> a detached HEAD, which I am not sure if it is a good idea, or if it is
> better to fail the attempt to clone to give incentive to the owner of the
> remote repository to fix it.

Then a hostile remote can stop users from cloning his repository by
detaching HEAD? That's not nice. On the other hand, if specifying
--branch=<wrong-branch> leads to detached case, then we should
probably refuse to clone. But that should happen before transferring
the pack.
-- 
Duy
