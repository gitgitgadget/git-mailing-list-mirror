From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: re[4]: sparse checkout file with windows line endings doesn't work
Date: Fri, 20 Sep 2013 08:15:28 +0700
Message-ID: <CACsJy8BeT7ZP+ZQah7FR6ogqRNiiDZYP5SEs8J6J=+gEHU5MUg@mail.gmail.com>
References: <CACsJy8BSqJjxNwz=p7sGO2jfByLfngvN0yq55URXkX=yV+OEfQ@mail.gmail.com>
 <SDZYRFhOTCk2PDAuPVQvMjI4MjE1ODkw@IBMLT4>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Gregory <marting@adelaideinterim.com.au>
X-From: git-owner@vger.kernel.org Fri Sep 20 03:16:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VMpKV-0004LV-1y
	for gcvg-git-2@plane.gmane.org; Fri, 20 Sep 2013 03:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab3ITBQA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Sep 2013 21:16:00 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:56364 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3ITBP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Sep 2013 21:15:59 -0400
Received: by mail-ob0-f177.google.com with SMTP id wp18so10743526obc.36
        for <git@vger.kernel.org>; Thu, 19 Sep 2013 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=U4TwUOjz9rJUS1el/aJOBtgXHNo58hvNLEE1FHCRKU8=;
        b=NHaklaqVL3yUVWdqy7l60TF1SrblzpeLAqjEM9YrF4E1w7KkB94m+BmXw9icJpyOVj
         tz0yZVg2hxD6l7SWe27vh7fwRs5OKQFh9OKXcTuNDZjHf/eUT3NSuliQbsIeEyPi3h8D
         VgKN32E3Kh9IqnXfTAW6AsHjLGsLsYnskW2AypwEQpheGXrRnsdQptidhQdwKTrTMwAj
         9Vh3AnaNdpPQh9jumr4jv6TXJCQWhI6vL6OQvJizp+JojxZFKJVjiF+LXzR+lTenFcxT
         CwVTs4t3UuyTud436wIMora5QuE81RqwjLPhJE/v0X8RRP+drrFlhijGjuZpiEjpQ/S7
         CBXw==
X-Received: by 10.60.80.8 with SMTP id n8mr3517388oex.33.1379639758965; Thu,
 19 Sep 2013 18:15:58 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Thu, 19 Sep 2013 18:15:28 -0700 (PDT)
In-Reply-To: <SDZYRFhOTCk2PDAuPVQvMjI4MjE1ODkw@IBMLT4>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235043>

On Fri, Sep 20, 2013 at 7:01 AM, Martin Gregory
<marting@adelaideinterim.com.au> wrote:
> Hi Duy ,
>
> re: [file created in gitbash]
>
>>>  Thanks. Please send me the file created by windows shell. I suspected
>>>  that windows shell may save it in some funny encoding like utf-16..
>
>
> Strangely, I had sent the file created by the windows shell ahead of the one
> created by gitbash, but here it is again :)

Sorry I must have missed it. Anyway there is a trailing space at the
end of the rule. This is the content of your sparse checkout file in C
syntax

"/CONFIGURATION\x20\r\n"

Maybe we could warn about trailing spaces.. Stripping them
automatically is a possibility, but we need an escape hatch for
(crazy?) people who actually have trailing spaces in there paths.
-- 
Duy
