From: Jay Levitt <jay.levitt@gmail.com>
Subject: Rewriting history and public-private-ish branches
Date: Tue, 20 Dec 2011 07:33:10 -0500
Message-ID: <4EF08086.6080606@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 20 13:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcyso-0000sN-SW
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 13:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625Ab1LTMdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 07:33:19 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37992 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751514Ab1LTMdR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 07:33:17 -0500
Received: by qadc12 with SMTP id c12so2946855qad.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 04:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=vKXgDdp2rsq8e2fPtCS22N7hwA3FefvxxRiNWEaJ33g=;
        b=GQfEVVkIg6Wq+M7Uxw2VhHDkbk8SStwxXL7CuUQe89xIAAFMn4cjqrY0qU9eX1kLAi
         O8rIZfpnpALYNMrNAe650Qs/Osc3+203kIJvhL6ZejJrBz2cbD/Z4WJcz9AqkwBV9bBN
         BBEOmDctGK+PMojI/w6VbKik7Gf5CXBCW+6Ws=
Received: by 10.224.52.68 with SMTP id h4mr2155655qag.71.1324384396735;
        Tue, 20 Dec 2011 04:33:16 -0800 (PST)
Received: from speedbook-air.home.jay.fm (home.jay.fm. [173.166.48.118])
        by mx.google.com with ESMTPS id ft9sm3291416qab.20.2011.12.20.04.33.12
        (version=SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 04:33:12 -0800 (PST)
User-Agent: Postbox 3.0.2 (Macintosh/20111203)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187512>

I frequently conflate git-as-version-control with git-as-deployer when I'm 
editing on my Mac but testing on a server.  I'll do things like...


Mac: checkout -b origin/topic-branch
Mac: make a major change, commit and push
server: pull
[do while buggy]
   server: discover a typo
   Mac: fix the typo, commit and push
   server: pull
[end]
Mac: squash commits
Mac: checkout master
Mac: merge topic-branch
Mac: branch -d topic-branch
Mac: push origin :topic-branch

As long as I'm the only one who's seen this "published" history, am I doing 
anything bad? Do I leave any residue behind in the repo?

Jay Levitt
