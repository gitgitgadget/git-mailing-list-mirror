From: Pekka Kaitaniemi <kaitanie@cc.helsinki.fi>
Subject: Re: [PATCH] Test case for a problem with git add -u from subdirectory
Date: Wed, 20 Feb 2008 21:31:26 +0200
Message-ID: <20080220193126.GA26686@localdomain>
References: <20080220143215.GA23053@localdomain> <7vhcg35v9r.fsf@gitster.siamese.dyndns.org>
Reply-To: kaitanie@cc.helsinki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kaitanie@cc.helsinki.fi, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRug5-0004ph-Kb
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 20:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482AbYBTTbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2008 14:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755915AbYBTTbu
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Feb 2008 14:31:50 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:39645 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754198AbYBTTbt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2008 14:31:49 -0500
Received: by ug-out-1314.google.com with SMTP id z38so822545ugc.16
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=RvjggAQ7q6VmA3DpsBo9cOBh63CqBNSCQ1B6AM8we8E=;
        b=DFZJt7GKJdAp2VSoKeGGB1yeBpSESBc6lKzfV8PnEO1LEZFKRqUphcmpjFll3Q3spt60txhCsl/cimIQrd7j/mMS5SLhrSmC7OIT6XXb9fRO/yprqePQEnN2USeU5/+aXYGKnP/mnHVyy0SMDnKppun1VcgpW0o7klFo5B3Il/A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=OVZwfgjLUAI3VkZhmY/4d4X5Bv9iI5/fAP5CZ4Zl8Rxv1c2cCn2Z5ePC3VhDzrl/wr92G04F3QPR6YpD1ocXFTPac6FsIxav5ko+qf9OWRATqSQi+IFdUjqAkTDJ/6Xk5jR5vdyExLGE//8zRHquxXW3duWNgQIz0Lejgz7cw4Q=
Received: by 10.67.116.9 with SMTP id t9mr2853522ugm.77.1203535905742;
        Wed, 20 Feb 2008 11:31:45 -0800 (PST)
Received: from shadow ( [217.30.191.90])
        by mx.google.com with ESMTPS id k30sm9698770ugc.53.2008.02.20.11.31.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 11:31:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhcg35v9r.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74538>

On Wed, Feb 20, 2008 at 10:37:36AM -0800, Junio C Hamano wrote:
> Pekka Kaitaniemi <kaitanie@cc.helsinki.fi> writes:
> 
> > The key sentence being: "If no paths are specified, all tracked files
> > are updated."
> 
> My recollection is that the current behaviour was requested
> specifically by the users.  Although I do not remember offhand,
> the first implementation might have even been doing the whole
> tree unconditionally, and surprised users by stepping outside of
> the current subdirectory.

I was a bit confused whether it was a feature or a bug and since the
documentation seemed to indicate that "git add -u" should add
everything I suspected that it was a bug. Anyways, thanks for the
clarification.

> Sometimes I am annoyed that it does not do the whole tree
> (i.e. you have to go to the top), but some other times (which
> happens to be majority for me but it would depend on the
> project) I find the current behaviour a lot more convenient, and
> personally I do not think it is a good idea to change the
> current behaviour.

I agree. Changing the behaviour is not good since it was requested by
users and implemented intentionally.

If adding all tracked files in the whole tree to the index is needed,
then maybe it would be useful to add a new flag to git-add? Something
like -a (as in all), or -U (really update the whole tree) might be
useful option. But then again, the difference between them should also
be documented clearly.

> Please send in documentation clarifications.

OK, I'll prepare a patch.

Pekka
