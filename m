From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: 'git log FILE' slow
Date: Wed, 11 Jul 2007 23:33:41 +0300
Message-ID: <f36b08ee0707111333q38004cb5x152f25e2055e2796@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 11 22:33:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ise-0005CI-7V
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 22:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754809AbXGKUdo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 16:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbXGKUdo
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 16:33:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:39137 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915AbXGKUdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 16:33:44 -0400
Received: by wr-out-0506.google.com with SMTP id i30so923664wra
        for <git@vger.kernel.org>; Wed, 11 Jul 2007 13:33:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AgXGgMSICLEEVLQ3W9vd/Sl1dcyO54uJe+nyv5y6fZ+mR79qLIYZSRouyt21hgvg7GXq8DYeqpH4ikGqXqiWdXfwce76sz8n1hMcuva6PP5WBIOtAEIJY6UH0L511XJQJNLiV5lOmUEzJVim9fJX8Tb8b8pbMg7I/jrEtqj2Cwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VgO0Zj70BVwmGiY7f/nf/hlvEKw2Bh2P+X44SNauAer304z+WbTjFrwbkillYGRNPkJ07i1ZE+q6UnubGj90nQPraJ2+x3hVnqOZI6EAnSsUFTVDmlx4YIvPvAzcSnv/3IdW1VmEZKgA5jthJIV2xItnZhisA/ErXxc+dQUhdjg=
Received: by 10.142.84.3 with SMTP id h3mr434109wfb.1184186021998;
        Wed, 11 Jul 2007 13:33:41 -0700 (PDT)
Received: by 10.142.116.4 with HTTP; Wed, 11 Jul 2007 13:33:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52198>

[git version 1.5.1.3]

'git-log FILE' takes 10-13 sec.  What can I do to identify
the reason ? 'git log >/dev/null' takes 0.1 sec (cached).
On the cloned copy, the times are approximately same.

The 'git-count-objects -v' shows:

count: 9830
size: 241412
in-pack: 12080
packs: 18
prune-packable: 188
garbage: 0

The strace shows only thousands of sbrk during the 10-13 sec time
(after some initial I/O). Ltrace, I was not able to complete, takes too much.

Yakov
