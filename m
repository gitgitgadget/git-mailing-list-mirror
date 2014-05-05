From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] Revert "make error()'s constant return value more
 visible"
Date: Mon, 05 May 2014 02:30:12 -0500
Message-ID: <53673e0499ebe_78fd70f2ecb5@nysa.notmuch>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-2-git-send-email-felipe.contreras@gmail.com>
 <20140505054901.GA19331@sigill.intra.peff.net>
 <5367257a857ce_2db613a731043@nysa.notmuch>
 <20140505060202.GA27360@sigill.intra.peff.net>
 <53672c53f2ed9_2e86acd30c6e@nysa.notmuch>
 <20140505062931.GA9311@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 06 18:13:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whhtp-0005Yp-K3
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbaEEHkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2014 03:40:55 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:56554 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbaEEHkz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2014 03:40:55 -0400
Received: by mail-ob0-f176.google.com with SMTP id wp4so8042845obc.35
        for <git@vger.kernel.org>; Mon, 05 May 2014 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=CJ2msq+bPz4m29TU4Mi9deDfFMmUMBBm6hWa3nUOOzE=;
        b=nybQK9F+zTKKEJayWnh/TZgVEIhOZT/eCYUKzx+saZqduQQX3FAP3/ClCCfI1gcsru
         1vABEU/VL6EzoAcc4bShlxlS5EyoxnVJLcp2RIdSLHDAmTaTDZMPV8ROCEvEGviqRzLY
         Ub/jzHhWX4ROidXC/9jKuHxWjDbZ7+MX6Jn8Yib047rzRVikFkAVkZsJ4M1vogOOl6J0
         a17ksNoPVwI11fIZ3/7fbiGZXxEoIf4tGxkTJqkPZ0WbIfSXbmt6LURH4wF6EHn4FrkW
         A2PxIPQ7UkiZkgMxUjEucLT4WuIkGOmcvTH580eU98ij5FojckC5v+tUpXjhAOPaxRzm
         y24Q==
X-Received: by 10.182.22.33 with SMTP id a1mr668307obf.60.1399275654453;
        Mon, 05 May 2014 00:40:54 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id ut8sm17593875obc.22.2014.05.05.00.40.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 May 2014 00:40:53 -0700 (PDT)
In-Reply-To: <20140505062931.GA9311@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248121>

Jeff King wrote:
> On Mon, May 05, 2014 at 01:14:43AM -0500, Felipe Contreras wrote:
> > Jeff King wrote:

> > > You could try reading the commit message of the commit you are
> > > reverting, which explains it, but the short answer is: try compiling
> > > with -O3.
> > 
> > Sigh. And I'm the one with the abrasive style of communication.
> 
> I apologize if that seemed abrasive. I am slightly annoyed that you
> seemed to be reverting my commit without understanding (or dealing with)
> the problem that the original fixed.

The original problem happens only with -O3, I tried only with -O2 and
didn't see any problems.

If we have a) code that fixes a couple warnings with -O3 but introduces
hundreds with -O2, vs. b) code that has only a comple warnings with -O3,
I'd go for b) any day.

> But I was _also_ trying to point you in the right direction by directing
> you to -O3. Do you see the problem now?  And did you look at the
> follow-up patch I sent?

Yes, I see the problem now with -O3. And yes, I looked at the patch you
sent. I haven't tested it but I bet it would sove both problems.

Cheers.

-- 
Felipe Contreras
