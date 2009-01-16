From: David Aguilar <davvid@gmail.com>
Subject: Re: git-difftool
Date: Thu, 15 Jan 2009 21:05:56 -0800
Message-ID: <402731c90901152105q1880c5beod4146d955f04dd8b@mail.gmail.com>
References: <20081226013021.GA15414@gmail.com> <vpq63kxofi3.fsf@bauges.imag.fr>
	 <402731c90901020939k1a8ae795oc4cbfd0ced992aab@mail.gmail.com>
	 <200901152326.47332.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Fri Jan 16 06:07:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNgvf-0005Co-Ui
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 06:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbZAPFF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 00:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbZAPFF6
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 00:05:58 -0500
Received: from wf-out-1314.google.com ([209.85.200.168]:2514 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbZAPFF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 00:05:57 -0500
Received: by wf-out-1314.google.com with SMTP id 27so1683950wfd.4
        for <git@vger.kernel.org>; Thu, 15 Jan 2009 21:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=EbI9MzoDXz0ajNNBZjiJ5xuvA0qQcK6hWNxZVuoD5nQ=;
        b=nrI2MXxV3On8vcP4JAsTGgX6aSG/AoHZz+VzHdumh/bir4IaO2vd4Z/GrZKWv3s/F8
         JvswvPCbN+9DIHuVJBeUIhFFOLXeFUsOw2TWFDUVLkZ5ntggK9g1+TnE61Q8Gxm7BCAv
         5tQxLSQ4m43eFDbjv0lhJwryRSsDanyoEgo7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rGWQDWnI5XiwEcE2zszgt/9bEcNYhnHb2KiHRKnzx7/6apnRvILB+esZjJmbTwM+1A
         wNIUKhrLGD1YDFWS0UIU0UCvaI1NogDHylEzhivVHpFzE0xn3NnRAcwV6M+64cU54xIT
         N7eqoTniWxoz6Ir25UtvXVWbGszuEibPneNS0=
Received: by 10.142.231.7 with SMTP id d7mr865475wfh.52.1232082356689; Thu, 15 
	Jan 2009 21:05:56 -0800 (PST)
In-Reply-To: <200901152326.47332.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105922>

On Thu, Jan 15, 2009 at 2:26 PM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> David Aguilar, 02.01.2009:
>> I now have a git-difftool wrapper script that basically just sets up
>> the environment for git-difftool-helper.  git-difftool-helper does all
>> of the merge tool configuration stuff ala
>> http://www.kernel.org/pub/software/scm/git/docs/git-mergetool.html (it
>> uses the same git config variables and thus works with existing custom
>> commands).  If you drop them both into the same directory it should
>> work as-is (it munges $PATH).
>>
>> It's not a two-liner (they do all that git config stuff and handle
>> more than just vimdiff) but it does use GIT_EXTERNAL_DIFF now, which
>> makes the script infinitely more useful.  This is much nicer now since
>> you can pass any 'git diff' options to git-difftool and it'll handle
>> it correctly.
>>
>> The usage is simpler now too:
>>
>> usage: git difftool [--no-prompt] [--tool=tool] ["git diff" options]
>
> Now isn't this something for contrib, David?
>
> Markus
>
>

It sure is.

BTW the script worked beautifully on *nix.

I later decided to give it a try on Windows and of course it didn't
work right the first time.  Once I added a check to use "git.exe"
instead of "git" then it started working again.  I'll prepare some
documentation and post a patch later tonight.

Thanks for reminding me,

-- 
    David


(p.s. Markus: sorry for the double-email -- I forgot to cc: the list)
