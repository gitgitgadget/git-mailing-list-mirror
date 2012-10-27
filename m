From: Ben Walton <bdwalton@gmail.com>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 09:45:24 +0100
Message-ID: <CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Schwab <schwab@linux-m68k.org>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:45:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS21c-0000Qc-4d
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338Ab2J0Ipa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:45:30 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40280 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298Ab2J0IpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:45:25 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so3288953obb.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=snP6sCA8eEAjHqYoWzH14aUgXEWGDb1TDwy7eiyIgas=;
        b=BCTvmYH1taqmsDVCMX4vSOvR6n0QkI7NQ4i/9kvjbzKpU8yAhSRN5nU1R8J7qYezmW
         oDxS1YewGg822iPrpF2bupY2ruj6QS5PUpB4fsZgNkoBQNm38Lnt49qFUHCP1u+pue/j
         LyvP9z9rE9i/Xz9AaXU8O208VgYlkw96to1LDpUbtZyetw3mT3F7OyV0St1Js2LDQyGP
         fs5L/DWtGUNjGr+a5HuN8Xu61038ACCOK5GWIA4V1ZV1Cg79okHb8vRi/xdafSkl3d/1
         oDS7uLoRLLBku4C9AAC30fooDF9xT7oePeSm0mfnuPmzYQKCLldFD9Zd186kHhVXCR2W
         oUew==
Received: by 10.60.31.175 with SMTP id b15mr5266568oei.76.1351327524310; Sat,
 27 Oct 2012 01:45:24 -0700 (PDT)
Received: by 10.76.173.1 with HTTP; Sat, 27 Oct 2012 01:45:24 -0700 (PDT)
In-Reply-To: <CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208503>

On Sat, Oct 27, 2012 at 9:32 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:

Hi Angelo,

> I wrote "value", but I meant "name". The first example I made contains
> a name with a nonexistent section, the second a name with a
> nonexistent key.

This still wouldn't be an error condition though, especially in terms
of how "git config" should treat it.  It should be up to the consumer
of the information to display, or not, any error or diagnostics that
don't result from either a bad request (your first case) or a
malformed configuration file.  This fits with the callback nature of
how the config file is parsed by builtin tools.  The exit code from
"git config" with a missing key is enough for the consumer to make
this decision.

This is just my take on it, but I think the current approach makes sense.

Thanks
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
