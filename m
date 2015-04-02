From: "Reid Woodbury Jr." <reidw@rawsound.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 11:58:13 -0700
Message-ID: <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 02 20:58:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdkJq-0002ye-Gi
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 20:58:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbbDBS6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 14:58:17 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34728 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbbDBS6R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 14:58:17 -0400
Received: by pactp5 with SMTP id tp5so92319142pac.1
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 11:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=mLm+B/HDUXf/rsNedIyY5E+K+eqXrICUmkaW45l1SKE=;
        b=TbsdSj8H5kRcxYHfQ8xVNr2rq3rqVTpneD856GIpZ/fAob4Ap49fRCn+NWe53o/2gY
         w8wmUQ94vwe+5TslRK6XJYes2pWEC+S+J+wTTsur6CLDUKabWSkY38aV2TbgK57QFdQx
         norUCj5vhsDK/CAjB7BuZTuWE+iFDxCQ+j/WmXcSjoZnYILznuJ2ME+2tdAZsgsRyMkI
         cSdfleWeoWmv8bBZLPj41fytFnbY/aDRWDWlfIekdT2VWzeHNXmoLPys7+88vKqrfCvf
         ywPaKowUcAQurU24NpWixwERba8gioiDN3N989fMFjmqFihGDPPrjUZHPnxijouueFTw
         u39Q==
X-Gm-Message-State: ALoCoQkgd3XD2pTOtMQ8p2VkhvS6liaD8KGSZe9eTdICA9RptEcxThOR6l4uwIPzllg5w9AjK79A
X-Received: by 10.66.142.134 with SMTP id rw6mr73571007pab.56.1428001096512;
        Thu, 02 Apr 2015 11:58:16 -0700 (PDT)
Received: from [192.168.1.87] (107-128-47-25.lightspeed.irvnca.sbcglobal.net. [107.128.47.25])
        by mx.google.com with ESMTPSA id pr1sm5925673pbc.66.2015.04.02.11.58.14
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 11:58:15 -0700 (PDT)
In-Reply-To: <20150402180914.GA19081@peff.net>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266656>

Peff
The colons were part of the output. The 'xxxx' replaces the domain in the response. The domain is an internal one that my client would rather keep private. But this got me to think that this might be an important detail: I am using GIT from a remote node on a Cisco AnyConnect VPN with DNS served by ActiveDirectory.
Reid


> On Apr 2, 2015, at 11:09 AM, Jeff King <peff@peff.net> wrote:
> 
> On Thu, Apr 02, 2015 at 10:18:33AM -0700, Reid Woodbury Jr. wrote:
> 
>> After upgrading from GIT 2.3.3 to 2.3.4 (on Mac OS X 10.10.2,
>> installed with MacPorts) I received this error message when doing a
>> push:
>> 
>> $ git push
>> ssh: Could not resolve hostname xxxx:: nodename nor servname provided, or not known
>> fatal: Could not read from remote repository.
> 
> It is hard to tell from the obfuscated output, but perhaps the problem
> is the two colons (i.e., git is feeding a hostname like "foo:" when it
> should be just "foo"). There were some changes in v2.3.4 related to
> parsing ssh URLs. +cc Torsten, who worked on that code.
> 
> Can you show us your git config (presumably the host is defined in
> remote.origin.url in .git/config of the repository)?
> 
> -Peff
