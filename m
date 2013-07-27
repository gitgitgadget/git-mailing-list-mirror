From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] git_path() returns relative paths
Date: Sat, 27 Jul 2013 17:35:36 +0530
Message-ID: <CALkWK0k-23rTohYvNWP_XbuUCSGUE+G_e_7cBbPP5C9OzsJ4XQ@mail.gmail.com>
References: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Xin Jiang <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jul 27 14:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V33GR-0000X2-L4
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 14:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588Ab3G0MGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jul 2013 08:06:20 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:50612 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab3G0MGT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jul 2013 08:06:19 -0400
Received: by mail-ob0-f169.google.com with SMTP id up14so6395878obb.0
        for <git@vger.kernel.org>; Sat, 27 Jul 2013 05:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=gT/0RrCEW8xkP04GwzwhgxKUauIBECSaw6ISKmhTQwg=;
        b=cvwFVTsBjoxqDfWP4SZTglmXNDln1VLqeqMDtFLRAZhfOiZdsjLVU66eaZ+X2+U9E7
         i0p+8wdCVEYIQBVs/tOndqqa44u39jN/+ZCNHtnLOHWa3r4GFsQXlLH938/zVXnxDh3O
         5/4AbFwe0rZWHtYwK2v8hcx8iBV4mS+kUDPXAwrFJWg0wTkkKupk2+hRc1+biRgtg8QW
         0caKZ1kp/e2fZJz3rlTcqjGapapBzo9nUwpEhUHz0NlfDau+F6z7KFJ9x1t5koDQmqUt
         4S0XVGdMbnk8AzM7F9yVDlziZ8Pw+rjyne6wvsECpveyI1+yOw68jt5Qlk3bg3zLaB6A
         QVug==
X-Received: by 10.42.76.5 with SMTP id c5mr21065752ick.91.1374926776791; Sat,
 27 Jul 2013 05:06:16 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Sat, 27 Jul 2013 05:05:36 -0700 (PDT)
In-Reply-To: <CALkWK0m-4wtpTAcePPWFLT7iwXdcpp+nOy9oG2iFHLsp9XdKZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231239>

Ramkumar Ramachandra wrote:
> *scratches head*

Just took a much-needed shower and came back.  It was trivial to find.

  $ git log v1.8.3.4.. -- path.c

e02ca72 (path.c: refactor relative_path(), not only strip prefix,
2013-06-25) is the offender.
