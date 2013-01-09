From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] commit: make default of "cleanup" option configurable
Date: Wed, 9 Jan 2013 00:28:58 -0800
Message-ID: <20130109082858.GG6503@elie.Belkin>
References: <1357676176-30019-1-git-send-email-ralf.thielow@gmail.com>
 <20130109072952.GC6503@elie.Belkin>
 <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 09:39:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tsr2M-0003lp-Ic
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jan 2013 09:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315Ab3AII3F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2013 03:29:05 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:52552 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757246Ab3AII3E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2013 03:29:04 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so633367dal.1
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 00:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+sFPTHBBlitH2FVGqZ1pO/+UB0Woq8spaKjc82wiRmc=;
        b=WfiT89C1OVINZqhPs2Y0fGkXycWoKNakfIUC5DRS3a08RJgZg6+4TreS8lycXRK+Hs
         vIQbj8ktBj16Da9l2Z4NGmpp8YqFgfrmmv67svRudfYSlSkhvRaB5G8vvs9wY2tWcEXd
         TuE32zZgFKwhs08EJpwNFAyVELf91XvyM0W4vPeHQru8ZeDTpeUejUdFAcGpREhzTOQN
         ot6OiqmrLW9h10koR1T/gLqTV5R0NxV9crFUO8Fj5Eky+hWLOzhGo2JufmE9bEM08oPY
         LGGyhL+3d/qedFTP+sDkz/8AcNU4WisEyXDxQQt9v6lyAbxsNdrGqDtAX7xaH+yVV7Da
         Dq5w==
X-Received: by 10.68.235.200 with SMTP id uo8mr16488150pbc.29.1357720143238;
        Wed, 09 Jan 2013 00:29:03 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vk5sm41231267pbc.34.2013.01.09.00.29.01
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Jan 2013 00:29:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAN0XMO+t2gu9UKJFVXAxt91-hUUhMqqmMoop88KYp0vo3x6c_g@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213051>

Ralf Thielow wrote:

> It's actually my own usecase :). The bugtracker I'm using is able
> to create relationships between issues and related commits. It
> expects that a part of the commit message contains the issue number
> in format "#<issueId>". So I need to use a cleanup mode different
> from "default" to keep the commentary. The mode I'd use is "whitespace",
> "verbatim" is also possible.

Hm, so "whitespace-when-editing" would be the ideal setting.

Would it be confusing if the '[commit] cleanup' setting only took
effect when launching an editor (and not with -F, -C, or -m)?  My
first impression is that I'd like that behavior better, even though
it's harder to explain.

[...]
> When a user uses a script/importer which expects that the "default" option
> is used without setting it explicitly, and then the user changes the default,
> isn't it the users fault if that would break things?

Consider the following series of events.

 1. My friend writes an importer that uses the "git commit" command.
    I like it and start using it.

 2. Another friend writes a blog post about the '[commit] cleanup'
    setting.  I like it and start using it.

 3. I try to use the importer again.

 4. Years later, I notice the commit messages are corrupted in the
    imported history.

It's hard to assign blame.  I guess it's my fault. ;)

[...]
> I'll add a sentence of my bugtracker example to it. I think many developers
> are using such a tool, so it'd makes sense.

Thanks, sounds good.

Regards,
Jonathan
