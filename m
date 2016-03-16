From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 03:07:36 +0530
Message-ID: <CAFZEwPOySiVwLJOw0seRu+c-NTK_vnsdi3Gsvv_tpJt6KY=Chg@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 22:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agJ8P-0006nk-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 22:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935127AbcCPVhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 17:37:37 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36130 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbcCPVhh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 17:37:37 -0400
Received: by mail-yw0-f182.google.com with SMTP id g3so78336236ywa.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=8OOsikSxKf8s03S5ZTjkuMQV+hiKsUpjda5Ciit2kkI=;
        b=ARpPNxe3Vw49oQrTsitTdZ+UuwOwdiycApH9uUUoMq3q9jx42OJrkybFIJrAu0AcRz
         pagHwlnfu+/8akbWdsaUkOJbVCSSuvUNJcv/9w/c2hf/CEvUoLxnQ2VyEyYkkJWHtpy6
         9zAgHhkVWbtm1h2RoeIDGu2kjhu+ryK2+6trcBSjaud/LGYFrO15LETBy1escLlb1TsM
         aTG695kEpbp2RCZNgYdzKkVj22lLZmTjca6S1qkN1EhtfJlTc5BSG4yMsyPGortR816X
         q3FCpwk/SOY4cnVSMyYPlAiuZ6ghhSg0a2b9E53wAcniUd0x0DF9a6x49JZjpgcpl+Si
         109Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=8OOsikSxKf8s03S5ZTjkuMQV+hiKsUpjda5Ciit2kkI=;
        b=Wjz7V1wOvaU8Bp00FhAbLuwg+ahmz/tpAhLYt/UKLNlGDwUyUNDVRh0/APwVEv0Tf0
         0uTzN6PsW283TXytATMRittKUJoAnzjVUIQsU//RMO6iasoBqFU+/GIYJnZDEhvZVYbY
         25mGIX7U21GrJOmw1IukkX5ROTuzxBUoYUHh7O4NhJjWhixNy5F3XzR0fjcGtjArS1xn
         02jbvM9Rj+67cxnuCoTYJTWgeNQKh4m7Ao2AieDyusGn76jBHsqhIZeK9tOSPgH7dIMA
         cYAGJ9yfD6U/456gFownSnz1tpxlTUAxdBS+gEPh5iqf5U8OJQ2gqkvadYc3fvlZLzlV
         qEvg==
X-Gm-Message-State: AD7BkJL4EbpL/z+NwJQ5BzBoKJLCCcVZgq8VhMD3jS9+lL3WU014J2MRwsg7lXEdKq4rd8s9Yui7cg6DPkvcKQ==
X-Received: by 10.13.252.67 with SMTP id m64mr3075953ywf.67.1458164256304;
 Wed, 16 Mar 2016 14:37:36 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Wed, 16 Mar 2016 14:37:36 -0700 (PDT)
In-Reply-To: <20160316212308.GA4538@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289045>

On Thu, Mar 17, 2016 at 2:53 AM, Jeff King <peff@peff.net> wrote:

> I don't think that would produce the wrong behavior, but it seems like a
> very complicated solution to a problem that can easily be solved by just
> following the usual conventions (that verbose starts at 0, options make
> it go up or down, and "--no-" resets it to zero).
>
> Perhaps it would make more sense if I understood what your goal was in
> setting verbose to -1 in the first place.
>
> -Peff

I am working on the micro project "configuration for commonly used
command line options like "git commit -v".
I sent out a final patch without considering the multiple verbosity
behavior of `git commit`. To take consideration for that behavior,
Junio suggested this approach [1]. I was trying to write code for this
when I noticed this behavior. I did a `git grep " unspecified " just
to find that using -1 is not that common. I think this problem can
also arise in future if some more options are included. The question
still remains whether its worth all this effort?

[1] : http://thread.gmane.org/gmane.comp.version-control.git/288820/focus=288909
