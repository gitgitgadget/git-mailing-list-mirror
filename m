From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Mon, 6 Apr 2009 01:35:24 +0300
Message-ID: <94a0d4530904051535v8bd901fsedecdf61bc4acb33@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <200904052358.53028.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Apr 06 00:37:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqaxY-0003lD-MH
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 00:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753872AbZDEWf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 18:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753798AbZDEWf2
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 18:35:28 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49719 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbZDEWf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 18:35:27 -0400
Received: by fxm2 with SMTP id 2so1655537fxm.37
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 15:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Itx/5BCtI8c3pB7cDMzo2Ej/bqAfuOHtDTesDJlaAhU=;
        b=xUHPjBg17EyXlZdtS8jDdh20O9PR9DOOkQeIwDHUNF/kCmxwienMDgsi2Thi9nYHvf
         FJHLhqSKdL5QTit/akLIzu1gODQFLuE4XQoZDL4LVLsjTf477gI1Z6qGdVXB4hVwCx+8
         LNC9sY3l9ebGADavL9b1LIinEskjAlsuk1PlA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xdHBZ27+0iM0yrfp965BBCmoagxg/i4X+/kHsthHN0VtHoPpq54NgZVSWBMnSPokFi
         aFj4WS+2Jdzf4rr3ahqH1gi8GTwEqQ65yurp9l2V5ilwMDuyeeArAfK6J3GRlVc6cbI9
         nXkgnpKS5d/WAh+eO4WW7s2OD1yHfvzTIVMOg=
Received: by 10.86.61.13 with SMTP id j13mr2564773fga.68.1238970924723; Sun, 
	05 Apr 2009 15:35:24 -0700 (PDT)
In-Reply-To: <200904052358.53028.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115730>

On Mon, Apr 6, 2009 at 12:58 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> Felipe Contreras, 05.04.2009:
>> For example 'git stage diff' is more natural (at least to me) than 'git diff
>> --cached', same goes for 'git stage rm foo.c' vs 'git rm --cached foo.c'.
>
> Not for me. If I want to GET a diff, I want to use a command "diff", so
> "git diff" is more obvious.
> The next step is to say WHAT exactly to diff. Therefor options to the
> "diff" command are more logically to me from a hierarchic POV. And here
> I don't think options like "--cached" or "sha1..sha2", despite having
> different style, make any difference.

Well, it's a matter of preference, and you would not loose the option
to do it the way you like. But actually, "git diff --cached" is a
different action; you can't do "git diff --cached HEAD^.." for
example.

Consider "git rm foo.c" vs "git rm --cached foo.c"... both commands
are removing a file, the only difference is that one is removing from
the staging area while the other is removing it from the working
directory. Now think about "git branch -d bar", following the "first I
specify the action, and then the object" thinking, would it make sense
to have "git rm --branch bar"? Probably not; if you want to do stuff
with branches, you use "git branch", similarly, if you want to do
stuff with the staging area, why not use "git stage"?

-- 
Felipe Contreras
