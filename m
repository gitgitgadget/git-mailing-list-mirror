From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH] t3300-*.sh: Fix a TAP parse error
Date: Wed, 25 Jul 2012 15:51:20 -0500
Message-ID: <20120725205120.GD4732@burratino>
References: <500AEB11.4050006@ramsay1.demon.co.uk>
 <20120721182049.GL19860@burratino>
 <500EEAAA.8030604@ramsay1.demon.co.uk>
 <7veho1exu6.fsf@alter.siamese.dyndns.org>
 <501043D9.70604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jul 25 22:52:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su8Yx-0004yh-EV
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 22:52:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350Ab2GYUv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 16:51:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:62587 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750826Ab2GYUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 16:51:27 -0400
Received: by yenl2 with SMTP id l2so1213266yen.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 13:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/DTYnHDdjLAMyetieYgLAwp8yC73o0S6K7hXBKYKrYE=;
        b=PuSNgo5T3pD+EfxW45q9mZcdxDuehhZxr/DZ6LDwaWhNpsKM/4ZbV5XG3RtOVdF8oC
         xkt+r3hSA4RBTDOJMykxiAvDGROPMFSNRRu18yz5qjDELuQreg0hcHhARKd92Sz1tdkC
         WwYCx70Hng4hWJ/BY58judXRbeXhyVn0nT7hWjIMKaUUbwBT+0ezbKdCAOz1dx2ZR6co
         izf+Al+KVWEXnYcxFssCpbzLjo5iFecCY6MjYJAAF+Tzr/karo8B696Q1Ch3PMUnkTfP
         7ndnpgd+ty8mgN8Kdmod07bWQmFZGFEDzDOENrNtqud0/4jpLxhmgR7jLizC6GwGz4dw
         V1ng==
Received: by 10.236.186.73 with SMTP id v49mr24845885yhm.48.1343249487238;
        Wed, 25 Jul 2012 13:51:27 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id h15sm19590888ank.1.2012.07.25.13.51.24
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 13:51:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <501043D9.70604@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202195>

Hi,

Ramsay Jones wrote:
> Junio C Hamano wrote:

>> Observing that all well-written test scripts we have begin with this
>> boilerplate line:
>>
>>	test_expect_success setup '
>>
>> I wouldn't mind introducing a new helper function test_setup that
>> behaves like test_expect_success but is meant to be used in the
>> first "set-up" phase of the tests in a test script.

Neat.  This could be used for later set-up tests, too, perhaps with a
long-term goal of making non set-up tests independent of each other
(reorderable and skippable).

[...]
> [1] For example, what should/will happen if someone uses test_must_fail,
> test_might_fail, etc., within the test_fixture script? Should they simply
> be banned within a text_fixture?

Why wouldn't they act just like they do in test_expect_success blocks?

FWIW I find Junio's test_setup name more self-explanatory.  What
mnemonic should I be using to remember the _fixture name?

Thanks,
Jonathan
