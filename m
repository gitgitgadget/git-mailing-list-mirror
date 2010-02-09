From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: [Announce] gitolite 1.0
Date: Tue, 9 Feb 2010 18:45:26 +0530
Message-ID: <2e24e5b91002090515o356c53baib1f5f750e0d67dba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 14:15:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NepwC-0002VJ-Qa
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 14:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754368Ab0BINP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 08:15:28 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:48027 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245Ab0BINP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 08:15:27 -0500
Received: by pzk17 with SMTP id 17so359801pzk.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2010 05:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=XWP/0en2z0gfgZz7vwmRCx6h7eEXnFNOP+jiUBYGmlw=;
        b=UxOPP7HYkSm8PpV7ME7Prh9Q9b35cRo7MRebts51u/VHmd3LentopEIlBA4ni1cG0Z
         46F7X/NY06D4odtStUqlgDDhNWM7e7a113ji4YId+WfZOLdcPQp6balk1tMLEfxDCDMy
         mjfRqkxs7UODFY038bODqMl6W9BFXgHH3RQuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=YBf6jKeJon9vpAkZcOUjV6AB93Tw9aCTwjdSQglowpSu6wQHItUr9W+U/WCGav07aA
         JVTC7pR8LPxHfIPq6daSNAE5krKjBS0TAq3N5ccVoZ3ejs2kISNKSZy4/58lLk1BV6Ae
         /yl9C6+guSn+OHLTLLfmh1uUPUOKiofMTE88Y=
Received: by 10.115.101.39 with SMTP id d39mr3484348wam.207.1265721326595; 
	Tue, 09 Feb 2010 05:15:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139403>

Gitolite is an ssh-based access control tool for using git in a typical
"corporate" environment.  The original goals were very simple:
read/write/rewind access control at the git branch level, the ability to
install on any Unix, no need for root access, and no need for additional
software (other than git and perl).

There is plenty of documentation included with the source, because by
now it has acquired a lot of features not originally planned.

I now consider gitolite to be at 1.0, and this note summarises the
features added since the last email to the list [1] about gitolite.
Please see README.mkd and doc/3-faq-tips-etc.mkd for *all* the details
if you are completely new to gitolite.

  * Install/upgrade can now be done even from the bash that comes with
    msysgit.  This means pretty much anyone can quickly and easily
    install gitolite on any Unix server.

  * You can specify an "owner" and a "description" for gitweb to
    display.  The syntax is very simple, here's an example:

        gitolite "Sitaram Chamarty" = "fast, secure, access control for git"

  * You can include any site-specific (custom) hooks that you want to
    propagate to any repo created by gitolite.

  * The "deny access" feature can be very useful sometimes; an example
    that shows how only bob may push version tags would look like this:

        @devs                       =   alice bob charlie

        RW      refs/tags/v[0-9]    =   bob
        -       refs/tags/v[0-9]    =   @devs
        RW      refs/tags/          =   @devs

    More details can be found in the documentation.

  * Gitolite can now let you specify restrictions based on file/dir
    names (for example, restrict who can push changes that touch some
    file or directory).

    My initial response to this request was that this is better done by
    the social mechanisms of the project team, and I do not believe this
    feature is really necessary in a well-run project.

    However, people coming from other VCSs seem to make this a sticking
    point at work, so I added it anyway, if only to see how far I could
    stretch gitolite's config file while keeping its simplicity intact
    :-)

----

I'm often on #git, subject to my living in UTC+0530 time, and email is
also welcome (sitaramc <at> gmail.com is preferred, but sitaram.chamarty
<at> tcs.com may get my attention quicker).  Feel free to contact me
with questions or feedback.

-- 
Sitaram

[1]: http://article.gmane.org/gmane.comp.version-control.git/131834


-- 
Sitaram
