From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v1] config: add '--sources' option to print the source of
 a config value
Date: Mon, 8 Feb 2016 12:25:58 +0100
Message-ID: <56B87B46.6050304@gmail.com>
References: <1454661750-85703-1-git-send-email-larsxschneider@gmail.com>
 <20160205112001.GA13397@sigill.intra.peff.net> <56B48803.9080909@gmail.com>
 <20160205135855.GA19154@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 12:26:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSjxH-0007OW-2X
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 12:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbcBHL0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 06:26:01 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34378 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbcBHL0B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 06:26:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id p63so15037995wmp.1
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 03:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=8towDdi3cKrx0G1GavFVGLRwO2++B4nHCrHCN/Qh06A=;
        b=sL4alcnK4vEKNRnYBgXdhKs0301u0rX+FHniEPAhK5rk6pr37UCXANrl1WMXiQwnvN
         X+eW96GrR3/sU4tz8JzHnT+d+ggVOvfGrgh3y9c97WruMPHJLXfrkPFpLg5e7ncdjoJC
         bh5Z8UcAOZcN1yCMHT8/ZOyNXdoRp1id0MQpAsNAGGcq9Q/6iN2YhEJb3g6KCqMdZlpW
         v4r89lp/hbl0IaM6OIZ0ymks4flffXcY/qHh/P4L4NweXFl8HyQHmVMD8/iv4mjvlWMt
         elHkyzJrQ5a0mgHYX1dSPnlFfzoiiNUhEJfUvrdehgY/boT19OuRjHNv5g4+ecZRzJQs
         f7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=8towDdi3cKrx0G1GavFVGLRwO2++B4nHCrHCN/Qh06A=;
        b=Pvj3nPo5r7XLiYiv289Gh77Bn83eiZLgXNVEVMKg+MutltDKnPzEI/jPhZeqTq9MF4
         82eVRgGPWPu/8N6kxDF2MYmHvWpfrgmNLUI8DGqRsXLLTC5NItudiXHkc/iqTzTOpPHh
         9z5GgVWf/ggDkrZunhOrMdWS0MfEjBBRL7e5g1eqNFtRgdlv1CXfxiO2ADXBb2MWFGn5
         yrjeBDB1TUKde5SAsJ7XelBijfMVVy4N8LMVo9prlaKrej94jkRWaBpV/bdMQkXKeUo4
         uJYUc3VexsRLcWMmjj2K6BDPmbcX0HcNW8hUudSDp6RKSHvGZJ8pEBprlxarVFXefAug
         bc0g==
X-Gm-Message-State: AG10YOS17KLEUrAk8N0zYfezHqugTAhV9nkezvyuqm/qRsKAMcPuoIo+QG+6gFsEdf3c/w==
X-Received: by 10.28.182.136 with SMTP id g130mr23710064wmf.10.1454930759955;
        Mon, 08 Feb 2016 03:25:59 -0800 (PST)
Received: from [10.223.62.214] ([131.228.216.134])
        by smtp.googlemail.com with ESMTPSA id 73sm12229839wmm.7.2016.02.08.03.25.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 08 Feb 2016 03:25:59 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160205135855.GA19154@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285756>

On 2/5/2016 14:58, Jeff King wrote:

> Yeah, I agree it's unlikely. And the output is already ambiguous, as the
> first field could be a blob (though I guess the caller knows if they
> passed "--blob" or not). If we really wanted an unambiguous output, we
> could have something like "file:...", "blob:...", etc. But that's a bit
> less readable for humans, and I don't think solves any real-world
> problems.
>
> So I think it would be OK to use "<command line>" here, as long as the
> token is documented.

Thinking about it again, I actually do like Peff's prefix solution 
better. It would solve the real-world problem that my proposed "<command 
line>" marker could in fact be a file name.

Regards,
Sebastian
