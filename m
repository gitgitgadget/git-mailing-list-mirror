From: Chris Cowan <cowan@streak.com>
Subject: gitk: "argument list too long"
Date: Mon, 15 Jun 2015 11:25:22 -0700
Message-ID: <CAL_Ays8piaRHk6BxDOBLYbrxoN4wt3bLB0Pt8K6NydOBCi9dzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 15 20:26:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Z55-0000GY-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbbFOSZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:25:55 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35283 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754542AbbFOSZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:25:53 -0400
Received: by ykar6 with SMTP id r6so37002049yka.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2015 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streak.com; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=xtd/M3YXMSm+7rdNABuaf0YdNazCAheph/Tb/oOUF7I=;
        b=sWdRhu8V7sTgt5goYhwLE1xH5XyGvuiu3hGR3U8Zfl6vAwDhD4pnHiYDBSwLq952rG
         Cziv98JBYkTEB8bW7OiCQ2aVuZM3lzt6hkw7F25dGRVk4ueTca5nhJlr3Gm9qdVUcZXm
         2W5ktf3AaiQS0+tnGc3Gq3Spx6qahKHCXVVgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=xtd/M3YXMSm+7rdNABuaf0YdNazCAheph/Tb/oOUF7I=;
        b=HiERPjJlOzJONh4jSd0H2KNc1u6TWwu1IzLmB622DtF4r7uyOC5HXmGeME9CKK2Twc
         5cUhebx1eha2kPgWtrryt/pjZwWO278N7u5kEH5i6Q5wpebqZD1eji7YT4XykoOvo216
         xQJxa2Flob55H+WMbPzKYZEvdPvgGS+K7EK4XwSGIB2CByE+cJbCP1+46FBz5qeX/loP
         YJ8qMDuc9M61olKtm7xDEe5+buXJD0JTE2P58P8b+C3U+uSRGSEL7ICOoviyXFKYnZfe
         JQgncX2gov4lpB4O0FWwkrTNSeYoBb+RXWrBlBr+ImveBslXrohGtFALk2UTfSNl6tqm
         KsEg==
X-Gm-Message-State: ALoCoQlG4VcIhKAghlWSeRtUd/lvRu4VJaE7Q0BHHhMqxwTW1E82M4WNObUpj97ui+m06/QdwIjN
X-Received: by 10.129.95.135 with SMTP id t129mr578089ywb.29.1434392752340;
 Mon, 15 Jun 2015 11:25:52 -0700 (PDT)
Received: by 10.37.68.133 with HTTP; Mon, 15 Jun 2015 11:25:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271698>

I've recently had an issue where running "gitk --all" has stopped
working on a large repository of mine. Gitk's main window appears with
all of the sections empty, and a modal tells me 'Error executing git
log: couldn't execute "git": argument list too long'.

I'm on OS X, and am running git version 2.4.3 installed via homebrew.
"getconf ARG_MAX" tells me that the maximum argument length is 262144
bytes. "git tag|wc -l" tells me that there 5271 tags in the repo, and
more are added regularly. I think that's what set it over recently.
For now I've worked around the issue by running "gitk --branches"
instead.

I searched for other mentions of this issue, and found this issue from
I think this same mailing list:
http://www.spinics.net/lists/git/msg243731.html . Trying to run "gitk
--all" in the chromium git repo (available at
https://chromium.googlesource.com/chromium/src.git) gives me the same
issue too always as Nicolas reported.
