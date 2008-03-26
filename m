From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 22:46:42 -0400
Message-ID: <76718490803251946t2640a8d2ga1e68ad06405c076@mail.gmail.com>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
	 <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
	 <200803252031.17017.tlikonen@iki.fi>
	 <20080325230649.GA5273@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>,
	"Samuel Tardieu" <sam@rfc1149.net>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 03:47:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeLfg-0005tz-QR
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 03:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbYCZCqo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 22:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYCZCqn
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 22:46:43 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:16617 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYCZCqn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 22:46:43 -0400
Received: by wa-out-1112.google.com with SMTP id v27so4099661wah.23
        for <git@vger.kernel.org>; Tue, 25 Mar 2008 19:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=E0/iWdtqfFVNi9I94QhLz9NvyC8J8iAYswPReE2i2sM=;
        b=EnkmceW9UgwIlrLK7QiEqC5959Az9oRcFAHtKqov3Wn+ABpt3sIn0hA3ibmyZVWWHP2maxNirKGBmkHoRmeJQ5/SjiqGO2u0oKGO92d/Sq6mjWyM+MwL+KYyDe64xi2tfsEnExMMPM/VW+93Refaq2kbBM8DVfuv4WDTJUbD4PM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jeFIJ7Pq/m42ILoM34nTe+QQICcqtoxXIQw5ly/T4ZIJj6MHog5zLOcwdE1Z8xZffFo2j5NZAJpjOR1qrZonsuCctH9ci4WiiN3wMniImU9onVf+egwkys4E4bBShE2ajKNvOrM6PWwqt6D6Pb5GWkpK3v0njv16xR2xWN2YyOY=
Received: by 10.115.79.1 with SMTP id g1mr14622148wal.43.1206499602468;
        Tue, 25 Mar 2008 19:46:42 -0700 (PDT)
Received: by 10.114.13.5 with HTTP; Tue, 25 Mar 2008 19:46:42 -0700 (PDT)
In-Reply-To: <20080325230649.GA5273@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78246>

On Tue, Mar 25, 2008 at 7:06 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 25, 2008 at 08:31:16PM +0200, Teemu Likonen wrote:
>
>  > By the way, 'git send-email --compose' does not add MIME headers to
>  > introductory message. All non-Ascii chars will output something
>  > undefined in receivers' end.
>  >
>  > I guess the right way would be to detect user's charset (locale) and add
>  > appropriate MIME headers. Also, the Subject field should be encoded if
>  > it contains non-Ascii characters.
>
>  I just posted some patches to fix this; however, they always encode as
>  utf-8. I'm not sure what is the best way to find the user's encoding.
>  AIUI, locale environment variables are not enough, since, e.g., "en_US"
>  could come in iso8859-1 and utf-8 flavors. Is there a portable way to
>  figure this out? Should we be pulling it from .git/config?

I think so. There's no reason the message encoding necessarily matches the
locale anyway. There are ways to guess, but I think .git/config is sanest
with UTF-8 as the default.

j.
