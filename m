From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/7] t5528-push-default.sh: add helper functions
Date: Mon, 23 Apr 2012 09:16:12 -0700
Message-ID: <xmqq8vhml8z7.fsf@junio.mtv.corp.google.com>
References: <1334933944-13446-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-1-git-send-email-Matthieu.Moy@imag.fr>
	<1335170284-30768-4-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqipgqlass.fsf@junio.mtv.corp.google.com>
	<vpqobqil9ml.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 23 18:16:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMLw4-00083h-96
	for gcvg-git-2@plane.gmane.org; Mon, 23 Apr 2012 18:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298Ab2DWQQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Apr 2012 12:16:16 -0400
Received: from mail-ey0-f202.google.com ([209.85.215.202]:40085 "EHLO
	mail-ey0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582Ab2DWQQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2012 12:16:15 -0400
Received: by eaaq10 with SMTP id q10so577751eaa.1
        for <git@vger.kernel.org>; Mon, 23 Apr 2012 09:16:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=tcoMg9s0tBY/+JZ72IORn/OPZrv6/DOBR09d6OjzR1s=;
        b=aX+9buo418LufyWNTJfjZPMs20jPyu5sZRd/jKq2ZNGMtWB8kwguo+G3cMgT0Y8V9w
         JRuy0kXGe4TK8br+F3Dbh7+O5Ki/rP41BLknez8MqIprUXbGEyvODc4/G1SwGlg7F1NM
         JmLccSVv8oD2zhmUroiQ7JPupC40nfkfYt3TljY3qjhptG942tM1nym37O3YY7ik+8o+
         ruDVhj2ARb/baH4elIeuiJPaREj1kW4Y4PGcQCKKPeVwGxQGWWgOBk6y86yZv79mAdfm
         T5tjf5dEWUMujwHPzKP8tU4HsdyvcY3Rusgfds0UUb1rCfwTaUDutQZT9AltHZ7iqzbf
         3y/Q==
Received: by 10.213.26.20 with SMTP id b20mr1286923ebc.12.1335197773964;
        Mon, 23 Apr 2012 09:16:13 -0700 (PDT)
Received: by 10.213.26.20 with SMTP id b20mr1286912ebc.12.1335197773836;
        Mon, 23 Apr 2012 09:16:13 -0700 (PDT)
Received: from hpza10.eem.corp.google.com ([74.125.121.33])
        by gmr-mx.google.com with ESMTPS id t8si10273991eef.1.2012.04.23.09.16.13
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Mon, 23 Apr 2012 09:16:13 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by hpza10.eem.corp.google.com (Postfix) with ESMTP id A24EB20004E;
	Mon, 23 Apr 2012 09:16:13 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 00935E120A; Mon, 23 Apr 2012 09:16:12 -0700 (PDT)
In-Reply-To: <vpqobqil9ml.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	23 Apr 2012 18:02:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmTMvrCDeNn3mBiol762kpuJhoydGAy9A9llv+2CJcmWavgjWYHkQEsIidcnxXqKHYMhb2tiRCRfiTrZzDDRRhWF/2ESDyh6O+6upodiPXraDRvfD0gwYW0kvaMnQRNFT4Fp+gJr/nIIWSeXt/rJIEdlaarK8/H9dxyLnZLsDC6orqIkgk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196138>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> ... and we can use --all not master here, right?
>
> Actually, we can even use --all everywhere. And then, we don't even need
> the second argument, and we can simplify greatly the function:

That did cross my mind but I suspected that the reason to have the
argument was because you would want to use the helper also to test
'matching' case where you want to make sure ones that the pusher does
not have are left alone.
