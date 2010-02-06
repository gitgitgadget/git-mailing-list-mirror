From: Jon Seymour <jon.seymour@gmail.com>
Subject: A generalization of git notes from blobs to trees - git metadata?
Date: Sun, 7 Feb 2010 00:32:52 +1100
Message-ID: <2cfc40321002060532g4d22dd4dx403bf312708e1424@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:38:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ndkrz-0006YW-8C
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:38:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755842Ab0BFNii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2010 08:38:38 -0500
Received: from mail-pz0-f178.google.com ([209.85.222.178]:38601 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755668Ab0BFNih (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2010 08:38:37 -0500
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Feb 2010 08:38:37 EST
Received: by pzk8 with SMTP id 8so2724039pzk.22
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 05:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=+jrCzpeA+nW3wtxjnx8tffdOIGenuikoDk6cfMXyUAY=;
        b=KdF5SZ4kyJUGR9kQhM8C/4h05MttwZzBl/7su4Hi5KgiSsWRmL+hlFez2jDPVoj0ZT
         ALXYWksW9GMBjo4VJ6ZrT0GUHtl3zst650NEqXzeXrnIkBYCttJxuX/okhylfHWrVqhX
         2N5KreMPimIz4/UznMuDuBT1tfWePahKeug6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=VSSwt+v3TqHwmR3imt8H0HRzZ9CSJEbcaBuhJXV5GglxY2LG5C31LIjLJqzpN1ggmd
         wnQMF1X+Fz6U5qsaoEWzHIbWoxT8wDL3dM5eqK7aJFe9VxjxohsqHK5I60KELPTBDlio
         5igG3wKhyKLl+WGtTAzdrBCfwmvjqMaVzuUTc=
Received: by 10.114.70.4 with SMTP id s4mr2754154waa.31.1265463172576; Sat, 06 
	Feb 2010 05:32:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139165>

git notes is a nice innovation - well done to all those involved.

Has consideration ever been given to generalizing the concept to allow
note (or more correctly -  metadata) trees with arbitrary sha1s?

For example, suppose you had reason to cache the distribution that
resulted from the build of a particular commit, then it'd be nice to
be able to do this using a notes like mechanism.

    git metadata import foo-1.1.0 dist ~/foo/dist

would create a git tree from the contents of ~/foo/dist and then bind
it to meta item called dist associated with the sha1 corresponding to
foo-1.1.0

To retrieve the contents of the previous build, you'd do something like

   get metadata export foo-1.1.0 dist /tmp/foo-1.1.0

This would find the metadata tree associated with foo-1.1.0, extract
the dist subtree from that tree and write it to disk at /tmp/foo-1.1.0

I've used build outputs as an example here, but really it needn't be
limited to that. I can see this facility would be useful for any kind
of annotation or derived result that is more complex than a single
text blob. Metadata trees in combination with a name spacing
technique, could be used to store arbitrary metadata created by an
arbitrary set of tools to arbitrary SHA1 objects.

jon.
