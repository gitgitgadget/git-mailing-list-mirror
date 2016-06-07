From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [RFC/PATCH] verify-tag: add --check-name flag
Date: Tue, 7 Jun 2016 18:16:22 -0400
Message-ID: <20160607221621.GG24676@LykOS.localdomain>
References: <20160607195608.16643-1-santiago@nyu.edu>
 <xmqq7fe0pv5b.fsf@gitster.mtv.corp.google.com>
 <20160607211707.GA7981@sigill.intra.peff.net>
 <xmqq37oopt28.fsf@gitster.mtv.corp.google.com>
 <20160607215536.GA20768@sigill.intra.peff.net>
 <xmqqy46gods1.fsf@gitster.mtv.corp.google.com>
 <20160607220743.GA21043@sigill.intra.peff.net>
 <CAPc5daV=gqDLeFLB2csJDvNo4fpSKW_FjoB10TyroapQiHFq=A@mail.gmail.com>
 <20160607221325.GA21166@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Colin Walters <walters@verbum.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 00:18:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPIT-0003pE-8y
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755895AbcFGWQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:16:25 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:36571 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbcFGWQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:16:24 -0400
Received: by mail-qk0-f176.google.com with SMTP id i187so102742752qkd.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 15:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gmKKNabblVzN/sKl2aISvPwF/rcwZ03QsjtrxNvw7fs=;
        b=EXhYPBfXnrcZdy6CASfsR5MoSUJQYetsytGZ/0aR7rM1gCXj9ImrPEIM2nakNCju4V
         0zgJvbCXlgw1ZuRPKtKwytg1bP9kA/8l03Zb7BIef8P54nzWImhtJ37GwItEkmnQ98vK
         YY5YhQBVg4Ajn858XL8X6b40RjNIP8jeUyUDZsu5ZKyJr+Bdr9NREttNkW+5GOSd5Tje
         2a/uObygahvGJXj3gnSZUZ12mFcGL2QTay9Tc23Y/p+kV6E4HRC0yg8hUwy6YZlZvfBj
         BV8pp8TSL90JIHTjR0tPt1rcVij8eSSY01iZumMo2HmkaIp1204qkz1uOR/cYVxM8Egt
         it6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmKKNabblVzN/sKl2aISvPwF/rcwZ03QsjtrxNvw7fs=;
        b=k9ZHv2iuY1mc6GpKZ0aZhSQbt53qHkRzsseaanvn0Ozyq2heTPY9/3DbfHYCxwFQDU
         EAQaIoRYlLN32t2/ieKFdXvl9wgHXyx8rvcznLSFizaZDKRMw51w3OkVVgtpQoAq8cpG
         DCaKV0Qit6hMeUKUlTZi3rbu6HBEzwCcsY9nutEEKE6l3i5YppSJx+v8pgwcRj1sske1
         TXrTsIZdGFq1enMn3F7bXzt3NTtqzhpcvrYW0tgRnjPQl8MCayJk8nkwbPnCBy1bm2p0
         xd0N1BVskD2PlITRe/OyYXPR2bNUqtwwc3rIV93RefRfN1z5/OhM/0GxHG8tcuSX8cbU
         T7iw==
X-Gm-Message-State: ALyK8tK0MIlSGLzNCH6dfVj9myjJCFuv0u7LpeljZQ76NI88RC6iJ2D6SNv0Ka3A7MVirYlc
X-Received: by 10.55.133.130 with SMTP id h124mr1904823qkd.82.1465337783514;
        Tue, 07 Jun 2016 15:16:23 -0700 (PDT)
Received: from LykOS.localdomain (NYUFWA-WLESSAUTHCLIENTS-EXP01.NATPOOL.NYU.EDU. [216.165.95.69])
        by smtp.gmail.com with ESMTPSA id t77sm7193389qgt.20.2016.06.07.15.16.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2016 15:16:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160607221325.GA21166@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296737>

On Tue, Jun 07, 2016 at 06:13:25PM -0400, Jeff King wrote:
> On Tue, Jun 07, 2016 at 03:11:47PM -0700, Junio C Hamano wrote:
> 
> > On Tue, Jun 7, 2016 at 3:07 PM, Jeff King <peff@peff.net> wrote:
> > >>
> > >> Puzzled.  I didn't even use --format=%(tagname) in the above.
> > >
> > > No, but you used --show-tagname, which does not exist today (and which
> > > IMHO should be implemented as --format). Would --show-tagname take
> > > either a tagname _or_ a sha1? I assume it would not be calling
> > > get_sha1(), as having it find refs/heads/$tag would be silly.
> > 
> > And you do not even want to rely on where refs/tags/* it lives.
> > show-tagname, as I hinted in the first response, was meant to be
> > a short-hand for
> > 
> >        git cat-file tag $tag_object_name | sed -e '/^$/q' -e 's/^tag //p'
> > 
> > so I am still puzzled.
> 
> If you are suggesting that you can do the whole thing today by parsing
> the tag object yourself, then sure, I agree. I thought the point of the
> exercise was to make that less painful for the callers.

This is what I understand so far, it seems all of us are on the same
understanding here?

1.- we can do this right now by sed-ing out the tagname, but it might
    not be optimal.

2.- We can, instead, provide a --format flag to git tag -v for the same
    purpose. Which would only print the tag (if the appropriate format
    string is provided)

I still agree with the rest of Peff's comments about this approach. I'm
not sure about which approach to take either.

-Santiago.
