From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 11:28:42 -0700
Organization: Twitter
Message-ID: <1430418522.22711.22.camel@ubuntu>
References: <1430341032.14907.9.camel@ubuntu>
	 <xmqqlhha4otr.fsf@gitster.dls.corp.google.com>
	 <1430343059.14907.18.camel@ubuntu> <20150429214817.GA2725@peff.net>
	 <1430346576.14907.40.camel@ubuntu> <20150429231150.GB3887@peff.net>
	 <20150430003750.GA4258@peff.net> <1430355983.14907.55.camel@ubuntu>
	 <20150430011612.GA7530@peff.net> <1430358345.14907.62.camel@ubuntu>
	 <20150430033725.GB12361@peff.net>
	 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	 <5541E3D4.7040207@alum.mit.edu> <1430417023.22711.8.camel@ubuntu>
	 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
	git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 20:28:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntCc-0000v3-4z
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 20:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745AbbD3S2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 14:28:46 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36069 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbD3S2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 14:28:45 -0400
Received: by pabsx10 with SMTP id sx10so67290787pab.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 11:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=X9dv0XhmskC1C8km2aWjoZ9a2A+KKvtHB+jQTbXEXAg=;
        b=eBXgkaxumcYC6MLUx29oSa2Xy0s4tvL1vJWEIiZJGFSASIEkSKrbI8l/OQ2PVqqNWY
         50f0FG3wko5paMR48DsncVKNVj33o6UrkuB0+oXjycq3tFaF1Pe6C3tgKGb+esL5x0KK
         SViFcxcpNyS7JhA9B2JKPOfyY0EbzmpUmavwgJfFi9Ba4ybMRQhCYclF6BU7ApzCHPGC
         cbDR+8IZ5CHWqpcHud8XTbCPcjyOm47dLoYBdOgzIYX6k1OL1B3LmAmrCMSkG7xVBl1g
         xuQzmtyMMFKeVjNq+DqD7LrWSePlU/yzv7md52XWt/VgXjUh2P9t7vosR+c6yrBLQa2F
         naJw==
X-Gm-Message-State: ALoCoQkgzGcX0Lf9xnpOoQc7nJcHho3w6mtzCMnS1/vqOsOBwjOUGPL2XRBBFwAP9P8jA17Gb7+V
X-Received: by 10.66.148.225 with SMTP id tv1mr10714778pab.51.1430418524959;
        Thu, 30 Apr 2015 11:28:44 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id u8sm2813706pdi.90.2015.04.30.11.28.43
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 11:28:44 -0700 (PDT)
In-Reply-To: <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268088>

On Thu, 2015-04-30 at 11:19 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > In no case did we do a ls-files command,...
> 
> "ls-tree -r" is what I would have imagined you would be using, as
> somebody needs to have the full repository in order to resolve the
> symbolic links _anyway_, and that somebody does not need to have a
> checkout in order to do so.

Yes, they have the full repo, but we are only exploring a small fraction
of it. ls-tree -r would require parsing the entire thing.
