From: "Mark Desnoyer" <mdesnoyer@gmail.com>
Subject: Files not deleted when merging after a rename
Date: Mon, 21 Jan 2008 20:45:07 +0100
Message-ID: <d997e2110801211145o5fe0a1bbpb1e32dd71b70568e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 21 20:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH2aS-0006tF-SZ
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbYAUTpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbYAUTpL
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:45:11 -0500
Received: from hs-out-0708.google.com ([64.233.178.244]:58100 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569AbYAUTpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:45:09 -0500
Received: by hs-out-2122.google.com with SMTP id 54so1859973hsz.5
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 11:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=XUdJEaiA6lI2lInHWPgp8wabWj9urTLn0ptCP5r1FZI=;
        b=c5WOqYsg6CV6DoaXzouQs12DJEUKjMp4TAGpZj396KBZEufHED86nYKLANFAHHlK1mnfFjnUOQbFa0ZwzOIGt+w1tm2ljDNmBWCHBsltsb0M27eWAG/Uy9L+0hSVJMOI5MLVnP9c2YN7AzAo9RrwuJpTuIBc+RIifCswidoxerc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ecjLCIopPKvYBGpeCabuQqx1g1D3OGRpT5zVt9b5Bjnsn+ecvWqeUXPhvki4JbpVaBg+jZtF0X71/sTQfUDjBui9EOvITCnZi0eIDkpcC60XxJJODN7hiqoLMP7TYgh3kolkAErAypZZzqTL5/OiMsrvM9WbC7v6Wi5LzgtSZOE=
Received: by 10.115.90.1 with SMTP id s1mr5322600wal.41.1200944707747;
        Mon, 21 Jan 2008 11:45:07 -0800 (PST)
Received: by 10.114.174.11 with HTTP; Mon, 21 Jan 2008 11:45:07 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71318>

Hi,

I've run across a small problem and I was wondering if I could get
some help. I have two users A and B. They are both git-cloned from a
common repository on a different server.

User A moves a directory:
foo/bar/ ==> bar
using:
git mv foo/bar bar
git commit
git push

Meanwhile, user B is doing some other changes that are completely
unrelated and has a few local commits. Now, when user B pulls from the
repository (git pull), and returns no errors merging, the directory
"bar" is created, but "foo/bar" is not deleted, although, it becomes
untracked.

Any ideas why the merge isn't deleting foo/bar? The users are using
git version 1.5.2.5 in Ubuntu Hoary. Thanks in advance.

-Mark
