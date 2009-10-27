From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: From 200 to 404 to 407.
Date: Tue, 27 Oct 2009 12:53:39 -0400
Message-ID: <32541b130910270953w6bd35ddctd471e682830b8f62@mail.gmail.com>
References: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Peter_Od=E9us?= <peter.odeus@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 17:54:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2pJ8-0002Ab-GE
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 17:54:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175AbZJ0Qxz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Oct 2009 12:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756172AbZJ0Qxz
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 12:53:55 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:52374 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756123AbZJ0Qxy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 12:53:54 -0400
Received: by ywh40 with SMTP id 40so303305ywh.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=CtP4sHoPjWxDnq//AJ6eBbUpswBVRo3JbqCeukc5kN0=;
        b=eKN9JFDDTQaqtT3pdJSOe61OZEkoSMD11vHAWKKY7+L2MsN17SmqjcivAMQo9qUs7t
         lFqAb6apVtFbiS0ELfnxl3HQLq0Y2rG2yWdpu6reK785rcTMV2v2pYOEp0of8wDMUzEJ
         95Nq/CjudAX1QBg2dpivpX2mxPQmoyEhS+EZg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gP13ju7AZTPHib7rbUa9peGDr+e7tQ+ZgGid2DetcbfwCSid48BdPF5kQpFVJ9kgzF
         8Gw0ytFtqai5FzWta3Fkyg4M1efFL5oWdHTM4rfyXbgwbVJHLsrb4nX0gLpxB/6St+ds
         xbIuN3ifeFmyvV9O5H0zeyZVYn0yv6MAs4p+A=
Received: by 10.150.20.1 with SMTP id 1mr5149447ybt.4.1256662439096; Tue, 27 
	Oct 2009 09:53:59 -0700 (PDT)
In-Reply-To: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131359>

On Tue, Oct 27, 2009 at 6:18 AM, Peter Od=E9us <peter.odeus@gmail.com> =
wrote:
> Doing a "git clone..." using authenticated proxy (set in $http_proxy)=
:
>
> Upon initial success (HTTP 200) and receiving a single HTTP 404 (not
> found), every GET after that renders a HTTP 407 (Proxy authentication
> required).
>
> curl -I "url_giving_http_407" comes out just fine as a HTTP 200.

The easiest way to track this down is to log it using ethereal, and
compare the http session dumps.  There may be differences in headers
or something that git is providing vs. the command-line curl.

If you don't know how to analyze http dumps, then just log them to a
file using tcpdump's -w option and email them to me, and I'll take a
look.  (I probably won't fix the bug in git, but I can at least tell
you what/if the bug is :))  Please don't send the binary dumpfiles to
the mailing list, though.

Have fun,

Avery
