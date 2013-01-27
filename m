From: David Aguilar <davvid@gmail.com>
Subject: Re: mergetool: include custom tools in '--tool-help'
Date: Sun, 27 Jan 2013 13:10:51 -0800
Message-ID: <CAJDDKr5s=XS1m2rvBhibwEc8KNJswPJhb1arY0nhf4vZO56z6g@mail.gmail.com>
References: <20130127163442.GQ7498@serenity.lan>
	<7vobgawljs.fsf@alter.siamese.dyndns.org>
	<20130127195618.GS7498@serenity.lan>
	<7vmwvuv0ya.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jan 27 22:11:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzZVW-0000Sz-DF
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 22:11:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756261Ab3A0VKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 16:10:54 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:57702 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128Ab3A0VKx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 16:10:53 -0500
Received: by mail-wi0-f174.google.com with SMTP id hj13so194131wib.7
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 13:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=NdZl2GAvK/1fLLkt91U9efQDjB1Sx9UIe+KMzuDz0xI=;
        b=yWmnxaj8gEtwVuw5fFpaFj6ZkrA/3J6xZRWn2cwPTlu/vAurpJ5Vf28moI0hS/Z///
         p52U7oKfjXCi0bv7e3P+yaWomyBJhZbtJ9Pojt5D/nyw7Y9Wp/TjB2+DB685tknGSEqy
         RxrSFH0oJE3x3frYO2BDCQ3YYBH9TvzvZIu4q5h1VjPV2qAYICbKl/YOW1U4rqy96b+D
         qnU3/qQ8d6Vn2PqYfTbMQF5Fdky/+cH1doMubVOE420iba6a6rE4vutSFd3pM/IlEQbd
         C5D3ThT8U0u/dpQT70QFZNpqR4ixE69g7a6E0F51qKhL7dDqmxUeVAxzo2bHf+eodCBa
         n3vg==
X-Received: by 10.180.101.99 with SMTP id ff3mr6413744wib.21.1359321051843;
 Sun, 27 Jan 2013 13:10:51 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sun, 27 Jan 2013 13:10:51 -0800 (PST)
In-Reply-To: <7vmwvuv0ya.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214732>

On Sun, Jan 27, 2013 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> John Keeping <john@keeping.me.uk> writes:
>
>> I think I'd want to do this with a suffix if at all, so the output would
>> be like this:
>>
>>     'git mergetool --tool=<tool>' may be set to one of the following:
>>
>>             araxis
>>             gvimdiff
>>             gvimdiff2
>>             mytool    (user-defined)
>>             vimdiff
>>             vimdiff2
>
> That is fine by me, but the real users of mergetool please feel free
> to raise objections.

This seems pretty useful.

I did a bit of refactoring last night that I'd like to post here,
the end result being something that's plugged into Documentation/.

I think what I did may also help add this functionality, and
could be useful to build upon.

I'll send my patches shortly so you can take a look.
Basically, I added a simple way to loop over the tools
and filter them.  This is reused in show_tool_help() and
Documentation/Makefile.

The refactoring changes how show_tool_help() works,
so I'd like you to take a look before we add a new feature
since it might make it easier to do.
-- 
David
