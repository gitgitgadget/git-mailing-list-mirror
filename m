From: Lex Spoon <lex@lexspoon.org>
Subject: Re: [PATCH v3] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 10:30:27 -0400
Message-ID: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>
References: <CALM2SnZmCJ2nVqPyLiepF1zJH=S0BzCTM=-L6hnn8Vnrb+prCw@mail.gmail.com>
	<1429312285-13552-1-git-send-email-lex@lexspoon.org>
	<5534CC83.2000304@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Junio C Hamano <gitster@pobox.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkCiX-0002zs-28
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 16:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068AbbDTOa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 10:30:28 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:34051 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbbDTOa2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 10:30:28 -0400
Received: by pdbqa5 with SMTP id qa5so209262120pdb.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ez9QUVxx3kvSx7BOpBLquKkB4oQjVFZwJyj0VjDdAiU=;
        b=jscyyXwNK2uxv/ncOH3kvAH8Uy+EGErVKyQ8DGznAKiy+JiEUipTxkAIJ99qOMJ1WM
         xAwqcEBpgiG+gTT3wyIp8bt1Y/ZINDQq58w1M2y8vQOaKhxbmhiF1Fp7Zzo4RR0X/u5g
         U6Klgv5g/UZrEGkbk12v1V2Fd7rKhqtuB8vYtAfinS04Q2hjn1PApOGlxa+vIKzFSOU7
         uSVvxuN5CnsQLIUimUiq5IlkSzAAmPv/qv7eanueQ+nrhd/nKbasstPZiH2u5Vwg9Q2I
         gq5GjGqppelUrHKhBwjdeow6n4EISGjKeOnxt+WjeZrwhPe3+q2ez0Rva74aSjM/rbku
         UKfA==
X-Received: by 10.66.139.135 with SMTP id qy7mr28277997pab.144.1429540227596;
 Mon, 20 Apr 2015 07:30:27 -0700 (PDT)
Received: by 10.70.25.132 with HTTP; Mon, 20 Apr 2015 07:30:27 -0700 (PDT)
In-Reply-To: <5534CC83.2000304@diamand.org>
X-Google-Sender-Auth: HdwBo_IbKw0vMvniesp2zw9xr9c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267468>

On Mon, Apr 20, 2015 at 5:53 AM, Luke Diamand <luke@diamand.org> wrote:
> I could be wrong about this, but it looks like importNewBranches() is taking
> an extra argument, but that isn't reflected in the place where it gets
> called. I think it just got missed.
>
> As a result, t9801-git-p4-branch.sh fails with this error:

Oh dear, definitely. The argument can in fact be dropped, because it's
already already available via a field of the same object. I post an
update with that change.  -Lex
