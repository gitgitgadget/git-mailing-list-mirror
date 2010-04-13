From: Richard Dallaway <dallaway@gmail.com>
Subject: SVN bridge for multiple SVN modules
Date: Tue, 13 Apr 2010 08:34:14 +0100
Message-ID: <m2ue3041f5c1004130034h51eb196dke0ebb8b3634e7302@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 09:34:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1adt-0002SI-O5
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 09:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200Ab0DMHeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 03:34:36 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57610 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983Ab0DMHef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 03:34:35 -0400
Received: by wyf19 with SMTP id 19so51290wyf.19
        for <git@vger.kernel.org>; Tue, 13 Apr 2010 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:content-type;
        bh=0dUbPvLR8NJBjPS4X8PPe5XhzA3dZboOnU3/9trWtso=;
        b=Qpw16UydarE03XHy6UMDFywoC68th1TwNMc2Mhmdts/ZtU4iMz+45WrvLd1S3bAyTv
         H7cLKoLphDnc5njxa25BEqIlfued31p+gA0VNwbp5wytjgO1jt4xo+YnQZae4mI4aOVY
         lQOGK5Fwwkmbg2eknyU3Ldp+xGn/DMXIoGS50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=WHkwFzVn9FdthyYK3+AwnKrPXbM8qS+EBdHGBTwWfBCVHofj0F8E55LcJgpImbgxWN
         CwHiUG4VbNXGjdEcLZhuHzxYe6hOC40Rc9AJtUB3oRe9fbYlK4AbEpWBfq3mi6tTC1kh
         YneuNLGkRvw7857b3LMElisazugi2hwn5UKN4=
Received: by 10.216.159.131 with HTTP; Tue, 13 Apr 2010 00:34:14 -0700 (PDT)
Received: by 10.216.89.195 with SMTP id c45mr3179076wef.98.1271144074184; Tue, 
	13 Apr 2010 00:34:34 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144793>

Hello

We've run into something we'd like to do with "git svn clone" that
looks like it should work, but doesn't appear to.

The task: we have an SVN repository with 38 modules in it (each with
their own branches, tags, and trunk) and we'd like to pull just two of
the modules into a single git repository -- but maintain the ability
to perform git svn rebase/fetch/dcommit as the SVN repository is
remaining active for some developers.

It looks like we should be able to point at the parent of the SVN
modules and use --ignore-paths=/a long regexp/  to do the job, but
we've not managed to get it to work yet and we're now wondering if
we're missing a few concepts in the git/svn bridging concepts. Or
maybe we've just not got the syntax right yet.

There's a related question we spotted on stackoverflow that indicates
this isn't possible:

http://stackoverflow.com/questions/898568/multiple-svn-projects-into-one-git-repository

If that is the case (can anyone confirm?), is there a way we can do
this by pulling each SVN module into a separate intermediate git
repository, then doing "something" to push on to our target single
repository.... a "something" that would still enable us to git svn
fetch and git svn dcommit back to the SVN repo?

Suggestions, clues, explanations all very welcome.

Regards
Richard
