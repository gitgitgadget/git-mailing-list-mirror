From: Francis Moreau <francis.moro@gmail.com>
Subject: Question about git-cherry and the rev list it's using
Date: Wed, 11 May 2011 18:11:23 +0200
Message-ID: <BANLkTinMfVE=s+TouyxE-ucf7MHGf1m7HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 18:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKC0t-0004ug-Gt
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 18:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757174Ab1EKQL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 12:11:26 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:47683 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757117Ab1EKQLZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 12:11:25 -0400
Received: by pzk9 with SMTP id 9so305390pzk.19
        for <git@vger.kernel.org>; Wed, 11 May 2011 09:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=O75rKhwUeb/7cwDF4SqGMMlsBQFj0v7Xtdm/8+2KdPU=;
        b=vCLH41NZelG1m2mTKVLAyhbl268Hbz3XKJ0Tg80sZHkjfXd30MwV+Q1RfoPBkxOiwC
         pUCIEJN7OSepfa7jCuxM+GvExXH13UU5xz5L558nIu0LpcVHwpfQ1VmmilqJiwkk+ulx
         rkjs3ete57hZQY4/+0eeUJOZ77BKrA/PiMnjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vONibE014F7DjciY+rrPeXlt9gREoJLymQoUHhG+4OU4rGgTJpm5T0NMkyYlYw+hz+
         qedcrXJrkP6HDGSfevYydMe3dZf6CqbT0UUaT7RLt64vF1ni4YVN2N3xOZutVyz5kosf
         nVm6AearLKqkNWLKMoBdaSZffUPnOoTtUw1LQ=
Received: by 10.143.84.9 with SMTP id m9mr1436613wfl.53.1305130283660; Wed, 11
 May 2011 09:11:23 -0700 (PDT)
Received: by 10.142.77.4 with HTTP; Wed, 11 May 2011 09:11:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173402>

Hello,

I'm using "git cherry old master base" to see if all commits between
master and base have been applied in my 'old' branch.

So I expect that git cherry is using a list of commits given by : "git
rev-list --no-merges base..master".

But it looks like it's not the case:

  $ git rev-list --no-merges --oneline base..master | wc -l
  22

  $ git cherry old master base | wc -l
  12

Could anybody help me on this because I don't understand the results I have ?

Thanks
-- 
Francis
