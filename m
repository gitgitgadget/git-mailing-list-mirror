From: Phil Hord <hordp@cisco.com>
Subject: Re: remove all traces of some files
Date: Wed, 27 Apr 2011 16:40:22 -0400
Message-ID: <4DB87F36.9080901@cisco.com>
References: <BANLkTim_PriowuBH71M2DxxkJ=Y5oAA2uA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Frederich <eric.frederich@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 22:40:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFBXL-0001us-9w
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 22:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759683Ab1D0Ukd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 16:40:33 -0400
Received: from sj-iport-3.cisco.com ([171.71.176.72]:55935 "EHLO
	sj-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755722Ab1D0Ukd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 16:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=hordp@cisco.com; l=1097; q=dns/txt;
  s=iport; t=1303936832; x=1305146432;
  h=message-id:date:from:mime-version:to:cc:subject:
   references:in-reply-to:content-transfer-encoding;
  bh=wk15HWjacgY0TR54Pd7dFChWCdWqprI5usRvxelOYKU=;
  b=O0N9VmD+orl0K/U2kOj1ivoc1rxNTbQR3Rz/MqyLJKJ/+Ikax/kqhj6z
   2RfgDEfNJ9zhtBd6MY7lznsqI1AaNYBHRtL3ow+BufebKRuGrTSQziaBt
   4aD7baeMA8m6LPG/ce45kOzoYAaE6vHMijfgyaxl72+B+A9ksuvgSRpnY
   A=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAF/uE2tJXG//2dsb2JhbAClcXenXJx2hXYEjlGEEoo2
X-IronPort-AV: E=Sophos;i="4.64,276,1301875200"; 
   d="scan'208";a="303458780"
Received: from rcdn-core2-4.cisco.com ([173.37.113.191])
  by sj-iport-3.cisco.com with ESMTP; 27 Apr 2011 20:40:23 +0000
Received: from [64.100.104.120] (dhcp-64-100-104-120.cisco.com [64.100.104.120])
	by rcdn-core2-4.cisco.com (8.14.3/8.14.3) with ESMTP id p3RKeN0U019257;
	Wed, 27 Apr 2011 20:40:23 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Lightning/1.0b2 Thunderbird/3.1.7
In-Reply-To: <BANLkTim_PriowuBH71M2DxxkJ=Y5oAA2uA@mail.gmail.com>
X-Enigmail-Version: 1.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172271>

On 04/27/2011 03:58 PM, Eric Frederich wrote:
> I have been adding build files (.dll and .so files) to my git
> repository periodically when I have been doing builds of my project.
> I know I shouldn't be doing this and want to set up some other kind of
> separate archive or something for built files.
>
> Although there are other devs on the project, I am the only one using
> Git.  Everyone else uses AccuRev.
> Personally, I maintain my own Git repo (with an AccuRev git branch).
>
> I would like to remove all traces of those .dll and .so files if I
> could in my git repository.
> I realize this would mess with hashes and would ultimately result in a
> completely new tree.
> I am fine with that since, as I said, I am the only user of this Git repo.
>
> So, can this be done?  Can I rebuild the tree preserving commit
> messages, timestamps, etc but ignoring certain files?

Something like this, perhaps:
  git filter-branch --index-filter "git rm --cached --ignore-unmatch
--quiet '*.dll' '*.so' " -- --all

More examples here:
  git filter-branch --help

Phil
