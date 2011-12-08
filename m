From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] index-pack: eliminate unlimited recursion in get_delta_base()
Date: Thu, 8 Dec 2011 18:06:27 +0700
Message-ID: <CACsJy8Dr14ek-Fv4a4eAo_QRHyHrg=2X=YaMRy1z8UXRdcescg@mail.gmail.com>
References: <7vvcpthh97.fsf@alter.siamese.dyndns.org> <1323280223-7990-1-git-send-email-pclouds@gmail.com>
 <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 08 12:07:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYboo-0006yg-A9
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 12:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab1LHLHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 06:07:00 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55428 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922Ab1LHLG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 06:06:59 -0500
Received: by bkbzv3 with SMTP id zv3so1470506bkb.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 03:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tGcQRJ97QwHVse3Q6qHcgma27/s+iWc1Mi6Qlag8jCI=;
        b=RnWadeloPFOBYpXfcV7bEkYqQFmMBoehQOGGLvZkZEs4dZDfcRiuq6YjMCpisLpsnd
         tNZxN8lcBGK9P+6PSLh6NuMTxWSOPS5NMbT3xLIxL3hXoRHaHPuXaZbQS3oetL+/mNR5
         v5D4+quM1kpdqdO/OObGIzuBK62E0X5mg/tsA=
Received: by 10.204.148.77 with SMTP id o13mr1139627bkv.97.1323342418331; Thu,
 08 Dec 2011 03:06:58 -0800 (PST)
Received: by 10.204.129.205 with HTTP; Thu, 8 Dec 2011 03:06:27 -0800 (PST)
In-Reply-To: <CAJo=hJvrk3Jzg3dQhQnfbmKAFovLuEtJAP4rakHPFeuZ0T5R7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186547>

2011/12/8 Shawn Pearce <spearce@spearce.org>:
> I think you missed the critical recursion. The real work is the
> recursion within find_unresolved_deltas(). This little helper
> get_base_data() shouldn't be tripping over these cases unless we have
> run out of delta_base_cache_limit and released objects near the base
> end of the delta chain, in which case this will restore them.
>
> Maybe this is useful on its own, but in my opinion its not an
> interesting patch to consider without first fixing
> find_unresolved_deltas's recursion.

Thanks. I missed that function. Will try to fix it.
-- 
Duy
