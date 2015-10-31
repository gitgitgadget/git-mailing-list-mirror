From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH] checkout: add --progress option
Date: Fri, 30 Oct 2015 19:08:12 -0600
Message-ID: <CAOc6etZ+MeSuVDF6W4pefsxDDee3Dx3DikGxNA_X8-Qh3R9ZQQ@mail.gmail.com>
References: <1446168186-4730-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cTvRs_O8uY9_SrZZCf95Lraon8knkQUDgm0Lke3pve01A@mail.gmail.com>
	<xmqqh9l8kxa3.fsf@gitster.mtv.corp.google.com>
	<20151030193151.GB5336@sigill.intra.peff.net>
	<xmqq4mh8kv0e.fsf@gitster.mtv.corp.google.com>
	<CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsKea-0003h3-PS
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 02:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754408AbbJaBIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 21:08:15 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33595 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbbJaBIN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 21:08:13 -0400
Received: by padhy1 with SMTP id hy1so82722298pad.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 18:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=oQe4eYewlYnpu9zTRWsq9oq1/fnOmO6RpnNNzzsbnME=;
        b=ux5Z17jv9AZ8bu+Bstg06/L618ebAWMR1vHMy7s5CJ+WZKtMPoxRZKhaKPythTmRq1
         hVRap2N4jxL8theAXNT/Uyz8pZH7c8guHcdFtDK+TjTVvejVtqf9w0SBkreEMQk+Q0GC
         pNNpphwvIi0V2EfwFjxVrkC6kWV7TxcH5tWSFBhJWsdk/1E5GxxWY/mhR2tYvPdJO7zh
         ipo9ATOZwu064neTj87Wy3lOQOSfnf3u4LR3V3ATEDUFrlIBhb/+k3uCfCPsKAeeMP7O
         TaVadXCeiRTg4xsgR9vKtipbrg5TnKzqfpe1+fkZWFgkFMyb0rYNd+SN6x64KaXZQ6WH
         kMDQ==
X-Received: by 10.66.157.36 with SMTP id wj4mr12106978pab.36.1446253692937;
 Fri, 30 Oct 2015 18:08:12 -0700 (PDT)
Received: by 10.66.149.4 with HTTP; Fri, 30 Oct 2015 18:08:12 -0700 (PDT)
In-Reply-To: <CAOc6etYiqH8bvnCD_9hedzDW6fhknXLGesM6dX7S9DBB_r-9zA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280564>

One line got wrapped around, hope that's not a problem to understand
the whole concept.

> +/*
> + * Any of these conditions will make progress output be skipped:
> + * - selected --quiet
> + * - selected --no-progress
> + * - (didn't select --progress nor --no-progress) and not working on a terminal
> + */
> +static int verbose_update(const struct checkout_opts *o)
> +{
> +       return !o->quiet && o->show_progress && (o->show_progress >= 0
> || isatty(2));
> +}
> +
