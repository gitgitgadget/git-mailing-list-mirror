From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 21:06:22 +0700
Message-ID: <CACsJy8B3pHZLUuqnmZuqfAo-B=LAm5Q6M4waf4sK8387E9U+uA@mail.gmail.com>
References: <20120210185516.GA4903@tgrennan-laptop> <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org> <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
 <m3sjihu18t.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	krh@redhat.com, jasampler@gmail.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 15:07:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwDbP-0002cA-PK
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 15:07:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758758Ab2BKOGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 09:06:54 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:60567 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758741Ab2BKOGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 09:06:53 -0500
Received: by werb13 with SMTP id b13so2616150wer.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 06:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8ZNzUyqQE2Q3iFhJyGH4XDc8PBYxs33OUE2nzSYiQZ8=;
        b=Dl2VW0Hb3GI43tAwMPjBqUv7ybmQ1pHZE1hvD8yRJCozYsxv+asoAcuyh+BoGmf5jQ
         N8T/7RC5le6abz0xAGHLMVW5vHrcxK0wAG/nfERkUe0kTmnVpHzjG7DCeeguFbX4KSJs
         ZOIuFiV/A0B6VF4QjdDTcwL328grI3Bjp9ZXM=
Received: by 10.180.87.8 with SMTP id t8mr8886624wiz.15.1328969212218; Sat, 11
 Feb 2012 06:06:52 -0800 (PST)
Received: by 10.223.2.139 with HTTP; Sat, 11 Feb 2012 06:06:22 -0800 (PST)
In-Reply-To: <m3sjihu18t.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190514>

On Sat, Feb 11, 2012 at 5:13 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> In a future versions, we may want to have "branch/tag --list" also ask for
>> FNM_PATHNAME (this *is* a backward incompatible change, so it needs to be
>> performed across major version boundary, with backward compatibility
>> configurations, deprecation warnings and whole nine yards). Under the new
>> match function, today's "branch --list 'maint*'" needs to be spelled as
>> "branch --list 'maint*/*'" or something.

One of the reasons I proposed pathspec is to avoid another set of
matching syntax in addition to gitattr, gitignore and pathspec,
Pathspec magic makes it extensible, FNM_PATHNAME be set that way.

> Or "branch --list 'maint**'

But this comes up a few times already on gitignore discussions. We
have fnmatch.c in compat for Windows. Someone just needs to step up
and implement "**". It would also a nice thing to add to pathspec
syntax, if we can forget the backward compatibility nightmare.
-- 
Duy
