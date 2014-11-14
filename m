From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: how to reduce disk usage for large .git dirs?
Date: Fri, 14 Nov 2014 13:32:09 +0100
Message-ID: <5465F649.4090906@gmail.com>
References: <20141113111444.GA15503@aepfle.de> <20141113114919.GA2737@paksenarrion.iveqy.com> <20141113120313.GB15503@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Olaf Hering <olaf@aepfle.de>, Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 13:32:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpG3C-00007J-3S
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 13:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965492AbaKNMc0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Nov 2014 07:32:26 -0500
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51319 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965171AbaKNMcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 07:32:25 -0500
Received: by mail-wi0-f172.google.com with SMTP id bs8so2495767wib.17
        for <git@vger.kernel.org>; Fri, 14 Nov 2014 04:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=cu+gbb8gzne7DqnyoEfBZjDh+aztkSIQR4wBzLcvuEA=;
        b=u3R3ywnbsecxmGoJItbMul3hCMFmLiwyA3FZ2UJPHOproBV4B0Fugnb/YI6MVtZ4Yh
         nTOwQdFWbcLKHKUmJZxljK9dTqhgEj33FU9wehfmO2iG9UMJTOg5cODw6YCg4p92bIjz
         NyKJPcTNirwbCWa30NHywXVZo0K7ni8lipxxraSaFpNe8x12FXLr9f7+rbKeW6vOvpp3
         yRiFHExYt3xNHYvYuwFyVp2ViQ21zSwsMeqcqTRsnt7WSDme6KE7CORQW/4yo1UNzUcB
         ckTGcRQZ+ccE0qdKg+fkPzzfnzkVMmCtZ4/CGvRaBm+eK+XFwPA29eyR/GpYgwQCyrtl
         G8kg==
X-Received: by 10.194.150.148 with SMTP id ui20mr13415016wjb.90.1415968344053;
        Fri, 14 Nov 2014 04:32:24 -0800 (PST)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id r10sm3267670wiy.13.2014.11.14.04.32.22
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 14 Nov 2014 04:32:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <20141113120313.GB15503@aepfle.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 2014-11-13 13:03, Olaf Hering pisze:
 > On Thu, Nov 13, Fredrik Gustafsson wrote:
[...]
>> Your setup looks familiar to me for a subversion user switching to g=
it
>> and trying to use git as subversion. The common usecase is not to ha=
ve
>> multiple worktrees but to do a checkout to the worktree you need to =
work
>> on. This is possible with git since it's very fast and I recommend y=
ou
>> to try to use one worktree.

> Switching branches will invalidate timestamps, causing a full rebuild=
=2E

Wouldn't a better way of solving "full rebuild" issue be to use ccache=20
or similar solution?

Anyway, switching branches invalidates timestamps only on those files=20
that change between branches -- it is to avoid unnecessary rebuilds.

You can always clone with --reference, and use alternates (alternate=20
object store). Just don't delete objects in repository that other=20
repositories borrow from; GitHub uses refs/borrowers/ namespace for=20
that, IIRC.

HTH
--=20
Jakub Nar=C4=99bski
