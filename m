From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Sat, 15 Sep 2007 16:08:31 +0200
Message-ID: <8c5c35580709150708k5acdeabdh17fc7ef30ee3eb79@mail.gmail.com>
References: <20070906075104.GA10192@hand.yhbt.net>
	 <1189096669534-git-send-email-hjemli@gmail.com>
	 <20070906210155.GA20938@soma> <20070906213556.GA21234@soma>
	 <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com>
	 <20070906235516.GC4538@xp.machine.xx>
	 <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com>
	 <20070907084352.GD4538@xp.machine.xx>
	 <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Eric Wong" <normalperson@yhbt.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Peter Baumann" <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:08:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYK5-0007Hk-Nb
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835AbXIOOIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbXIOOIe
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:08:34 -0400
Received: from rv-out-0910.google.com ([209.85.198.188]:11831 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772AbXIOOId (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 10:08:33 -0400
Received: by rv-out-0910.google.com with SMTP id k20so910901rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 07:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0mdW7GwYG3CnIr3Svu4aZCBWrfBTQnBzyBVUOEnsLZ0=;
        b=EW6yEHkcbsY+HPAXRmO3DWMLZAYrJTF9UOGR8/bXAbbifF5KH12JgtS+WFNNjhZ+HQlK3GwNHw+xVyCRkgY0Gbm8EFlu4W315W/WexwzyacRyIQRdnBFbAhvS//eWH4mOBVj1mGJODvr+DtyxOX5KL3EvPD1YnbaVGp75c/KjVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nkBwzVqd+VgUDZSql/xSTylgelDyfgvtNBj/PQh0oMul3QXsQJVW4WfNyVFBAHPKNyupsMk8j/vpCA8k4XpUPSHi3CeZREBIcMGAb/4CCqZvdZCctjLA4V/6+jKGbjvoRnzVQCFQX78SrT4FGCQxPUEoj77jJl5DB2z5VE2o9cg=
Received: by 10.115.47.1 with SMTP id z1mr541428waj.1189865312001;
        Sat, 15 Sep 2007 07:08:32 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sat, 15 Sep 2007 07:08:31 -0700 (PDT)
In-Reply-To: <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58243>

On 9/7/07, Lars Hjemli <hjemli@gmail.com> wrote:
> On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> >    lets reset 'trunk' to its state before the merge and
> >    'branch1' to the merge commit, before fixing the bug in 'branch1'.
> >
> >        a-b-c-d-e    trunk
> >           \      \
> >            \ -x-y m branch1
>
> Yeah, this would certainly not be handled correctly by dcommit using
> --first-parent (but it could be handled by (a correct implementation
> of) --upstream).

Actually, I don't think there's any way to handle this correctly. The
current git-svn will do the right thing except in cases like the one
you described, and in these cases it can be _forced_ to do the right
thing by editing the grafts file, so I'll drop the whole --upstream
idea.

--
larsh
