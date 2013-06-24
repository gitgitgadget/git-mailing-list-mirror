From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 19:49:38 +0530
Message-ID: <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-7-git-send-email-gitster@pobox.com> <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
 <7vhagndis4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 16:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur7d1-0007sQ-Dg
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 16:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169Ab3FXOUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 10:20:19 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:35353 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750902Ab3FXOUS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 10:20:18 -0400
Received: by mail-ie0-f169.google.com with SMTP id 10so25436600ied.0
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 07:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cQsrCIckpHnVYM+PI50h8mMzYm/U/PdvCcxbDyohL+A=;
        b=CWReCdm+hpfCQwflaC07C+S/unCpcT31IjA6jjzzF86DfBdC8WfauK6c21K7j9PbQj
         iziyRH36cKeG664/YvFv+dc6fUvqBTAebUeckUaWJjXRsdq/Hd/AFa4gs1nEN10myTVr
         aEogET7xoM/6OztQ49h0Qz3hTA4iTj8tLLRmtYZJLMHhaiS6NNcqyVZldHtQSSTW1yIX
         fynZ5gWCZ0ZCPT5Jy+XayjdT6ZKisAbba8tqA0LoqA6MZG69i/IQybICCIM8h5dmpkaf
         sTbCLNcq36S7XN4nRn/K6IHqvukb6iLjCdvgWL3RQB02ybCrsKgaagXQoP+miSEha00v
         Vsqw==
X-Received: by 10.42.76.5 with SMTP id c5mr8326406ick.91.1372083618296; Mon,
 24 Jun 2013 07:20:18 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 07:19:38 -0700 (PDT)
In-Reply-To: <7vhagndis4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228816>

Junio C Hamano wrote:
>>   # on branch master, derived from origin
>>   $ git push ram
>>
>> And branch.master.push is set to next?  Will you let her shoot herself
>> in the foot like this?
>
> It is not shooting in the foot, if branch.master.push is explicitly
> set to update next.  I do not see any issue in that part.

The question does not pertain to master being mapped to next; it
pertains to central-workflow versus triangular-workflow: origin versus
ram.  If the user has set push.default to upstream, she _expects_
triangular pushes to always be denied, and this is the first violation
of that rule.  I'm tilting towards building a dependency between
branch.<name>.push and push.default.
