From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Proposal for pruning tags
Date: Thu, 5 Jun 2014 09:51:47 -0500
Message-ID: <CAHd499BLX3q2FHLfFpq_14w2mmosywfRqMHVjkke0BRhAAjx7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 05 16:51:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZ1G-0005wX-Ru
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 16:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaFEOvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 10:51:49 -0400
Received: from mail-ve0-f172.google.com ([209.85.128.172]:37112 "EHLO
	mail-ve0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbaFEOvs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 10:51:48 -0400
Received: by mail-ve0-f172.google.com with SMTP id oz11so1332988veb.17
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 07:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=mEtArrWdhvh93SiakQJR7/h4O7nVtGROcai2r8Qndx8=;
        b=Yo3amRsOlxoE7ibGxMKEX+xGJvJzTtVeLc/sUGAmCh2pchi/2t+u4vjg+HzwRxyPEb
         Dc70sJf7IwPcKZc2KSyNdCZX68rPoxqTb5xQFAw7PtdyqxgJkfyKgFm0xLU28g5DFnok
         uPbCCjKUT2BSpIkpZZCa7DUtCW2RnR1+ynbBHhfzSndNc1OWWdYKb3zwgpI02v1M4js2
         QPI77qseBDPziNr0PB00onzk2ZreivSv22ETGG6Z+0e8pBbry7VYxMuF1SEq1PIaRcmk
         f+fcMzqLSec3q2Ok5LtqU7p6cUui3QN1XCL1odWuT9Pl/mw4SbJc+2QJVkqYfSvxOWm3
         CrXw==
X-Received: by 10.58.243.72 with SMTP id ww8mr2346883vec.49.1401979907481;
 Thu, 05 Jun 2014 07:51:47 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.204 with HTTP; Thu, 5 Jun 2014 07:51:47 -0700 (PDT)
X-Google-Sender-Auth: scZjhXsShl7NwC2GAPPfcxNAOb8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250842>

I've never contributed to the Git project before. I'm a Windows user,
so I use msysgit, but I'd be happy to install linux just so I can help
implement this feature if everyone feels it would be useful.

Right now AFAIK, there is no way to prune tags through Git. The way I
currently do it is like so:

$ git tag -l | xargs git tag -d
$ git fetch --all

This is not only wasteful, but dangerous. I might accidentally delete
a local tag I haven't pushed yet. What would be great is if we had the
following:

git tag prune [<remote>|--all]

The <remote> is needed in decentralized workflows (upstream vs
origin). I'd also like to see an `--all` option in place of the
remote, which means it will prune local tags from all remotes. I'm not
sure if this command line structure will work, but it can be altered
as necessary.

Alternatively, this might also make sense on the remote command:

git remote prune <remote> --tags

Again I'm not an expert at the internals of Git, so I wanted to share
my idea with the community first to see if this holds water or if
there is already some built in way of doing this. Thanks for hearing
out my idea!
