From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/3] t3404: preserve test_tick state across short SHA-1
 collision test
Date: Sun, 25 Aug 2013 01:53:18 -0700
Message-ID: <20130825085318.GV2882@elie.Belkin>
References: <1377112378-45511-1-git-send-email-sunshine@sunshineco.com>
 <1377112378-45511-2-git-send-email-sunshine@sunshineco.com>
 <20130825055550.GN2882@elie.Belkin>
 <CAPig+cSns+_mOMRVRv2Kqb3vHNQGoE4NGZ3ELu7y3pQ57VqPXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 25 10:53:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VDW4f-0004NW-L6
	for gcvg-git-2@plane.gmane.org; Sun, 25 Aug 2013 10:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756166Ab3HYIxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Aug 2013 04:53:25 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:36160 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129Ab3HYIxX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Aug 2013 04:53:23 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so2285325pdj.6
        for <git@vger.kernel.org>; Sun, 25 Aug 2013 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ocHAVyu8G7WvZ1uH32R8JJhJUglFKziG3W46BF0vgj4=;
        b=Q7lN7pBUP5i9yJwIdoULGc69UROIViJgfRPeibddeH3aYltyX/QSUloG2iVfA7F2lx
         doMBYAFawHUll4GF4wLn/BmIcaVZ3Dk2qd6xWYTfIdmbTZz713Bb8rHYxL8XwnQ4PRxC
         uCieoWWwjaoQvZoJmzlCnFek3/EBM1XaaN0AiO7pmA8mpvBML4ctUbxLoWk1kPCNtacl
         J/nDfPAVGx/xP7+Qb/NPvFifXANV5yY2+op7JElkZnweMDVUu4TEx9vDGTEARJbSquGj
         vsc2kADczpXOn4whk5JbQJ450+zxTgSiUuvGwtYliTToujw6RGrufF7cY72I2H/ka39B
         H+gw==
X-Received: by 10.68.252.106 with SMTP id zr10mr9190368pbc.63.1377420803179;
        Sun, 25 Aug 2013 01:53:23 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ta10sm12520568pab.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 25 Aug 2013 01:53:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cSns+_mOMRVRv2Kqb3vHNQGoE4NGZ3ELu7y3pQ57VqPXw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232939>

Eric Sunshine wrote:
> On Sun, Aug 25, 2013 at 1:55 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Would be clearer if the code in a subshell were indented:
>>
>>         (
>>                 unset test_tick &&
>>                 test_commit ...
>>         )
>
> I considered it, but decided against it for a couple reasons:
>
> * In this script, there already is a mix between the two styles:
> indented vs. unindented.
>
> * In this particular patch, the test_commit line creating commit3
> wrapped beyond 80 columns when indented.

I'm just one person, but I find the indented form way more readable.
Long lines or lines with \ continuation are not a big deal.

[...]
>                                      Should this be worth a re-roll?

Since the file already has a mixture of styles, if there's no other
reason to reroll, I'd suggest leaving it alone.

The next time it bugs me or someone else, that person can write a
patch that cleans up the whole file on top. :)

Thanks,
Jonathan
