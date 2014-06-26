From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v3 3/3] test-config: add usage examples for non-callback
 query functions
Date: Thu, 26 Jun 2014 14:10:08 +0530
Message-ID: <53ABDC68.4090701@gmail.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>	<1403518300-23053-4-git-send-email-tanayabh@gmail.com> <CAPig+cTf+8H38SSxoLMSuU9JUSPiEuTCm=8wHFe5QSCK3j8ELw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 10:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X05EL-0007FN-4F
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 10:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbaFZIkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2014 04:40:24 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54942 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaFZIkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2014 04:40:20 -0400
Received: by mail-pb0-f46.google.com with SMTP id md12so2854131pbc.5
        for <git@vger.kernel.org>; Thu, 26 Jun 2014 01:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dut3XU66vzPpztIdRXKRM6JX5QW9+Onb869cV562Pws=;
        b=pMorrQ05HuC2lXT6vaSLCIyFLLfPmHKb47W85Z2bI2CmTEaANg31LQDhR1VFoKDF/g
         SS8lX3IuzKml2wX33lU/JztzdWUaI2uZBx6aIJOQwzY0qkTPa6Uxrq0IwBuIIgAu+7+o
         P5sUkrPFCuLzJ8ir/6oJBKfRgovYjufl4JIYBwR3JW4IBs1zo0UVgZuWXHufH6ysuvDA
         3v8lQIJK2a6ym9Nz6RFdpT0FAmKzLUm4fFcv84unJlxBLWb6/mBOW37c/Kuo7ExFfl3D
         5XJhQqP6SR551XVycEklgxqReLEQRc6bYebajzAKFO/nW02Rfl4OVCID2QwCaw4VvP9j
         Gh/g==
X-Received: by 10.68.104.66 with SMTP id gc2mr19586383pbb.17.1403772019916;
        Thu, 26 Jun 2014 01:40:19 -0700 (PDT)
Received: from [127.0.0.1] ([117.251.76.15])
        by mx.google.com with ESMTPSA id io8sm8809943pbc.96.2014.06.26.01.40.16
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 26 Jun 2014 01:40:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPig+cTf+8H38SSxoLMSuU9JUSPiEuTCm=8wHFe5QSCK3j8ELw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252494>

Hi,

I thought about adding a test*.sh file after sending the series.
No worries, I will rectify it in the next patch.
Also, I have read all your comments.

Thanks for the review.

Cheers,
Tanay Abhra.

On 6/25/2014 4:49 PM, Eric Sunshine wrote:
> On Mon, Jun 23, 2014 at 6:11 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
>> Add different usage examples for 'git_config_get_string' and
>> `git_config_get_string_multi`. They will serve as documentation
>> on how to query for config values in a non-callback manner.
> 
> This is a good start, but it's not fully what Matthieu was suggesting
> when he said that you should prove to other developers, by way of
> reproducible tests, that your changes work. What he meant, was that
> you should write a test-config program which exposes (as a runnable
> command) the new config C API you've added, and then write tests which
> exercise that API and implementation exhaustively.
> 
> For example, take a look at test-string-list.c and
> t/t0063-string-list.sh. The C program does no checking itself. It
> merely exposes the C API via command-line arguments, such as "split",
> "filter", etc. The test script then employs that program to perform
> the actual testing in a reproducible and (hopefully) exhaustive
> fashion. Because t/t0063-string-list.sh is part of the test suite, the
> string-list tests are run regularly by many developers. It's not just
> something that someone might remember to run once in a while.
> 
> Contrary to your commit message and the comment in the program itself,
> the purpose of test-config is not to serve as documentation or to
> provide examples of usage. (Real documentation is better suited for
> those purposes.) Instead, test-config should exist in support of a
> real test script in t/ which is run regularly. The new script you add
> to t/ should exercise the exposed C API as exhaustively as possible.
> This means checking each possible state: for instance, (1) when a key
> is absent, (2) when a value is boolean (NULL), (3) one non-boolean
> (non-NULL) value, (4) multiple values, etc. Moreover, it should check
> expected success _and_ expected failure modes. Check not only that it
> returns expected values, but that it fails when appropriate.
> 
> More below.
> 
