From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pretty format specifier for commit count?
Date: Mon, 19 Jan 2015 14:54:13 +0100
Message-ID: <54BD0C85.1070001@drmicha.warpmail.net>
References: <20150119012926.GA24004@thin>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 19 14:54:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDCmZ-0003kR-Ri
	for gcvg-git-2@plane.gmane.org; Mon, 19 Jan 2015 14:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbbASNyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2015 08:54:15 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45945 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbbASNyP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Jan 2015 08:54:15 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 8148C2092A
	for <git@vger.kernel.org>; Mon, 19 Jan 2015 08:54:14 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Mon, 19 Jan 2015 08:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=NT+7LuT3KHs8QZMD6uGNf1
	RvtzQ=; b=aLm90gvdC+vFlDw/26l587RXjqOy0cZn9rrVKqvtbRtDay7ECyX0zr
	QJSvQY4tbVSToxBi1F2rc+nqorgj00AW72IB2pboyC85jfdmRxeULAWAGFivh6qM
	qrviAMnSj+xPNuDQvhD0g90Sifwp7Lgm4fLht7pNyZtPZXk75rWis=
X-Sasl-enc: E6Fgrp4H5lutvykoyXNrUTGjbb5k8dIGIU9utjs9fzHr 1421675654
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 06BE2680100;
	Mon, 19 Jan 2015 08:54:13 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150119012926.GA24004@thin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262613>

Josh Triplett schrieb am 19.01.2015 um 02:29:
> I'd like to use git-log to generate a Debian changelog file (with one
> entry per commit), which has entries like this:
> 
> package-name (version-number) unstable; urgency=low
> 
>  * ...
> 
>  -- Example Person <person@example.org>  RFC822-date
> 
> Since I'm intentionally generating one entry per commit, I can generate
> *almost* all of this with git log:
> 
> git log --pretty='format:packagename (FIXME) unstable; urgency=low%n%n  * %s%n%w(0,4,4)%+b%w(0,0,0)%n -- %an <%ae>  %aD%n'
> 
> This produces entries like this:
> 
> packagename (FIXME) unstable; urgency=low
> 
>   * Example change
> 
>     Long description of example change.
> 
>  -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:52 -0800
> 
> packagename (FIXME) unstable; urgency=low
> 
>   * Initial version
> 
>  -- Josh Triplett <josh@joshtriplett.org>  Thu, 8 Jan 2015 16:36:51 -0800
> 
> Would it be possible to add a format specifier producing a commit count,
> similar to that provided by git-describe?  Such a specifier would allow
> filling in the version number in the format above (replacing the FIXME).
> (Note that the version numbers need to monotonically increase; otherwise
> I would just use the commit hash as the version numer.)
> 
> - Josh Triplett
> 

Can you be a bit more specific about the type count that you are after?
"git describe" counts commits since the most recent tag (possibly within
a specific subset of all tags). Is that your desired format?

(I won't suggest scripting around rev-list, describe and log -1 because
you know that already...)

Michael
