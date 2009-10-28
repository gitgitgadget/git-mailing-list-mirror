From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: From 200 to 404 to 407.
Date: Wed, 28 Oct 2009 11:50:21 -0400
Message-ID: <32541b130910280850t5b4baa91p90b31b4c1c467e94@mail.gmail.com>
References: <82fd2c5d0910270318wc30bc44tfd3362933d3f62cf@mail.gmail.com> 
	<32541b130910270953w6bd35ddctd471e682830b8f62@mail.gmail.com> 
	<82fd2c5d0910280138r52baff98p3f4ff65e968b0d37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?Peter_Od=E9us?= <peter.odeus@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 16:50:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3AnP-0004Vv-8T
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 16:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754647AbZJ1Puh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581AbZJ1Puh
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 11:50:37 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:47119 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbZJ1Pug convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Oct 2009 11:50:36 -0400
Received: by ywh40 with SMTP id 40so756709ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zpRV57XQ/MXWe+IflrmLtUmKhwIv6/N5lU+8X7chd1E=;
        b=PLNnrroi4KKeKorR7KO8z1NOiTvG+OQkd+yY2c64r3tlR6cMle3tXlGwfhIBzxyfp3
         NEOtCqPUVMcKr2p++PSfiKuUbUI16AB2mAqKJUX3tPkXGgKpfrJEoVjLmd7We0SIeQML
         sIkyjIGtPoTd61nTxZraOvhcKed5ymMEo3Ja0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=G4lByFf4CLeAl9NMS3TX3R0noFEhBKyAlCsUYUKBCex193c7C1Zs4xRgOWYDlc6EUE
         tTh5dV2E+FMVHZtVwx91YL+9DNnWp3wspyjG/r7IEpkRPVOTLNNwlbDffBImTpcKVOEt
         nMyAAxrJvT/iEnd1Ort9f+3VJhtD/vrLYD3PY=
Received: by 10.150.8.1 with SMTP id 1mr29359110ybh.151.1256745041065; Wed, 28 
	Oct 2009 08:50:41 -0700 (PDT)
In-Reply-To: <82fd2c5d0910280138r52baff98p3f4ff65e968b0d37@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131476>

On Wed, Oct 28, 2009 at 4:38 AM, Peter Od=E9us <peter.odeus@gmail.com> =
wrote:
> * Re-using existing connection! (#0) with host proxyserver.acme.com
> * Connected to proxyserver.acme.com (192.71.145.9) port 8080
> > GET http://gitrepo.outside.com/git/gitrepo.git/objects/6b/132a9e811=
61e58812902d7f735a38bf5ee1583 HTTP/1.1
> Proxy-Authorization: Basic cmQva3F3Zzc2MjptYW1tYW1pYQ=3D=3D
> User-Agent: git/1.6.5.2
> Host: gitrepo.outside.com
> Accept: */*
>
> * The requested URL returned error: 404

So this git object didn't exist, apparently.  Can you confirm that the
object shouldn't be there?  (on the server: git cat-file -p
6b132a9e81161e58812902d7f735a38bf5ee1583)  Does git-fsck report
anything weird on the server repository?

> * Closing connection #0
> * Couldn't find host gitrepo.outside.com in the .netrc file, using de=
faults
> * About to connect() to proxyserver.acme.com port 8080
> * =A0 Trying 192.71.145.9... * connected
> * Connected to proxyserver.acme.com (192.71.145.9) port 8080
> > GET http://gitrepo.outside.com/git/gitrepo.git/objects/info/http-al=
ternates HTTP/1.1
> User-Agent: git/1.6.5.2
> Host: gitrepo.outside.com
> Accept: */*
> Pragma: no-cache
>
> < HTTP/1.1 407 Proxy Authentication Required ( The ISA Server require=
s
> authorization to fulfill the request. Access to the Web Proxy service
> is denied. =A0)

This error seems to happen because the Proxy-Authorization line was
not included in this request like it was included in prior ones.
Probably the authorization key was forgotten when the first connection
closed.  If there hadn't been a 404, the connection wouldn't have
closed and this wouldn't have happened, which is presumably why you
haven't seen this problem before.

This is where my expertise ends, since I've never messed with either
libcurl or git's usage of it.  I couldn't tell you if this is a
libcurl bug or a git bug.  (Proxies are relatively rare nowadays, so
this code path is likely to be rarely tested.)

Hopefully someone else on the list can assist.

** WARNING: the username/password sent in the Proxy-Authorization line
is not encrypted and you've posted a trace of it to a public mailing
list.  You need to change your password immediately. **

Good luck,

Avery
