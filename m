From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/23] Introduce "skip-worktree" bit in index, teach Git 
	to get/set this bit
Date: Tue, 15 Dec 2009 10:51:11 +0700
Message-ID: <fcaeb9bf0912141951l5bbb4baanb991354aa3f11ae4@mail.gmail.com>
References: <1260786666-8405-4-git-send-email-pclouds@gmail.com> 
	<20091214230619.GA30538@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 04:51:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKORm-0002nt-WC
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 04:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758096AbZLODvc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 22:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758022AbZLODvc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 22:51:32 -0500
Received: from mail-px0-f174.google.com ([209.85.216.174]:62923 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342AbZLODvb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 22:51:31 -0500
Received: by pxi4 with SMTP id 4so2299731pxi.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 19:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8GI4nx4uzeynAHDGSMqNlOqU9oPMCbgJc94K8U+GydU=;
        b=NmtRix+OrUW+Cq5vhgWETzu6D0xpud05QFuLr3VSkDMcxsupvgrAtQ2bFt+sOVN2BJ
         JBBVIXZLI7izu6exHGe1QbXsI+iliNRulb4aDBaEFxqdKUhKnWu/AUwWeo/GYuM58V3C
         b8zJAjDMr0upGpoO2O65dmV/aqjGH/mQW6njQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=qrHzonm4g1uYUnL4tBUugwp09Mc/WkyicS6/HVHMd1szaU7/A6CGOzQSRx6+5nzrv2
         AWhtIeLZvVumGOjLMGCEIg29aE0LSBS8rpHikv25b+ERiDKjIDg44tL7Mv1yZwFvo9yT
         6YePJxO/+CoQTb1hoGyWirdYQvToleXsdVaH4=
Received: by 10.114.6.25 with SMTP id 25mr3921463waf.25.1260849091118; Mon, 14 
	Dec 2009 19:51:31 -0800 (PST)
In-Reply-To: <20091214230619.GA30538@dr-wily.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135267>

2009/12/15 Greg Price <price@ksplice.com>:
> I confess I can't tell how the skip-worktree bit does differ from
> assume-unchanged. =C2=A0Is its 'goal' different only in that you have=
 a
> different motivation for introducing it, or does it actually have a
> different effect -- and what is that different effect?

On the fun side, you could use both bits in the same worktree, to
narrow your worktree and have some assume-unchanged files.

Another difference is that with assume-unchanged bit, you make a
promise to Git that those assume-unchanged files are "good", Git does
not have to care for them. If somehow you violate the promise, Git can
harm your files on worktree.
--=20
Duy
