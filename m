From: David Pisoni <dpisoni@gmail.com>
Subject: Re: [PATCH] Adds 'stash.index' configuration option
Date: Wed, 11 May 2011 17:48:58 -0700
Message-ID: <30791C70-81D4-44D7-B2E7-814D001F3E12@gmail.com>
References: <D80C1130-8DE6-457E-B203-FCF25B8ED72C@gmail.com> <7vfwoker7i.fsf@alter.siamese.dyndns.org> <7vboz8epbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 12 02:49:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKK5V-0006rj-Rk
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 02:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752811Ab1ELAtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 20:49:03 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48924 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1ELAtB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 20:49:01 -0400
Received: by gwaa18 with SMTP id a18so369441gwa.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 17:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        bh=3cq9uo6RA126Ft6p2zgs/xTQSswH3fDzEVxy0JNnXh8=;
        b=aOI8DYGe6yybflngvTdo6Pr6TTAM+lmiGIK1yV/KUHXIr2rzMn3cx/BhZ0p8bj14Zj
         D7FDpHO+84PNhMKnqBl2QWPJej8UGEnA2pBzzOaxOqFco1d/ruCV95TSmb+lBeBy869e
         /dKy5xmzyDSkAVldBbL7O4Q+aFtiFXK7xpOZw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=DAgHQHRogugnBqyzGi7MO1IM6SMF5ysO7+f16QcJ4RXK4s0nV6aPBUazl9N01EeL/a
         OAWrHY6gi/RBzK5UjtKxcox9iHFwVGXrcoZbvuwrd1o61ucRf+DSfTG99JK+H6nG7Nn2
         OOHRhqa0zr7d2g4K1JuCrsgL+Cs3ZtRO9nWvo=
Received: by 10.236.155.199 with SMTP id j47mr11817388yhk.127.1305161340742;
        Wed, 11 May 2011 17:49:00 -0700 (PDT)
Received: from [192.168.0.28] (ip-64-32-149-57.lax.megapath.net [64.32.149.57])
        by mx.google.com with ESMTPS id b70sm367679yha.88.2011.05.11.17.48.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 May 2011 17:49:00 -0700 (PDT)
In-Reply-To: <7vboz8epbp.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173436>


On May 11, 2011, at 17.26 , Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> Setting 'stash.index' config option changes 'git-stash pop|apply'  
>>> to behave
>>> as if '--index' switch is always supplied.
>
> One thing I forgot to say.  "stash.index" invites "index _what_?"
> Naming it to "stash.useIndex" may avoid such reaction.

No objection.  I want the feature (scratching my own itch here), but I  
don't really care what it's called. :)

>
> Also, the current code has this comment:
>
>    #   INDEX_OPTION is set to --index if --index is specified.
>
> but it probably makes sense to change it (in the first patch in the  
> series
> that adds --no-index support) to a boolean whose value can be either  
> true
> or empty.

It seemed a little wonky to me also, but this is my first foray into  
hacking on git and was concerned someone was depending on this,  
strange though it may be. git-blame fingers ef763129d for this oddity,  
dating August 2010.

>
> The reason why the very original code used INDEX_OPTION=--index may be
> because it did something like "git some-cmd $INDEX_OPTION", but that  
> is
> not what the current code does, and using "either '--index' or ''"  
> as a
> form of boolean is confusing.

I agree.  I like your change, also.
Does this feature make sense to you overall?

<SNIP>

Thanks,
David
