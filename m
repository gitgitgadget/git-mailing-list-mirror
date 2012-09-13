From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: CRLF, LF ... CR ?
Date: Thu, 13 Sep 2012 17:43:48 +0200
Message-ID: <CABPQNSZ4Mh02xmbJPubhW9XDbTeYqg3LXLz+s=7DtKRt5AvJkg@mail.gmail.com>
References: <20120913170943725232.01d717ef@gpio.dk> <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jens Bauer <jens-lists@gpio.dk>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Thu Sep 13 17:45:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCBbF-0002tY-9J
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 17:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758375Ab2IMPor (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 11:44:47 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58831 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758355Ab2IMPo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 11:44:29 -0400
Received: by dady13 with SMTP id y13so1784148dad.19
        for <git@vger.kernel.org>; Thu, 13 Sep 2012 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+pCCg6ijxQKzN8NMmr8BI/sUFzj79U6aeookg0fjw3w=;
        b=mUcIF/XV+XNOd5Qa/fz2+miDT/JBJQkft9dNiZsir0evjBveK7gjis4Q+shzPxIfus
         qdB3uHZXLgWSTBLadfS+sTAP3/RZ8hkmgqZrPCA9RNvOe26YpP0AUagZlwrmS1P8yAPr
         NCDxCi7kwb+614Yqe3oWhgr7FKFf1lO/ibsVLkT/FljCYFS6LqfUZ2aO+AhCfBa9Y9XO
         Eq/o/MtBAxQpIPvBiigzD49+NTTcgozCqB/YYVR4j+yk6AaHZ7dq5AWvxVi+9DhvCFTv
         9rgvanCjr4EiAvCXyPSfUywgPNB6hWg6CDr7F9I8eTAsVK4+qG14SM04Ujt+D8xTRo5t
         j5CA==
Received: by 10.66.75.104 with SMTP id b8mr3971590paw.21.1347551068549; Thu,
 13 Sep 2012 08:44:28 -0700 (PDT)
Received: by 10.66.15.234 with HTTP; Thu, 13 Sep 2012 08:43:48 -0700 (PDT)
In-Reply-To: <1347550490.24469.54.camel@drew-northup.unet.maine.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205389>

On Thu, Sep 13, 2012 at 5:34 PM, Drew Northup <drew.northup@maine.edu> wrote:
> On Thu, 2012-09-13 at 17:09 +0200, Jens Bauer wrote:
>> Hi everyone.
>>
>> I'm quite fond of git, and have used it for a while.
>> Recently, I've started making printed circuit boards (PCBs) using an application called OsmondPCB (for Mac), and I'd like to use git to track changes on these.
>> This application was originally written for the old Mac OS (Mac OS 6 to Mac OS 9.2).
>> The old Mac OS does not use LF, nor CRLF for line endings, but only CR.
>>
>> I've read that git supports two different line endings; either CRLF or LF, but it does not support CR.
>> Would it make sense to add support for CR (if so, I hereby request it as a new feature) ?
>
> Jens,
> Even if Git can't do CRLF/LF translation on a file it will still store
> and track the content of it it just fine. In fact you probably want
> translation completely disabled in this case.
>
> (Given that you seem to be working on a Mac I suspect that "disabled" is
> likely the default setting for that configuration item.)

This might be less than ideal, because diffing and merging will break.

Perhaps clean/smudge filters can be used instead? That way you can
have CR on disk and LF in the repo.
