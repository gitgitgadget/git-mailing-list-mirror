From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] attr: map builtin userdiff drivers to well-known
 extensions
Date: Thu, 25 Aug 2011 19:44:25 -0400
Message-ID: <4E56DE59.5050601@sunshineco.com>
References: <20110825200001.GA6165@sigill.intra.peff.net> <20110825204047.GA9948@sigill.intra.peff.net> <CAPig+cQ33PESWC5fzN8enLFRwNPx8o+PgRUTeCva4dSJ_EdwOw@mail.gmail.com> <20110825210654.GA11077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 01:45:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwjbX-0000i8-Hj
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 01:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753949Ab1HYXoc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 19:44:32 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:52285 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab1HYXo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2011 19:44:28 -0400
Received: by qyk34 with SMTP id 34so1906067qyk.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 16:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=oSqc+MJ9PzUAMVsGZFcultKtKFMW+Ddk/BOQJx2nr7E=;
        b=Dm+ospg6h+hS9LyiULPevN6yPLQI4cgQM/QcFou41wHWW9CaOwijDFQyISP5BNXJe0
         tMTnT5/VQxBGbuUNzO8Z04aW4SHsS+AyHt7ayYrog3bDWcXM4JmUqBHr96yvWfKjcOKs
         L1ftLUh1NEERAFJ0uxOWiHUiKfH6Bt3nsONVU=
Received: by 10.229.247.15 with SMTP id ma15mr522553qcb.1.1314315868049;
        Thu, 25 Aug 2011 16:44:28 -0700 (PDT)
Received: from [192.168.1.3] (user-0c936tj.cable.mindspring.com [24.145.155.179])
        by mx.google.com with ESMTPS id h16sm762204qct.44.2011.08.25.16.44.26
        (version=SSLv3 cipher=OTHER);
        Thu, 25 Aug 2011 16:44:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Thunderbird/3.1.11
In-Reply-To: <20110825210654.GA11077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180139>

On 08/25/2011 05:06 PM, Jeff King wrote:
> On Thu, Aug 25, 2011 at 05:00:51PM -0400, Eric Sunshine wrote:
>
>>> Also, any other extensions that would go into such a list? I have no
>>> idea what the common extension is for something like pascal or csharp.
>>
>> C# uses extension ".cs".
>>
>> ".cpp" is common, in fact often required, by Windows compilers.
>
> Thanks, added both to my list.

To clarify, I meant to say that for C++, .cpp is common/required on Windows.

>> What about ".h" and ".hpp"?
>
> How well do our cpp patterns do with header files? I imagine they're
> better than the default, but I don't think I've ever really tried
> anything tricky.

I scanned through a number of revisions for one of my long-running C++ 
projects comparing the diff of header files with and without "*.h 
diff=cpp". In some header files in this project, the oft-used C++ 
keywords public:, protected:, and private: appear at start-of-line. In 
such cases, the default diff emits a less-than-useful hunk header:

     @@ -19,8 +19,8 @@ public:

whereas, "diff=cpp" emits:

     @@ -19,8 +19,8 @@ class Foobar

-- ES
