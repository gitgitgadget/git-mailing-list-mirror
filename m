From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Efficiently detecting paths that differ from each other only in case
Date: Fri, 8 Oct 2010 14:57:49 -0500
Message-ID: <AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
	<20101008135034.GC5163@sigill.intra.peff.net>
	<AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
	<20101008195120.GA10810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 08 21:57:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4J4m-0003kx-0P
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 21:57:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757323Ab0JHT5u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 15:57:50 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:36309 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab0JHT5u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 15:57:50 -0400
Received: by pzk34 with SMTP id 34so404329pzk.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=X+SQ49jmSPnrl5/JNNUkjJvuP2/aKi9K6xVLGlr37w8=;
        b=F2iholnrbrgwuL7S58/S3hiCI0M4+TckTMF00A+W3Bzdpp5UGqKkyg/YYyeoMLEKQG
         nhlSyiHnJ68F3RBuzBjAnyy6EkfX7tkX2vaEXQYpnXkJS6bjWXNHPqcwzhlLJe7WS4Yu
         Ql+6PY6yW4AXr5T/LvEVjDhZqbr6qQszfq6BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=srPWZOtTTzsNQmzAwYiDIzYj3znDAjsRdBTg0AW6+wLhFoUX7tVnZaBh2u7IHr/HZw
         zcTP5zuzY4XlYpcUwMmq4qauEUW0ii4BMduPf2iYMdbEOFCGG9slNTGyF5WqahLhTJ5f
         BoSs47OJNLrB0U3ii//qBp1Ra4XgiQRJXS7ME=
Received: by 10.142.12.3 with SMTP id 3mr2474017wfl.187.1286567869329; Fri, 08
 Oct 2010 12:57:49 -0700 (PDT)
Received: by 10.220.187.9 with HTTP; Fri, 8 Oct 2010 12:57:49 -0700 (PDT)
In-Reply-To: <20101008195120.GA10810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158531>

On Fri, Oct 8, 2010 at 2:51 PM, Jeff King <peff@peff.net> wrote:
> One thing to consider, though, is if this is a hook running on the
> server, you probably don't want to look at the index. You probably want
> to look for duplicates in one tree entry (fed to the hook). So you would
> be using git ls-tree, which probably is a bit slower.

Thanks, but why is that?  Why can't I use ls-files, and must use use
ls-tree, which you say would be slower?

For extra details: is the central Git repository, running under
Gitorious, on a fairly powerful server. It's a bare repo, naturally.

D
