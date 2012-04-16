From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH i18n 03/11] i18n: parseopt: lookup help and argument
 translations when showing usage
Date: Mon, 16 Apr 2012 18:35:14 -0500
Message-ID: <20120416233514.GX12613@burratino>
References: <1334580603-11577-1-git-send-email-pclouds@gmail.com>
 <1334580603-11577-4-git-send-email-pclouds@gmail.com>
 <20120416175402.GV5813@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 01:35:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJvSS-00030A-D7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 01:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752964Ab2DPXf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 19:35:29 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55313 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab2DPXfY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 19:35:24 -0400
Received: by iagz16 with SMTP id z16so8099254iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 16:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=nRC9vqKgYViSoqvnCC3wyI9K1JWJqyvMZ20YbSRgFso=;
        b=yB6puFmaBDcalDs7Ar7ebyC1NzV4pGiAlkgesTgUFzVnkPekL99i3BNWbcu8WAJDqR
         q/5kGRgmhOosQpt962aOs7HsUpiNzR9hTuz8W7uXTMSMSR1l2t+QBwwsGUcPmRKMdyQ5
         8AGKoHHaIdqYwxV3UOYsdttqH8wBisWf8cJhgxZgCMTnoJYxJpHI3vPIxj/YRzz3Sa2G
         mFQAWun4qplq4fG9UdUjt+s173/pXpmp/e4pZtvor4b8QjNfGGf7mQnl0VALz/R7ZAGp
         dVZcq2I2FG6FXjap35yVXvs7DRwvLV7JCP48Q53yfOK6QIN8yLtj4bRp/jm0GOvOt9jZ
         Xtkg==
Received: by 10.50.193.199 with SMTP id hq7mr7354738igc.49.1334619323506;
        Mon, 16 Apr 2012 16:35:23 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id us6sm12766019igc.9.2012.04.16.16.35.22
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 16:35:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120416175402.GV5813@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195724>

Jonathan Nieder wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>> -                                   *usagestr++);
>> +                                   _(*usagestr++));
>
> Maybe this change belongs in a separate patch that would mark the
> usage strings with N_ at the same time. (*)

I missed that you took care of many of these (e.g., for "git apply")
later in the series.  I wonder if coccinelle could be used to make
the change everywhere at once.

[...]
>                                      Is there some easy way to catch
> strings not in the po template that are passed to gettext() using a
> variable (at runtime)?

If doing that, this kind of sanity check would help catch stragglers.

Jonathan
