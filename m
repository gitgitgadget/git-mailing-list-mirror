From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log: add log.follow config option
Date: Wed, 01 Jul 2015 14:19:49 -0700
Message-ID: <xmqqvbe37eyy.fsf@gitster.dls.corp.google.com>
References: <1435777439-5002-1-git-send-email-dturner@twopensource.com>
	<vpq8uazo9y6.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jul 01 23:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAPQD-0000wz-29
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 23:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918AbbGAVTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 17:19:52 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:32797 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbGAVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 17:19:51 -0400
Received: by igcur8 with SMTP id ur8so102666220igc.0
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 14:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pX/Y9u3TkfC0F1yyVqejkLNlzk3wEdpx3qwByOVw3hw=;
        b=efgXtqelHm4oCCm0vWNQMSk2kCjoQ6jkDDVuer0kHOpwU3fKq1RrP0nXE/kq3ygcRO
         EYyd611yHxwhxGj+koUSAjkhe70Uw+tLr546QU+/ZlSDC6blwo64/qfjDFJJmWtkktAw
         zL0nAmtDwrtocGxGrnR5ZZgJAc3B6lBbo3aEZ65Iyepk2zlODwWoaX9b6aI+yZ2YXSt4
         95vLZ83Aiv5lllZKZXTw9maHEv6DfzssVuBGTWQ8dS/3Ffx92C7x+N4HhqxbEy8pC2+T
         U1b1RPeBx8MQJYG2kVjA96k/GXn01URV/oBnGDD9yiBCWZS0YKdYnaO+myx3gCiZMYsA
         SF2g==
X-Received: by 10.50.87.74 with SMTP id v10mr8570301igz.37.1435785591094;
        Wed, 01 Jul 2015 14:19:51 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by smtp.gmail.com with ESMTPSA id x3sm23505igl.2.2015.07.01.14.19.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 14:19:50 -0700 (PDT)
In-Reply-To: <vpq8uazo9y6.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	01 Jul 2015 23:16:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273205>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> So activating --follow for all "git log" calls would prevent log from
> being used with several pathspecs.
>
> Or, do you have a preparation patch that allows --follow with multiple
> pathspecs? ;-)
>
> In any case, you have to test "git log -- path1 path2" with the option
> activated.

Or more commonly, just "git log" with no pathspec.

I also think that it is a bad idea to force "log --follow" to people
before it is made into a true feature; as it stands, it is merely a
"checkbox" item.  It has too severe limitation to be used seriously
in real projects, unless your history is completely linear.

cf.

  http://thread.gmane.org/gmane.comp.version-control.git/269357/focus=269433
