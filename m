From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: How safe are signed git tags? Only as safe as SHA-1 or somehow
 safer?
Date: Mon, 24 Nov 2014 17:23:59 -0800
Message-ID: <20141125012359.GR6527@google.com>
References: <5468C33E.2080108@whonix.org>
 <20141117212657.GC15880@peff.net>
 <CAK3OfOgko5Fb5FMGCKw3+12fAzMVEHuUriaiBNGi8nb28bNTQA@mail.gmail.com>
 <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nico Williams <nico@cryptonector.com>,
	git discussion list <git@vger.kernel.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 02:23:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt4rD-0002w0-BS
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 02:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644AbaKYBXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 20:23:52 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:40342 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaKYBXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 20:23:51 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so10089038iec.19
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 17:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=INORLTDWt1D4Ofsc1Mvmoul6fPhq4xJVAx6SigirC4E=;
        b=ouovR6s+9dgFEM1pnogpimwhhes6E5/Ao2biO3kYGKI6SmSE9fpx8VrZrKpTnWpg6M
         BHXwg+VOZQa/k/zHpaU12zyThg+Qjekecv9n1Lf3FetudcB5gw6dNbvM7y+3BSVoZ3ZO
         38z7eSkBFujtDTR0Ks3mKc8mL12K9lgNGxaOcp42DfTkZbqTGckYv7nY+qngyBN6Y5jA
         T5cbtFvyKE+0xoN6zPN1f0tJiLoF3IEpYyvALPDO1sjbwzYXkMMeZ8mMhYtPSOftaJsB
         zoBoG2ovJhJpJqQve2ZzyUd9HynxKlzRtieiHntfUo+MVcX81I1KSIVRtevFWW9wP/Kq
         QTjg==
X-Received: by 10.42.206.4 with SMTP id fs4mr16873640icb.90.1416878630600;
        Mon, 24 Nov 2014 17:23:50 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f4ca:5cf2:f45c:13f0])
        by mx.google.com with ESMTPSA id hi15sm5326853igb.19.2014.11.24.17.23.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 17:23:50 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACsJy8BMNXUinfK=YcJPkx98tYv_e40N0_mqqnzMLxDN6hkruA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260180>

Duy Nguyen wrote:

> The biggest obstacle is the assumption of SHA-1 everywhere in the
> source code (e.g. assume the object name always takes 20 bytes). Brian
> started on cleaning that up [1] but I think it's stalled. Then we need
> to deal with upgrade path for SHA-1 repos.

I think the biggest obstacle is the upgrade path. ;-)

If the upgrade path is taken care of, I won't mind writing and
reviewing a coccinelle-generated patch to replace 20, 40, 21, 41, and
so on with appropriate constants.  Or we can take the first 20 bytes
of a SHA-256, which is already supposed to have better security
properties than SHA-1.

Another obstacle is hard-coded SHA-1s in tests.

Thanks,
Jonathan
