From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Test failures in contrib/remote-helpers
Date: Tue, 13 Nov 2012 01:35:29 +0100
Message-ID: <CAMP44s1E7qKCPTH1MMuOwJkW8opmD+Q6bzD6j1-KM039g-Uq2g@mail.gmail.com>
References: <CALkWK0mU5O3Rqznkx-qn8VLFEgsMzOba1i8onSvf8X3FBeTs6g@mail.gmail.com>
	<CAMP44s1TLyKoHVouwgCFqi-vwA6rUBYJZXTA7JDFX6bfyQ7_tw@mail.gmail.com>
	<CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY4Tg-0003dY-Ga
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 01:35:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780Ab2KMAfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 19:35:31 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:53152 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200Ab2KMAfa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 19:35:30 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so6889262oag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 16:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OBJC3feBh1cWK0xLLKUyJwfw/rmJv4rUrjLklrBtvUE=;
        b=vF9wugOx9C+Vn2QFtb34NJ+WFqRdbMkhA7e62nmkhJDQZCEmxPW6EyGPyCZzxldNLM
         LNz79tkKBdlW6iBL20RXWDWFs3aJ/tlwNhgJ1DplUZ/o7A+1aoyUkhaLUR9SLxzu9Y2o
         6qg573003wPl++r6nDJnrBVV9n/SZ+6pI29ELvHsEAua68mcExOeq9VTDBcqHHliDxb+
         Qi2rl8Gn8gk63aIMCN3D6n58ELjrP92W/YnQ0pDBpNfDx1Y0+A2wKOfunyHGIFugXmWx
         Q1kdpmf5qhpid3rZa5UbDilMPvkgYOHHxT9vmivWikqQlqPiPaBbPsu9TgRW3NyAk4Mn
         31Iw==
Received: by 10.60.20.1 with SMTP id j1mr6961519oee.46.1352766929818; Mon, 12
 Nov 2012 16:35:29 -0800 (PST)
Received: by 10.60.4.74 with HTTP; Mon, 12 Nov 2012 16:35:29 -0800 (PST)
In-Reply-To: <CALkWK0k9trxx8NC1GWw-yYzBKhFchrvg2JLeBtyoAkokmv9A0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209552>

On Sun, Nov 11, 2012 at 1:48 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Sun, Nov 11, 2012 at 11:32 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> I'm experiencing test failures in contrib/remote-helpers.
>>
>> Which are your versions of hg, and bzr?
>
> Mercurial Distributed SCM (version 1.9.1)
> Bazaar (bzr) 2.4.1

And here's the one for bzr:

--- a/contrib/remote-helpers/git-remote-bzr
+++ b/contrib/remote-helpers/git-remote-bzr
@@ -646,12 +646,12 @@ def get_repo(url, alias):
     global dirname, peer

     clone_path = os.path.join(dirname, 'clone')
-    origin = bzrlib.controldir.ControlDir.open(url)
+    origin = bzrlib.bzrdir.BzrDir.open(url)
     remote_branch = origin.open_branch()

     if os.path.exists(clone_path):
         # pull
-        d = bzrlib.controldir.ControlDir.open(clone_path)
+        d = bzrlib.bzrdir.BzrDir.open(clone_path)
         branch = d.open_branch()
         result = branch.pull(remote_branch, [], None, False)
     else:

I have other fixes to run up to 2.0.

Cheers.

-- 
Felipe Contreras
