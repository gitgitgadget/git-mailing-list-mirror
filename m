From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 08:30:24 -0700
Message-ID: <xmqqvbdi3ipb.fsf@gitster.dls.corp.google.com>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li>
	<20150717092251.GB5916@iris.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Jul 17 17:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG7as-0006xv-3J
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 17:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827AbbGQPa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 11:30:29 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34972 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbGQPa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 11:30:28 -0400
Received: by pactm7 with SMTP id tm7so62961364pac.2
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uJ0drDwK4JQHjGeJwtuoR7uVD0h0gg0p5CcsVeulMq8=;
        b=lxjZcEDOqoX7jocCWDMxjUajunV9VED9WNy1KFubwB2AKqobjbgJ5LDfLaWCQ6X5Ef
         ojssAXf1IKWXvVFwt5A9A/TOXaf0TUHkw/5A8nexbGbvZpgT2e4t0gWvR4CoUrJsIchy
         nR1mBryDrL+r/+cGmPzcSVnHEkUaLIvh7Ovm2/wRHAcZUmmAFkR6Wt+SuqosXAjic0/Q
         wsoPT2r5wE+jD66eTXb4uDB5xckVQRUZrmFFN+TdobMs6jc7qbncOrJWmrjiu0SvDAiT
         goH6tC6Q0tcGDnRhUjHLA15FmLF/kKJ0fTT1/Cx3ewnQq4uX59RhIM1vMaRE9W5nW8U5
         oBtQ==
X-Received: by 10.68.190.41 with SMTP id gn9mr30106319pbc.113.1437147027984;
        Fri, 17 Jul 2015 08:30:27 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id q7sm2823433pdj.31.2015.07.17.08.30.25
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 08:30:27 -0700 (PDT)
In-Reply-To: <20150717092251.GB5916@iris.ozlabs.ibm.com> (Paul Mackerras's
	message of "Fri, 17 Jul 2015 19:22:51 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274076>

Paul Mackerras <paulus@samba.org> writes:

> We have an item in the preferences menu to control the SHA1 length
> that is automatically selected when going to a new commit.  It's
> stored in the variable $autosellen.  That seems like it would be a
> reasonable choice for the SHA1 length to use here.

Reusing a configuration that is used to control something similar
sounds sensible to me.

> The only possible
> problem is that it defaults to 40 and so might give an overly long
> result for some users.  Maybe you could use $autosellen but limit it
> to at most 12 or 16 or something like that.

How is the thing that is "automatically selected when going to a new
commit" used by the end user?  What is the reason why people may
want to configure it?  I understand that this is the string that
goes into the selection buffer, so presumably people are using this
selection to paste elsewhere?  If so, that sounds like very similar
to Beat's use case---perhaps if 40 is too long for Beat's use case
as a sensible default, then it is also too long for its original use
case?

Or do you expect it to be common to want to use autosellen set to 40
and Beat's abbrev len set to much shorter, e.g. 16?  If so they may
deserve two different settings, with different defaults.

Artificially limiting it to 12 or 16 does not sound all that
sensible, though.

Thanks.
