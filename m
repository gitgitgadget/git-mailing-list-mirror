From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Commiting automatically (2)
Date: Tue, 21 Dec 2010 05:06:39 -0800 (PST)
Message-ID: <m34oa7l1hq.fsf@localhost.localdomain>
References: <loom.20101219T090500-396@post.gmane.org>
	<7vaak1ftin.fsf@alter.siamese.dyndns.org>
	<loom.20101220T062209-24@post.gmane.org>
	<20101220073312.GA23482@nibiru.local>
	<loom.20101221T092948-59@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Tue Dec 21 14:06:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV1vU-0006tV-6p
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 14:06:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab0LUNGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 08:06:43 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:63850 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab0LUNGm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 08:06:42 -0500
Received: by fxm18 with SMTP id 18so4278216fxm.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=cqdqBPqKz8QZ68oxyaTzmNTNusMNQ5jFRA02Q/Vwct4=;
        b=tr0x2EVM0Ru4Fvq18WS8O5nU8XJ98L2c0qbuV89cgnclZnRXNVzn4ONCoY/Q1gTf+l
         PCpVN2GwOv0c4949ApJQbfhPjEqJlYGjLZysSfjvHJJ2tiExqltaq6Gdh/HCmnh0DZ7T
         7kMTQKltktBxRjrI9VNTVEoL5kVy+oXtr2YPg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=uzAMpijwIllyp85hiFKIH6+3jzAAgIgt6tcEAolUGrowzp82AEoAUYrqSD7lRspyla
         zDUzVk7y7CBq/yyMAgMCHDa5aUGjrUmcdPJI38zVKzm7Vdp/fWlTt0+qdhwcDRGfpORJ
         GyvAqZAqQ/9s6D2lJwTb/30vWcepeM2jgOgR8=
Received: by 10.103.220.6 with SMTP id x6mr117244muq.90.1292936801016;
        Tue, 21 Dec 2010 05:06:41 -0800 (PST)
Received: from localhost.localdomain (aehn132.neoplus.adsl.tpnet.pl [79.186.195.132])
        by mx.google.com with ESMTPS id l3sm936620fan.2.2010.12.21.05.06.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 05:06:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBLD6Gdr019209;
	Tue, 21 Dec 2010 14:06:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oBLD5sSk019203;
	Tue, 21 Dec 2010 14:05:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20101221T092948-59@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164031>

Please try to not cull Cc list (use 'reply via email', if possible)

Maaartin <grajcar1@seznam.cz> writes:

> I let the snapshot point to the current head, which is where I get a problem now:
>
>   git show-ref HEAD
>
> returns nothing,
>
>   git show-ref --head
>
> returns HEAD and all branches and tags. Isn't it a bug? How can I get the HEAD 
> reference? I'm using git version 1.7.2.3 on cygwin.

You can use `git rev-parse --verify HEAD`, for example.  Generally
scripted commands (including those in contrib/examples/) are good
sources of inspiration.  Or if you want symbolic name, you can use
`git symbolic-ref HEAD` or `git rev-parse --symbolic-full-name HEAD`.

As for `git show-ref HEAD` - git-show-ref uses its own way of pattern
matching; in new enough version of git-show-ref manpage you can read
that:

  <pattern>...::

        Show references matching one or more patterns. Patterns are matched from
        the end of the full name, and only complete parts are matched, e.g.
        'master' matches 'refs/heads/master', 'refs/remotes/origin/master',
        'refs/tags/jedi/master' but not 'refs/heads/mymaster' nor
        'refs/remotes/master/jedi'.

So `git show-ref HEAD` would match 'refs/.../HEAD`, e.g. `refs/remotes/origin/HEAD`,
but not `HEAD` which is outside `refs/`.

I tripped over strange git-show-ref <pattern> semantic too.

P.S. there is also git-for-each-ref.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
