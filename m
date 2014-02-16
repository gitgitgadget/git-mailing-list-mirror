From: Stefan Beller <stefanbeller@googlemail.com>
Subject: How to delete all merged branches?
Date: Sun, 16 Feb 2014 18:37:12 +0100
Message-ID: <5300F748.2060805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 16 18:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WF5ed-0002Ea-1d
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 18:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753313AbaBPRhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 12:37:16 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:65385 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245AbaBPRhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 12:37:15 -0500
Received: by mail-ea0-f177.google.com with SMTP id m10so4087681eaj.22
        for <git@vger.kernel.org>; Sun, 16 Feb 2014 09:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=bewbYnqXrBruiAgwjFvbooskAzjBTbnAG8L7vL7xAMA=;
        b=uIze8RDta/NyZQFYN2PMaNV+uRDTEG9BY5xN5pRucfaDyD746cvE5wXXUWmKdk9lyA
         UkbSPMn4IlDZ0O6AwQ4aU143TckX34frfap8OZFhS3TDZ7yiBdKrAN7mFYEd4IbiWDiY
         0fdgmG2YvxjTThifjjm+erjzrGAREiZ3Q22iR6bJCL1vSCj8UXU+S7wn0rVvcM8b/QBV
         Mshx/fOYnoqS2jhUkqNk58GkLTT27TXziis3pUnwlcDSQJsd165QEETrh3KIQxlkuqXr
         9SX72/fPuNlL/Z+zaH9GudF4bWeG9qWKupALvRjVoo8V8P45FXcM1do+RJfHpUPPt/GZ
         XZ8w==
X-Received: by 10.15.24.1 with SMTP id i1mr22237230eeu.12.1392572233961;
        Sun, 16 Feb 2014 09:37:13 -0800 (PST)
Received: from [192.168.1.7] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id m9sm46943389eeh.3.2014.02.16.09.37.12
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 16 Feb 2014 09:37:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242239>

Hi,

so I tend to accumulate lots of branches as I'd do one 
branch per feature. When cleaning up, I'd like to 
delete all branches, which have been merged.
I could use 
	$ git branch -d (which was merged already?) ^C
	$ git branch --merged # let's find out
	...
	$ # Now run git branch -d with each of the branches.

This kind of question has already been discussed, 
http://stackoverflow.com/questions/6127328/how-can-i-delete-all-git-branches-which-are-already-merged
suggests:
	git branch --merged | grep -v "\*" | xargs -n 1 git branch -d

Now it seems as if this operation would be needed by quite a few people
actually. Maybe it's time to integrate into git? I'd be interested, which
way would be the most git-like way to do it.
I could think of:
	$ git branch -d --merged # no need to specifiy a branch iff --merged is given with -d
	$ git branch --delete-merged 	# comes as an new extra option, doesn't clutter other commands
	$ git branch -d keyword-for-all-merged-branches

Before starting such a feature, I'd like to hear input of others.

Thanks,
Stefan
