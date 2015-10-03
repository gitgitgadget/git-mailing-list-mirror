From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Sat, 03 Oct 2015 10:23:39 -0700
Message-ID: <xmqqd1wv3lyc.fsf@gitster.mtv.corp.google.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih78tsDe-RAUOEjrGMBJU0sage37V1sL9QLPZhRQhb5GUCA@mail.gmail.com>
	<xmqqh9m73m7z.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Oct 03 19:23:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiQXD-0001pD-6V
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 19:23:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbbJCRXn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 13:23:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35809 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbbJCRXm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 13:23:42 -0400
Received: by pacfv12 with SMTP id fv12so137788868pac.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 10:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XsG8NN20u5G6qhETdUafmCDiEY9gBsYpu37OC8tswv8=;
        b=gbgVA97LW5esRZj+ZbUwhnyVwqOY8TucLBYhlae0WU1LQAF8/WJ8wNhEa7OYdlvDyT
         DJqxsW45cF4IN4eleQ7/btJqrU77tIU1xN4IIHJ9Ub6j/23IPkDUw0Jp7GxGy9S4manR
         Z21A5tl4J7U07/vnFsNLEDXoBSS3GKevxyJKSuvLbc6a0YWJxqnmx27poIQIwOVQyp4H
         QsYFbgKJst8sEtBvox578PtFqAZfEFZKqZJE/+JlGvrNmbidrvfA4I8fwHOHQXYx7nX3
         w+UDAaAAc/qWw9ldlmP+S4mxseHd8v/2BUXuD5u2olyZrPFnU+RmXDR8FFp2JiUeOvJL
         AJIw==
X-Received: by 10.68.68.143 with SMTP id w15mr28201829pbt.56.1443893021715;
        Sat, 03 Oct 2015 10:23:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:6403:45be:a5c3:ebf3])
        by smtp.gmail.com with ESMTPSA id gi4sm18478197pbc.4.2015.10.03.10.23.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Oct 2015 10:23:40 -0700 (PDT)
In-Reply-To: <xmqqh9m73m7z.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 03 Oct 2015 10:17:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278979>

Junio C Hamano <gitster@pobox.com> writes:

> Luke Diamand <luke@diamand.org> writes:
>
>> All looks good to me, Ack.
>>
>> One tiny thing perhaps Junio could comment on: the git commit message
>> for 75abe9fa5b39980de27dfc33dd5b4f4b5926f34c, "git-p4: add optional
>> type specifier to gitConfig reader" uses what looks like UTF-8 encoded
>> left and right quotes, rather than regular ASCII quotes ("). I don't
>> know if that matters.
>
> Yeah, I noticed them, too.  In general, I'd prefer to avoid these
> pretty-quotes myself, as they typically do not add much information
> (unless nesting matters, which is usually not the case in the log
> message, or something) and the primary effect of them is to force us
> to step outside ASCII, which causes editors and pagers to misalign
> for some people.
>
> But it is not too huge an issue that it is worth to go back and fix
> them, either.

Well, I looked at it again and it also replaced double-dash before
option names like --bool and --int with something funny (are these
em-dashes?), which is a more serious bogosity than pretty quotes, so
I ended up amending the message for that commit after all.

Thanks.
