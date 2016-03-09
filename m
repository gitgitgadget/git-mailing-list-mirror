From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH] add a commit.verbose config variable
Date: Thu, 10 Mar 2016 02:02:28 +0530
Message-ID: <CAFZEwPM6XLkp07ekBfDaAPcJLvKxRNCW=deFy+GasWYeqcjk-A@mail.gmail.com>
References: <010201535cb62b56-9aa72755-b730-478c-9244-41a1ee69e231-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 09 21:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adkn0-0005Kq-95
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 21:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753847AbcCIUck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 15:32:40 -0500
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34481 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933881AbcCIUc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 15:32:29 -0500
Received: by mail-yk0-f181.google.com with SMTP id x17so26077175ykd.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 12:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to;
        bh=iazjaAB0nhDg7qpCxG3EQrBYihC+eq/WECzWakn8TnU=;
        b=jRy3T9TsGZIMg+srUUKcWh8v6meqnbmdhw3dmZdIYus12G5uuuO8HsEvI0XDaB9QDC
         0Lyi3COgNHsHFsVH9HVworP8OheMZp2WbKmxaH1Jq/EdhNMzfBphxgWYAleYxPt5ngb3
         JbRX4NdPK/JljjsU7Tclt+irJu8gstGw+XHPNQ/uG0qe/dcdRDJqm5vaN28z1eevs/z2
         uJtPqF5JOJo/PiJRmn0tRSJ/m6RvCBykKha0X/RsCxQfeCFp0HmpaHUlp7s+Bs4+twdf
         zlIrHbIztxZKWs99N3ZCrwUl0oI7U8Lrzhl0lNrHKoBg9E4jho/oixHS2b+fGiEOOVrS
         3o1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to;
        bh=iazjaAB0nhDg7qpCxG3EQrBYihC+eq/WECzWakn8TnU=;
        b=QiKVEHQWJ3vr4SzzisQo9NkefJmvAq4rm8E5SJ3NlBfc7EFCMZE/pHtiP/glhLRhVM
         AYKxmJXZyHgcWy6Gbdm500ddifEOd3K2ijCOVEOHoUKOBBznl3pBPXu8PH7jR6Bb7KmT
         ETZ2u39m0+u74g2jlbiOmOMCqtclx35JkMDE9RCzaweAMf3soUfo/Fzk4MF58dADg31T
         pM/krLjXAnDFCOg9yEuim9KI321BBwdZo5LMywiRHqditcnoGH6NA9BRs1vNxrBS4LhX
         Wba78fhn7pFwtJPMn+x4ArR474yH1SU34lppt/oOHFo2AjJzbQ5MAirkPWiRcS9323Yw
         WkTA==
X-Gm-Message-State: AD7BkJIXbBw3y01h5+6EAOJsGCBQCD1fmeQ6F49zmHoP54f8OANi83cmxRWvD63BqSovqhRsOPRfzVmGT7cxZQ==
X-Received: by 10.37.0.193 with SMTP id 184mr126064yba.53.1457555548453; Wed,
 09 Mar 2016 12:32:28 -0800 (PST)
Received: by 10.13.203.137 with HTTP; Wed, 9 Mar 2016 12:32:28 -0800 (PST)
In-Reply-To: <010201535cb62b56-9aa72755-b730-478c-9244-41a1ee69e231-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288574>

A previous version of this patch can be found at
http://news.gmane.org/gmane.comp.version-control.git/287540 .

The changes in the patch are :-
 - Fix typo "git config" to "git commit"
 - Use a better commit message
 - Drop a paragraph in commit message so as to not misguide readers
 - Consider additional tests as suggested by Eric Sunshine
 - Add an option "override-verbose" to git commit to override the
"always true" setting if set in the configuration file

It took me quite some time to send this patch. I was trying to write
tests for this and send the patch together but I could not find the
test examples that could be used from the existing code base. If
someone has an idea in mind then I could probably write the tests.
Though I have tested this personally for all the cases but I think it
would be preferable to automate the job.

Regards,
Pranit Bauva
IIT Kharagpur
