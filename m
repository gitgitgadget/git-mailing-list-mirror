From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 22:23:46 +0200
Message-ID: <CABPQNSYxq1cSYKi+fGajoASL6x7e6VCaSDoWNmYuEHSgt8NFBA@mail.gmail.com>
References: <1339515815-10752-1-git-send-email-kusmabite@gmail.com> <7vd354jwss.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 22:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeXdh-0002al-8G
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 22:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751552Ab2FLUY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 16:24:28 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43005 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab2FLUY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 16:24:27 -0400
Received: by dady13 with SMTP id y13so7347121dad.19
        for <git@vger.kernel.org>; Tue, 12 Jun 2012 13:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EjzxlnLHM//NFZ8uKoCPM7u+gzrfgs+6wRX4DTLt7Aw=;
        b=gRQOrrqWu1Wm+prWVcWvEhTOtGDkA8VSZukrJglPnWDIYWw9lcqaWkO28Q7OUnJ7X5
         w510JMYS4hU3bSPKannn1U5vKx2VfC801HCXZpHjgcC4iGhA8DVEQouO/NuwZF79Bv1h
         ct8lHLUt9Kp43eUoRsfpxvq0T66n82ZLYdexglliUXgxvsNETrQqYAaQo2fpAU8xWA7Y
         ZGeszBpZUMGxUhLyoCWiGKrd0CCKnEPLIkWIutE+5fwfFR5vDSPd2+pgFD2zBAcMPay5
         6S54lILlBdGTjSzncxu10zv8kHDLPdRBn9wPMf99lW3+BSSwLOmXf6yeqrOvehE/eYKa
         FmRg==
Received: by 10.68.194.105 with SMTP id hv9mr42116139pbc.126.1339532666937;
 Tue, 12 Jun 2012 13:24:26 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Tue, 12 Jun 2012 13:23:46 -0700 (PDT)
In-Reply-To: <7vd354jwss.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199847>

On Tue, Jun 12, 2012 at 6:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Erik Faye-Lund <kusmabite@gmail.com> writes:
>
>> When calling "git svn rebase -q", we still get the message
>> "Current branch BRANCHNAME is up to date." from git-rebase, which
>> isn't quite as quiet as we could be.
>>
>> Fix this by forwarding the -q flag to git-rebase.
>>
>> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
>> ---
>>
>> I just set up a cronjob that did a "git svn rebase -q", and noticed
>> it triggered cron to send me an e-mail every time.
>>
>> Since I'm not really interested in getting an e-mail every time the
>> script does nothing, but I'd like the option to get an e-mail whenever
>> it does something useful, perhaps something like this can benefit
>> other people as well?
>
> If it matches what you would get from "git pull -q" run in a
> cronjob, I would say that is a sensible change to make.

Seems like it to me in my tests, yeah.
