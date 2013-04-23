From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 2/7] rebase -i: don't error out if $state_dir already exists
Date: Tue, 23 Apr 2013 07:45:02 -0700
Message-ID: <CANiSa6gMA8ZHNjaGu+hG4HxUCa5g+s00E=kGMyqeSv5NNRCCeQ@mail.gmail.com>
References: <1366725724-1016-1-git-send-email-artagnon@gmail.com>
	<1366725724-1016-3-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 23 16:45:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUeT2-0003Ro-Ty
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 16:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754367Ab3DWOpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:45:07 -0400
Received: from mail-we0-f182.google.com ([74.125.82.182]:40298 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168Ab3DWOpF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:45:05 -0400
Received: by mail-we0-f182.google.com with SMTP id s43so673058wey.41
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SmODKCNx1agQJMxJMfd76AGVGtFCpAEPUrfAUU/oO4A=;
        b=reTZfaiPY3yM6iAcxifEJXlDXFDDbDAHMXHKYPvs6ogWwQS9MxQsOIVlJA7WllFaE1
         nRrA6NzTz88qcUurRo9lblZ1CMMhVPdc3tAflKf1sYAndvkd9sLoVALoqrSn8K9t/l2H
         tabYTEf8O4myHe9SADgv1HSvoCx2xN7icmU/uKMd5fwFcjxJPmYRdWjiJNcKDgccx9lt
         uXEsF7KvJqXzDuuJoHYHjets2XlyoVMABJQt1POzU15+p5DFRzPfmauIQIwqo6NsqH30
         WAvUQFsJQLjqjL3lATTnQd+f30BV1P1B6YgA9SEMipZthSSDQ6//5YrX7/gjqayja6Ir
         5eug==
X-Received: by 10.180.189.205 with SMTP id gk13mr75118465wic.25.1366728302774;
 Tue, 23 Apr 2013 07:45:02 -0700 (PDT)
Received: by 10.180.19.198 with HTTP; Tue, 23 Apr 2013 07:45:02 -0700 (PDT)
In-Reply-To: <1366725724-1016-3-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222167>

On Tue, Apr 23, 2013 at 7:01 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Practically speaking, the only reason why a `mkdir $state_dir` would
> fail is because $state_dir already exists.

Would we ever get to this point in the code if it already exists?

Also, I had the feeling that the check it might fail if the user does
not have permissions to create the directory. Is there always
something else that will fail first?
