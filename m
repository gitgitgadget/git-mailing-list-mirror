From: Josh Hagins <hagins.josh@gmail.com>
Subject: [BUG] git commit --allow-empty-message -m '' fails
Date: Fri, 1 May 2015 19:31:08 -0400
Message-ID: <CANuW5x0eKVAToG76rJr6+n-Fdg7E5c8mHb8NvnQUT2PBzxjjPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 02 01:31:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoKPI-0000or-Nf
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 01:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbbEAXbj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 19:31:39 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:35644 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbEAXbj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 19:31:39 -0400
Received: by yhda23 with SMTP id a23so20552956yhd.2
        for <git@vger.kernel.org>; Fri, 01 May 2015 16:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=wTNi3OR72S+0O1/N4Vwe+QOeNoYCW8ffRJDE5UiDgE8=;
        b=u1ePV2mcdjN6j/BV0OGoRWWGKETidEC1FZ0J4jHg181MEAFwA5gaZLk6HUH85jQ92X
         GnpRBFi6TIusSqDbHt8Xzyh9TNjVmo3Uy0I7VLGmptDUR3j1vBsEIXv/4rZr52jmjF1K
         mjMOP5CWRoOKLCLD/aB67QBC/fcv3z7kX92xoBPK32O5Rhw2wuRA7ciqGvCanhy86sbw
         VgD/l3tlZDHnsKp5W1WDUuJ69Tb9QF/0e2EvMw91+wObIiOxbLLpgIplLpE74H/FJhIc
         oSobpzhB89R67KFzMa4mY4NIUqC52C6P1OfWN6HZZjCawEsnzy6sFco5zu/pFqjXQkPw
         EldA==
X-Received: by 10.236.53.68 with SMTP id f44mr660768yhc.62.1430523098565; Fri,
 01 May 2015 16:31:38 -0700 (PDT)
Received: by 10.13.245.129 with HTTP; Fri, 1 May 2015 16:31:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268201>

When passed the `--allow-empty-message` flag with no `-m`, `git
commit` will open the editor and allow you to exit with an empty
message, as expected.

However, when passed `-m ''` in addition to `--allow-empty-message`,
the commit fails. Example below:

    $ git commit -a --allow-empty-message -m ''
    error: switch `m' requires a value
    usage: git commit [<options>] [--] <pathspec>...
    ...

Shouldn't the `-m` switch know whether the `--allow-empty-message`
flag has been passed?

Thanks,
Josh
