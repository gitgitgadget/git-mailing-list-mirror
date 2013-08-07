From: shawn wilson <ag4ve.us@gmail.com>
Subject: Repo with only one file
Date: Wed, 7 Aug 2013 02:24:40 -0400
Message-ID: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 07 08:25:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6xBF-0001CN-DF
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 08:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3HGGZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 02:25:03 -0400
Received: from mail-ve0-f176.google.com ([209.85.128.176]:48755 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab3HGGZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 02:25:01 -0400
Received: by mail-ve0-f176.google.com with SMTP id b10so1358003vea.7
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=AylRGwcXMdsYyez8NE/K/yPU/f9J7LC2hZKEG7vsZrQ=;
        b=U7CU8a/+cf/rJF89ssQ11Nu6KZjbBkkDCb3Vy1WV4Hhtw65bCc41USx/3diMUagRIv
         QCKzw9jP37kLLdktVsGesum28uIE0hwuRqgLCMU45dlnN1M6wDXUIu6x+PXIAkNl9Rgb
         7wx4QWVp3/dueQQmPGR/CjyHxvvA59t9mna8Pd/vHs7aC3ST4InGCdyEY9tEpx1a87lg
         mh+6ibjWy2p131Ph8JFiUYDRcOipUGUi4CNwE3XU86AQ2pLUGNWHunajnNdTzSWtnMnn
         1WydneD04hFq9GxYnTpkVuH/gFRpAa/ENQnD28EK7WKDvNyM8gVParR7r/1pdjfCyH13
         PtuA==
X-Received: by 10.58.29.111 with SMTP id j15mr513810veh.76.1375856700490; Tue,
 06 Aug 2013 23:25:00 -0700 (PDT)
Received: by 10.52.116.72 with HTTP; Tue, 6 Aug 2013 23:24:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231807>

I started writing this script in a repo I have called misc-scripts
where I just keep one off projects and the like (notes, throw away
scripts, etc). Well, my boss asked me to create a repo for one of
these scripts and I'd like to keep the commit history.

Ok, so:
% find -type f ! -iname "webban.pl" | while read f; do git
filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
HEAD ; done

Which basically did it. But, I've got this one commit that seems to be
orphaned - it doesn't change any files. That is, it shows up in a git
log but not a git whatchanged. When I try to rebase -p --onto, I get
tons of conflicts, git adding blah in every other line of the file and
after I totally mess up the repo, that commit is still there. If I do
a git checkout and try to amend the message, I get:

# Not currently on any branch.
#
# Initial commit
#
# No changes
You asked to amend the most recent commit, but doing so would make
it empty. You can repeat your command with --allow-empty, or you can
remove the commit entirely with "git reset HEAD^".

iWhen I do --allow-empty, I can no longer see any other commits.

So, how do I remove this commit or what is the proper way to get this
one file into a repo with nothing else?

Also, I sign my commits and would like to keep each commit signed if
at all possible.
