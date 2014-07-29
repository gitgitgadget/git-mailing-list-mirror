From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: "error: Tweaking file descriptors doesn't work with this MSVCRT.dll"
 on wine
Date: Tue, 29 Jul 2014 21:55:39 +0200
Message-ID: <53D7FC3B.9070001@gmail.com>
References: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 29 21:55:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCDUv-0004QW-8B
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 21:55:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbaG2Tzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 15:55:41 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:44271 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbaG2Tzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 15:55:41 -0400
Received: by mail-wi0-f170.google.com with SMTP id f8so5961019wiw.5
        for <git@vger.kernel.org>; Tue, 29 Jul 2014 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Kpz88qElPdVu1nGNVYs8i2MMfXcDaGo7HQ9XL9Ee/Mk=;
        b=ZQvK4bv+XRwHXlT2iMfTqo9SUr0sdZImMbj9kslYD/TyThvGxVgxk96OxqwKk9Wf94
         5cfv+0QFmQ8+yJRwEtPHsAVz3UvjFyG3ON6Ba6IRgxDr5dcs3Mfklh6OEPQSm6P4u1Vb
         3SoXP1QbU2N9x4+9uoZ8g5bpsh1B+38O1ufGn/NUV9tGJhIfYhOsuEs/OxAreZT2BPll
         NWRhyrL6tKvuytFkRzaiJCUkWSK1WPPrArBSa/TmuA6WlyD+bfN0xDcQ3KVgtVcsJibH
         hAxnnbAL/wSqKY/PAdLJ/Sh6lkvZKK3nvouCI/7Vuumtohv1r8LyEEJcmTpjpUXPo44W
         Svzg==
X-Received: by 10.180.88.167 with SMTP id bh7mr290475wib.12.1406663739645;
        Tue, 29 Jul 2014 12:55:39 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ut2sm59781878wjc.49.2014.07.29.12.55.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Jul 2014 12:55:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CACsJy8DFvTHieQc-nZL2h7JbQYc4Qkbx+Ouc297VpNeU=kNaoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254464>

Am 28.07.2014 12:39, schrieb Duy Nguyen:
> I know wine is kind of second citizen but is there a cheap trick to
> make it work on wine? Reverting fcd428f (Win32: fix broken pipe
> detection - 2012-03-01) could result in conflicts in compat that I'm
> not comfortable resolving. I don't have Windows at home. Wine is the
> only option for me (or if somebody has a modern.ie image for KVM, or a
> simple recipe to make one, that'd be great). "Fix wine" is not really
> an option.
> 

Have you tried using a native msvcrt.dll instead of the Wine stub?
Downloading msvcrt.dll 7.0.2600 from dll-files.com and extracting it to
~/.wine/drive_c/Windows/System32 fixed the error message for me.

(The newest versions don't work as they depend on a bunch of other
dlls that you'd need too.)
