From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/2] merge-file: correctly find files when called in
 subdir
Date: Sun, 17 Oct 2010 14:59:14 -0500
Message-ID: <20101017195914.GA3434@burratino>
References: <64b470380b8f7bd8afe8f019553cb99f72091c7d.1287342969.git.trast@student.ethz.ch>
 <d0e540fdced31557e983d7503da3dcb75c622dc9.1287342969.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	msysgit@googlegroups.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Oct 17 22:03:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7ZRd-0003fn-Jw
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 22:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685Ab0JQUC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 16:02:56 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51179 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932639Ab0JQUCz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 16:02:55 -0400
Received: by ywi6 with SMTP id 6so59860ywi.19
        for <git@vger.kernel.org>; Sun, 17 Oct 2010 13:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=6OlOWfYMdVdWqBjnClmfrfD2GzRRBXQu03cv/+mKnhc=;
        b=kkKygIIjsMVj+A4gapQclXTzdPJaJ9paLmrTo7+sQf5A0tOBwosCSL+V/vJUdh2Vot
         XZ10m855xaGJGMmKQBojDPFENvVtpLb7PsBEZRw2i7VClUVHlW8XPyBzjIDlXfxB3tnF
         DsNhP0UK/dJExpF1nWBaCiqKfUnsRE5jBzmfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BXEpTyNinB0cxU7WN3bO/+QqtGL0I27gUkGawE98+wxzY8mvMWrBU6PK0xpBL8fXvh
         Z8uxYEN1TlRbFiumtoq6rRLYWB47PtGePN6kmLSGvXjCES8A5ytCxzNk9Xn9rtZ1KuR2
         G43OEgwo1NCAv4qliCH+3JwjAc7QrxbBop0Ig=
Received: by 10.100.209.17 with SMTP id h17mr1445175ang.94.1287345774477;
        Sun, 17 Oct 2010 13:02:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id w32sm18713670ana.17.2010.10.17.13.02.52
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 17 Oct 2010 13:02:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <d0e540fdced31557e983d7503da3dcb75c622dc9.1287342969.git.trast@student.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159217>

Thomas Rast wrote:

> This is a slight semantic change on Windows, because it now
> substitutes / for \ in paths, but I suppose that's harmless?

Yeah, I think it doesn't matter either way.  cc-ing msysgit@
just in case.

>  builtin/merge-file.c  |    7 ++++++-
>  t/t6023-merge-file.sh |    8 ++++++++
>  2 files changed, 14 insertions(+), 1 deletions(-)

FWIW I still like both patches.
