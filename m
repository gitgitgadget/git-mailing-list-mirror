From: =?UTF-8?B?S29ucsOhZCBMxZFyaW5jemk=?= <klorinczi@gmail.com>
Subject: Git doesn't detect change, if file modification time is restored to
 original one
Date: Thu, 23 Jul 2015 09:29:07 +0200
Message-ID: <CABEDGg8zixeab-CsviAU-fNE1Jmi0ZWbN6=e6Q+-XK3eFv6djA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 09:29:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIAwz-0002bW-QH
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 09:29:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbbGWH3t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 03:29:49 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34312 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbGWH3s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 03:29:48 -0400
Received: by wibud3 with SMTP id ud3so11034210wib.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 00:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=SjfBQjO/ZdHmTpEC0A+ZPU/eL+YMUCS7gRbDfL5x+kY=;
        b=B30gUkQfcSCngxTrq7lmHKbz735z7g0uEdVN0nfYHxYgvxvQCN8FcTssP1wMiUEsN2
         gb160o4W65z99OBch20jeHUt7VJJqx/QOrg7xqO6eI1z59VANwHh8QmH+gzADCs9FJTs
         lbiYeR7lctRNcP7Ad3QKzn92ETUAwEz6HXhwZb7sSs+9uI+HFhplG3PAnH7XXMzGT78t
         FB+t1493OAiQ/0whMfRui4ldLNVQX6tsB1HwotUGHcxsEbu+e7EzH+5n520A7Mmx1WXG
         jLPjYbNFYfqeqhp8ZcUe1wfSHnFQte2MPvuC9tffVj99D549zzcingz6kT7RU+fLxGTj
         Uz4Q==
X-Received: by 10.194.178.99 with SMTP id cx3mr12463492wjc.33.1437636587330;
 Thu, 23 Jul 2015 00:29:47 -0700 (PDT)
Received: by 10.28.21.4 with HTTP; Thu, 23 Jul 2015 00:29:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274486>

I wrote a search & replace perl script, which recursively searches
files and replaces text in them. After replace, it restores original
modification time (mtime) of file.

Interesting, that git status doesn't show replaced changes, if the
mtime is same as original.

Is there a way to force git status to show changes, even if the file
dates are the same?


I tried to set core to:
    trustctime = false
    checkStat = minimal
Unfortunately the change is still not detected :(
It seems isn't a way to force fallback to file checking and completely
ignore file modification date :(


Any idea?


Thanks,
Konrad Lorinczi
