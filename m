From: Dan Aloni <alonid@gmail.com>
Subject: Re: [PATCH v4 2/3] Add user.useConfigOnly boolean for when ident
 shouldn't be guessed
Date: Fri, 5 Feb 2016 08:47:54 +0200
Message-ID: <20160205064754.GB15392@gmail.com>
References: <1454577160-24484-1-git-send-email-alonid@gmail.com>
 <1454577160-24484-3-git-send-email-alonid@gmail.com>
 <xmqq8u30gn1m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 07:48:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRaBW-00040g-Md
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 07:48:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbcBEGr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 01:47:59 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38252 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcBEGr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 01:47:57 -0500
Received: by mail-wm0-f44.google.com with SMTP id p63so13305208wmp.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 22:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Y7PDN6o39xXC0iQoURdexQShoTKiZYPGpW+Ao15pr9A=;
        b=AvlWdjSHMIV03fx2SYiQFAnB7GWPjk45KXkUBpzuXbpdEp4hGzYxj1rqiWj64dQHte
         aQuRe/n/bx1+yQY9qXwMai9aN08OhE72sL3/dKzrEXDgpn6A8TfsxfNc3Q9T6oAucnqi
         8vzsMT6R2x5R++RAZ8wmJxgdepz2amphnCDL2k+mpy4W4ln4sUfO41R2M/eJAth5yoF4
         Xj0PcuaiO4jcRX/J3WhZ1aKsx9+byBcCjyDaYZpPfKtgkhE+bAKutznZGPBSi7lA4xoO
         qIdSHZItMLjuODtDYj6TNdd4oQp1WxeKADopn4hgGBP/fxkzmxrT3oRb0/4aV2ePQns4
         zG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Y7PDN6o39xXC0iQoURdexQShoTKiZYPGpW+Ao15pr9A=;
        b=fIPklt/Pg8jRwvMIzesLQK5E4Jall8EE+NJR8kd75eB/R7Bhh63UizukP2JQjxtl1f
         PPDXUyKupjpA7r4szUUCHlmDTIkV9/lxGcsQd3pYB8IrQoNC1inhcz13eirB0OmDd5Hz
         UMTKvbl7yqUQORVpu+Fx+mmD4+OSZbT3qtleFjS8Ych6IphVl1zgnh7iQSx7kI1SHOgI
         pVrZQNS2C/6JBw39ZExWkTneJqo1hgQzuJvsCWGb00WmkqP5t49Ni7hLOS4qLVDbBSsK
         MiwRSDsKZsFHdFQiyaKcqhSSiw8ugQLnCN9dEKs99pvzmY3t2VvHfi8ASR1kMKvscqS4
         NxVA==
X-Gm-Message-State: AG10YOQ2P9TBWDUD8HrJAflmF9bKRGHABKIeY4tPeJCBoDuJlB1rwDvA7/wKlLIUHk252w==
X-Received: by 10.28.96.198 with SMTP id u189mr15524019wmb.55.1454654876800;
        Thu, 04 Feb 2016 22:47:56 -0800 (PST)
Received: from localhost ([31.210.180.167])
        by smtp.gmail.com with ESMTPSA id l2sm14450438wjf.15.2016.02.04.22.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2016 22:47:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqq8u30gn1m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285543>

On Thu, Feb 04, 2016 at 01:53:25PM -0800, Junio C Hamano wrote:
>[..]
> "by adding a new configuration variable" is a bit weak.  Help the
> reader by mentioning what it is called and what it does in the same
> sentence.
> 
> Perhaps like this?
> 
> -- >8 --
>[..]
>

Looks good, I'll just take that :)

>     ident: add user.useConfigOnly boolean for when ident shouldn't be guessed
>[..]
> >  		}
> > +		if (strict && ident_use_config_only && !(ident_config_given & IDENT_MAIL_GIVEN))
> > +			die("user.useConfigOnly set but no mail given");
> >  	}
> 
> By folding the line just like you did for "name" above, you do not
> have to worry about an overlong line here.

Consistency is important. Will fix here too, though it got fixed later
in the cleanup.

>[..]
> > +        git add foo &&
> > +        EDITOR=: VISUAL=: git commit -m foo &&
> 
> What is the point of these one-shot assignments to the environment
> variables?
> 
> "git commit -m <msg>" does not invoke the editor unless given "-e",
> and EDITOR=: is done early in test-lib.sh already, so I am puzzled.
> 
> Besides, if you are worried about some stray environment variable,
> overriding EDITOR and VISUAL would not guard you against a stray
> GIT_EDITOR, which takes the precedence, I think.

Being new to this testing framework, I tried learning the trade from
other tests. Maybe I goofed, or the other tests need cleaning?

> 
> > +	# Setup a likely user.useConfigOnly use case
> > +	unset GIT_AUTHOR_NAME &&
> > +	unset GIT_AUTHOR_EMAIL &&
> 
> Doesn't unset fail when the variable is not set (we have sane_unset
> helper for that)?

Sure.

>[..] 
> > +test_expect_success 'fails committing if clone email is not set, but EMAIL set' '
> > +        prepare && about_to_commit &&
> > +
> > +	EMAIL=test@fail.com EDITOR=: VISUAL=: test_must_fail git commit -m msg
> 
> This is a good place to use the "test_must_fail env" pattern, i.e.
> 
> 	test_must_fail env EMAIL=test@fail.com git commit -m msg
> 
> I would think.

Yes, and the fixed test still passes. Will resubmit the patches.

-- 
Dan Aloni
