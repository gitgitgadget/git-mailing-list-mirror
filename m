From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange behaviour of git diff branch1 ... branch2
Date: Sat, 27 Oct 2012 21:33:01 +0900
Message-ID: <4ecbe65e-4b56-4a49-96c3-1ea8b3f0c473@email.android.com>
References: <20121026212650.GB2612@pug.qqx.org> <CACsJy8CX4Wbf3Bqez2kcQ7NGYMkqXC8MK+=hrH4iaev+0ZrQ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org,
	Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 14:33:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS5Zr-0005TE-CY
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 14:33:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab2J0MdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 08:33:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:64956 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330Ab2J0MdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 08:33:09 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2480264pad.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 05:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:user-agent:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:message-id;
        bh=e+E8RCYQ4TaI0MpvrxniNWkeZL50MjH2fadjg0VApSM=;
        b=FncoHp3vcdo9SjiCpFgPgldKMDYIxOfsc+iNIUwnOblGFAd+jSBx6fqecfnhv9FlTY
         cDXiZDBn1AFFkReSlqmjFE5Vr3drDsDSE1J3LvDEthyxwzn5GpmtQDOPWSDpo0OTzGVp
         YePY8PbxR46gFxKIKwkNa+zdaB8NkfmQJ/nGXO8IdAEpSSl3OaGkCx9pM5ZP+trEABaF
         c0YstqWHVLrwBRnIjnr0+KBDDh6FMkotA83vm4UaSzuXoTGFSvWUpOX28RpcVLA6RDaR
         mChbMx5pV4sLzB9Oq1i0EAnVKuRcBmKBI7bvs7rHh5ytsNwr1BBdfQd6SgPzI37DJLV6
         l5Kg==
Received: by 10.68.231.3 with SMTP id tc3mr21105832pbc.89.1351341189228;
        Sat, 27 Oct 2012 05:33:09 -0700 (PDT)
Received: from [192.168.0.3] (61.245.104.144.er.eaccess.ne.jp. [61.245.104.144])
        by mx.google.com with ESMTPS id n7sm2640399pav.26.2012.10.27.05.33.07
        (version=SSLv3 cipher=OTHER);
        Sat, 27 Oct 2012 05:33:08 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <CACsJy8CX4Wbf3Bqez2kcQ7NGYMkqXC8MK+=hrH4iaev+0ZrQ8Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208506>



Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>
>Notice the --cc in the first line, which is combined diff. Usually
>combined-diff is between two points and one parent. Though somehow git
>passes 4 parents down combined-diff.c:show_combined_header, as you can
>see in the "index" line. I think we should fix rev parsing code as it
>does not make sense to pass 4 identical parents this way.

The two heads home from HEAD...HEAD the user has on the command line.

The user is getting exactly what she asked; there is nothing to fix.
