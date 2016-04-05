From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v4 2/6] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Mon, 4 Apr 2016 21:46:10 -0400
Message-ID: <20160405014609.GB12006@LykOS>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
 <1459808535-8895-3-git-send-email-santiago@nyu.edu>
 <CAPig+cQJ6EzJ0976NJBHXRZyuTf1dr+0ZOvzrCfiTVZOp6fXBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 03:49:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anG77-0002t9-8Q
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 03:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933019AbcDEBrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 21:47:09 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34765 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbcDEBrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 21:47:07 -0400
Received: by mail-qg0-f43.google.com with SMTP id c6so39099389qga.1
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 18:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O36AwJseLfwVf0FNEsUUE8v+ADK0lckiY4RmkJo+xQA=;
        b=UAVhYrvJOn622NFibyy/07VCnLc7KkN0GPUpS9KRBAJxfjUpPMs16nONn3Lq3fh52r
         VHwRafN/FRi6iMpvSTl7XeCqEmJbcmR1imD59EaBOS62L5OiGw1fmor7uf2Z5EswNke2
         Nz4BD5bMizqHfKevh102vBl0TZN8uLTu2GQxhGS+nfJoAgaD+v7DnSLdhbuL1uNyDi5W
         H0XL9VsjRWnTrgESYvfCzzSQRkm2JIgBUxmmohgLnrrK6W6ueHPPSeBhBzVBUNQyrl3s
         r4h0c7ej53gc9GmmgGbJoFEuYWvguvCwQHDb6P+CLXyn3tvkNfwViAyOGokk2xaKUW/2
         Kyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O36AwJseLfwVf0FNEsUUE8v+ADK0lckiY4RmkJo+xQA=;
        b=WKkj04vuGNpN1rTWmKZAAKt/3k8noTaumQ/AXCqUMrx1Vndhz4qn1IkcBGBvaAJSYU
         PX/qs+9SUtIJWSSRLiF1DoxMfzWmx6i8I06mYjuFz310F1uXWO319yT28GgqU+wFSAE7
         lZh6DP0ORhcINHgkYRZ0FgSzSAJZQw1A9GUqMUFtYrhDN8zsN59/QC2wF+VCG9rXqEii
         NzOezGuiTZ4BntHLlRI2uuYsyuozcT6cqnx0TRSiAT8D00/ip+O3qlRBYfRsKUlhzuXR
         r+AZk4tVgIBD4173b+v9WOTlRU3VJDnHxsYdzE74IsSJlnm0PQwjtk4duIite6oWt4VX
         Wefw==
X-Gm-Message-State: AD7BkJL78rFUGkfCw9J6ftNedRJ4sf6A6qzqOgWWcH4a2A3vInJijp8bPql0EbR/ZK3+9goP
X-Received: by 10.140.178.73 with SMTP id y70mr17521142qhy.100.1459820774801;
        Mon, 04 Apr 2016 18:46:14 -0700 (PDT)
Received: from LykOS ([2604:2000:8183:da00:b6b6:76ff:fe46:8151])
        by smtp.gmail.com with ESMTPSA id o8sm13678441qko.24.2016.04.04.18.46.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2016 18:46:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cQJ6EzJ0976NJBHXRZyuTf1dr+0ZOvzrCfiTVZOp6fXBA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290750>

> 
> The bulk of this description is merely repeating what the patch itself
> already says, thus is redundant. The entire commit message could
> probably be collapsed to:
> 
>     t7030: test verify-tag with multiple tags
> 
>     git-verify-tag accepts multiple tags as arguments, however,
>     existing tests only ever invoke it with a single tag, so add a
>     test invoking it with multiple tags.

Yeah, this is actually clearer. Sorry for the academ-ose commit message.

> > +test_expect_success GPG 'verify multiple tags' '
> > +       tags="fourth-signed sixth-signed seventh-signed" &&
> > +       for i in $tags; do
> > +               git verify-tag -v --raw $i || return 1
> > +       done >expect.stdout 2>expect.stderr.1 &&
> > +       grep GOODSIG <expect.stderr.1 >expect.stderr &&
> > +       git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr.1 &&
> > +       grep GOODSIG <actual.stderr.1 >actual.stderr &&
> 
> Hmm, I had expected you to adopt Peff's suggestion[1] for the greps:
> 
>     grep '^.GNUPG:.' ...
> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/290691

I thought this was an stylistic thing. I can of course adopt this
suggestion.

Thanks,
-Santiago
