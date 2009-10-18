From: Mohit Aron <mohit.aron@gmail.com>
Subject: git push should automatically push to remote tracking branch
Date: Sun, 18 Oct 2009 13:20:22 -0700
Message-ID: <ee22b09e0910181320j15a273e8vc510801c890b93a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 18 22:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzcEx-0007zM-Tc
	for gcvg-git-2@lo.gmane.org; Sun, 18 Oct 2009 22:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755181AbZJRUUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Oct 2009 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbZJRUUT
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 16:20:19 -0400
Received: from mail-px0-f171.google.com ([209.85.216.171]:62016 "EHLO
	mail-px0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbZJRUUS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Oct 2009 16:20:18 -0400
Received: by pxi1 with SMTP id 1so743614pxi.33
        for <git@vger.kernel.org>; Sun, 18 Oct 2009 13:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=kj5LliuLrobsL/DZ/+UiSYTTqLu1276/zNlLVTvg0mc=;
        b=kXxg/vaN/6q9LgKbox0XTO/Eqt2ONfWDaGmd1q0yaexm5SNJgKm1k3fNYGlEX9m3zJ
         oB6JrsbF10wToGvBSgv0FyBSvb0Apfgh7sZVdBBylZeX2dWklKrZPFnexi+ftEZ+/wHC
         8DCw/+nNiWB0MjU7Gig2y2lX1SE9G6nnwq5c8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=X8c4dFJABAJ5o9wchIN4dVJ9qJsC9wWC++jnssK0jbeWqpig2bhKj0NQ+F+adYTnxL
         aDVORyvhmqXlgp8/XZYW353jnzoAOu1TZBOpWQOK787v/Qd+i9zN0RZ7hawOJ2I4a2++
         mtfepnPlynChV8tDLY9/b7qifOOaIOp+37h1I=
Received: by 10.114.18.17 with SMTP id 17mr4395526war.131.1255897222959; Sun, 
	18 Oct 2009 13:20:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130609>

Hello,

I've been using git for around a year now and I'm continuing to find
the 'git push' API rather cumbersome. My workflow is as follows. I
typically have a local branch track a remote branch and want to pull
and push changes back and forth. The names of the local and remote
branches are different. Even so, while 'git pull' is enough to pull
changes, 'git push' is not. Instead, the pull requires a full refspec
to be specified which gets real cumbersome and error prone.

Say my local branch name is foo and it is tracking a remote release
branch of a product. Say the remote's name is origin and corresponding
branch there is 6.1. 'git pull' nicely fetches and merges changes
submitted by others in the remote branch to my branch foo. However, to
do a push, I need to call:

=A0=A0 =A0 =A0git push origin HEAD:6.1

Since my local branch has been setup to track the remote branch, I
shouldn't have to specify all this in the 'git push' command. It'll be
great if 'git push' were to support a variant that automatically
allows pushing to the remotely tracked branch. This is the typical
workflow with other version control systems too.

If anyone knows a simpler alternative I can use in Git, please let me
know. Otherwise, it'll be great if such a feature could be added to
Git in the future.


- Mohit
