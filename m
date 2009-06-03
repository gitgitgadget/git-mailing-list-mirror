From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 23:20:19 +0200
Message-ID: <200906032320.23559.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906030250.01413.jnareb@gmail.com> <alpine.LSU.2.00.0906032147330.31588@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Wed Jun 03 23:15:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBxoQ-0002gi-29
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 23:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669AbZFCVPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbZFCVPn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 17:15:43 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:43232 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbZFCVPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 17:15:43 -0400
Received: by bwz9 with SMTP id 9so294980bwz.37
        for <git@vger.kernel.org>; Wed, 03 Jun 2009 14:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=f2OLD21pDMWg7H4WKlCtyA01r65SbZKJSYa7bQbXZU4=;
        b=twhmxUguUUjx9T36tvXO02mq0DrIVIXQDw+NgmBcnskOtB0rjROxYtItfK5J1hnWyv
         eooi14t83YoIq8j1As18cmZO5Ar4NMJT/a5L1j8iv9UWKd3QrYf5ZOhfdz+ozXtWo7ow
         N6eIfqO2b5ihQs0suf/Ku9BRs8cmTyw2iNvM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KZxRlYMiqkJHBYx6Alg+vt4irrPDtpQDHOCGiShB0tAnt+XwYLeiIiIHTODbfZd2Yu
         W2N+URTjStg4Tbxkou8hlWMnamM3ZqUjwq/XNNpC5H4zklF2EUXObS+uQd3q1TgF66Bv
         0lQVGDgNh/kFYJUisVHQIYPdLZCg0KSXNKThM=
Received: by 10.204.31.82 with SMTP id x18mr1309681bkc.5.1244063744000;
        Wed, 03 Jun 2009 14:15:44 -0700 (PDT)
Received: from ?192.168.1.13? (absh69.neoplus.adsl.tpnet.pl [83.8.127.69])
        by mx.google.com with ESMTPS id 12sm10638659fks.51.2009.06.03.14.15.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Jun 2009 14:15:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.2.00.0906032147330.31588@hermes-2.csi.cam.ac.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120643>

On Wed, 3 Jan 2009, Tony Finch wrote:
> On Wed, 3 Jun 2009, Jakub Narebski wrote:
> >
> >      HEXDIGIT = 0-9 / a-f
> >
> > Well, it should probably be spelled in full. Probably, because I have
> > no experience with using ABNF... and didn't do my research :-)
> 
> The ABNF core rules include a definition for HEXDIG. See appendix B of
> RFC 5234.

I have found it _after_ sending this post in Wikipedia article (which
is shorter than RFC 5234), but thanks anyway.

> > (should HEXDIGIT use lowercase a-f, or can it use uppercase A-F?)
> 
> Double-quoted strings in ABNF are case-insensitive ASCII, so the HEXDIG
> rule accepts both. You need to use %x61 if you want a but not A.

        HEXDIG_LC = DIGIT / %x61-%x66  ; 0-9a-f, case sensitive

Actually git accepts both lowercase and uppercase in HEXDIG (at least
for pkt-length), but it prefers lowercase.
-- 
Jakub Narebski
Poland
