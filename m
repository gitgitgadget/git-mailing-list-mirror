From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Simulating an empty git repository without having said repository on disk
Date: Mon, 16 Jan 2012 19:34:04 +0100
Message-ID: <CAD77+gR=txp8sKrA57ztQX0a1-QZM7wwR6ThBq77c=c+AbsS0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 19:34:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmrO3-0000ej-SN
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 19:34:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755857Ab2APSe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 13:34:27 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:48454 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755069Ab2APSe0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 13:34:26 -0500
Received: by obcva7 with SMTP id va7so4873502obc.19
        for <git@vger.kernel.org>; Mon, 16 Jan 2012 10:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=lSd9rTGOBGk/mJ2/3RUnYpVtYgUJNTwd7sPW9ONg5wM=;
        b=XfvML7vXdB5jXW5lsj5BY9RUfU9ErtzwWcIU4qlbeOBNBslJnrzUhxrIiJSnJLxLZF
         k9xI8B2HSXJ50sSYWwfWqnyrAL+H2DYKsHgxJhMwLiShH22zQwnivseEJpE928d9yR/M
         Dgm4rol4prwzwyStoX+ROv6lZlLdti5qw7wf8=
Received: by 10.182.48.100 with SMTP id k4mr8974517obn.55.1326738866217; Mon,
 16 Jan 2012 10:34:26 -0800 (PST)
Received: by 10.182.49.168 with HTTP; Mon, 16 Jan 2012 10:34:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188638>

Hi all,

for vcsh[1], I need a rather hackish feature: List all files untracked
by vcsh. The plan to achieve this is:

Get lists of all files by all repos which' GIT_WORK_TREE is in one
directory ($HOME, by default), merge all lists into one and use that
as a .gitignore or exclude. Then run `git status` with $GIT_WORK_TREE
pointing to $HOME while using said ignore/exclude. That will give me a
list of all files & directories which are not tracked by any of the
git repos managed by vcsh.

I could create an empty git repo to run this operation in, but that
seems wasteful. Thus, I would prefer to run this command against a
non-existing, empty git repo. Problem is, I could not find a way to do
this.


I know the empty tree's SHA is hard-coded into git so I was hoping
there would be a way to trick git using this, but I couldn't find a
way.


Any and all help appreciated, even if it's just a "no, this is not possible"


Thanks,
Richard


[1] https://github.com/RichiH/vcsh
