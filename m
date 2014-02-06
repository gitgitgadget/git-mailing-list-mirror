From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] reset: support "--mixed --intent-to-add" mode
Date: Wed, 5 Feb 2014 16:08:15 -0800
Message-ID: <CAPc5daXvBPTVCUv=qO++kiOMQck1daTc_rmhpWrDk-KbTuvZOQ@mail.gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com> <1391480409-25727-2-git-send-email-pclouds@gmail.com>
 <xmqqvbwu8zjx.fsf@gitster.dls.corp.google.com> <xmqqeh3i7bxm.fsf@gitster.dls.corp.google.com>
 <20140205002725.GA3858@lanh> <xmqqob2l5vl2.fsf@gitster.dls.corp.google.com>
 <xmqqbnyl5sde.fsf@gitster.dls.corp.google.com> <CACsJy8Aj-5MzRjDxfWkOVtqxjo+w7v6uEjGfGAj_9s59t5eiYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 01:08:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBCWI-0000yp-Er
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 01:08:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbaBFAIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 19:08:38 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44095 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbaBFAIh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 19:08:37 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so917732lbj.31
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 16:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bWx8JFoYlw6IozAOSnp0lJLh9oct1sgfXE19Cgdjmz8=;
        b=PN8Cbv9pm9bNT0xBnlWsZJhbGIn4jmvN2slF7OXycsw1WMd7NLX5IMeeSJdzcpCRvJ
         FzbOcX3aJ3D0pwhE7xHQkkiYTVhuX71gz4a1eNq9u6my8QdnivwLfX3TrMaRhaEC7d9G
         X0mYGTmUDbY1kK+inQUGxQaKfkNvsuWg99bXtAdL2HEDHshM5JoUFTkPhww9sqpBFqDq
         jrkzDQAo9duZTKrn3kWMDQrpYNLFR4IFfBPLD4OignlFcZzztCR/79pEDZB3KOZPgfUp
         THXPGe3rfNrKT2WfD41WsV4Oiml72BGpGOHuDLosI3p0T1R+XBnM0BsMvXeKXN2oiFtQ
         8gnQ==
X-Received: by 10.152.6.199 with SMTP id d7mr3107436laa.22.1391645315882; Wed,
 05 Feb 2014 16:08:35 -0800 (PST)
Received: by 10.112.180.130 with HTTP; Wed, 5 Feb 2014 16:08:15 -0800 (PST)
In-Reply-To: <CACsJy8Aj-5MzRjDxfWkOVtqxjo+w7v6uEjGfGAj_9s59t5eiYA@mail.gmail.com>
X-Google-Sender-Auth: LtlCcW0z9-nppmEBRDio3A_7ty4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241679>

On Wed, Feb 5, 2014 at 3:48 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> No no. I found that duplicate, but I did not suggest removing it
> because it is needed there..

Hmph, if that is the case, we probably should make it the
responsibility of the calling side to actually mark ce->flags with the
bit (which would also mean the function must be renamed to make it
clear that it does not mark).
