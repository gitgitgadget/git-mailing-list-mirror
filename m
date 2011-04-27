From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 13:36:44 +1000
Message-ID: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 05:37:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEvYl-0005g6-GE
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 05:37:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031Ab1D0Dgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2011 23:36:46 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49717 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1D0Dgp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2011 23:36:45 -0400
Received: by vws1 with SMTP id 1so982825vws.19
        for <git@vger.kernel.org>; Tue, 26 Apr 2011 20:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=nDwHKwrH0cb2RUWhpEeb/mMRHM1ETG2gqKnurB9uiPk=;
        b=xeOdpqR16AmTgJyhjT9tKU9mdl08Ocq6o05DVcTnIU+04VGTRZ9ysx5hBC3fgs5u+n
         xEsLGIKeLclaFjYjKfFBRzlXKQquZfCKC/a37SY8H2ChOdBqSqY6unJTY3LmFMUFucd7
         /+ZjOoXtnSkmWtNwuT5JZea77WetdV5nXRXLk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=gBZ16N4xOlHwVBVIhYJU4XYrXb3ABw52YwVXdrTgn0sq6nnmLJJjldlsYI7sso8MoK
         AaLOH07ZR9S8KUT0g4N2o0LnGRJo9LSEemCW4PQxRw+K77T/RTpzwjwKBQ91fPKIY/cH
         K0k2YUPrTpyT1sixxr+bJeCQ1KDvYlWsalQHA=
Received: by 10.52.95.108 with SMTP id dj12mr2419730vdb.39.1303875404414; Tue,
 26 Apr 2011 20:36:44 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Tue, 26 Apr 2011 20:36:44 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172161>

Has anyone ever given consideration to git supporting a plugin
architecture for git extensions?

The idea would be to provide a consistent way to install, and address
extensions to the core git functionality in a manner that does not
require the extension to actually be integrated into the git core.

For example, I have recently proposed a new command 'git work'
https://github.com/jonseymour/git/blob/master/README.md which I think
is a really useful extension to git.

I haven't had much feedback for the concept. I am not sure if it is
because people are too busy, just don't grok it, or grok it and don't
think it is useful.

So, perhaps it won't be included in git. That's fine, I can build my
own fork of git which includes the proposed extension [ indeed, this
is how I originally developed it]. That's fine for
me, but it isn't the most practical way to distribute it to others
since I'll have to produce distribution packages for a variety of
different distribution formats or fallback to tars and zips.

What would be call is if I could package my extension in a standard
way and then anyone who was interested could simply do something like:

    git plugin install gitwork

and then start using the commands as if they had built my fork of git
themselves.

jon.
