From: E R <pc88mxer@gmail.com>
Subject: keeping track of where a patch begins
Date: Wed, 21 Oct 2009 09:45:15 -0500
Message-ID: <3a69fa7c0910210745r311cf18xf966f5c63650cde6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 21 16:52:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0cY9-0000L1-U3
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 16:52:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbZJUOwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 10:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753671AbZJUOwT
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 10:52:19 -0400
Received: from mail-px0-f197.google.com ([209.85.216.197]:53510 "EHLO
	mail-px0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbZJUOwS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 10:52:18 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2009 10:52:18 EDT
Received: by pxi35 with SMTP id 35so49584pxi.18
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 07:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=BWJ0kUElHmHYjxRweji2jMzLaE6R6aBTJZUYiiubino=;
        b=kCvNeK2kXhFatJ8nb3YC4Eh1KmdnS+bB0J5wiD82FMjBXDjevl7nZBep9DTSByE+Eg
         bRPN3+sFRnyAszSZjJBFd3jjsz8JNtAp6Y8f3cu3yjpc572Ya4HjX/7Jm1spNqkBrRWw
         5AaeD5UeCAmVz9oEbXXC/ezepoIYQDHEXK+JQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=tGyNYiL5qu0FWh2+10eChI6xrUT3C3J1uJRMW+DGk7nr7g0Kxhu11j65FrAQSxRPo9
         fdQuAAabx6k3NFeRu1JCksBSIrzLx1aOulNQ/RbJb7XlfBt8VQUqhAIOrgyK6sXOzhcV
         URNYBVbJD/RsW5Z6J6F8JcM1/LiwkU51iATJ0=
Received: by 10.142.75.21 with SMTP id x21mr617639wfa.150.1256136315067; Wed, 
	21 Oct 2009 07:45:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130924>

Hi,

We've started to use git at work. Developers create branches for their
patches (which we call "tickets" because they are related to our
ticketing system), and those branches are picked up by an integration
team and merged together to form a release. Hopefully this is not too
unconventional.

Ideally a developer will start their ticket branch from a previous
release. However, occasionally a developer working on multiple tickets
will forget to switch back to a release node when creating a new
ticket branch. Then code from the first ticket inadvertently gets
added to the second ticket, and this is a problem if integration
decides to include the second ticket in the release but not the first.

What solutions have you come up with to either to catch or prevent
this from happening? It is possible to determine what node a branch
started from?

It seems that somehow the node that the patch begins at has to be
either identified, marked or remembered, and it might have to done
outside of git. Then the integration team or other tools can validate
the starting node to ensure that it complies with the build process.

Thanks,
ER
