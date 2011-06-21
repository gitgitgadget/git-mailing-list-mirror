From: Kasra Khosoussi <kasra.mail@gmail.com>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 14:40:47 +0430
Message-ID: <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>
	<4E005404.5010901@drmicha.warpmail.net>
	<BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>
	<4E006682.80101@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 12:10:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYxv3-0006k6-Ce
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 12:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab1FUKKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 06:10:48 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:33275 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab1FUKKr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 06:10:47 -0400
Received: by pvg12 with SMTP id 12so1355386pvg.19
        for <git@vger.kernel.org>; Tue, 21 Jun 2011 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=oRqYKmhRSK0tU/GbK5jpQtZY6xKYqZ5tj4V6j7IUzAc=;
        b=pGtSsxAPjghv0cgGQqJqY7Fo8ZxQyGoa5zw7TzFqtU0R8z7/32FfT/YZY3qsVZnV1t
         yU/A5K+G7waC+CHEtHFQ4v7u4d4D1ZGLLnqECPFjHfXF2fD62HBH1FpqBsJFYoztAuTe
         Imr9dr4wN2ATmsAgNLIW1Fg5sd0OI0eBm6vXU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XfasGJ7AQ8r4SBdfcTLTT0LygoC7jqpWJl9j4DjBSLUG23zdMI736+5boEq5Z6MiU1
         4m3c8cFXo5NiSi8WgKp3YLjX+qCiTBZkIP7kRV5swjD78Jh6WKfFmSMtMGxHRF2QRvD8
         bU2Yfxp4EqdoNFA4pKUGjA9D05+N382CCM2L8=
Received: by 10.68.19.131 with SMTP id f3mr2551408pbe.379.1308651047170; Tue,
 21 Jun 2011 03:10:47 -0700 (PDT)
Received: by 10.68.55.132 with HTTP; Tue, 21 Jun 2011 03:10:47 -0700 (PDT)
In-Reply-To: <4E006682.80101@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176135>

Thanks for your help.

I used update-ref and changed refs/heads/master to the sha1 of
previous commit. Then I commit the changes. Everything seems fine now
except (as you previously mentioned), git fsck -full complains about
dangling trees. Is it critical?

-Kasra

On Tue, Jun 21, 2011 at 2:08 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Kasra Khosoussi venit, vidit, dixit 21.06.2011 11:30:
>>> Backup now!
>>> I guess you've done that meanwhile anyways, but it's important before
>>> any recovery attempts.
>>
>> Yes, I've done that.
>>
>>> Is your reflog OK, i.e. do you get proper output from "git reflog" or
>>> "git log -g"?
>>
>> No. Before moving the corrupted object git reflog would return:
>> fatal: object 0a83757505387aacc2fd36b3c996729e6bf9d6e5 is corrupted
>>
>> and after moving the file it would say:
>> fatal: bad object HEAD
>
> Oh yes, stupid me, sorry. "git reflog" tries to parse HEAD. But you can
> look at the file directly:
>
> tail .git/logs/HEAD
> tail .git/logs/refs/heads/master
>
> etc. show you what's been going on with those refs lately.
>
> You should be able to pick the the sha1 before the corrupt one from that
> and do things like "git log that_sha1" if only the most recent commit is
> corrupt.
>
> Michael
>
