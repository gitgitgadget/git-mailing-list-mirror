From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status doesn't ignore GIT_DIR directory?
Date: Sat, 23 May 2015 10:00:23 -0700
Message-ID: <xmqqwpzzcjq0.fsf@gitster.dls.corp.google.com>
References: <555FD1EA.2060706@rightscale.com>
	<CAPc5daW2yTHHegPDrEWS5KiSYWZECV+AxMnewzz9ayASB1QNUw@mail.gmail.com>
	<20150523022256.GA17789@lanh> <20150523053900.GA2364@glandium.org>
	<xmqq1ti7dyky.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Thorsten von Eicken <tve@rightscale.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat May 23 19:00:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YwCmn-00029M-Em
	for gcvg-git-2@plane.gmane.org; Sat, 23 May 2015 19:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758041AbbEWRA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2015 13:00:26 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:36285 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757957AbbEWRAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2015 13:00:25 -0400
Received: by igbpi8 with SMTP id pi8so11571248igb.1
        for <git@vger.kernel.org>; Sat, 23 May 2015 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=WewYE04xUYpp495YNhWOnICv1+BnoIqjDZRqH3qk1xE=;
        b=KpSwjI+pl5CHNpoNtY4N/I4p3XiUT0gl8rLZlGf5Rp8kVyL1UB31SdW0FyRkQNxhsF
         8IjPrnGlzKGg+vdVH6bsya2mlVX5T8p7yDFnIaqD3IrvE6WrBjEUZxy246aJTuUiUzN9
         RSb1t2rjWsQ/CsDhy3onkSLTR2QlDzpsi+5f355cALm1tJaBQs+T0lBaeiYyZZTwSncc
         zGUt1rMJ6Jiqk1ZfVSo9n5PiIQo7mY2nV3Bo+FQlTLQW5DeFEhuh4Yqo9306A2D7oOxp
         5fkdrDFJQSxVwN/OGDjemqnvy5mc0VY/LhqPVgdsbvJEJ2yiPB03iYFluG95BjZr73dC
         fjRg==
X-Received: by 10.42.226.8 with SMTP id iu8mr15478164icb.17.1432400425095;
        Sat, 23 May 2015 10:00:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:609e:6a22:2d9d:c8d5])
        by mx.google.com with ESMTPSA id m9sm1902468igv.4.2015.05.23.10.00.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 23 May 2015 10:00:24 -0700 (PDT)
In-Reply-To: <xmqq1ti7dyky.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 23 May 2015 09:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269807>

Junio C Hamano <gitster@pobox.com> writes:

> I think both of you are wrong ;-)
>
> The thing is, what you are seeing does not have much to do with
> GIT_DIR.  It is "what Git does when it finds a directory inside the
> working tree of a project".  And ".git" is the only special thing in
> that context.

In short, I think Duy's "how about this" means well, but adds
documentation at a wrong place.

Having said all that, the message I am responding to showed the
right way to look at, understand, and explain the current behaviour.
It is a separate issue if the current behaviour is optimal from the
usability point of view.  It is not entirely implausible to extend
the special casing rules from "a directory named '.git' only" to "in
addition, the directory pointed at by GIT_DIR, if exists, is treated
the same way".
