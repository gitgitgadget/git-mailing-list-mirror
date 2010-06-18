From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: rebasing a merge
Date: Fri, 18 Jun 2010 11:19:14 -0400
Message-ID: <AANLkTikH9S1GCOwJfmKvO4fTvG46libJtrdMNQeiBm1_@mail.gmail.com>
References: <AANLkTilY_9j2sXlplhYB4FPAIAzuPBg2UyUTEk4DaaYF@mail.gmail.com>
	<alpine.DEB.2.00.1006181010220.12445@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 18 17:19:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPdLo-0006CC-DF
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 17:19:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933688Ab0FRPTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 11:19:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53813 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933643Ab0FRPTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 11:19:16 -0400
Received: by iwn9 with SMTP id 9so1159498iwn.19
        for <git@vger.kernel.org>; Fri, 18 Jun 2010 08:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=03nHrM+zFEiXKGe7EuLY3PSnOJcWjzEh6BN/Gx/hQOU=;
        b=fQXEtbpD5T4MtUMIpvPcKyF6RYLNuv51VuT1F2NcgRX99t27aUlwe8/xd4OR72MDR0
         csFvF27ZAqqZlAR/RuWTPz86eLnNmFSi6GA6H9VMsM4HyhIeWy2I9qBl24uK0YlboZtX
         YoyP2XBx2D4GUdxOd8J5eODzMQBAtPaewf8BI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fnv2dH4d85et+Fx/tM3hs6xsDCH30ocb2H6E8U8uZ0PIGWQiRNIO7AWV2H79L3/xAg
         p0ry3Po66zxwbzeHnuJSLZwyl8X0+yQxgvPrNGFQKUCWrAencvHMIyP3Bq1EvVgm6o+R
         FmPadSY5IbH1Nx30hHQKMfBx88SmWffbvXiro=
Received: by 10.231.141.15 with SMTP id k15mr1314786ibu.161.1276874354897; 
	Fri, 18 Jun 2010 08:19:14 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Fri, 18 Jun 2010 08:19:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1006181010220.12445@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149349>

On Fri, Jun 18, 2010 at 5:10 AM, Peter Krefting <peter@softwolves.pp.se> wrote:
> Jay Soffian:
>
>> Here's how I've been doing it, but I'll bet there's a less convoluted way:
>
> Do you have git-rerere enabled? I have found that to be a major timesaver
> for cases like these.

I'm familiar with rerere. The problem is that my original merge often
takes me several attempts to get correct, where each attempt I'm
amending the merge. So once the merge is finally correct, I need to
retrain rerere (see my earlier post to the list about this). Now at
that point, I could use "git rebase  -i -p --onto ..." to redo the
merge and let rerere take care of the conflict resolution.

Which is what I was doing. But it occurred to me that the final tree
that I want is the same as if I just do a second merge, save that off,
then redo my original merge and commit it with the second merge's
tree. This is also a lot faster (this repo is 1GB well packed composed
of 40k files) and I think less error prone.

j.
