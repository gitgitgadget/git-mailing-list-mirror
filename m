From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: Unexpected cherry-pick behaviour
Date: Wed, 11 Dec 2013 12:09:02 +0100
Message-ID: <CALWbr2zPPnDiv7oVBhnM9dSW=pfz2jUA_A5u_gk2ttgXTStvkw@mail.gmail.com>
References: <118044938ad8ebf6b069bcc1d220a986@matos-sorge.com>
	<xmqqvbywts9d.fsf@gitster.dls.corp.google.com>
	<7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Paulo Matos <paulo@matos-sorge.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 12:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqhgC-0002nd-Mf
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773Ab3LKLKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:10:05 -0500
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33940 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab3LKLJD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:09:03 -0500
Received: by mail-pd0-f177.google.com with SMTP id q10so9256774pdj.22
        for <git@vger.kernel.org>; Wed, 11 Dec 2013 03:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=foWgfydV8FMnwN+f0hX6/OmFBeIUd4tvy5d0Dbq+O/s=;
        b=rNZzj/wHCvVO4ZfZnqpyPBZj7nLrVWYoie9YftFYEmaLT07UCh6kGE+xVBYYBXp0TE
         64Xm9sU8rqwjERDZiybJW5iJ8KfDmLJAb0XF2h2/JVxLTcJ4RLlSvwVX+ED3iuiUoDHH
         89sQ0pXG6BAnMTp4kNnqCBTmF3b6mIr8ZeckhFNzzmVAH53cr7AASVoYkteSqCfX+r/A
         qYeSY6U7Jpn+pQTwrH03ijvjQw4YMdqjzQfplMxX1MPRKnp03D9lnWe4Lp65RCvwcdq/
         4OQDONqz6c4ZD7T3u+t/hV1WUBC1VadOgaJ8JkLHffrGAmCHv4ovtyK1dZ8XBjp0WwFY
         3Xvw==
X-Received: by 10.68.29.103 with SMTP id j7mr910318pbh.17.1386760142644; Wed,
 11 Dec 2013 03:09:02 -0800 (PST)
Received: by 10.70.124.228 with HTTP; Wed, 11 Dec 2013 03:09:02 -0800 (PST)
In-Reply-To: <7050e7272bb83d083a56a2c391228ed8@matos-sorge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239184>

On Wed, Dec 11, 2013 at 11:04 AM, Paulo Matos <paulo@matos-sorge.com> wrote:
> On 10/12/2013 19:34, Junio C Hamano wrote:
>>
>> Perhaps immediately after "cherry-pick" stopped and asked your help
>> to resolve the conflicts, running
>>
>>         $ git checkout --conflicts=diff3 gcc/tree-ssa-threadedge.c
>>
>> and looking at the file again may show you what is going on better.
>
>
> I don't know how to interpret the fact that the line you sent (with the
> obvious --conflicts being --conflict) outputs nothing...

That is expected. git-checkout with this option [1] will reset the
conflict on gcc/tree-ssa-threadedge.c file to the initial conflict
state, and use the diff3 markers. You should have a new look at that
file as you will now be able to see the "ancestor" in the conflict.

[1] You can have a look either at git-checkout manpage or here:
http://git-scm.com/docs/git-checkout, especially --merge and
--conflict options.
