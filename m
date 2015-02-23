From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [cosmetic bug?] needlessly(?) executable files
Date: Mon, 23 Feb 2015 09:21:03 +0100
Message-ID: <1424679663.30155.30.camel@kaarsemaker.net>
References: <1424540917.15539.24.camel@scientia.net>
	 <xmqqr3thwzur.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 09:21:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPoGO-0006zA-TA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 09:21:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752402AbbBWIVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 03:21:07 -0500
Received: from mail-wg0-f52.google.com ([74.125.82.52]:63887 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbbBWIVG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 03:21:06 -0500
Received: by mail-wg0-f52.google.com with SMTP id x12so23992193wgg.11
        for <git@vger.kernel.org>; Mon, 23 Feb 2015 00:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=3zf1pOLYq+RDHDu/QxJq9EPU/z9YTl5F8Fy7HdTbR58=;
        b=RdirvXlOt6AhblVCiVkA8YiW9mrJlNmEDeiO9EMURpde4BZSfEBW0O5sDSzZ0HkyJt
         7j5CWTnrzpl/cEEDb82wcPdGsmWKpJTrvdAxuKq9vAzdLgGN+gcFwjW4SgeOq3gtiAul
         cBc8VFaY/MK+3n9WL4kSga0JroORsWOfKBHukKIRz00OBoW2gXZhMtzsS0fSe9RsW/MP
         1cXVBw2sZJIAGsAAH4c1xivPx0W1w7ZU4IlqRz8k6KfaS06MzhTsRpZJuc7/z4xBlI4S
         kOc31FqdDr3lFEvmKogKTP9Jm4sAccL/wWPoltmNHJlU3FBcuOqR//sPV1MAW9k2l10M
         A8RQ==
X-Gm-Message-State: ALoCoQkyqV//QrvtKJPYCsGvjG8024+P1OqsKYet08SGs8bllSrQvnxeIngrBwyVUQl73ILyUQeL
X-Received: by 10.180.73.205 with SMTP id n13mr18102660wiv.64.1424679665433;
        Mon, 23 Feb 2015 00:21:05 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id v7sm54455673wju.22.2015.02.23.00.21.04
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2015 00:21:04 -0800 (PST)
In-Reply-To: <xmqqr3thwzur.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.7-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264250>

On zo, 2015-02-22 at 10:44 -0800, Junio C Hamano wrote:
> Christoph Anton Mitterer <calestyo@scientia.net> writes:
> 
> > Just a question about files like:
> > .git/config
> > .git/hooks/*.sample
> >
> > Is there any reason that these are created executable? Especially
> the
> > config file?
> 
> In a new repository I just did "git init", I see this:
> 
>     $ rm -fr stupid
>     $ umask 0027
>     $ git init stupid
>     $ ls -l stupid/.git/config | sed -e 's/ .*//'
>     -rw-r-----
> 
> So no, config is not created executable.

It used to be for a brief period in history, between daa22c6f8d (2.1.0)
and 1f32ecf (2.2.2).

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
