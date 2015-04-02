From: "Reid Woodbury Jr." <reidw@rawsound.com>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Thu, 2 Apr 2015 12:31:14 -0700
Message-ID: <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 21:31:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydkq0-0001wL-4m
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 21:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751666AbbDBTbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 15:31:18 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33712 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbbDBTbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Apr 2015 15:31:17 -0400
Received: by paboj16 with SMTP id oj16so12162649pab.0
        for <git@vger.kernel.org>; Thu, 02 Apr 2015 12:31:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:content-type:mime-version:subject:from
         :in-reply-to:date:cc:content-transfer-encoding:message-id:references
         :to;
        bh=lE9XQi7I5VCJp4oWAXqgg2Rsf4qfJCpEPoEMlkEzcUw=;
        b=QdQ/t0i8MOK/leUY66q5fJiMNn6/Kj6NpKNXGuXKIxdlVZKNkpq3cQsarr4XySGxBF
         QoOH4ZNqxdE752ZQH4qF0vN0VeD0K6hZxDFtYfPy1NMOP11itDxP6k+wXOfCs/jtA8eQ
         slbRUhaU14XLaWan3tbQi2k4N7kA2AKh4MfbjabT0lZDFMru413oyXAUydOQFDiZoZ2C
         P6KmlP0IZcCoeaq8flE/3x8ZA6tqOK+j4iVcRcO3xrpjmTSJ3pN2GDzo0sUo027KQm8E
         /YKg0rQ6wg9ddNj99Kh2x6L53EcgL18sMTKGSpU2rNCkIVX4F2fBbYcGbZGoFrqzPGyn
         yQ4A==
X-Gm-Message-State: ALoCoQkNYytCVa4t6bkABatf+4uvsIDkc3Vq+orAcgbN7VSRWkfCPFqUEwEo5XJn9d/VZJqPLRva
X-Received: by 10.68.94.129 with SMTP id dc1mr90132975pbb.8.1428003076883;
        Thu, 02 Apr 2015 12:31:16 -0700 (PDT)
Received: from [192.168.1.87] (107-128-47-25.lightspeed.irvnca.sbcglobal.net. [107.128.47.25])
        by mx.google.com with ESMTPSA id jx2sm5991829pbb.9.2015.04.02.12.31.15
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 02 Apr 2015 12:31:16 -0700 (PDT)
In-Reply-To: <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.2070.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266661>

Ah, understand. Here's my project URL for 'remote "origin"' with a more meaningful representation of their internal FQDN:

	url = ssh://rwoodbury@systemname.groupname.online:/opt/git/inventory.git

The "online" is their literal internal TLD.

Reid

> On Apr 2, 2015, at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> but this does not:
>> 
>>  $ git push ssh://does-not-exist:/repo.git
>>  ssh: Could not resolve hostname does-not-exist:: No address associated with hostname
>> 
>> (note the doubled colon). v2.3.3 did strip off that extra colon, but I
>> am not sure the URL above (i.e., a colon with no hostname) is actually
>> sane. IOW, it may have happened to work in older versions, but I'm not
>> sure we would want to promise to keep it working.
>> 
>> Can you show us what your URL looks like, obfuscating the names but
>> keeping the syntax the same? Also, are you using the "insteadOf" config
>> syntax at all (which could easily lead to funny splicing, I imagine).
> 
> Everything Jeff said ;-)
> 
> Depending on the nature of 'xxxx' in the original, Torsten's
> response may be different.  'xxxx' could stand for [9999:9999::9999],
> a.host.in.domain.xz, 127.0.0.1, or all the other things and it is a
> bit too vague to help us tell which codepath will pick up what and
> possibly screw it up.
> 
