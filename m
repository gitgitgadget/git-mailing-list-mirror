From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Running interpret-trailers automatically on each commit?
Date: Mon, 31 Aug 2015 10:48:24 -0700
Message-ID: <xmqqio7vwdqv.fsf@gitster.mtv.corp.google.com>
References: <55E07CB1.0@game-point.net>
	<xmqqk2sf2vic.fsf@gitster.mtv.corp.google.com>
	<55E09540.60805@game-point.net> <vpqmvx7ho5r.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 31 19:48:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTC2-0007Rm-TS
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 19:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbHaRs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 13:48:27 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34516 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753916AbbHaRs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 13:48:27 -0400
Received: by pabzx8 with SMTP id zx8so146312980pab.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wRCXSIwZbtbkTsk8y9odWiCtlb4POtYRsBUkZkJ8Pno=;
        b=kWUlnz1gLm3KeH3paxHq96wnGzurYqLu/mbZcpxGQ15QvQygp//nneXqh+GoJ5SLee
         6le6PJbBr7qcCCn1iFgmM7KZ1FnJXpxbM9DtRhgx+TyDzaZMlWcXQ12jJd1XVOMl0g9v
         h+w7UECXiSk8WixCnHdhqAxGYuOSOTwSQD2aBnYMRC+vWTO1Vh9haaAH937lrLxNaQ6A
         2J5vXm6sQTmqgB1gr5+FOaUq1fuT6ShR7jxvu05SLaPJ5guQZE7kaQDhq5SXok8Buu5j
         vBZ/RsEmMzgU+vwVf+EzAwYuwJLjSO9E1XVWLbXuvH6aBAqv08+bTnxAecOfEb253+ES
         6MMw==
X-Received: by 10.66.251.197 with SMTP id zm5mr39060492pac.157.1441043306725;
        Mon, 31 Aug 2015 10:48:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id u10sm15296068pdp.85.2015.08.31.10.48.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 10:48:24 -0700 (PDT)
In-Reply-To: <vpqmvx7ho5r.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	31 Aug 2015 10:12:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276897>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Jeremy Morton <admin@game-point.net> writes:
>
>> Yeah but it's kind of useless to me having it on each commit on a
>> per-repo basis (and even then, only with hooks).
>
> Please, don't top-post on this list.
>
> Actually, it seems strange to me to activate it on a per-user basis.
> Whether you add a trailer is usually a per-project policy. If you add a
> branch trailer in each of your repository, it seems likely that some
> projects you contribute to will be bothered by this.
>
> That said, I agree it would be nice to allow a configuration-based
> mechanism in addition to the current hook-based one we currently have.
> But no one stepped in to implement it until now ...

Certanly.  A new experimental feature is shipped in 2.2 timeframe,
so that people can gain experience with it and come up with the best
practice in their hooks, and then laster we may fold the best
practice into somewhere deeper in the system.

We are still in the early "ship an experimental feature to let
people play with it" stage.  It is not "no one stepped in to
implement until now", but more like "no one designed what to
implement".

And we still do not have a concrete design on what to implement on
the table.  "At various points in the codebase, interpret-trailers
is invoked with some magic parameters, depending on settings of
unspecified set of configuration variables" is not a design.
