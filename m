From: Sudarshan Wadkar <wadkar@gmail.com>
Subject: Odd remote: error: packfile ./objects/pack/pack-FOO.pack cannot be accessed
Date: Mon, 2 Jan 2012 14:48:22 +0530
Message-ID: <CAOoYcj0JO4q0GJRzuexQR6OAng2PdZX8gD7zNYNoOCmCCLqz4Q@mail.gmail.com>
References: <CAOoYcj2pnNtK3RshcJFwiXK356cZz6M38-NG1_uORjknyhdAKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 02 10:19:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rhe3H-0005Os-6A
	for gcvg-git-2@lo.gmane.org; Mon, 02 Jan 2012 10:19:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354Ab2ABJTJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jan 2012 04:19:09 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53785 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab2ABJTI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jan 2012 04:19:08 -0500
Received: by wibhm6 with SMTP id hm6so8248972wib.19
        for <git@vger.kernel.org>; Mon, 02 Jan 2012 01:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=kbs6d77YSi9JWXcMKsOQbCkkgNHYF2uCW4LxeNA+7FM=;
        b=aITHhgaLwx0qQp+VDYIfQAON/+h6sk2JU3oBrM1av6O6FT44WI7NKStrhSnR+G84nx
         TaE/5yfIHGWkto4Dxus7wbhnn904WyQzs8kw3YOnbYQ4pZDOi6MnSljxHbP5jb+JsHcE
         3s7yMEPWNGYZnaMCfMhqvJ/PyGj85Rqo5QTbg=
Received: by 10.216.137.195 with SMTP id y45mr32700636wei.45.1325495946214;
 Mon, 02 Jan 2012 01:19:06 -0800 (PST)
Received: by 10.223.156.144 with HTTP; Mon, 2 Jan 2012 01:18:22 -0800 (PST)
In-Reply-To: <CAOoYcj2pnNtK3RshcJFwiXK356cZz6M38-NG1_uORjknyhdAKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187836>

I have a simple post-receive hook as follows :

#!/bin/bash
# using bash and not simple sh
# simply checkout the master branch to notBare path, use tools from
that portion to deploy further
notBareRepo=3D'/home/sudhi/repo/notBare/myproj-master'
GIT_WORK_TREE=3D"$notBareRepo" git reset --hard master
#end post-receive

But when I push, I get this odd error from remote

$ git push --verbose --mirror
ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
Pushing to ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
Counting objects: 5, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 323 bytes, done.
Total 3 (delta 2), reused 0 (delta 0)
remote: error: packfile
=2E/objects/pack/pack-17900952dc824651db15369a341eec8d3e8f39d2.pack
cannot be accessed
remote: HEAD is now at 4d5a6f1 Investigate and report odd error
To ssh://wadkar@192.168.1.177:7185/~wadkar/repo/bare/myproj.git
=A0=A0 d066a2f..4d5a6f1=A0 master -> master

This happens even if I do a fresh clone on remote server as:

$ cd repo/bare; git clone --mirror wadkar@my_ip_address:myproj

Local " git fsck " reports few dangling blobs but nothing
fancy/serious. Remote git version is 1.7.4.1 on a CentOS 5.7, while
the local is same (1.7.4.1) on a Ubuntu 11.04.

1. How bad is the situation?
2. Have I done something wrong, or this is not my doing?
3. The checked out version in repo/notBare is fine, and seems to be
working (I can pass my unit-tests). Should I be worried?
4. If not, then can I ignore this particular error and move on?

-Sudarshan Wadkar

"Success is getting what you want. Happiness is wanting what you get."
- Dale Carnegie
"It's always our decision who we are"
- Robert Solomon in Waking Life
"The truth is the truth, so all you can do is live with it."
--Systematic Chaos
