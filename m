From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 19:37:21 +0100
Message-ID: <CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
 <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
 <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com> <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:39:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDei3-0004nq-VS
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:39:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbaBLSiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:38:07 -0500
Received: from mail-ob0-f179.google.com ([209.85.214.179]:33927 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753876AbaBLSiE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:38:04 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so10935775obc.38
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=1a7tQFWH58xdvEkXC+aIWKzcGXxzezR+UhH+Vrkb1YI=;
        b=BVDC4pYrLzOzntw8ouAJWOjRuyNc+pbgBTmcPGMp/2b8t8Y/m7FUJrfT7Q5GfqNFCQ
         uwvIdcKLglpTtYJHMPRsq8sTy6Yuufoi4Bld+JyjaV9a5whXHLW4CQHeVhwsD+mtimCP
         RuZXyXZsyafQzEa53itwhWZwH5mX6PIQ0y//VHfM3XzJIPU00Ni1IhLEbPUWPZkCu/Je
         4yixqThxRu91ev28dSo3aBUtTpuJ3U1+q2hlXCeklcepcviNiiH74iss42SZFi7oDJEU
         pbEB3+1rkbSkq1+Piw2T7c/cbMnmFAq2zJ432Lw9rpp/bM3WPEEmoUAU6J6tSmEQxED9
         6a6g==
X-Received: by 10.182.87.42 with SMTP id u10mr37803056obz.22.1392230282096;
 Wed, 12 Feb 2014 10:38:02 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 10:37:21 -0800 (PST)
In-Reply-To: <CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242007>

On Wed, Feb 12, 2014 at 7:34 PM, Stefan Zager <szager@google.com> wrote:
> On Wed, Feb 12, 2014 at 10:27 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager@google.com> wrote:
>>>
>>> I don't want to steal the thunder of my coworker, who wrote the
>>> implementation.  He plans to submit it upstream soon-ish.  It relies
>>> on using the lpOverlapped argument to ReadFile(), with some additional
>>> tomfoolery to make sure that the implicit position pointer for the
>>> file descriptor doesn't get modified.
>>
>> Is the code available somewhere? I'm especially interested in the
>> "additional tomfoolery to make sure that the implicit position pointer
>> for the file descriptor doesn't get modified"-part, as this was what I
>> ended up butting my head into when trying to do this myself.
>
> https://chromium-review.googlesource.com/#/c/186104/

ReOpenFile, that's fantastic. Thanks a lot!
