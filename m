From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 1/4] remote: use parse_config_key
Date: Tue, 16 Feb 2016 01:13:27 +0100
Message-ID: <20160216001327.GA1831@hank>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455575984-24348-2-git-send-email-t.gummerer@gmail.com>
 <20160215230443.GB30631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 01:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVTH3-0002vB-2R
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 01:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752853AbcBPANF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 19:13:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34591 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbcBPANE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 19:13:04 -0500
Received: by mail-wm0-f67.google.com with SMTP id b205so10809544wmb.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 16:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hBKovQ+cMGkMXAv0avVptWYt5Pf2kI4ZQi0FPXV0HQ4=;
        b=ViTnyjER4LWD5tZIsy8CL0cYJ1P8GeuznqWbUMm2W4zE1P176raufLQmbI1boNzKp+
         vb4GtkwD48Q8BnhuDbLGbe6L+gIojRahBdgTUIEEsgv1eWltHii3YVfO8Q4QH9qvKTPe
         oVhYSlf1m04A1LyAAc1vru5iu+hvcM5iZBbVeYRFvfuB4MZiHucVsio3KT7xLEZaH9vz
         SkZT4OsGAnRztn6hi+4vMvZenLjyYIQ2qBcISOliDuAHRkpGdMtZdA8jdUv3pYqpIQIw
         vUWWYmbhiac3GOo1wmSYBf1HmxoayxZPC8jAX0l6yjxrjxCXuOpFleco5XkQHe6OcIPr
         jvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hBKovQ+cMGkMXAv0avVptWYt5Pf2kI4ZQi0FPXV0HQ4=;
        b=Gx8mbQwHV6TvC3gfMQDLz4JCADyBxIPPzaz5Ioq7WaSGPWCnpPfkvX1lITh9RYlB6z
         h1WEzo9aduyuCn634sSpLX3p9YOsZlJriIqoEw2EM4f8CBhm1zy+95pL8i7tSmSLEPQV
         B6VIRw1Z+nexPRFxiHCjfaTaBXo63wFJGpJbVjwb7PCUTjIdb6slvd9EEJZ3gEU7425m
         ZngqWVZp7kvgc4W/rLvKKlyJYsU5VbDCqijZQ1R8guoZgnKhMg/xQCaIVNt6xaiPNvE1
         mHl/HpE8Xog5JlOa+ADZ6tR/skbX8xbX40EcTABbykpimCuge9eoet5qoCbRYxeo0T0G
         xerQ==
X-Gm-Message-State: AG10YOQlm0/HQ6vUdNHF1fiOmLtk1V7B0iaf8dX0nCVbfpQuctaTxuCbtsMlB59CeWxtjA==
X-Received: by 10.28.215.16 with SMTP id o16mr14934986wmg.57.1455581582641;
        Mon, 15 Feb 2016 16:13:02 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id i10sm17943070wmf.14.2016.02.15.16.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 16:13:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215230443.GB30631@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286294>

On 02/15, Jeff King wrote:
> On Mon, Feb 15, 2016 at 11:39:41PM +0100, Thomas Gummerer wrote:
>
> > -	if (!starts_with(key,  "remote."))
> > +	if (parse_config_key(key, "remote", &name, &namelen, &subkey) < 0)
> >  		return 0;
> > -	name = key + 7;
> >
> >  	/* Handle remote.* variables */
> > -	if (!strcmp(name, "pushdefault"))
> > +	if (!strcmp(subkey, "pushdefault"))
> >  		return git_config_string(&pushremote_name, key, value);
>
> I think this needs to become:
>
>   if (!name && !strcmp(subkey, "pushdefault"))
>
> so that we do not match "remote.foo.pushdefault", which is nonsense. The
> original avoided it by conflating "name" and "subkey" at various points,
> and not parsing out the subkey until later. Making that more explicit is
> one of the things that I think is improved by your patch. :)

Good catch.  I'll fix this in the re-roll.

> >  	/* Handle remote.<name>.* variables */
> > -	if (*name == '/') {
> > +	if (*(name ? name : subkey) == '/') {
> >  		warning("Config remote shorthand cannot begin with '/': %s",
> > -			name);
> > +			name ? name : subkey);
> >  		return 0;
> >  	}
> > -	subkey = strrchr(name, '.');
> > -	if (!subkey)
> > +	if (!name)
> >  		return 0;
>
> I think you can bump the "if (!name)" check earlier. If it is empty, we
> know that it does not start with "/". And then you can avoid the extra
> NULL-checks.

Thanks, will change that.

> The rest of the patch looks good to me. I hadn't realized initially that
> all of the subkey compares would become "foo" and not ".foo". That makes
> the diff noisier, but IMHO the result is much better.
>
> -Peff

--
Thomas
