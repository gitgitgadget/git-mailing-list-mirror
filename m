From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 08:07:49 -0700
Message-ID: <xmqq8ua5oapm.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
	<20150724072325.GC2111@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:08:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIeZp-00014o-E5
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 17:07:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbbGXPHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 11:07:54 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34373 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752081AbbGXPHv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 11:07:51 -0400
Received: by pacan13 with SMTP id an13so16056869pac.1
        for <git@vger.kernel.org>; Fri, 24 Jul 2015 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=rJbeo2kLkOh+nQj8lVlLQDJGdRzvdIv/p32YCsQArwE=;
        b=lj7XPLwZ5XjRC1jWEVUj4iIjZelLJZLGBRXNBaogrA9UZUy2PQufPPfrrwy1GfiJmR
         1+C3AwQHkI75gIUXK5eKFxxiigxyZeZSIQ3GJY9OStcZYfyBPBr5BbuWCl5dDgJ1OguS
         sUUY3TJvn50+0lEMM//BHhLDFZkvTJtH5uTTOcg6iHODCGFUYhCK+cyDnn/fkcZP/R51
         9qj91LFunURCLNw87UC0wBByUvCyVW1JiAaTg++jv4tXiU+dVW1FlFZLhp/uOUbBLy5K
         PGCzExMqPGah7LhwbzSwQY58YMNWnZ3yUmuvcfOaopztopMA4ezNsiJQWZK72V0HR/U1
         UYTg==
X-Received: by 10.66.168.229 with SMTP id zz5mr29520977pab.41.1437750470595;
        Fri, 24 Jul 2015 08:07:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:bdad:9e5d:aa9:33a9])
        by smtp.gmail.com with ESMTPSA id de2sm15134799pdb.15.2015.07.24.08.07.49
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 24 Jul 2015 08:07:49 -0700 (PDT)
In-Reply-To: <20150724072325.GC2111@peff.net> (Jeff King's message of "Fri, 24
	Jul 2015 00:23:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274572>

Jeff King <peff@peff.net> writes:

> On Thu, Jul 23, 2015 at 03:46:33PM -0700, Junio C Hamano wrote:
>
>> Admittedly, that
>> merely is saying that "--first-parent" is not a solution to such a
>> project, and does not say much about the usefulness of the new
>> configuration, so I'd queue it as-is.
>
> Yeah, I agree that this patch does not make a judgement on particular
> workflows, and can stand on its own. I buried a related deep in a
> footnote in my other email, so let me bring it up again here.
>
> I am not entirely convinced this won't bite somebody who gets a sha1
> from some other source, and then wants to run:
>
>   git log $some_other_sha1
>
> who might be quite confused to start a first-parent traversal from
> somewhere other than the tip of "master" or the tip of a topic branch.

Yeah, you actually convinced me reasonably well that it would
happen.  I'd never use it myself.  If people want to shoot
themselves in the foot, be my guest ;-)

Perhaps we should drop this, and give a shorter synonym to the
option?
.
