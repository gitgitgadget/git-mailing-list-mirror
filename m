From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 07/18] revert: put option information in an option
 struct
Date: Fri, 26 Nov 2010 00:18:31 -0600
Message-ID: <20101126061831.GE18751@burratino>
References: <20101125210138.5188.13115.chriscool@tuxfamily.org>
 <20101125212050.5188.8316.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Nov 26 07:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLrio-00085E-0A
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 07:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501Ab0KZGSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Nov 2010 01:18:38 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53652 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab0KZGSh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Nov 2010 01:18:37 -0500
Received: by gwj20 with SMTP id 20so793015gwj.19
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 22:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=yzwvo7PGU5D9mfC29+LtmVYdJS4Lp0qeyz5QN8rqXVk=;
        b=gmBcBrwR0ev8U+LQ0zkdLKG4yQP28QUHWQcJqLVdl2DcRT/YPsDnjH9c6NpdT/4EOl
         pUOmmJaGDc06Oiqo1f8eYSG9rRbgeTbWRQyWeKRMxqk8Gsj3Z5qBXSpPHjHdsNn+DED+
         sGRtPLQdZVCIint6hoAeI12CenE+9lw5/aAkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ruykupml0fcGVTvAmjuoUh0zweQ/2tvBx8YohH4/RUaQYsyyviCe1401zKSHeZMTJ0
         GobVQtYX9iVYcvK8WqJrNrVYeyvvoUax5jZTdGKEBm88Q9Ys+/gofZ+53QvUKJKSzwT2
         3fxiOR4O6KBGl38VJp1fgCQaOA3uLmbF5bj7g=
Received: by 10.151.10.12 with SMTP id n12mr4377223ybi.318.1290752316131;
        Thu, 25 Nov 2010 22:18:36 -0800 (PST)
Received: from burratino (adsl-68-255-101-216.dsl.chcgil.sbcglobal.net [68.255.101.216])
        by mx.google.com with ESMTPS id w5sm1134043ybe.10.2010.11.25.22.18.34
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 25 Nov 2010 22:18:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101125212050.5188.8316.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162205>

Christian Couder wrote:

> This is needed because we want to reuse the parse_args() function
> so that we can parse options saved in a TODO file.

Why couldn't parse_args() write to the globals?  I would be more
convinced by an explanation like

	This helps attain greater sanity by being explicit
	about which functions depend on the parameters passed
	to cherry-pick.
