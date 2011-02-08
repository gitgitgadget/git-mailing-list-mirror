From: Kevin Ballard <kevin@sb.org>
Subject: Git describe finding wrong tag
Date: Mon, 7 Feb 2011 20:46:23 -0800
Message-ID: <A76F5A9B-6E22-40D5-A8C9-C471A22DF1BE@sb.org>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 08 05:46:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmfTL-0002UT-QP
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 05:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979Ab1BHEq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 23:46:26 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61741 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab1BHEq0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 23:46:26 -0500
Received: by pzk35 with SMTP id 35so1052143pzk.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 20:46:25 -0800 (PST)
Received: by 10.142.173.3 with SMTP id v3mr16448626wfe.62.1297140385403;
        Mon, 07 Feb 2011 20:46:25 -0800 (PST)
Received: from [10.8.8.46] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm6977263wfd.7.2011.02.07.20.46.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 20:46:24 -0800 (PST)
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166334>

I just encountered an odd situation where `git describe` insists on finding the
wrong tag. In my case, I tagged a branch, then merged it into another branch,
and now `git describe` in that other branch decides that it should emit a tag
name that's over 200 commits old rather than the one that's a single commit
away.

% git --version
git version 1.7.4.31.g3f8c4
% git describe
build_1.2.2_applestore_1-203-g742967b
% git describe HEAD^2
build_1.2.2

Is there any rational for why git-describe is opting for the much older
commit?

-Kevin Ballard