From: Jed Brown <jed@59A2.org>
Subject: Re: [PATCH 00/13] remote-hg: general updates
Date: Thu, 04 Apr 2013 14:23:01 -0500
Message-ID: <87sj36qewa.fsf@59A2.org>
References: <1364929382-1399-1-git-send-email-felipe.contreras@gmail.com> <20130402200948.GF2222@serenity.lan> <2670C2C0-E30F-47DA-8901-899FEE11059E@quendi.de> <CAMP44s3DETFBhexPhEEMP1TZGNrc91266=t16H2t_+VB_4V38w@mail.gmail.com> <871uaqrwrp.fsf@59A2.org> <7vip42i1r0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Max Horn <max@quendi.de>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:23:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNpl2-0004B5-A1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:23:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764586Ab3DDTXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:23:06 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:64653 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764484Ab3DDTXF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:23:05 -0400
Received: by mail-oa0-f42.google.com with SMTP id i18so3226152oag.15
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 12:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-type;
        bh=oS9RLsfFuuEGAmUO9+MRXHWKlzuZYzuBR8yWC+oE3O0=;
        b=s5r3wf4EooAOV2hjftVJsDDGDBRVQKxvyGd/tF74tfZ/PjG+06KHcJPWu32I2qE5eC
         R7hZ8qAJ8LRg0jsiuMoKkbESFohATYLfTSAnY/xVuK/MXH5x3hHedFvv8HrmElQtL8eC
         0vxxUv/gqc03JjkaruxlMJMAVGpe/vAERkk429vlCBYbkKtE60xCNOxrJzHdpL8pR7XY
         B5b177wd7q9k0xd+VFZcinmqJ/cMHdJ7mjNGA8ebXbAUwPQzpNEO9AtJxIlvv0nHuwC+
         Dy/muP/wRMyyF/e2XQokKOhtgGGX/x07Hq87GIZcZUaooH/L8Bf/vutl2VLwkfZ8hRU5
         RLxw==
X-Received: by 10.182.19.168 with SMTP id g8mr5562526obe.21.1365103383722;
        Thu, 04 Apr 2013 12:23:03 -0700 (PDT)
Received: from localhost (vis-v410v070.mcs.anl-external.org. [130.202.17.70])
        by mx.google.com with ESMTPS id t9sm8028322obk.13.2013.04.04.12.23.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 12:23:03 -0700 (PDT)
In-Reply-To: <7vip42i1r0.fsf@alter.siamese.dyndns.org>
User-Agent: Notmuch/0.15.2 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220075>

Junio C Hamano <gitster@pobox.com> writes:

> So,... is there a concrete proposal for _me_ to act on?  Do you want
> to see contrib/remtote-hg out of my tree, and have it compete with
> the other one (which also shouldn't be in my tree) in the open?

Three months ago, I would have said yes.  Now I don't know.  It looks
like remote-hg has improved and is perhaps stable enough to remain, but
I think it needs a much more complete test suite [1] and some visible
documentation about its mapping semantics.  There is no way a change
like "force-push by default" should come without the user knowing about
it.  (I don't think force-push should become the default in any case,
but something is wrong with the process if there isn't a good way to
communicate such behavioral turmoil.)  A separate project making its own
releases has a more visible place to indicate such changes.

[1] Max and I have no love for the "obfuscated shell scripting" in
gitifyhg's 'py.test'- and 'sh'-based test suite, and we expressed early
on that we'd rather have git-style shell scripts.  So while porting
these would provide a good start, they can't just be dropped into
git.git.
