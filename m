From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deleted files can't be checked back out?
Date: Fri, 23 May 2008 17:43:05 -0700 (PDT)
Message-ID: <m38wy04jo1.fsf@localhost.localdomain>
References: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: fREW <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 24 02:44:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jzhrf-0002AG-AQ
	for gcvg-git-2@gmane.org; Sat, 24 May 2008 02:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbYEXAnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 20:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbYEXAnM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 20:43:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:49522 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbYEXAnK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 20:43:10 -0400
Received: by ug-out-1314.google.com with SMTP id h2so935508ugf.16
        for <git@vger.kernel.org>; Fri, 23 May 2008 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=or1ml63F2zyzgAh4XD521HNHwAQYKjjg3UG6RecXgAk=;
        b=xJAEXxlxKMzIS40S4fOUwYufFhUZcXQE1zmVc/NiPNn47mm+VLpCaAOiGr+p32UUPF03yl1A6Nyqkciuo/uv99XxZeHwiTGlvVgO7mfS9RWQHlmVgKm8xgn4v71MZMun0svKbNRvjqcevEGZhqOge+5C7lB9xb9mo5dyO/Uyf6c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=H+7HrOWfU8TX9+NvRZs64V8SaPHzgJ1SjKeIWYSBKJ5kFr3THo5+I2GkJLfHDjyjFnERQXnrTpZjyc4Bb5LDVleJJs4btJ9ylpgw1hexHEZi3ZQfIb1kvNalY9A/6wMopwP+IvYw5RoHS1a9nZZhj5CL7lFaTgfz5XFf93pVACA=
Received: by 10.67.105.12 with SMTP id h12mr23591ugm.45.1211589786809;
        Fri, 23 May 2008 17:43:06 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.211.36])
        by mx.google.com with ESMTPS id b33sm6496656ika.2.2008.05.23.17.43.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 May 2008 17:43:05 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4O0gZvh032284;
	Sat, 24 May 2008 02:42:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4O0gMKb032280;
	Sat, 24 May 2008 02:42:22 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82783>

fREW <frioux@gmail.com> writes:

> I recently deleted a bunch of files and checked the change into git,
> and then changed my mind and wanted the files back.  I did a
> git-checkout <file> and got each file back individually.  Then I did
> some work and did a git-push to upload to github. Then I did more work
> and tried to do a git push and it gave me an error that apparently
> meant I had to pull before I pushed.  

You didn't change history, did you (e.g. using rebase)?

> Anyway, I pulled, it redeleted the files and now when I do
> git-checkout <file> to get them back it says:
> 
> error: pathspec 'foo' did not match any file(s) known to git.

Use "git checkout -- <file>" (or "git checkout HEAD -- <file>") to do
a checkout of a file which is not present in the working area.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
