From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v1 00/25] contrib: cleanup
Date: Thu, 08 May 2014 21:01:32 -0500
Message-ID: <536c36fc8e04c_741a161d31095@nysa.notmuch>
References: <1399597116-1851-1-git-send-email-felipe.contreras@gmail.com>
 <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 04:12:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiaIW-0007v1-72
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 04:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbaEICMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 22:12:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:48847 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395AbaEICMX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 22:12:23 -0400
Received: by mail-ob0-f176.google.com with SMTP id wo20so4066201obc.21
        for <git@vger.kernel.org>; Thu, 08 May 2014 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=xD7ds+3ue2+/Fxhx5eBGfu1hUnSTGijlMirHe25MQmA=;
        b=VUQSezhi3o02mSkAU8S3qS1x7miw3LXZZRRvAmQcmuTahSyotjZy7mT6XLuzxBAZzs
         6JFsvqh4xMqlPvhz9b6JNZL4G/9TSMWiUAmnnYMyo09ZWVFqu2QOmgq+8OteO/0KgFXA
         dOxqwWiWTai8hbtpwfrJfYd7KoeS4u3dqyuzT8VAgrnHFjA+4lbQyg9koTzAAOMXTP5P
         Jk5nCXtvjkaWEjmWo2EZHPK+F9IagRaj2OH9q4eKAPBIZapsVtchyrrvIoFEZStO6VC/
         YmnPmzGBsaXTXU0LNTPuH0FZbDk1XScE0z/L8lVNgftH+JZRTzZ4fS5KoxpWHzahJ696
         YetQ==
X-Received: by 10.60.37.199 with SMTP id a7mr9659402oek.41.1399601542902;
        Thu, 08 May 2014 19:12:22 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id m9sm2383379oer.15.2014.05.08.19.12.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 May 2014 19:12:21 -0700 (PDT)
In-Reply-To: <CACPiFCJnsu3qw59oK94sP1u0+KBDvne0ZpKS0LMGc_9ge+rJjA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248502>

Martin Langhoff wrote:
> On Thu, May 8, 2014 at 8:58 PM, Felipe Contreras <felipe.contreras@gmail.com
> > wrote:
> 
> > Let us be honest, the vast majority of tools in 'contrib/' have no chance
> > of
> > ever graduating, so let's remove them.
> >
> 
> I am curious -- have you checked what parts of contrib downstreams
> package&ship?

I have checked a few, not throughly. From what I can see most of them
just copy everything to /usr/share/git without much consideration to
what is actually there.

The only exception is the shell completions.

> Are you planning on CC'ing the (inactive) authors/maintainers
> so they know that if they care they should host those elsewhere?

They are already Cc'ed.

> My candid opinion is that you're trying to force a group of people to
> undertake a pointless exercise. Contrib in many/most projects is uneven,
> and folks know that. But it gives upstream a chance to push for some
> minimal quality, and in turn it gives visibility to a bunch of sometimes
> useful tools.

Yes, but that's not what our contrib/ is supposed to be. Read
conrib/README.

> If my code was going to get the axe, I'd be rather pissed off. If Junio is
> in agreement that code quality is bad, or tools should have unit tests,
> then the push could be to address the problem or face removal. For example:
> contrib maintainer, show you're responsive to bug reports on the list, or
> face removal; add unit tests (or explain why they aren't needed) or face
> removal.

That's right, and they are Cc'ed so they can respond.  Some tools have
only one commit or two, and in those I didn't even bother Cc'ing anyone.

Moreover, it's not enough that they are actively maintained. Accoding to
Junio they need to show that they can't work properly out-of-tree, and
thus there's a need for them to be in contrib/. Or they are temporarily
in contrib/ so they can become part of the core. That doesn't apply to
the tools I proposed to remove here.

-- 
Felipe Contreras
