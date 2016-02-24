From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of for-each-ref
Date: Wed, 24 Feb 2016 08:48:52 +0100
Message-ID: <CAHGBnuPcSFVknueuO5zTo9i956dZKyo+mXga9YCN8XByxZg=8A@mail.gmail.com>
References: <56B32953.2010908@gmail.com>
	<20160204111307.GA30495@sigill.intra.peff.net>
	<xmqqsi0xu2ac.fsf@gitster.mtv.corp.google.com>
	<20160212224048.Horde.IpOeDKLAMM4a11F2xyIeY4M@webmail.informatik.kit.edu>
	<20160212221639.GA27974@sigill.intra.peff.net>
	<xmqqk2m9ts91.fsf@gitster.mtv.corp.google.com>
	<xmqqfuwjngwy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>, tr@thomasrast.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:48:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYUBt-0003Md-5P
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757916AbcBXHsx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 02:48:53 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35349 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757625AbcBXHsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:48:53 -0500
Received: by mail-vk0-f41.google.com with SMTP id e6so9437755vkh.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2016 23:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NmIjQyCjhYR+KSjak/dl5Vy/7xS7ue/yO7soO/JhE14=;
        b=RSh63AkIfgQ4OA4h3TR0Wr+C30YxVFWt0g9szT2wwTJ/+x2rCYZZ+UNkCV8awCQ4Ob
         Fcuq930MJ7w5t3u77OuhZ/eVGUTiVaGhTGPeplUn/svXmFCy8iyl3aU0Kf+Bg8Ywl1Hx
         r6bA7YwgPgSk1akuwZLpgQqGo+fw8188NS3g9oHmSBxVn6BqbGvrVdgqqAP+OZHqGHVw
         1dY22oPTap3lwPSM6zg8P8ipadg6XkyzmEWlYE87GSx3X3XLuFkWbA3u72pJh8ZaLwip
         TkrSX8JNs6rdnAB+u33u8q+vD9HR7OJvPJ30SARgrU+zY/sGDWye0nIaBszTBJ4JIIfB
         luUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NmIjQyCjhYR+KSjak/dl5Vy/7xS7ue/yO7soO/JhE14=;
        b=Fiu+AqQccUstepRkZ1Btb6d3LQUvLGSGeKTSHAB8pztQrIUddyuptH9gCi/sTTroOr
         LFAhPF+jAlKdvuYBaFj2T0loIg/CUFeSi7D2inuHn0n/fTsjaoE5BpxebFyznfelAnwf
         K8thaa4Ep/PxfCXXRjkEb6U9HhyDkfrQRhanUFlW2avHWzFtn26iVNu/D9e4bptsj6JW
         agcDgexn/lvQkkmSuKyP+Kagf3s14r6pyg0V3KsNSMO5EgwP3hSKQ8UYfT08qZvTE7BR
         ePnbetnhhUSymOSPowCivj7Kk31reIfcWd3jRpmB4jLuWbNwLzXRMqq6VG9YPzFYK6/8
         NiyA==
X-Gm-Message-State: AG10YOQTfAPmtvLlfjtUXlIaBPFddZSjqLMRfP+vfw80TLWz0QevyU1QyXY9QT6hh4biU2rviEk5cWPJUAJlug==
X-Received: by 10.31.5.9 with SMTP id 9mr30403850vkf.109.1456300132261; Tue,
 23 Feb 2016 23:48:52 -0800 (PST)
Received: by 10.176.68.6 with HTTP; Tue, 23 Feb 2016 23:48:52 -0800 (PST)
In-Reply-To: <xmqqfuwjngwy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287182>

On Wed, Feb 24, 2016 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:

> So, have we decided to wait, or we'd rather apply the band-aid in
> the meantime?  I can go either way, just double checking as I
> noticed this thread while updating my leftover bits list.

Thanks for the follow-up, I was about to ask for a status update on
this. As my patch it ready now, and we don't know how long we'd have
to wait for the other solution, I'd vote for applying my patch.

-- 
Sebastian Schuberth
