From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 04/12] Makefile: introduce CROSS_COMPILE variable
Date: Mon, 28 Apr 2014 18:54:24 -0500
Message-ID: <535eea307640d_5a07e812f050@nysa.notmuch>
References: <1398693097-24651-1-git-send-email-marat@slonopotamus.org>
 <1398693097-24651-5-git-send-email-marat@slonopotamus.org>
 <535e91e6c69eb_4565148331047@nysa.notmuch>
 <20140428181506.GA20059@seldon>
 <20140428233806.GS9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>,
	Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:05:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WevXo-00086R-SY
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:05:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbaD2AFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:05:00 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63076 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932475AbaD2AE6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 20:04:58 -0400
Received: by mail-ob0-f169.google.com with SMTP id uz6so8246186obc.0
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 17:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=lfiAMVQCoMWzU4Ff/HWc0SO4T/Q5ZPLC7NrVsk+HwQI=;
        b=J4FSJPvTlFQEbPxhRJREQP1OFXaaMHhW+62VCtKtWMzNVOVzhNeQNqN2iwDPN0Luxm
         NpTCSxpCBc1oSAB51Oz8kzwQzVgqWL85Z+H/KE6mQDCNuljrUFMlGCGCdE5yOJ89cEOI
         Ud/SZE3FlF/VwaczCQ1lyqTrrorCbwtJZ4zk04F2gBYDKtAVfB49qFktRG1ItsSJckmI
         tWZ2/0PzoKr5eeS5klm2o/UinBRTO+ar03x+k7J5RaYHlqMNlCnvqP+91fyT5MOs21Vu
         j0V2+vPKHgl2sPg3zaf6VpmizwlhdEPftyfgn8vLw3G3erImeby17Z6Bgr80Xma0MvBe
         mcQg==
X-Received: by 10.182.22.33 with SMTP id a1mr4254556obf.60.1398729898175;
        Mon, 28 Apr 2014 17:04:58 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id qp6sm40095960obb.14.2014.04.28.17.04.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Apr 2014 17:04:57 -0700 (PDT)
In-Reply-To: <20140428233806.GS9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247500>

Jonathan Nieder wrote:
> Marat Radchenko wrote:
> > On Mon, Apr 28, 2014 at 12:37:42PM -0500, Felipe Contreras wrote:
> 
> >>> +CC = $(CROSS_COMPILE)cc
> >>
> >> Nice.
> >
> > Actually, not. You still have to override CC because it is
> > $(CROSS_COMPILE)*g*cc. Any thoughts how to handle this?
> 
> One possibility would be something like
> 
> 	ifdef CROSS_COMPILE
> 	CC = $(CROSS_COMPILE)gcc
> 	else
> 	CC = cc
> 	endif

Or just:

  CC = $(CROSS_COMPILE)gcc

Which is what the Linux kernel does.

> Or as Felipe says, you can try to lobby your distro to install the
> symlink.

He can add the symlink into his ~/bin, or any $PATH.

-- 
Felipe Contreras
