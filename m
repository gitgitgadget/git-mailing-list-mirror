From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: checkout won't checkout?
Date: Thu, 18 Jun 2015 15:28:04 -0700
Message-ID: <xmqq4mm4d53f.fsf@gitster.dls.corp.google.com>
References: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:28:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5iI8-0004mE-W5
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbbFRW2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:28:08 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35367 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751560AbbFRW2G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:28:06 -0400
Received: by iefd2 with SMTP id d2so7744994ief.2
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2u698NGp+cOHp9ngxsJdTIdQGA73CQXiRs/6YZyO7IQ=;
        b=z7WyBOs6/Lddk7nVviN0P/v4aFl1lN4jYP7WO2J9WtprLF8cDW0XMrHLT/iuc6hsV9
         r83/AqlXjd9X6qgu4W+pdEBsgh4mT6X6ri51GjtU5Q/o5HwMjUnEQXI03xXcE/Taphgx
         FlGSI0H9eIcfjvY5X5OYmwm/jUo7E4n+I0qVhxhJLuxRoQpWVgJMdtgOsTCI8keHM0nh
         E5N3ZE5JZi26ciuz5Jg9KRMJnNLqW1MQUK3kizNAsjvliVMTdjtGoRgXsqPUUfZj1Vdy
         We7BIYPt33tT7t4aZ73o9hM4zTgws9+RbtXZB7CoXcahZf/5vzBhJzIB2CRa8FqTusNt
         +5Ow==
X-Received: by 10.43.39.208 with SMTP id tn16mr8276167icb.27.1434666486258;
        Thu, 18 Jun 2015 15:28:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id i185sm5816235ioi.24.2015.06.18.15.28.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 15:28:05 -0700 (PDT)
In-Reply-To: <CAE5ih7-=WPme_BxgAjtm9hrShxTk1z+uDM-LXzc3BcN3n2vqAg@mail.gmail.com>
	(Luke Diamand's message of "Thu, 18 Jun 2015 23:07:18 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272088>

Luke Diamand <luke@diamand.org> writes:

> This is probably user error, but I'm not sure what I'm doing wrong.
> I'm posting here in case anyone else gets the same thing
>
> I'm using 2.4.4.598.gd7bed1d, i.e. 'next' as of today.
>
> I've somehow ended up with history skipping back in time, but git not
> prepared to let let me fix it, or something.
>
> $ git diff upstream/master -- subtree
>  - lots of deltas, which look like I've reverted this back several
> revisions (which I haven't AFAIK)

Are you on the right branch that you think you are working on?

> $ git checkout upstream/master -- subtree
> $ git diff upstream/master -- subtree
> -- still lots of deltas

Does this show _ONLY_ additions?  Or does it include modifications
and removals?
