From: Kevin Wern <kevin.m.wern@gmail.com>
Subject: Resumable clone
Date: Sat, 5 Mar 2016 01:23:04 -0800
Message-ID: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 05 10:23:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ac8Qj-000450-B8
	for gcvg-git-2@plane.gmane.org; Sat, 05 Mar 2016 10:23:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759182AbcCEJXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2016 04:23:09 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35837 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067AbcCEJXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2016 04:23:06 -0500
Received: by mail-oi0-f45.google.com with SMTP id c203so52842131oia.2
        for <git@vger.kernel.org>; Sat, 05 Mar 2016 01:23:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=O+ATPaNXRCLDRiImwyYZw+diaGjDEhPdzXUtTCAmb1U=;
        b=oeXnzT4fYTSXhBt090hl12C5OpX6zvG6LGxgtHItlAsDgMX5DKGeVHCQb2auQLpSmq
         W0hyuk+n/0HvSRt/HtPs5F+A6KXLi3sEgqNwZdzUaZgaMXdmSbkhalR/DmnjGAMj2HbQ
         kpiAGrXey1mmF5crbaKD6UVYGU4FnDpjnzhe6Vybah5OIv4KgwlRXSv+wTsZmjl2kf6E
         CCSZ/jQr5U1QeU0cTiZ5b7BZ5j+StWw79oyl6PIGnS8gQx1vOJuhTqLQS9h49AOb2JXA
         96W8uR3SJR/mP5x37Eea+4b5URyu1ymph6faSdmPYYaQdFf98sl9TtuOFm1S+SRnqBz5
         M5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O+ATPaNXRCLDRiImwyYZw+diaGjDEhPdzXUtTCAmb1U=;
        b=TsACvIqf6aEZ4gEEk14xMf9HTWrFMa6mpq2AE2fzoF16zRpbucswByK76dZRVQSaLk
         ZMLIFBjR445wzZjoVdWCnZ7Nr/dYhYRRhjMOqXIvKiH3c/emUyQHxpx9JVNWNbQtAh2K
         u1fG8EV/dSfHfXEkTIRSwZSiU3Y0VSkYq9HBDmlOgHaCEfnLLUC6L8MqO9vb9wkZXR5H
         fTAPG1adGN55XJHV11SrV0WDWQNcj+89bE7mKArBcc8iSZBpKHx93HhzQnDXze1e+PMG
         GVzjTqREL1p1gbpopiJuIxBnoIJCZAKMqQG/E98ogBcWw2RcOhg3w7eGIxLy0/XyI9lI
         M7ng==
X-Gm-Message-State: AD7BkJKMmax8nxPoa8i4ivsLgBIDJuQP3gx5wtLkpDqJCME0ZQVUXK4ArL3hicQ0a9jP0rTcBPcPRNZ/O9YyRw==
X-Received: by 10.202.48.130 with SMTP id w124mr8448123oiw.61.1457169784995;
 Sat, 05 Mar 2016 01:23:04 -0800 (PST)
Received: by 10.202.206.11 with HTTP; Sat, 5 Mar 2016 01:23:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288306>

Hey, all,

A while ago, I noticed that if a clone is interrupted, it has to be
restarted completely. When I looked up the issue, I saw that someone
suggested resumable clones as a feature as early as 2007.  It doesn't
seem like any progress has been made on this issue, so I began looking
at relevant code yesterday to start working on it.

Is someone working on this currently?  Are there any things I should
know moving forward?  Is there a certain way I should break
down/organize the feature when writing patches?

Any information is appreciated.

Thanks,
Kevin
