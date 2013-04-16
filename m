From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 18:41:45 -0700
Message-ID: <20130416014145.GC3262@elie.Belkin>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
 <20130416004228.GA14995@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <drafnel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 16 03:42:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URuuG-0002LH-2u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 03:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840Ab3DPBlv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 21:41:51 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:37941 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934863Ab3DPBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 21:41:50 -0400
Received: by mail-pd0-f173.google.com with SMTP id v14so2842675pde.4
        for <git@vger.kernel.org>; Mon, 15 Apr 2013 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3fN845h258mRYXUuvJ6zWuzhS6Zd9HgN84LNP7kHYkw=;
        b=uT1wgsJq4904s+S2aiJ0O4tt5fpbUN9Mkw7AwhHpDlQQhkQog5z6rkjgNolJVDxlr1
         ZIyFVCdmAWnzIgoN611NvEaHNvK4iLYzT/0CgFzCaAQRvdr+ySX+6A3uyo7CAAyy1RK9
         yA6HNGZ8jtYbBZlFjiCrjts8vwjA/i5jvKZLK8Kf4Tmwnb1INDSaGlLl5Hp/wFPiPkKS
         XMipeGl92WDWmsPBSMOHpfQCDKXHJiz6fMPnS9BCzwxSUumUPPqVT2Xx2xa4R551UOzH
         J5t3PxcogayRqwswSZHkTVbOQJgj/YIL/yPH6l7IAC1U49dmzAObhWu6S0yKua4tI9WZ
         MjFA==
X-Received: by 10.67.2.68 with SMTP id bm4mr907083pad.9.1366076510143;
        Mon, 15 Apr 2013 18:41:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ba10sm22377777pbd.21.2013.04.15.18.41.47
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 18:41:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130416004228.GA14995@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221342>

Jeff King wrote:

> I was also tempted to suggest just dropping the recursion check
> altogether. While it is neat to detect such things, it's a "should never
> happen" bug situation, and an infinite loop of printing out the same
> message is pretty easy to notice.

On servers it might be useful to avoid accidentally filling up logs
quickly.

IIUC the context is in the following two threads:

 http://thread.gmane.org/gmane.comp.version-control.git/182982
 http://thread.gmane.org/gmane.comp.version-control.git/181421/focus=181443

Thanks,
Jonathan
