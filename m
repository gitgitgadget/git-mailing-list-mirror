From: Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] Makefile: default to -lcurl when no CURL_CONFIG or CURLDIR
Date: Mon, 28 Apr 2014 13:56:14 -0700
Message-ID: <CAD0k6qRgLfgCTr=Erc=TxJ7_cnSuQLo+swv6Y=Z6-OqEzs=Hwg@mail.gmail.com>
References: <1398714653-1050-1-git-send-email-dborowitz@google.com> <xmqqlhupp4hx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WesbR-0001dV-UB
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:56:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbaD1U4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 16:56:38 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:44117 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbaD1U4g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:56:36 -0400
Received: by mail-la0-f41.google.com with SMTP id el20so3163386lab.28
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 13:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Mxkg3BHqFs4LSXSeET1k5u14+QQK+OI7QnzkpM0tZ/U=;
        b=NFnZ3qweK45fRnkmHjMdP94P42QbdDlya4YX+CbcENYb47/7Sxhck/fXDao/H+hg4M
         6rStcwKu4BcYATrv/qsKElCw9JKwEimlsOR2K8G2KsFp4cSQZlTwr9wExmtblLBrs0E6
         TppjChHn9wVUtnvgOo9baWOm2P1WDv/hKmxfRriw72LIJslPc32M22+YsjbP1q6llozk
         1+HJ7JnNZ0Sju63Jn0o4rg92czexvceXfBK7p1LiE5fD5A459oB2Q6uD2ZZIa79Ebckz
         dKBlfKHb6q3fRgj3Vfoe6W5ZIcPdfcipo2XnR8hroGhSnsZ3qDVCgEN4hvuo+ID1CuW9
         d+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Mxkg3BHqFs4LSXSeET1k5u14+QQK+OI7QnzkpM0tZ/U=;
        b=IaHpKOKN6a4dNO9X8w53BScrZASRRcqqoYBaSg3XsssV4nMg1yCWzfEEMkoLF4KlHP
         HPX4dMwit+ob4/b9flSYhrjZkYxQ6tL+ui+TbcJsYC0v1n0NghWKQBiIt98CF0nNwB6T
         TNs7KKjGuep2sjBBKAq5BaeLv/+OqwfNb9qmPS/uz1t9UW+2QQHNY9/f3ZTIaiDszq3n
         PmbJvJ1/7XMWTcL7ZAlH6xanlE7SRS+iQjq+zKNLwqZ1bsOOwz7JXjSsqQNi2dOiKCuK
         T1Sbkzc1KRmcka5ZQjrbQBwECNCJaWXoGRR90MWBj9dDErzzWsR6rSy8xygmk9xVoIAA
         92DQ==
X-Gm-Message-State: ALoCoQkai+h+/4bj9rolP4dcqHTrkjbZjuL4llUreWBWhCDx3vIaSnLauXvfo8w+Ko1Dke9D0yZA67pV/jh4b2Qo2ny1/1HN6ro9VqcKG8ZM/4jSeV/n5uQfomvZiPvGP4CM1Ri9ByvZVxbBDqORlXaffo9uSdFrfuEw2Jaduw6lXMCU0QL18easbiJqchyZ5PB+Nk9no8aA
X-Received: by 10.152.21.200 with SMTP id x8mr20200lae.58.1398718595064; Mon,
 28 Apr 2014 13:56:35 -0700 (PDT)
Received: by 10.112.184.227 with HTTP; Mon, 28 Apr 2014 13:56:14 -0700 (PDT)
In-Reply-To: <xmqqlhupp4hx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247450>

On Mon, Apr 28, 2014 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I still think the implementation of "If CURL_CONFIG is unset" bit is
> a bit redundant, though.

If CURL_CONFIG is unset, then $(shell $(CURL_CONFIG) --libs) produces
"make: --libs: Command not found", which may be confusing.
