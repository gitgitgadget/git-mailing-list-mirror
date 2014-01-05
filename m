From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v3 2/4] completion: introduce __gitcomp_nl_append ()
Date: Sun, 5 Jan 2014 15:36:21 +0530
Message-ID: <CALkWK0=rrcTFdpymGB5QJhdLhYvm4FLMGurqugbCGvAdDKVhqA@mail.gmail.com>
References: <1388779022-14536-1-git-send-email-artagnon@gmail.com>
 <1388779022-14536-3-git-send-email-artagnon@gmail.com> <xmqq38l4n6h9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 05 11:07:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vzkc6-0007od-K7
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jan 2014 11:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050AbaAEKHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jan 2014 05:07:03 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42570 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbaAEKHC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jan 2014 05:07:02 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so17584479ieb.15
        for <git@vger.kernel.org>; Sun, 05 Jan 2014 02:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6l4bW1HUv3lbYWgn3CxyrRvfpEz3myoZ6RjmEwxSuTs=;
        b=qfSFH8Xfk56ztXLTyVflqerudkeuNA6IWldMqF6wEpd9EbiU9G7QU7euoS/mp9wHmi
         UZ2BOTvCyZp14EtoGWGZ0u31ulWHIblU6nhVwpBJ1x5yqW5CKq4kMu6yFvo7/u+bDJY1
         DIKdYeIDXWtH2zN0Gaa8DQ0un0lZ5Xq4YJqHRziscwrvt+aOmisJZ9Wdit/FqBz0Vz2N
         R7ejvBfrfN6UGI7GhtAMmaSFpFzHhNjHdu1G5wsCTYy6NGch+jPD69y/qKzKrVCQlImF
         XGvcj+4KuHtXWnzdq67hBQ/FOt6UudgGS9eIVkpiNCR97wQBqAI95Nvqsujm+doiY6d6
         vcDQ==
X-Received: by 10.42.40.83 with SMTP id k19mr71055577ice.3.1388916421166; Sun,
 05 Jan 2014 02:07:01 -0800 (PST)
Received: by 10.64.195.9 with HTTP; Sun, 5 Jan 2014 02:06:21 -0800 (PST)
In-Reply-To: <xmqq38l4n6h9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239959>

Junio C Hamano wrote:
> Is it because going this route and doing it at such a low level
> would make zsh completion (which I have no clue about ;-)
> unnecessarily complex?

The zsh completion only cares to override __gitcomp_nl () and
__gitcomp_nl_append (), without bothering to re-implement the
lower-level functions; so it's no problem at all. I wrote mine out by
thinking of a non-intrusive direct translation, while your version
focuses on eliminating duplication. I don't have a strong preference
either way, so I will resubmit with your version.
