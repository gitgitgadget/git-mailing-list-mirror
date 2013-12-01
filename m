From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: GIT_DIR not auto ignored
Date: Sun, 01 Dec 2013 19:08:39 +0100
Message-ID: <1385921319.3240.3.camel@localhost>
References: <CAHJtQJ77drefyhjrs_C8bEq14ZiSNf6Boztqx+JYx51dRtrd-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ingy dot Net <ingy@ingy.net>
X-From: git-owner@vger.kernel.org Sun Dec 01 19:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnBS4-0001gE-3o
	for gcvg-git-2@plane.gmane.org; Sun, 01 Dec 2013 19:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580Ab3LASIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Dec 2013 13:08:44 -0500
Received: from mail-wg0-f43.google.com ([74.125.82.43]:59041 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab3LASIn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Dec 2013 13:08:43 -0500
Received: by mail-wg0-f43.google.com with SMTP id k14so8496531wgh.10
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 10:08:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=fOyUCkHkK+axCk49Os+qvyBn6vnFDqvMbiTRCkHhWm4=;
        b=AXGDLJ/5FwxMxw78hJ3CP7iMN3tnLTqqHdcagyVj8UV5fowJfbpaISW8amPm9zkD1J
         yLu0jPHtKyuHIMiD+gF7KduKwwOPtMzoYwM0465tl8mkZJHY6QzGVaKBtHxzyFuKHIu7
         Hu+ul9KmbIAoVPYT4U71BOn/8CPRz42boeQa2uB2PqJcEfD5bOw1nDCQxpY6x46Yn+Q/
         fPu7MNMgivyzk1Aj7FKcJlXsCnuZ/eFgpTnLPFAyKI71aZATm1gUub9Izkm1TwgfWrDW
         W4pt+hJD3Q3LQNJtFTB0/OIOpxpXDZ9zkBSjgacHGIV1ODtjwqJqWGlW1OrcxiTk6YZN
         yDzA==
X-Gm-Message-State: ALoCoQlbBQ60hkqVdjw7EAvk54prHUwwF01uoZbWKEriWq92OsZIDKhrd+JVvgb5wsdFK+EcsXzE
X-Received: by 10.180.9.110 with SMTP id y14mr14953630wia.61.1385921321598;
        Sun, 01 Dec 2013 10:08:41 -0800 (PST)
Received: from [10.42.1.4] (82-168-11-8.ip.telfort.nl. [82.168.11.8])
        by mx.google.com with ESMTPSA id dj8sm114620341wid.2.2013.12.01.10.08.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 01 Dec 2013 10:08:40 -0800 (PST)
In-Reply-To: <CAHJtQJ77drefyhjrs_C8bEq14ZiSNf6Boztqx+JYx51dRtrd-w@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238591>

On za, 2013-11-30 at 23:06 -0800, Ingy dot Net wrote:
> Greetings,
> 
> I found this probable bug:
> https://gist.github.com/anonymous/01979fd9e6e285df41a2

Summary:

$ mv .git .foo
$ export GIT_DIR=$PWD/.foo
$ git status
# On branch master
#
# Initial commit
#
# Untracked files:
# .foo/
nothing added to commit but untracked files present


I checked with 1.8.5 and this still happens. And this also happens:

$ mv .git .foo 
$ export GIT_DIR=.foo
dennis@lightning:~/code/git$ touch .git
dennis@lightning:~/code/git$ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

	.foo/

nothing added to commit but untracked files present (use "git add" to
track)

(Note the absence of .git there)
-- 
Dennis Kaarsemaker
www.kaarsemaker.net
