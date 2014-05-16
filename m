From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [Bug] - Processing commit message after amend
Date: Fri, 16 May 2014 17:28:57 +0700
Message-ID: <CACsJy8DSqeAnCMCawsh-58=B1z93tBCVb+x8XAAUZ17Y1ZaJKA@mail.gmail.com>
References: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michal Stasa <michal.stasa@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 12:29:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlFOP-00013V-FI
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 12:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756981AbaEPK3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 06:29:31 -0400
Received: from mail-qc0-f177.google.com ([209.85.216.177]:35331 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbaEPK32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 06:29:28 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so3896475qcy.36
        for <git@vger.kernel.org>; Fri, 16 May 2014 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gQV7AC0HMY4RFvLBuIuNMY6ivfOCajADKKDcCVtGSLI=;
        b=uCZ49g5uvR1fR2OMic+f6zNmC7+gDNMHXB0VrbzS3kLTkII5e0KHg+vjZee8sssESR
         +BGeIJqkoqmEVnufNyQZ0oPBkLpSTq69nVfwWkGv/tPY7jlu15KohsFyd2GiWR+NfKo3
         pwY6WoGQupw3yUD1aDRX9fr4gDjeJrJ0n0P6kZnPj62APlUbt/bOdh0L733guVyDK8eu
         vf5Klp4nbaIfFLKmDdH+U6JppfaBz4T/Gm2p6sLScGxNEBcEQ3JOGSY//CnKz1ws8hEL
         wpIDAz+Rdf4CBh7CsnjOO1WrQXFgEm0YBMJZmax1VRvxSlw1JJJjPD+c03l1tYxAwqn6
         cXJg==
X-Received: by 10.140.80.40 with SMTP id b37mr22477956qgd.98.1400236167535;
 Fri, 16 May 2014 03:29:27 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Fri, 16 May 2014 03:28:57 -0700 (PDT)
In-Reply-To: <CALy3b+m7YkYB+mPEnAQnjKFAwUS_PqCUFtuxzN7hwhmNfMrw3Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249292>

On Fri, May 16, 2014 at 5:18 PM, Michal Stasa <michal.stasa@gmail.com> wrote:
> Hi,
>
> I have stumbled on a weird bug. At work, we use redmine as an issue
> tracker and its task are marked by a number starting with #. When I
> commit some work and write #1234 in the message, it works. However,
> later on when I remember that I forgot to add some files and amend the
> commit, vim appears and I cannot perform the commit because the
> message starts with # which is a comment in vim and thus I get an
> error that my commit message is empty.

A workaround would be "git -c core.commentChar=@ <command> ..." (@
could be some other character). But maybe git should detect that the
current commit message has leading '#' and automatically switch to
another character..
-- 
Duy
