From: Ittay Dror <ittay.dror@gmail.com>
Subject: Re: connecting existing local git repository to svn
Date: Tue, 27 Jan 2009 12:41:44 +0200
Message-ID: <497EE4E8.8070705@gmail.com>
References: <497E8927.1060506@gmail.com> <497EE386.5050805@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jan 27 11:44:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRlQH-0004ai-LK
	for gcvg-git-2@gmane.org; Tue, 27 Jan 2009 11:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbZA0Kmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 05:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753248AbZA0Kma
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 05:42:30 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:8722 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbZA0Km2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 05:42:28 -0500
Received: by ug-out-1314.google.com with SMTP id 39so204912ugf.37
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 02:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=OY0vfWXO2k4xRlc28fQ1kH4CdEyvsRiMVW5t6phRpHY=;
        b=DWh11GyubBq7mZJYhPZXESzzvd8W0/bW5nc9q5xnLJHOlzDrG+2AxRJxhNLlout6WL
         ann+dzg4VbBqTw2IXL7aTX8JvbjE2unsJ1zxBqu0Bbz+v2ElVnCPZEUTsshzYQVq/f5w
         btR7jbQf2i1Az4BGRpPofQZFsno5dGABnO/mc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=EBRXvlQsRdFH+ZFZQRgqwrmIvK5XOWJB2nubxMl1yKM6wi2Vedw9bEACJ/82Z4628K
         4kHzCEsoQf4HypJaPsaByHaVMUi4napR0kS1wmcqZRstLbS4XmgxNS0psdxKFU5kBojM
         7gwyz3ebQ6JQu6/U0sQZmr/Yws/ZOj8eG4aww=
Received: by 10.67.16.11 with SMTP id t11mr1744161ugi.29.1233052946057;
        Tue, 27 Jan 2009 02:42:26 -0800 (PST)
Received: from ?10.10.2.8? ([212.143.191.180])
        by mx.google.com with ESMTPS id u6sm11162444uge.50.2009.01.27.02.42.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jan 2009 02:42:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <497EE386.5050805@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107331>



Michael J Gruber wrote:

> Ittay Dror venit, vidit, dixit 01/27/09 05:10:
>   
>> Hi,
>>
>>
>> I'd like to create a branch in a subversion repository so that I can
>> work with git-svn on it.
>>
>>
>> My git repository is already with a history, that I don't want to
>> replicate to subversion, I want to start with subversion having just the
>> latest revision and then continue from there normally (git svn
>> dcommit/rebase).
>>
>>
>> How can I do that?
>>     
>
> Create the svn branch (with svn) and "git svn clone". Pull in your git
> branch under a new name (if that is what you want).
> Now, you can e.g. "git merge -s theirs" your other git branch into
> master, git svn rebase and dcommit. Untested, but comes with best wishes ;)
>   
but wouldn't that create a revision in svn for each commit in git?

what i want is something like:

git: ----v1----v2----v3--v4---v5
svn:                     \---v4--v5

so the svn history starts from v3, but the git history remains unchanged.

ittay
> Do you want to discard your existing git history completely?
>
> Cheers,
> Michael
>   
