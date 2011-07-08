From: Stephen Haberman <stephen@exigencecorp.com>
Subject: Re: [PATCH] test overlapping ignore patterns
Date: Fri, 8 Jul 2011 13:39:30 -0500
Organization: Exigence
Message-ID: <20110708133930.04b04a49@sh9>
References: <21043430.post@talk.nabble.com>
	<alpine.LFD.2.00.0812161450010.14014@localhost.localdomain>
	<7viqpjra57.fsf@gitster.siamese.dyndns.org>
	<1229620278-25152-1-git-send-email-git@drmicha.warpmail.net>
	<1310062372893-6559395.post@n2.nabble.com>
	<7vk4bsfy8c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 20:39:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QfFxk-0001pA-8Q
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 20:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246Ab1GHSjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jul 2011 14:39:35 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:51568 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600Ab1GHSje (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2011 14:39:34 -0400
Received: by yia27 with SMTP id 27so883946yia.19
        for <git@vger.kernel.org>; Fri, 08 Jul 2011 11:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exigencecorp.com; s=google;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=q2E/74qCO8i8AmFW1aWNKfpP5zQH1VW2JQTkcU7OM20=;
        b=dX87v8hrgL7EPIGjw6UWcUug0dUQAZ3wyUtdwjdvk822TBvDz34+FPNTr31iG949eS
         6dBTClN5/7XUuocQ5bhQxsz7oe76sXwemuKnPrZ0PA3KwGShlt6/IoKQjEKO/qxT4qNF
         +GjeJhT5uLNTXdj/XIyoRHTJRnPpOG1k/4YHU=
Received: by 10.150.240.16 with SMTP id n16mr2211347ybh.278.1310150373164;
        Fri, 08 Jul 2011 11:39:33 -0700 (PDT)
Received: from sh9 (wsip-184-187-11-226.om.om.cox.net [184.187.11.226])
        by mx.google.com with ESMTPS id l22sm3265208ybl.12.2011.07.08.11.39.31
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Jul 2011 11:39:32 -0700 (PDT)
In-Reply-To: <7vk4bsfy8c.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.9 (GTK+ 2.24.4; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176803>


> Doesn't the first "*" tells us to not to look at the contents of one/
> directory at all, so we that we do not have to waste time descending
> into it?  We wouldn't even know what pathnames are underneath it, so
> "!*.1" would not have any effect inside one/ at all, I think.

If that's the way the feature should work, that's fine.

I came across this thread via google referencing Linus's post from 2008
which mentioned versioning only jpg files. I want to do the same sort of
thing, but with a directory hierarchy.

If I say "exclude *.jpg" in my root .gitignore file, that applies into
sub directories, so I just assumed "exclude !*.jpg" would also apply to
sub directories.

Am I missing another way to accomplish this?

I understand from an implementation perspective, skipping all
subdirectories when you see "exlude *" is a smart thing to do, but
perhaps it should only be done if there are no negative excludes that
could bring items back into play?

Thanks,
Stephen
