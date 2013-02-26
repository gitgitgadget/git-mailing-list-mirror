From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Tue, 26 Feb 2013 20:58:20 +0200
Message-ID: <CAHXAxrM=X9q_65VcVkc+1JQk9QCjvGi1rFhEDcPN27S9ed7yMA@mail.gmail.com>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
	<7vzjysxnb1.fsf@alter.siamese.dyndns.org>
	<CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
	<7vr4k4xlie.fsf@alter.siamese.dyndns.org>
	<CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com>
	<7va9qsxjzk.fsf@alter.siamese.dyndns.org>
	<CAHXAxrO4c=s0pjNpXK171HUbQT06jm-VAxNNK1DAqZEZfz6OtA@mail.gmail.com>
	<7v4nh0oxnv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 19:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAPjj-0008Il-Hj
	for gcvg-git-2@plane.gmane.org; Tue, 26 Feb 2013 19:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab3BZS6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2013 13:58:22 -0500
Received: from mail-qe0-f49.google.com ([209.85.128.49]:48389 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755163Ab3BZS6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2013 13:58:21 -0500
Received: by mail-qe0-f49.google.com with SMTP id 1so966677qec.22
        for <git@vger.kernel.org>; Tue, 26 Feb 2013 10:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=VcWxO5Ehl0lUF94sWf7aTcS7d58Wfbuu4SfW8fC0DaI=;
        b=dqD45NUF5edE4EUsjsW2J2EzNOix2KJCiiWtz4yOpkdj8wDcPS3GKx2GqBtr7yPqc7
         vOSGdQO8JAdkEePtuQiPNvZTyt5q3EJlEzQLpSJ80X0A2m9EpY2uNupCQB6+Mx6GqIlv
         1YFKoLt+XxOyudqRCg3ftG0lsJDBAS1GwRJ6lttXgXQNMFLM+u0C25P7YvHF3JQ0zfxR
         wnzgBT6lLHFRNcFZXstGCNp7txFnsM4vQ5HkprWZxb3jO90rxYpnYuE7fkmZGZt8xIVQ
         w6Gykfh8j4Ps+qLyQvItdc2wWn0j2bC80LxvLQuLCyfLNfdbAWJEkX6MqP8j94goPwkT
         vx4w==
X-Received: by 10.224.27.136 with SMTP id i8mr3640780qac.63.1361905100084;
 Tue, 26 Feb 2013 10:58:20 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Tue, 26 Feb 2013 10:58:20 -0800 (PST)
In-Reply-To: <7v4nh0oxnv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217159>

> The test does _not_ fail.  That if condition does return -1 on Linux
> and BSD, and making tm_to_time_t() return a failure, but the caller
> goes on, ending up with the right values in year/month/date in the
> tm struct, which is the primary thing the function is used for.

I said it wrong, test itself is not failed, but numerous is_date()
checks are failed due to incomplete time.
