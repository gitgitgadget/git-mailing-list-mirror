From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v4 04/44] builtin-am: implement patch queue mechanism
Date: Tue, 7 Jul 2015 20:50:16 +0800
Message-ID: <CACRoPnTf7BWeTQPjbS4QfwRCbuMAOzK6=cH=NPPi5ZABn6QyFw@mail.gmail.com>
References: <1435500366-31700-1-git-send-email-pyokagan@gmail.com>
	<1435500366-31700-5-git-send-email-pyokagan@gmail.com>
	<CAGZ79kYxFceV=w3CQ1xFsT0igy2g=DX2JiV2hwqVLxq-OJ1AOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 14:50:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCSKU-0002yZ-Jn
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 14:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954AbbGGMu0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 08:50:26 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:35880 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756906AbbGGMuT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 08:50:19 -0400
Received: by lagc2 with SMTP id c2so192418125lag.3
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 05:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nJs0IaopCrBXLyjKk04+VhlOLpSpnbB7br4QvKADiaU=;
        b=vNC3LwA2ZPx4Syn1UZ7seIyetlk/rKJ/mf8zhQiJgoXSrOh5JXyCrE6afPF015FiNd
         ILnHYqxNabZLgeuahn9uSUAaQgZXg+5qz+Z2e63NC7IiALZc7k7DUGws+NSpOoLYHrrw
         aMFR90zj/XWiC8hcyQWUxBxZEgQCvxLzj3453b//7Ol5115USE7FN1/UKbUGTTr+bnIl
         G5QOWPmVy8U4uq5R/cj8/TdtcqYhJEH0RIpMiPWxj+65Dts8+1QzkyeVe4BLu1GfkZIT
         0/g8QXBcaCacOplpXmVNXJOsaLK34mQCHsOlpRbSzJeL/iVqTsjhJa4T2hZzK4x67Q3n
         ZkEw==
X-Received: by 10.152.164.193 with SMTP id ys1mr3861950lab.65.1436273416511;
 Tue, 07 Jul 2015 05:50:16 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 7 Jul 2015 05:50:16 -0700 (PDT)
In-Reply-To: <CAGZ79kYxFceV=w3CQ1xFsT0igy2g=DX2JiV2hwqVLxq-OJ1AOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273499>

On Mon, Jun 29, 2015 at 1:08 PM, Stefan Beller <sbeller@google.com> wrote:
> (optional nit, bikeshedding)
> In conjunction with the previous patch I just wonder when we put a
> TODO and when we want to put a NEEDSWORK, or if we're being
> inconsistent here as both issues will be resolved in a later patch
> in the series.

That's a code style thing that I don't personally have a strong opinion about.

Not sure if the following means anything, but on master,

git grep '\bTODO\b' | wc -l
102

git grep '\bNEEDSWORK\b' | wc -l
45

git log -G'\bTODO\b --oneline | wc -l
185

git log -G'\bNEEDSWORK\b' --oneline | wc -l
120

So it does seem that temporary stuff is usually tagged with
"NEEDSWORK", rather than "TODO".

Anyway, it's probably better to be consistent, so I will switch to "NEEDSWORK".

Thanks,
Paul
