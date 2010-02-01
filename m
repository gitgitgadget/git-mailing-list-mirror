From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH] rebase: don't invoke the pager for each commit summary
Date: Sun, 31 Jan 2010 21:39:39 -0800
Message-ID: <780e0a6b1001312139x1b91bed1q729766c4efde4060@mail.gmail.com>
References: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 01 06:40:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nbp0z-0000KX-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 06:40:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab0BAFjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 00:39:55 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:45386 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863Ab0BAFjy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 00:39:54 -0500
Received: by pxi12 with SMTP id 12so3910756pxi.33
        for <git@vger.kernel.org>; Sun, 31 Jan 2010 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=NTGqGg/4iOo9nyiiGuC7omdfkqPCRnhGhoaAYhMr4gw=;
        b=Mc5DNBbei+Nl3UWSAMxKIhvLkGrsIoIe77IzikHvGFv4nT2E/1mXCImh1ygjXuUCR0
         kHC1oB8yUS3xQO5q/ta4zQMqsddwb+fHiAQYEaAZo/uVD+vJ/CLXUV9GDuUJwZVsPQU3
         WIxu0yK1A384rRny+U/CweWl41kzp39pKDwsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XNqcYfzhESrmgpL4mSMpMEe8eOa0BFU+qlFkOzshK9GJtDQL5b2zLHd88GshMBzT5S
         FCy4l9U5nVEguQFWklSA0mNHGhUZeub5i5Br2RWIcvNUxufX83yTq06H5FAfbxRoyRxT
         ZuuU2jUYIgy/kATvaYjFXjZ14fegxtKp8xrJM=
Received: by 10.142.59.6 with SMTP id h6mr2780681wfa.330.1265002794102; Sun, 
	31 Jan 2010 21:39:54 -0800 (PST)
In-Reply-To: <1264868617-18547-1-git-send-email-markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138582>

On Sat, Jan 30, 2010 at 8:23 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> This regression was introduced by commit 0aa958d (rebase: replace
> antiquated sed invocation, 2010-01-24), which changed the invocation of
> "git rev-list | sed" to "git log".
>
> It can be reproduced by something like this:
> $ git rebase -s recursive origin/master
>
> Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
>

Thanks. Maybe you can use git show too instead of git log -1?
