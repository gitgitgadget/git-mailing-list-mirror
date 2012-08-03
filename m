From: Eugene Sajine <euguess@gmail.com>
Subject: Re: need help with syncing two bare repos
Date: Fri, 3 Aug 2012 16:31:41 -0400
Message-ID: <CAPZPVFZpLBXG0Ntbf06dWRS_Z4hVzMXF-2FmfqvT2mN9A8Ektg@mail.gmail.com>
References: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
	<7vboirbva3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxOXH-00054j-AH
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab2HCUbo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 16:31:44 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:61933 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752496Ab2HCUbn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2012 16:31:43 -0400
Received: by lahd3 with SMTP id d3so598914lah.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 13:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kVoCjekV1UH3iqfI+WnHrrFtNHTN4KIWNbS7vHF3P+Q=;
        b=B57unAAlf4Tlx5os0U7WPxKps4oj4SUjz6fP1GAPIzpDqDrwv8/5a80lgw3PzhRpcq
         eciRiduV5MR9YQDM1LFtPNz41ARV3cU9AqU00scJjobT8imUZh4jNNZXpMOtkhqwUHHP
         9qK62YlBDwGsLndWMNFh08YY9KcZtbbc5x0KDN/xmM5ZwQaf/YjqHaHJ6EPE3RpPXf20
         gPVDZOZA5K6vvr2bPsjBOsw0qHtvTIQqS6cYVsLF207MbtwntSLsIykDpeUEpN+Db2dN
         hbLkGyz/FWr6hEIQSP6Q5bMx5W6ZKketv21u6X2ShJZmhcDMt9/+tDfMstYWIajfTkMf
         BexQ==
Received: by 10.112.46.135 with SMTP id v7mr1176651lbm.3.1344025902016; Fri,
 03 Aug 2012 13:31:42 -0700 (PDT)
Received: by 10.112.82.163 with HTTP; Fri, 3 Aug 2012 13:31:41 -0700 (PDT)
In-Reply-To: <7vboirbva3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202859>

On Fri, Aug 3, 2012 at 4:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> I think the best variant would be to do something like:
>>
>> $ git pull --rebase /refs/heads/*:/refs/heads/*
>> $ git push origin /refs/heads/*:/refs/heads/*
>
> You perhaps meant "worst" not "best" here.  From the point of view
> of people who have pushed into the "origin" repository we see above,
> their history is rewritten; you are screwing half the population by
> doing this.
>
> Not allowing B to accept pushes while it is not positively sure that
> A has gone down would of course be the best solution (in your scenario,
> B started serving when it merely found out that *it* cannot contact
> A), but barring that, the recovery for two histories at A and B,
> once they diverged, should be to "merge" corresponding branches.

Junio,

Thanks for chipping in!
Please correct me if I'm wrong, but wouldn't merge result in the same
history changes for people pushing to the origin (bareA)?
Still all their consequent changes will not be fast-forwardable
because of merge commit. Or am i missing something?
It might be that the command i specified is incorrect.

I meant that I would execute "pull --rebase" (or proper analogue for
bare repo) for each branch on B side and then push those refs to A.
This way it would pretend that B is another "dev repo".
May be you can advise on correct commands to do that properly?

I'll think about not allowing pushes to B while not sure it is really
time, so it is not reacting on irrelevant connectivity issues or bareA
downtime due to the maintenance.

Thanks,
Eugene
