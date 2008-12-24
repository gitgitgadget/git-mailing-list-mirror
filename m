From: skillzero@gmail.com
Subject: git rev-list with --name-status?
Date: Wed, 24 Dec 2008 14:53:00 -0800
Message-ID: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 24 23:55:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFcdh-00013F-85
	for gcvg-git-2@gmane.org; Wed, 24 Dec 2008 23:55:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbYLXWxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2008 17:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYLXWxE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Dec 2008 17:53:04 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:61779 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYLXWxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Dec 2008 17:53:03 -0500
Received: by gxk6 with SMTP id 6so2705699gxk.13
        for <git@vger.kernel.org>; Wed, 24 Dec 2008 14:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0sf1EhXGWUOuCMbOil4IS5AFZAoVzi71D7pmp2A98Ag=;
        b=ldV7i5PnemDcJtV6I0RUysTVNFKjOlCWXXvdCO6S82nI30SARFU+Kt+5jlW8aLLz2u
         JT/16nswCnoltjEN//RwHFnact/iG52ZJk0Jt9K08y4KRNhShii9rLoppiI+3Z2rstGg
         T4YrRKjGcNtNUb4LwjwPGgvVaAzRBkfBbyi4s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=VGxoyxq65P2+JSemlLMKbQCx0pPa3s4gAKf+I37RvD2qXk4mxXyJCGvXk8cXU/I1bv
         aJTGF0DKuHxjHcLGuic+q74OFha6e0QkzMEFiSSwYvASUi3WcK5MesKmit6E5bMIGvV2
         3NAXcUV/Q0+J8eKP4tK4A8FdUHRqIZthCZeQM=
Received: by 10.65.96.17 with SMTP id y17mr7202793qbl.2.1230159180374;
        Wed, 24 Dec 2008 14:53:00 -0800 (PST)
Received: by 10.65.192.6 with HTTP; Wed, 24 Dec 2008 14:53:00 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103865>

Is there a way to print the equivalent of --name-status with git
rev-list? The post-receive script that comes with git for sending
comment emails does this to generate the commit log:

git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
	git rev-list --pretty --stdin $oldrev..$newrev

I'd like to also include the output of --name-status so the email
shows which files were changed by each commit (rather than just a
summary at the end since our pushes sometimes have a lot of commits in
them).

git rev-list doesn't seem to support --name-status and git log doesn't
seem to support --stdin. Is there a better way to do what I want?
