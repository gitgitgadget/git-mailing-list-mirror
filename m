From: Jon Seymour <jon.seymour@gmail.com>
Subject: RFC: a minimal plugin architecture
Date: Fri, 29 Apr 2011 09:22:49 +1000
Message-ID: <BANLkTi=53dShgcsyTUP2aA+hvm6p+93XrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Pau Garcia i Quiles <pg
X-From: git-owner@vger.kernel.org Fri Apr 29 01:22:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFaXw-00030X-MZ
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 01:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933046Ab1D1XWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 19:22:52 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50732 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932556Ab1D1XWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 19:22:51 -0400
Received: by ewy4 with SMTP id 4so982794ewy.19
        for <git@vger.kernel.org>; Thu, 28 Apr 2011 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=p/bRxPP4YiqVhCu+0FiRwS/CjLYR0TG4xgW9/o6zmCc=;
        b=q7Ui2rJo10H87EkODqGe+GNdIr81FcPmR/32IgC0Cv4jlFNX0/9pmmmgqMiGJy+3mF
         p+2GXs22ttLL6gfZBikq7xwZ+1jmKPLBrLOZH8+1afpW12eVvlnBnC8qJmmDxUrUEonM
         njMmF7VhSFZByphDYNZ4RZ311GBTuQeD57+j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Lxygcl35q0mDK2JUHQ5jAnX7WQHIc+sLjohBo3TQ4EyNdRt9vSk2acsIfNsVkAUB9W
         0EQekB3HFzt0m6aEqpNeBUN5Uw/Un1mlcleaOYCm4JMPmhIRAWosXKIiszhMwMzbWTMU
         GoRxTdgJWAMl2Jg9E6/6IMYdxhFH0Cmqzjm+M=
Received: by 10.14.6.10 with SMTP id 10mr1799241eem.117.1304032969345; Thu, 28
 Apr 2011 16:22:49 -0700 (PDT)
Received: by 10.14.22.68 with HTTP; Thu, 28 Apr 2011 16:22:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172419>

Hi,

I am starting to get the idea that everyone feels I am being a little
too ambitious. Slow learner, I know.

I think this is because my visions are much grander than people are
willing to swallow right now, so I want to scale back to where I think
there is some consensus and get some feedback about what a minimal
plugin architecture would be.

I understand that I am yet to convince people of the merits of either
git -mediated plugin management or package management, so let's assume
that the contents of a "git-plugins" directory is managed only by
package managers or plugin authors, following guidelines established
by git-core.

I observed that Pau, Junio and Jonathan are receptive to the idea of a
"standard" directory into which plugins could be installed. Pau would
prefer one directory per package, and with that I would concur.

However, let's start simple, what would a minimal plugin directory
look like and, assuming there was one per git-install, where would it
be located relative to the prefix?

Here's a suggestion for the layout:

bin/
   - all scripts and sh libraries
man/
   - all man pages
html/
   - all html pages

What about location?

   ${prefix}/git-plugins
   ${prefix}/lib/git-plugins

Or, decided by distribution?

Is there support for the idea of adding a --man-path switch to the main line?

What about a --plugins-path, that would answer the question about
where plugins should go?

Per Jonathan's and Junio's suggestions, the idea of having a plugins
search path seems like a reasonable one, so that users without control
over the git install can at least customize it themselves.

How would this path be configured by the user? Would the user
configuration edit the git default or would it override it?

If there are multiple plugin directories, how would a plugin discover
which one it has been installed in so that it can find any
plugin-specific resource it might need?

Regards,

jon.
