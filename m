From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [PATCH 24/34] checkout: reject if the branch is already checked
 out elsewhere
Date: Sun, 30 Nov 2014 12:18:40 -0500
Message-ID: <547B5170.6050206@gmail.com>
References: <1417335899-27307-1-git-send-email-pclouds@gmail.com> <1417335899-27307-25-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 30 18:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xv895-0000mh-59
	for gcvg-git-2@plane.gmane.org; Sun, 30 Nov 2014 18:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbaK3RSr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Nov 2014 12:18:47 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:53422 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbaK3RSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 12:18:46 -0500
Received: by mail-qa0-f47.google.com with SMTP id s7so6145929qap.20
        for <git@vger.kernel.org>; Sun, 30 Nov 2014 09:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=vGqPVW1tAUpa0OMV/c+1XCjVeNuqS/29AMpirPWE0fI=;
        b=skSmoGsc1Vu1SErIYyURtLqj7KofbZUFMz0QpWuUTLtbpAlidtgjbCETbXmZLkMSx1
         w0uyx5a9G6XvODlD1TWhC9GRUED2h5W8diGH2FYHSyU92Z2LpIgu4YCEj/4IsDuaIzI5
         qScdrPJfoYbIgUUUAvex/r25Z4LnMDPnk5Hmov0TPbzP48465bshw0/Ia6r4CMSm83rg
         zOBWsPA31rCv5ucPJslBS4iOaRI4isloyg2VlnFs38kApWd1VGLobXwDY/f3fJvbsDqv
         9vlNsMxfV72BXtuD7bJxEIRwD3SXXenOF5TdHXzfrEI7Zm2LJRWCzSvwSZb9PKGcm2hF
         4MxA==
X-Received: by 10.224.60.196 with SMTP id q4mr79894874qah.63.1417367925746;
        Sun, 30 Nov 2014 09:18:45 -0800 (PST)
Received: from marklaptop.lan (pool-173-79-126-100.washdc.fios.verizon.net. [173.79.126.100])
        by mx.google.com with ESMTPSA id t44sm15022348qgd.39.2014.11.30.09.18.43
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Nov 2014 09:18:44 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1417335899-27307-25-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260452>

On 11/30/2014 03:24 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote=
:
> One branch obviously can't be checked out at two places (but detached
> heads are ok). Give the user a choice in this case: --detach, -b
> new-branch, switch branch in the other checkout first or simply 'cd'
> and continue to work there.
>

This seems too restrictive and is not "obvious" to me: I currently use=20
git-new-workdir to have multiple checkouts of the same branch, with no=20
ill effect. While those who do not understand what is going on=20
underneath might be confused by one checkout suddenly showing=20
uncommitted diffs, I don't accept that as a reason to outright prevent=20
such use. I suggest, at the very least, that this behavior be overridde=
n=20
by a --force flag?

Mark
