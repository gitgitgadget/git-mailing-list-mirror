From: Chris Packham <judge.packham@gmail.com>
Subject: making stgit handle being rebased by git rebase
Date: Tue, 9 Nov 2010 11:39:32 +1300
Message-ID: <AANLkTik3MVNW0svJEo5gWq3+qGo6dKeqAUz9NPcJnYNN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: kha@treskal.com, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Mon Nov 08 23:39:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFaNV-0001rz-Ov
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755921Ab0KHWjd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:39:33 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60631 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab0KHWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Nov 2010 17:39:33 -0500
Received: by gyh4 with SMTP id 4so3851229gyh.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 14:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:cc:content-type;
        bh=3YoayprCe2Yqj1u8DumdKTOCdOVQFTP68Jqa1j+NBF4=;
        b=YtZRAckOzjUNOkI03yxCiJSGofaowNyjsBEtzYOUAZN2pBdUI6rJizsFpiGbe9tSCy
         1zw9ZQWu4eNp/Apn1fIX34Pwktu209icL9xd/XBA2qsbVNTBB5MCjPHhAxYFYriYToBf
         KcuANwKpkCWWhdamTQnkw7nITohT2zISEHFl8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=N941K/jVjK5ftDAZEhGaemiNEFej1xoxllYNVy7idWdHG2FNoh7+e59pbrKP+OGI5Z
         nJuqJ8x4XmBrpfZyL7xdXV3yHvQzyncwoCwo6pM4LbkIMY8rC0qBjB95qBhIkin2jH93
         ihXH5bWzDX6WIBXaK/4yXuBbGR5AQkp3VS8c4=
Received: by 10.229.86.80 with SMTP id r16mr5631419qcl.173.1289255972174; Mon,
 08 Nov 2010 14:39:32 -0800 (PST)
Received: by 10.229.13.8 with HTTP; Mon, 8 Nov 2010 14:39:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161004>

Hi Catalin, Karl,

Has anyone looked at making stgit interact with git-rebase more gracefully?

I've been playing with some of the recent git submodule improvements,
in particular the submodule.<mod>.update=rebase option. When I have a
submodule which I've been using stgit on it gets a bit upset when the
branch gets rebased by git. I don't loose any work but all my stgit
patches get turned into git commits. I can get them back with stg
repair and/or stg uncommit but I was wondering if there was any way of
making stgit play nicely with git rebase.

As a workaround I could have something remember the applied patches,
run stg pop -a and re-apply the patches after the fact. All of which
is doable but maybe there is a better way.

Thanks,
Chris
