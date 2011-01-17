From: Mathieu Malaterre <mathieu.malaterre@gmail.com>
Subject: Best practice for merging
Date: Mon, 17 Jan 2011 17:16:52 +0100
Message-ID: <AANLkTi=zpM3q1FXMVhavcUhjRWsg4wfLyFH88P7WMhc-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 17 17:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PermC-0004V4-Gm
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 17:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab1AQQRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 11:17:22 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36191 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab1AQQRO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 11:17:14 -0500
Received: by qyk12 with SMTP id 12so5908547qyk.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 08:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=UkP9KimyHGTYL380JGqfNwbDzRmO1KDpfwQPEBMuN4o=;
        b=xmKRvym0JpnENzd/T4EkHM+QCfNL2TyxkwJOw+WOQlTyRCDJhA3tjr+GcHTns9w38e
         0sQyh8c9n15uMC8ldp/Owtcpoy4kkJBTV9Cxbq28H5M6059GvjBEhdCPYls8AudgklLR
         RX8ehL25gGLJfE5bcwv6xiUmGkqVhD/UMOeVU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=W80XoxfumVWR4LMBKsfakJzWbu0iCWzBWHxWjOONoFLt7kpzAM78OTNjrIoCz7tDNa
         ktwuebDTg0nQ6e4PG4AQ7AH7vCWsPcv/wqHo7KSevbOg2LLdlqT+eckfXn40HsLO+Kuo
         GcvWFShQyStLa7PwiGOH6uFj4/PwVlxPYtHos=
Received: by 10.224.20.17 with SMTP id d17mr3991326qab.371.1295281033287; Mon,
 17 Jan 2011 08:17:13 -0800 (PST)
Received: by 10.224.74.84 with HTTP; Mon, 17 Jan 2011 08:16:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165174>

Hi all,

  Sorry if this sound like a noob question, but this is something that
I am still not quite happy with (and google was not of any help). What
is the best way to handle merging in between a development branch and
a release branch.
  Here is the state of my current branches:

$ git diff -w release..master | wc
 156468  688491 5327390
$ git cherry release | wc
    707    1414   30401

Should I go over all those 707 individual commit, and cherry-pick them
one-by-one ?

I know for example that I do not want to merge anything related to a
new app, eg 'app2.cxx', how would one do something like :

git merge master --not applications/app2.cxx ?

Same question, I know I want to apply any change that happen within a
subdirectory but not another (this might be a problem if a commit
contains both). Let's say I want everything but what ever happen in
directory libB, can I do:

git checkout release
git merge master
git rm -rf libs/libB

finally, If I try to apply any change directly

git checkout release
git checkout master applications/app1.cxx

This will loose the whole git history, is this a bad practice ?

Thanks a lot !
-- 
Mathieu
