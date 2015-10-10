From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Sat, 10 Oct 2015 12:45:03 -0400
Message-ID: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 10 18:45:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZkxGj-0005Un-WB
	for gcvg-git-2@plane.gmane.org; Sat, 10 Oct 2015 18:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbbJJQpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Oct 2015 12:45:07 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36501 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbbJJQpF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Oct 2015 12:45:05 -0400
Received: by wicgb1 with SMTP id gb1so103873014wic.1
        for <git@vger.kernel.org>; Sat, 10 Oct 2015 09:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=1twl+JrXuaXruJChSNytW+D3uA5f2kSYlNQ2iWnFlzg=;
        b=yF2aqyV5o7waGD3/aPlZmZdPKeR8a8BBeHdHep+8118SWCMj/gDDbewuvuMdDeMCDo
         /XkFIIWUN4rbByb6rnkVgL90eSQE6B2/UG8WUlGYJVhJsOpQwaVu2dcICMjRLKW26DWz
         u1gS7IK/gcbeBA+Kv0ntpX2C7JNJjunhroLCwVQnoi0BJd+ucSQ2J0wf3lIVzUAlLtyg
         7PeKW3sTTqANiWES6AOlMTTtbaozTB2vOAtBL6kzUO9FcW/XH89FsJjlWoxeCGoWxCZL
         GlpKY6y+sJB0spN9Zpmb7BgigcJuFWr+r98ahpZ/ODSjR6RAeGavjM+1DT3B2oCIWeFl
         dnjw==
X-Received: by 10.180.93.168 with SMTP id cv8mr5702508wib.54.1444495503993;
 Sat, 10 Oct 2015 09:45:03 -0700 (PDT)
Received: by 10.28.210.68 with HTTP; Sat, 10 Oct 2015 09:45:03 -0700 (PDT)
X-Google-Sender-Auth: 5aQgl6eY3pNlBbLm0m11tHdZr5w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279325>

I noticed that git-credential-cache--daemon quits on SIGHUP. This
seems like surprising behaviour for a daemon. Would it be acceptable
to change it to ignore SIGHUP?

(This came up while investigating a Magit bug[1], we are also
considering ways to avoid sending a SIGHUP in the first place)

[1]: https://github.com/magit/magit/issues/2309
