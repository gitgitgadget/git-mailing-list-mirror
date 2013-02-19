From: Shawn Pearce <spearce@spearce.org>
Subject: Re: feature request
Date: Tue, 19 Feb 2013 14:27:19 -0800
Message-ID: <CAJo=hJvmaj4Yn6ACDxQvnetfU+ay1hbfwsnCNN+tGG9MNoovkA@mail.gmail.com>
References: <BLU0-SMTP2753D5BFC50D7334EDDE278E1F40@phx.gbl>
 <CABVa4NgsbeNGS2F2jQJ5d9bDcFb4=oEVrBg_-n2eYjwnfQzMqA@mail.gmail.com> <20130218204511.GA27308@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: James Nylen <jnylen@gmail.com>,
	Jay Townsend <townsend891@hotmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 19 23:28:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7vfR-0003GW-T3
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 23:28:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933913Ab3BSW1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 17:27:41 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42308 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933886Ab3BSW1k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 17:27:40 -0500
Received: by mail-ie0-f174.google.com with SMTP id k10so9041081iea.19
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=X6OBhVmibxRW8lpw7nqpJv55Fm90NiFskCW/MGRs/IU=;
        b=bl+GWOh6HmY+JK0E/Zu10z7hEz9MiBABofVWxI58CZSUGpqqy/B1/Ekva4EuW/04uX
         +kz7PUCS/RojSZBuEiD/oPRXiIU8/uGHG8jv8xQ7JixUxMRH26DQsqVR4kAn4WHrTB4D
         NCzEmeEmBqwDghPyAJhL/4ycSoDZDhJUFONQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=X6OBhVmibxRW8lpw7nqpJv55Fm90NiFskCW/MGRs/IU=;
        b=hTAGbn9vlTxMDSbKqIDga0ZFGNMjnD7HAdKoemlED/5/hEuvcMmqJSbwHg2GqWVE9V
         gmkvP1Opf3/n4ETdMbP3FqbQD6jZDnqy0jOVNWxYksGN22crzH90Uzoz55p93CdT9LCQ
         J/w+Q2IqH0gXoEfggBxWX80uezn/DadkvI04cH0LaCc5PzoozYMQnMF+kiLQWwqhTzqM
         WGuknwEekY1pVnDr0M2Ombfm407howFE+7Kjx2zzJBERzi4t1+GbhJ2rSf+YY1n4kW7u
         2UftpWeXeReOtq2RWInXHvIS2mPBUmAOF7AT04iqmdOZOCDbF/nmYsZeaGEWtYmGeSwD
         5k4w==
X-Received: by 10.50.170.102 with SMTP id al6mr10344249igc.20.1361312860041;
 Tue, 19 Feb 2013 14:27:40 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Tue, 19 Feb 2013 14:27:19 -0800 (PST)
In-Reply-To: <20130218204511.GA27308@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmZdPObumJ5RxdoMBTuOkYwEG1/n/1fzRn9ZSa5qd1hnTNBJ5Xp+k7JqrgJiA5kJ0mkqu3q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216664>

On Mon, Feb 18, 2013 at 12:45 PM, Jeff King <peff@peff.net> wrote:
>
> The thing that makes 2FA usable in the web browser setting is that you
> authenticate only occasionally, and get a token (i.e., a cookie) from
> the server that lets you have a longer session without re-authenticating.

Right, otherwise you spend all day typing in your credentials and
syncing with the 2nd factor device.

> I suspect a usable 2FA scheme for http pushes would involve a special
> credential helper that did the 2FA auth to receive a cookie on the first
> use, cached the cookie, and then provided it for subsequent auth
> requests. That would not necessarily involve changing git, but it would
> mean writing the appropriate helper (and the server side to match). I
> seem to recall Shawn mentioning that Google does something like this
> internally, but I don't know the details[1].
...
> [1] I don't know if Google's system is based on the Google Authenticator
>     system. But it would be great if there could be an open,
>     standards-based system for doing 2FA+cookie authentication like
>     this. I'd hate to have "the GitHub credential helper" and "the
>     Google credential helper". I'm not well-versed enough in the area to
>     know what's feasible and what the standards are.

Yes, it is based on the Google Authenticator system, but that's not
relevant to how Git works with it. :-)

We have a special "git-remote-sso" helper we install onto corporate
workstations. This allows Git to understand the "sso://" protocol.
git-remote-sso is a small application that:

- reads the URL from the command line,
- makes sure a Netscape style cookies file has a current cookie for
the named host,
   - acquires or updates cookie if necessary
- rewrites the URL to be https://
- execs `git -c http.cookiefile=$cookiefile remote-https $URL`

The way 2FA works is the user authenticates to a special internal SSO
management point in their web browser once per period (I decline to
say how often but its tolerable). Users typically are presented this
SSO page anyway by other applications they visit, or they bookmark the
main entry point. A Chrome or Firefox extension has been installed and
authorized to steal cookies from this host. The extension writes the
user's cookie to a local file on disk. Our git-remote-sso tool uses
this cookie file to setup per-host cookies on demand within the
authentication period.

Horrifically hacky. It would be nice if this was more integrated into
Git itself, where the cookies could be acquired/refreshed through the
credential helper system rather than wrapping git-remote-https with a
magical URL. I am a fan of the way our extension manages to get the
token conveyed automatically for me. Much easier than the OAuth
flows[2], but harder to replicate in the wild. Our IT group makes sure
the extension is installed on workstations as part of the base OS
image.

[2] https://developers.google.com/storage/docs/gsutil_install#authenticate
