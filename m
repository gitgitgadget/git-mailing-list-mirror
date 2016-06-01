From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 1 Jun 2016 16:59:34 -0400
Message-ID: <CAPig+cSERmvSRhLYfNpTUu-SfFwhAzxfUh4XTZKUbARAu5rpdg@mail.gmail.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
	<xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
	<xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
	<20160601163747.GA10721@sigill.intra.peff.net>
	<20160601183100.GN1355@john.keeping.me.uk>
	<20160601190759.GB12496@sigill.intra.peff.net>
	<20160601191621.GO1355@john.keeping.me.uk>
	<xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
	<20160601202852.GP1355@john.keeping.me.uk>
	<xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
	<xmqq37owy6fr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:59:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DEq-0006rl-Df
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbcFAU7g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:59:36 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34253 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbcFAU7f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:59:35 -0400
Received: by mail-io0-f174.google.com with SMTP id p194so29299322iod.1
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 13:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=GAOLqc0pOJXMUMewEV11kMfXb3jnP7aEotsssOJya7c=;
        b=T95IFjaoQJVjRyAH4zAserHTTAQLDP0NZ64L0UkgltmtOLx6XnTRSjvlseBuVaVoBZ
         byAQMgx4KUYKamuJ/QxRm0I+V1HAzxvf1004OGlIXul6HPELw6mzW9uMCoGoen2B8R2L
         klj1Bb5t9BBtYHMu8mqZ8GDUiAKhoZ6JOUdwNRQSd6ohk5CY0yuvT0PCjJuMLlgZPzMh
         3/cvwoUlH+B1Pw1ZSNr5+Z//bqVkS7ABgy774UikialT6XWdNqexk9YbAnzxJ/GQgg1V
         vXakZxLDG5b//rsTPknesVhMCKW/uRuzHYBdbCAkkQV+4PWmtF9qc+sZjvgaVBW/PXQM
         at5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=GAOLqc0pOJXMUMewEV11kMfXb3jnP7aEotsssOJya7c=;
        b=eoJ/gTiUKqECi5djRddvso1iYiqfSw1nPyIaE1ian3ZloyM6mrORGwcjwwz73NupwV
         8IgIt9Dr2e0Nlr4in0a9ddGuDfm7LNRH98N2urwPNxZLRlGiA/KTk4qK0OLbXx60+B0E
         w/lAE9noU7cBqKTrrQIxILVQ0i0xdJ8twwIG8f6NwwGS/kQjLgBSICNvBERHeuHMaugQ
         CgVSEfk9DM07Sn14cjrrRHY2XhRFoyvmcDkhcA8WEv5gEow2AygsGKTOvin3CaUb4cxg
         mId277u7E7k57CVvC1eB8y+Ye0ANfVgH07+b9eV2633aBuOzHFrkYBRWCfb7ZiLZBReF
         YxLw==
X-Gm-Message-State: ALyK8tLTySg7K/9pH4hYRri7VLNj2ImQoI16SxD6KJviXopYtU8ypm+9ZJl1UA1C+Jxq2DdLGxdVYE6Mm0HvAg==
X-Received: by 10.107.132.40 with SMTP id g40mr7548264iod.34.1464814774872;
 Wed, 01 Jun 2016 13:59:34 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 1 Jun 2016 13:59:34 -0700 (PDT)
In-Reply-To: <xmqq37owy6fr.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: 9xO-Ya3FMeR4c0FzfDnaVOYUW7U
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296163>

On Wed, Jun 1, 2016 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Subject: [PATCH] t5500 & t7403: lose bash-ism "local"
>
> In t5500::check_prot_host_port_path(), diagport is not a variable
> used elsewhere and the function is not recursively called so this
> can simply lose the "local", which may not be supported by shell
> (besides, the function liberally clobbers other variables without
> making them "local").
>
> t7403::reset_submodule_urls() overrides the "root" variable used
> in the test framework for no good reason; its use is not about
> temporarily relocating where the test repositories are created.
> This assignment can be made not to clobber the varible by moving

s/varible/variable/

> them into the subshells it already uses.  Its value is always
> $TRASH_DIRECTORY, so we could use it instead there, and this
> function that is called only once and its two subshells may not be
> necessary (instead, the caller can use "git -C $there config" and
> set a value that is derived from $TRASH_DIRECTORY), but this is a
> minimum fix that is needed to lose "local".
>
> Helped-by: John Keeping <john@keeping.me.uk>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
