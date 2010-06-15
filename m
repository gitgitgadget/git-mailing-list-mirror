From: Joshua Shrader <jshrader83@gmail.com>
Subject: Fixing branches from a (really messed up) subversion repository
Date: Tue, 15 Jun 2010 12:26:16 -0400
Message-ID: <AANLkTinmU3tOkv9usjGogHn5cXm07FMde8ryDKuWNKD_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 15 18:26:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOYy3-0004nB-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab0FOQ0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:26:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56534 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756970Ab0FOQ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:26:17 -0400
Received: by mail-vw0-f46.google.com with SMTP id 13so1447979vws.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=Stfb9PVeX4OBGl2Vgu6wfdVSOoud5t0D26iQGXSvSNE=;
        b=Vtup2Ujk3j8N+oROQ8KOmZAaeOGKCnJigzDW1eQZqYMPUsK2mAzEt+K/aWT8wFmZ1f
         wH347FZ6MBRq8Fy+Jb8diQsXY9dRNeBLdj2zWrR6UqKoqJxasyM8U65i2hJGZ4TE/GdA
         X8H8yHlSGVQLAZlb2Ii5h7abxKxDCL6JlQJT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Ns29g1N91uubt0/sAcJgJhYtj5aqC0Q76Ftqx2/gtXry+TvXip2ytAg/phmzpB8OqK
         HtQAIKhMA/ZtFe/dz5yfM2pYl9PbeeIDsQZfWEHhjw07lpiNZi2MmMIMXUxhYLCeDaAj
         bxGQ2xWkWOrE+d2U1mA7Y+knv2DsZCC7ciMZ0=
Received: by 10.220.123.33 with SMTP id n33mr3872020vcr.64.1276619177214; Tue, 
	15 Jun 2010 09:26:17 -0700 (PDT)
Received: by 10.220.106.167 with HTTP; Tue, 15 Jun 2010 09:26:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149199>

I've finally convinced my project to switch to Git...  However, when
my project first began, the people responsible for branching/tagging
were fairly unfamiliar with standard procedures.  As such, the
beginnings of our repository look a little something like this:

.
`----project
     |
     `branch1
     |          |
     |          `----project
     |                        `src
     `branch2
     |          |
     |          `----project
     |                        `src
     `src

That is, the branches were essentially inside the trunk.  In order to
check out the "mainline" of development, you also got all of the
branches.  After a few branches, they realized that this was a
problem, and someone found out about the trunk/branches/tags paradigm.
 Our branches were svn mv'd to separate directories under "branches",
and all was well.  Now everything looked like a sane version control
repository.

Now, we want to import this into Git.  I tried git svn import
--stdlayout..., but this just stalled.  I'm assuming because the first
version didn't have a trunk/branches/tags structure.  So, I had to
import it leaving off the --stdlayout option.  Is there any way to
manually fix this in Git?  After the import is complete, my master
branch will have a trunk, branches, and tags directory in it.  Can I
create real branches out of the directories under the branches
directory and then remove them from master?

Any help is greatly appreciated.  I've been hoping for a while that
we'd switch to Git, and I don't want this to hang us up.

Thanks,

Josh
