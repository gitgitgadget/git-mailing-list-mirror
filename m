From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Proper way to abort incorrect cherry-picking?
Date: Wed, 28 Apr 2010 15:59:50 -0400
Message-ID: <h2v76c5b8581004281259yfaca7abfz5a455ff8fd6cdc6b@mail.gmail.com>
References: <s2m76c5b8581004281238jf7179fffna7d757fee6ab4f10@mail.gmail.com>
	 <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: David Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 22:00:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O7DQM-0004dA-EP
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 21:59:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756976Ab0D1T7w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Apr 2010 15:59:52 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:64835 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756954Ab0D1T7v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Apr 2010 15:59:51 -0400
Received: by qyk9 with SMTP id 9so21797568qyk.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2010 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=J4THPS/4W0bu/YO/lEOmY0x/jSm4b08G2mm0Xu8QI0c=;
        b=X5UBZ5q9TfmAvg8HLZ0W238fBdsy9Wx+kCHM38yaWDRpwDvfXMpAf5liasTg6qXnGq
         A5OG4U3A/FZP8QnA7PIOqdtMfTX2cbSJEr7uFIROrfUNRemiigGZqUFLTlWnopLl2uBZ
         M92LeFsxa23U5jeTtY3nyefnOyA6ch+mMBl7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=OKvpcUH4IC4VFPsI/kvn5+JTNdyLyDAJlngS9/ybrzXJ8V7TvOuqoD+Ywd7TszrtXn
         KE59fUkA8xi1KhznWreqtYTbE6JNk16mcHuN8hVbcU6Oe6fnUMBCQm00QwDlP/iHm4B9
         IlbmoKaSNMkkGLerq9w9iRgnDvbDL5BYGq1PQ=
Received: by 10.229.219.203 with SMTP id hv11mr10111233qcb.46.1272484790280; 
	Wed, 28 Apr 2010 12:59:50 -0700 (PDT)
Received: by 10.229.190.202 with HTTP; Wed, 28 Apr 2010 12:59:50 -0700 (PDT)
In-Reply-To: <r2s302ed1461004281249xd1b65e41l43fa7b639db7c97d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146009>

On Wed, Apr 28, 2010 at 3:49 PM, David Borowitz <dborowitz@google.com> wrote:
> On Wed, Apr 28, 2010 at 12:38, Eugene Sajine <euguess@gmail.com> wrote:
>>
>> hi,
>>
>> we have tried to cherry-pick 2 commits from one branch to another
>> branch, but unfortunately the incorrect commit was chosen to be
>> applied first.
>>
>> Thus, the automatic cherry-pick failed and caused conflicts, so in
>> order to to cancel the whole operation i had to do the following:
>>
>> 1. mark the conflicting files as resolved (without even resolving
>> them) by doing git add.
>> 2. unstage all files staged for commit as a result of incomplete cherry picking
>> 3. manually checkout touched files to their correct state (git checkout file)
>>
>> and then i was able to repeat cherry-picking with correct commits.
>>
>> Is there a better way?
>
> git reset --hard HEAD@{1}?

not always working. In our particular case there were some local
modifications to other files, which would be blown away with this for
no reason. That's why I went the long way of resetting specific files.

Thanks,
Eugene
