From: Jarrad Hope <me@jarradhope.com>
Subject: Tackling Git Limitations with Singular Large Line-seperated Plaintext files
Date: Fri, 27 Jun 2014 15:45:16 +0700
Message-ID: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 27 10:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0Rmk-0001qT-Ax
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 10:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753073AbaF0IpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 04:45:22 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:61361 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953AbaF0IpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 04:45:17 -0400
Received: by mail-vc0-f174.google.com with SMTP id hy4so4809098vcb.33
        for <git@vger.kernel.org>; Fri, 27 Jun 2014 01:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=5ZvWyRlVoNmGp4kIFNJJAZl00ZTgeTZL4ldd1jeWgwM=;
        b=ImhUMKkw/kSmHJeQVnQR3lK8SDuQEXqmwr/6g+0E7Rj42qwroNaJDUf3kdWT6XkG9i
         JSYv13F85LA1OlX4yf2pCh8/FYr5RbT0n6fBlJjsLefVWQUNTZSwdBnhkLnhhYg+Sy+M
         L4nq0hq6C5q4zwPGAyeHA4eMndth1UJTT/H7NKXW53+a/qz/U1jX/mwtTSdTNg5jNMkm
         VyiDfsiJIQAtB+qI5k584654ox/7UqzUJn4cGuRoFL9Yc+VDhT63yvp5k+NNgPD/MbrD
         JRqhodx5opn/2xUvaDDSMdQuE7Q60GMF5d8+uaWgfya60G5p1HikzjKZKET0bpDi+e6m
         RANQ==
X-Gm-Message-State: ALoCoQk/dCIizVn7w86mMdmHT8c3hADcIp98m7REKP/CFTDdcAGID8Q2HCHxAjT6rOpEtW0kF0pG
X-Received: by 10.52.253.131 with SMTP id aa3mr11685936vdd.25.1403858716809;
 Fri, 27 Jun 2014 01:45:16 -0700 (PDT)
Received: by 10.52.255.103 with HTTP; Fri, 27 Jun 2014 01:45:16 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252542>

Hello,

As a software developer I've used git for years and have found it the
perfect solution for source control.

Lately I have found myself using git in a unique use-case - modifying
DNA/RNA sequences and storing them in git, which are essentially
software/source code for cells/life. For Bacteria and Viruses the
repo's are very small <10mb & compress nicely.

However on the extreme end of the spectrum a human genome can run in
at 50gb or say ~1gb per file/chromosome.

Now, this is not the binary problem and it is not the same as storing
media inside git - I have reviewed the solutions that exist for the
binary problem, such as git-annex, git-media & bup. But they don't
provide the featureset of git and the data i'm storing is more like
plaintext sourcecode with relatively small edits per commit.

I have googled and asked in #git which discussion mostly revolved
around these tools.

The only project that holds interest is a 2009 project, git-bigfiles -
however it is abit dated & the author is not interested in reviving
this project - referring me to git-annex. Unfortunately.

With that background;
I wanted to discuss the problems with git and how I can contribute to
the core project to best solve them.

>From my understanding the largest problem revolves around git's delta
discovery method, holding 2 files in memory at once - is there a
reason this could not be adapted to page/chunk the data in a sliding
window fashion ?

Are there any other issues I need to know about, is anyone else
working on making git more capable of handling large source files that
I can collaborate with?

Thanks for your time,
Jarrad
