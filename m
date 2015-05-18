From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] subdirectory tests: code cleanup, uncomment test
Date: Mon, 18 May 2015 15:03:19 -0700
Message-ID: <20150518220318.GE5586@google.com>
References: <xmqqlhglbt4k.fsf@gitster.dls.corp.google.com>
 <1431983426-4346-1-git-send-email-sbeller@google.com>
 <xmqqvbfpa8ff.fsf@gitster.dls.corp.google.com>
 <CAGZ79kZ9h=Oev_mymFBRNyAGokAe8-vWh_D12VZYHTUv20Djvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 19 00:03:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuT8B-0005n9-Tc
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 00:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbbERWDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 18:03:23 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37499 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbbERWDW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 18:03:22 -0400
Received: by igbsb11 with SMTP id sb11so48462igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qma4RkmxgwVVQ5SdAipYKmSjYtb58M8uaH9VHJHgqBk=;
        b=SqQz0b58NyI2VrlUbPOGuKcDPIERCTa930ty2PHvpFpNPp2wR6p5b1A1W3q5D7XUGs
         YZ60bFyd+w4N1lYQi5zhkCNfrftmvzH3M2jlfRnC3muAQOZYvE+wgLG6qIYkxhvecCbs
         PjnQ+NGbRJ9FvY8Y0ahBkGITCKB5XYPKED1MKb4YuHemPq03tIfsbBLZCpQ7/ikg6BGP
         d/6ue8LvlUh0ohDpBmz/KRLVjBHLGZTxZPLzJhi+R9Ng9f3MmrLr/7OwJMq//5uKqo1C
         zAtrv+VIJoVIfkm8W6wapSpZtWeU3IG8YuM9V37ob463vB32OS81+N6xIdlrt+jArSZN
         liTA==
X-Received: by 10.43.135.5 with SMTP id ie5mr18851720icc.78.1431986602295;
        Mon, 18 May 2015 15:03:22 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:fc3a:4b70:52a9:16b0])
        by mx.google.com with ESMTPSA id j20sm6440420igt.16.2015.05.18.15.03.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 15:03:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZ9h=Oev_mymFBRNyAGokAe8-vWh_D12VZYHTUv20Djvg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269326>

Stefan Beller wrote:

> I am not happy with (historic) either, maybe "(explicit GIT_DIR)"
> is describing the test better without giving the reader the thoughts
> as you raised here?

The general principle I use is to try to briefly describe what
hypothesis the code is trying to test, so that if it fails someone knows
what that means.

In this case, I could do

	test_expect_success 'no file/rev ambiguity with explicit GIT_DIR=.' '

[...]
>>>               cd foo.git &&
>>> +             # older Git needed help by exporting GIT_DIR=.
>>> +             # to realize that it is inside a bare repository.
>>> +             # We keep this test around for regression testing.
>>>               GIT_DIR=. git show -s HEAD

I don't think this comment is needed, since it doesn't make it clearer
what the test is about.

Thanks,
Jonathan
