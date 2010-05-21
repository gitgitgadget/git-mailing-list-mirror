From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Use "git pull --ff-only" by default?
Date: Fri, 21 May 2010 15:13:38 -0400
Message-ID: <AANLkTilfD1jhDcyuK9zAthlW4vRU-15TmBgYlc16W0Ux@mail.gmail.com>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
	 <4BF68F5F.9010309@drmicha.warpmail.net>
	 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
	 <4BF6A445.1030105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 21 21:13:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFXfH-0002VA-R5
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 21:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758156Ab0EUTNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 15:13:42 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:40287 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab0EUTNl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 15:13:41 -0400
Received: by iwn6 with SMTP id 6so1533896iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=BHaTG2ds6wl/Jm11RpQIuSF7kq3BrWnKzP0+TKnigis=;
        b=AjdguUvTztG5Y4pbzqwpQLf9/h11tCq+eYwTyYRxMHr86gNOl0XieG+rF/JPkF6/Ze
         m1qeioNDlnr+d3Bpan14KcW+ODhfkWhKSaGzEwWERJs1BKCIWmNQYVuS0WONJQEN7LFX
         GZRyRwwBetjjoZtCWS2RqYZDq5FK4ISmvrnoY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=I8Dkyiu+DrnY9cvsGQjJAmH3qzqY0n+uK/1ZLFOOe01ldkDgVHkNbDDwVy9Y8FaMgE
         z/z1f2OOsBOTGrTRyOepqVesSq6rgVAXRKi5xHympkz+O9xaQ50UcJ6q/xBB3+RR62TN
         Do/uXJuuqpkiBLrx5xdKrYiMLU4dNwiVVIM2g=
Received: by 10.231.155.131 with SMTP id s3mr1664345ibw.2.1274469219083; Fri, 
	21 May 2010 12:13:39 -0700 (PDT)
Received: by 10.231.34.8 with HTTP; Fri, 21 May 2010 12:13:38 -0700 (PDT)
In-Reply-To: <4BF6A445.1030105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147494>

On Fri, May 21, 2010 at 11:18 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> git config alias.pull 'pull --ff-only'

That won't work. You cannot override built-in commands. Look at
run.argv() in git.c and notice it doesn't process aliases unless
handle_internal_command() and execv_dashed_external() fail.

j.
