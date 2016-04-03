From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 2/4] t/t7030-verify-tag.sh: Adds validation for
 multiple tags
Date: Sun, 3 Apr 2016 17:58:47 -0400
Message-ID: <20160403215847.GD28933@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-3-git-send-email-santiago@nyu.edu>
 <20160403044054.GB1519@sigill.intra.peff.net>
 <CAPig+cQp2t0y7imR5tTHdLdMO6w13ia-GxZXxq4c2NGaZTjErw@mail.gmail.com>
 <20160403130724.GA16206@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:59:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amq2w-0001JL-6i
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbcDCV66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:58:58 -0400
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35418 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcDCV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:58:57 -0400
Received: by mail-qg0-f41.google.com with SMTP id y89so135917633qge.2
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+BRw/ZU2q7O1wwBHqpij7Yg+V4TkrN6201fbN6ClxPc=;
        b=ZJTaRerhkbEIFO6Dgd6dgdEECy+mew+BgZji10Y53ZYBt0e0m/Tbu51LUOvlvn1fQe
         b8ZTM0uHY2l0rtXEtECvQgMLmBpLN819Um2xZSvvso/b5uahHeWXIqcTUeRkUzi4Ezc7
         VfrwKtM9mdpapK4pDM5Qpga/oASwrMdURgPyAV87ZrRz2zJl+j/YGRu/IQp+rr3Vzs1p
         vAZIHmXSDkNQiaNvTSqnNd2de1DzIbrbVefLViWg1tlWNvaJbn96Ap78o4PqNRPj0UYw
         y+A/fv7mp9zakEnG97jp+p0wl1f49ZFbKfBVXEcr0RTvxPHDA+RILCQ/HTruOfrhf0nR
         CsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+BRw/ZU2q7O1wwBHqpij7Yg+V4TkrN6201fbN6ClxPc=;
        b=BIbIiEloKIL9dvbKt7urmiCGJPsWaWIxqgmR8dJvtIbMjQsWmMisOlyGBqJAvjjjq9
         XlpW3yyrCWbqCAez0jDvSlD5DODwYGIf9BZ34VfNoPdRDRPqKp+yN1zPXfOr4fHgyOUw
         BEaB2omOb4S/tNFtlw0TAQw2iyvpJ+Mn2ET8LWGGnz3oMqSOeRmw9/p0ATfQWeTjexXx
         mFlovF6BwhoB0xeyiZLamFyX0eNXIDfewZ+mAVNREtjGuhBSpA5E7bL4YFZGVJJhvZsy
         KWUb6OgU1u2kcH27vA+/FPT6B8Hk47ZRShOnfR1p2Aqxvii7iY0/G/g6029VFUfpGinh
         7qjg==
X-Gm-Message-State: AD7BkJLa/5x2dj90zbpvrJ6a4lTETuBYZY3ydS83eaUtlg10DNWGz3XcuvSDpqRbFtrXbjba
X-Received: by 10.140.161.198 with SMTP id h189mr38678693qhh.24.1459720736265;
        Sun, 03 Apr 2016 14:58:56 -0700 (PDT)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id h34sm1914507qge.30.2016.04.03.14.58.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 14:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160403130724.GA16206@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290659>

On Sun, Apr 03, 2016 at 09:07:25AM -0400, Jeff King wrote:
> On Sun, Apr 03, 2016 at 03:59:46AM -0400, Eric Sunshine wrote:
> 
> > On Sun, Apr 3, 2016 at 12:40 AM, Jeff King <peff@peff.net> wrote:
> > > In fact, I suspect you could replace the "GOODSIG" check as well by
> > > doing something like:
> > >
> > >   # verifying 3 tags in one invocation should be exactly like
> > >   # verifying the 3 separately
> > >   tags="fourth-signed sixth-signed seventh-signed"
> > >   for i in $tags; do
> > >           git verify-tag -v --raw $i || return 1
> > >   done >expect.stdout 2>expect.stderr &&
> > >   git verify-tag -v --raw $tags >actual.stdout 2>actual.stderr &&
> > >   test_cmp expect.stdout actual.stdout &&
> > >   test_cmp expect.stderr actual.stderr
> > 
> > Hmm, does [1] suggest that using test_cmp on stderr here would be
> > contraindicated?
> > 
> > [1]: http://article.gmane.org/gmane.comp.version-control.git/289077
> 
> It does, but I am not sure I agree with the advice in that email in the
> general case (I like making "-x" work, too, but not at the cost of
> making the tests harder to read and write). In this case, I suppose you
> could grep for gpg raw-output on stderr, though, and compare only that.
> 
> -Peff

I just read [1], I'll take the later advice and use test_i18ngrep
instead.

Thanks!
-Santiago.
