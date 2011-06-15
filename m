From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Patch-level-format conversion
Date: Wed, 15 Jun 2011 15:55:07 -0500
Message-ID: <20110615205507.GB27172@elie>
References: <BANLkTimRArtFBqA4BFASjkS9BC1sbSfUJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: sedat.dilek@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 15 22:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWx7O-00017i-PC
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 22:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900Ab1FOUzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 16:55:13 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44118 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab1FOUzM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 16:55:12 -0400
Received: by iyb14 with SMTP id 14so586129iyb.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=3U6tHPKIJPt0h4rfOwnkMc0b3jus1cFSlWPx3Zfm/Kk=;
        b=YCqOO/1Uho36YPCNr3pgryvP0BFh0PyCILfYfQB3YArXSJ4pinJ+P6xIm/MQ0AXKS5
         G1ZDNn/MtLnmBHQOKVztqYp/WphfQj2W2NXCbE3Ef37LnhLR/UDCBtact9rEiHd3BcRG
         AxtvluS9mfhrd/2tOMAW/50cELP84Telod2MI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TG4fT3KX9PYOsm4EQBZAsCniHN6OojzmfWgWm0WtJzPOpXiuGDEVyqXL0KWGCjNBZZ
         IFq94wG1Aw8uWmzrach1Kh02MnOc3UXDeBErWc0x5RgnGemKW78dTAhFJow+pRvRSo83
         wvwB90otKPZo2CbKj6wuVmdyLa40IHVl3cYWM=
Received: by 10.231.48.71 with SMTP id q7mr63523ibf.68.1308171311808;
        Wed, 15 Jun 2011 13:55:11 -0700 (PDT)
Received: from elie (adsl-69-209-57-157.dsl.chcgil.sbcglobal.net [69.209.57.157])
        by mx.google.com with ESMTPS id hw7sm727543icc.15.2011.06.15.13.55.09
        (version=SSLv3 cipher=OTHER);
        Wed, 15 Jun 2011 13:55:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimRArtFBqA4BFASjkS9BC1sbSfUJQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175850>

(+cc: the git list so others can correct me.  I hope that's okay.)

Hi,

Sedat Dilek wrote:

> I have here a patchset extracted from my own git-repo (via git format-patch).
>
> The project for which those patches are want "p0" format, means no
> ---- a/... +++ b/... but --- ... +++ ...
>
> IIRC git does "p1" format as default.
> Any help? Idea?

If I understand correctly, you are in luck.  The "git format-patch
--no-prefix" command thanks to Dscho seems to do exactly that:

 $ git log -Sno-prefix -- Documentation/diff-options.txt
 commit eab9a40b6dd5c1c571b1deb264133db47bb4794d
 Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
 Date:   Tue Dec 18 19:32:14 2007 +0000

     Teach diff machinery to display other prefixes than "a/" and "b/"

     With the new options "--src-prefix=<prefix>", "--dst-prefix=<prefix>"
     and "--no-prefix", you can now control the path prefixes of the diff
     machinery.  These used to by hardwired to "a/" for the source prefix
     and "b/" for the destination prefix.

     Initial patch by Pascal Obry.  Sane option names suggested by Linus.

     Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

Hope that helps.
Jonathan
