From: "Miles Bader" <miles@gnu.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 7 Nov 2008 20:46:49 +0900
Message-ID: <fc339e4a0811070346k69c302bdnfcb59adf0036b5ea@mail.gmail.com>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com>
	 <20081106032437.GA27237@euler> <20081106095122.GA2656@atjola.homenet>
	 <buozlkd6oh1.fsf@dhapc248.dev.necel.com>
	 <20081106122658.GB4192@atjola.homenet>
	 <buozlkcqg0c.fsf@dhapc248.dev.necel.com>
	 <20081107110331.GA2938@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Deskin Miller" <deskinm@umich.edu>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Nov 07 12:48:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyPor-0001os-4H
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 12:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbYKGLqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 06:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYKGLqv
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 06:46:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.234]:9031 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751844AbYKGLqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 06:46:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1186599rvb.1
        for <git@vger.kernel.org>; Fri, 07 Nov 2008 03:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=78ly35rtVOIscmohOwk1dz/GBtGRKZ9sX1Yv7EMby7E=;
        b=QhWo6iT0Hq+2SNaTvm4FLRWW6JkbVPvvC9gnDCSWvPbnul/KBqOope7ONkoxnq4Sfy
         S7EQ8/SbEwXyfG1uXO0+dCtU7GjD2qTRRm1DKJ+yvz4KpSp5XO23rhHKEh1xx9PYA4+C
         iUgwayy4Z/pyH1Ly5jJLVjDVVCA+eCnurO6DM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=m21/CjMiP8PMSlw2H/px/hdzSAZtgY6TwV657z1FdnxAkK4IkN9R+PaNyNCMh/SSjq
         YsswOGRwR57jWMlLN9wt6OdtspRXjcgmdZwC+a3QKKDBssje2qO3pJfOSs3wl0nDN8fq
         4u1V04TJ6P+hVDDS5/G9Kvc/wfQuRxt0lOk5U=
Received: by 10.141.106.14 with SMTP id i14mr1718444rvm.27.1226058409480;
        Fri, 07 Nov 2008 03:46:49 -0800 (PST)
Received: by 10.141.106.8 with HTTP; Fri, 7 Nov 2008 03:46:49 -0800 (PST)
In-Reply-To: <20081107110331.GA2938@atjola.homenet>
Content-Disposition: inline
X-Google-Sender-Auth: 396f8d18f87c8128
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100304>

>> >> > git reset --hard C
>> >> > git rebase --onto ORIG_HEAD A^

>> Hmm, I guess using rebase --abort isn't a very good idea in this case
>> though... :-/
>
> Why not? I mean, ok, you end up at C, and not where you have been before
> the reset --hard, but there's the reflog to help you get back to
> whatever previous state of the branch it is that you want.

I just mean it's not a trivial way to get back to the state before the
multi-cherry-pick -- you need to know the details of what's going on,
and handle the rest of the cleanup manually.

So, for instance, if you were to package up the above commands in a
shell script, the abort issue is one of those rough edges which would
prevent it from being as convenient as a real git command.  [A
hypothetical extension of the cherry-pick command to handle multiple
commits would presumably offer a "cherry-pick --abort" option that did
everything magically.]

-Miles

-- 
Do not taunt Happy Fun Ball.
