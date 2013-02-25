From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Add pthread support in QNX. Do not declare NO_ macros
 if they can be autodetected.
Date: Mon, 25 Feb 2013 20:19:00 +0200
Message-ID: <CAHXAxrO8c8=d+og7rJexY4MKyKMYrWAzFYLMLRKVqtoaB6DUdQ@mail.gmail.com>
References: <CAHXAxrPTe6Q4BPtsGjiRnfFjZjUjwY6qXSAtZCzzAthODzA6EA@mail.gmail.com>
	<7vhal0z4a5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 19:19:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA2eE-0008AF-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 19:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920Ab3BYSTD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 13:19:03 -0500
Received: from mail-qe0-f52.google.com ([209.85.128.52]:62938 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756577Ab3BYSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 13:19:01 -0500
Received: by mail-qe0-f52.google.com with SMTP id i11so1113381qej.39
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 10:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WzgR4MFbflbY0MVI2hzez5lwWolC/Omc7FtxzqcCbtI=;
        b=AjHid6wgHfYNp0V5vHBbR+7m5FzFPrc+sJDdmn8H1+eZvibJ88jLKhaj21wF1RrPBa
         5g6Lgc9RntG7CQyOg1jGRywYCSIvWKAQjnmX96o6YfCSann8AVnp9TPJ4gS1vzoKVIpl
         24/xlPAf76/vFBbS/Ckdih/icJqY2WfvAf1TJIjKShUBYYxQ42bQhC5VrJVFlVtA4tv8
         v8olRoUPjRbiqu0WDvIHXK0xKDx3MWWf2n2ZrRRtAhCjF5tvfkjhproKnWvjWWrJzXbl
         kNlF3804+z4otWft/7+5b79FJGP6OWVjUaO++7epuIBg8yEYvyblDFdTEl6RSPVxqbO6
         2HAw==
X-Received: by 10.49.127.199 with SMTP id ni7mr14569947qeb.17.1361816340548;
 Mon, 25 Feb 2013 10:19:00 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 10:19:00 -0800 (PST)
In-Reply-To: <7vhal0z4a5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217071>

> Also, please leave the "autodetection" out.  If it is common to have
> strcasestr (or any other) on a newer QNX, then not defining the
> symbol NO_STRCASESTR in this file may still be the right thing to
> do, but the justification for such a change should not be because we
> rely on "autodetection".  The defaults given in config.mak.uname is
> primarily for people who do not use the optional ./configure script,
> so pick the default to help the most common configuration for the
> platform.

I see. I thought configure is the only legal way to build the git and
config.mak.uname is used to override settings produced by configure.
But it works vice versa configure settings override config.mak.uname
settings. Please do not commit this patch. This patch brokes QNX 6.3.2
build.

> I'd rewrite the patch like the attached, and tentatively queue the
> patch to 'pu', but I do not use or have access to QNX myself, so you
> may have to adjust the default set of symbols and the log message
> and in such a case, please do re-submit a fixed version.

I will re-do the patch.

> Specifically, I do not know if "... and others are also supported"
> is universally true with QNX 6; if not, we need to define NO_* for
> them to help people who build without using the ./configure script.

Ok.
