From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase --fix: interactive fixup mode
Date: Mon, 9 Jan 2012 02:43:09 -0600
Message-ID: <20120109084309.GD23422@burratino>
References: <20120108213134.GA18671@ecki.lan>
 <20120108220127.GA4050@burratino>
 <CACsJy8CKK0EAy79Fahi64bUw2kfr=eunegbeA7oX_XaXEBFr2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 09 09:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkAk9-0001fP-56
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 09:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150Ab2AIIiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 03:38:07 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:62608 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754462Ab2AIIiF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Jan 2012 03:38:05 -0500
Received: by obcwo16 with SMTP id wo16so3750574obc.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 00:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=IMVb/zLWlUm/oaYo+2B4vxFNzAQhvVZz97KiloiA/g4=;
        b=TyUA4T2LXWrHr3ptf72t6mI1ztUDUNUgo/FFy47LuYA0CYHDSzB3mBLcraQAQAnUYP
         8ok3w5tKuBnBFKbqFzZ59IVHqXEXTrhWnAJ0Sak+V+H9MOLfeOwOR3ygSusm4ucysiLL
         Gkwe9usGiqgEIMLIukvOG/SKuCQRgg3hbkJJY=
Received: by 10.182.182.65 with SMTP id ec1mr13603431obc.6.1326098284655;
        Mon, 09 Jan 2012 00:38:04 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id f7sm2544418obx.11.2012.01.09.00.38.03
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 00:38:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8CKK0EAy79Fahi64bUw2kfr=eunegbeA7oX_XaXEBFr2g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188161>

Nguyen Thai Ngoc Duy wrote:

> Is something like this over-generalized?
>
> http://kerneltrap.org/mailarchive/git/2010/12/24/47502

Yes, I suspect that at the moment (i.e., in the absence of a large
collection of examples to show their utility), both your ^{~custom}
and my ^{first:rev-list args} are overengineered, and that they do
something that is more clearly expressed using the shell's command
substitution feature:

	git rebase -i $(git rev-list --merges HEAD | head -1)

So why did I suggest it?

I guess I was reacting to the implementation of the
rebase-recent-commits command.  I understand that it was a sketch, but
it felt a little ad hoc.  If it could be expressed as a clean
two-liner, I would be more comfortable since the burden of maintaining
it would be less.

Thanks for clarifying.

Sincerely,
Jonathan
