From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 16:50:32 +0200
Message-ID: <CAB9Jk9A-uXXXKCBKvxyDN6QQx1b0zqemg7UbeRMcWeY7gi4MRQ@mail.gmail.com>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
	<CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
	<CAB9Jk9COSZOske5xzgnE=1oHe7qiwwOzHYE6pJkuZ0sZyZYhng@mail.gmail.com>
	<m2d3049hvs.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ben Walton <bdwalton@gmail.com>, git <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Oct 27 16:50:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS7io-0001tW-51
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 16:50:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab2J0Oud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 10:50:33 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42739 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436Ab2J0Oud (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 10:50:33 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so3364325pbb.19
        for <git@vger.kernel.org>; Sat, 27 Oct 2012 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1auhFwZkpx6fsxIvNtPoVwN33jQItevAE4g6muXZAzg=;
        b=ycjvH9fE0O8IQMmU2evPZ5cPfKX+HMn/+xts6cbfL7OjiIELYMOxsw4mMT2E19jqel
         afC0TQRg/okEoJPP2cLqOyYargNLW5CY+MVS35JRSX4StQlnwCWt5YfJOTe8p9TrbuoK
         xndeIxtifM5shmAICC9OCl6prIUhQxYxTmpleGouB4oo3rR4WhtBkDiHfLsUmHvllWSi
         HBPT1nTKkBjXhDeSoc3Z5gaVQ5dcSQy/PnC0TmDZL1yfbT+QmVtelgZ7cC7lRr5BNyVh
         IJ98nd2kFjE+B2Vq85tSiETgAcrZzC2Y/X315nE8h6KiRPp2CGjb/huECPpbp+VlYWKj
         mQdg==
Received: by 10.66.76.98 with SMTP id j2mr70140907paw.65.1351349432798; Sat,
 27 Oct 2012 07:50:32 -0700 (PDT)
Received: by 10.67.3.101 with HTTP; Sat, 27 Oct 2012 07:50:32 -0700 (PDT)
In-Reply-To: <m2d3049hvs.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208510>

Hi Andreas,

>
> Is grep not finding a match an error?  Is cmp finding a difference an
> error?  It all depends on the context.
>

Manpage of grep, exit staus:

   "Normally, the exit status is 0 if selected lines are found and 1
otherwise. But the exit status is 2 if an error occurred, ..."

cmp uses the same convention (albeit not reported in its manpage).

I am not stating that all linux commands and utilities follow exactly
the same convention, but these
two are at least consistent with themselves always returning an exit
status that has a well defined meaning. git-config returns
consistently the exit status, it only issues in certain cases messages
and in others not. A consistent solution could be for it to return 0
upon success, 1 when the section or key is absent, and 2 when the
config file does not exist or is corrupt issuing also an error
message.

-Angelo

>> How can otherwise the user tell a corrupted configuration file from a
>> missing key?
>
> You cannot, as long as your configuration file is well-formed, because a
> missing key is an expected condition in many cases.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
> "And now for something completely different."
