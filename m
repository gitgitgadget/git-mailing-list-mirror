From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: Why does "git config" output nothing instead of the default value
 for unset variables?
Date: Sun, 14 Apr 2013 14:56:22 +0200
Message-ID: <CAHGBnuO2d9Wkez4sLLKp3Ei0vkAJBjJp1+m+Lsu3ozaKPQD29A@mail.gmail.com>
References: <kke7o1$oo$1@ger.gmane.org>
	<CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMTw-0005CB-DD
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab3DNM40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:56:26 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:58300 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159Ab3DNM4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 08:56:25 -0400
Received: by mail-la0-f49.google.com with SMTP id fs12so3609642lab.22
        for <git@vger.kernel.org>; Sun, 14 Apr 2013 05:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=d4y5n0QkLd+nBUvcOfgF1PK2dwlZ8uBov/BEjYY8l/g=;
        b=XxZwxe3HKaOiJ3OC0PVruERLDTqh/z4PKUD6b/Mvdag1BpcBe14EXRBGq5xs7WeHnV
         TRrCHq/h6bR0Q+y7Y/o2MeOgzZApY/NXCXxiuBMwiXsGTfC/FennH9cMzWkMHoRGtXus
         ew1GBK5T2cCEsR0GP9XzcIc9QlR8DZpe96s5uPnndrRjQjwEwcpXAFBNG2IXGv+cSTmx
         ITDg5vyKteqr3Bh07agGvlTufgcVIpycS2U3P6LOKcGElGunlkJOqePGJyA5Tx5O0xDs
         H8AeFnX3wqZDFbZhAmyIu3D0rCCZKUxIZIlTZsqKghs2GY1EHyPcjvai7FqaDe0rBCMk
         4A0w==
X-Received: by 10.152.26.166 with SMTP id m6mr6952395lag.4.1365944182692; Sun,
 14 Apr 2013 05:56:22 -0700 (PDT)
Received: by 10.114.84.33 with HTTP; Sun, 14 Apr 2013 05:56:22 -0700 (PDT)
In-Reply-To: <CAH5451nL0cmTy+vwEsJnvX7OP1iSSgY9UMhvrrimk0zWM71YDw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221119>

On Sun, Apr 14, 2013 at 2:47 PM, Andrew Ardill <andrew.ardill@gmail.com> wrote:

> On 14 April 2013 22:34, Sebastian Schuberth <sschuberth@gmail.com> wrote:
>> Usually when I query a variable I'm not so much interested in whether it is at all (explicitly) set to some value or not, but what value is currently in use.
>
> With your change in place, how do you know if the config item has been
> explicitly set in your system?

Well, this could be done several ways. Maybe output the variable value
in all upper case if it's the implicit / built-in default, and in all
lower case if it has been explicitly set somewhere.

> The closest thing I can see for doing this is git config --list, but
> perhaps there should be a flag to check if a config item is set?

Yet more command line options? Well, there's probably no way around
that in order to maintain backward compatibility.

> More to the point, I can easily imagine many scripts relying on git
> config returning a value to indicate that a config item has been set.
> Your proposed change would break all those. For that reason, it might
> be nicer to introduce a flag that returns the config if it is set or
> the default otherwise. Something like git config --value perhaps.

Right.

-- 
Sebastian Schuberth
