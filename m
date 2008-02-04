From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 4/4] git-submodule: prepare for the .git-file
Date: Mon, 4 Feb 2008 23:44:39 +0100
Message-ID: <8c5c35580802041444y7bda301ctc8ff8df6cc0587a1@mail.gmail.com>
References: <1202158761-31211-1-git-send-email-hjemli@gmail.com>
	 <1202158761-31211-2-git-send-email-hjemli@gmail.com>
	 <1202158761-31211-3-git-send-email-hjemli@gmail.com>
	 <1202158761-31211-4-git-send-email-hjemli@gmail.com>
	 <1202158761-31211-5-git-send-email-hjemli@gmail.com>
	 <20080204222304.GA15178@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 23:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMA40-0001Wp-1T
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 23:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755700AbYBDWon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 17:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755708AbYBDWon
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 17:44:43 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:28376 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbYBDWom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 17:44:42 -0500
Received: by wr-out-0506.google.com with SMTP id c48so1773422wra.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2008 14:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=l5PzYzA5Lkc3DGxosHk1la+Fnt+8ZSzWFmsQRMDs8AY=;
        b=BVVMx0FGPF12aX+CBouBQMBumkEFdKkion9grlYogoSVg+fihHTrdlOncKRL0uSv2kovrluAErm3oMrEvp4MUQhRz9x2v5VGgv4eOd+t2Am18UCe+RtI0Rf5PxysJnmd8N79VTQWST73yDB67lLKLPnjv7jZiWhnTRtx4xAPGy0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vMIo89HPRqGd2UvewUpUUX+6ifi1KzoOaG9MWsEvE0Ii7NSzHdfIxdCU4aHjUWVRI3kMpmb9QDkCIhN+Y9onIepE0wPyGNKii06HBeANIcJUJ6R5h4ckv3ErvDH9Nnesrpv1sYkQVWTcwMs7Ooo9iYxlgRBf5qUOPUdwv6iwv5M=
Received: by 10.114.156.1 with SMTP id d1mr7487140wae.120.1202165079459;
        Mon, 04 Feb 2008 14:44:39 -0800 (PST)
Received: by 10.115.73.7 with HTTP; Mon, 4 Feb 2008 14:44:39 -0800 (PST)
In-Reply-To: <20080204222304.GA15178@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72587>

On Feb 4, 2008 11:23 PM, Mike Hommey <mh@glandium.org> wrote:
> On Mon, Feb 04, 2008 at 09:59:21PM +0100, Lars Hjemli wrote:
> > -             if ! test -d "$path"/.git
> > +             if ! test -e "$path"/.git
>
> Is test -e supported by all shells we support ? I have some doubts...
>

I dunno, but we already use it two other places in git-submodule.

I guess we can rewrite it to something like
  test -d $path || test -f $path || test -L $path || exist=0
if needed.

-- 
lh
