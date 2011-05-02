From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add --info-path and --man-path options to git.
Date: Mon, 2 May 2011 00:15:07 -0500
Message-ID: <20110502051507.GB14547@elie>
References: <1304237785-56101-1-git-send-email-jon.seymour@gmail.com>
 <7vbozmthhy.fsf@alter.siamese.dyndns.org>
 <20110501234833.GC11550@elie>
 <7v62puq8a5.fsf@alter.siamese.dyndns.org>
 <20110502002535.GE11550@elie>
 <7vzkn5pxv5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Seymour <jon.seymour@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 02 07:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGlTs-0000Mc-6y
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 07:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292Ab1EBFPO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 01:15:14 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33265 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab1EBFPN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 01:15:13 -0400
Received: by iyb14 with SMTP id 14so4403797iyb.19
        for <git@vger.kernel.org>; Sun, 01 May 2011 22:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0f0yKoWuXHstMWXHZlSNr3+RWbinOzN3heTpX+jPhXQ=;
        b=n+DD3ZXkJyTbX89dX7ZWbg9OHYh6xyCVd+JW7RcKu7EOd3MHEDTG5xCPxZxDlahdOW
         OfO+dtit4MEWgQUzLONerNVXVxEFYgurmrx140JzdqxxvmpNC3wqtX2jY6aa/DnwWhaW
         MmXTw/uBR0t3mNHvTzrFKc/M2BBfu+vSWiu2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ME7jHhnbWFTctC1phseytsKoJEXQdiaWigc9ncsqX/K4wv4RIiLyGlZZOK+yMsoxN/
         HfMxmcw2uYYzRt0ueXB/nrJDMLZtzJpn9QDhkQMQmBi8L0Fy67rJWBvIq50DCpgynAUM
         hq0Svf0E+r3dkyztty4ywf7nSSSFy29cbZN4s=
Received: by 10.42.177.202 with SMTP id bj10mr2110663icb.21.1304313312466;
        Sun, 01 May 2011 22:15:12 -0700 (PDT)
Received: from elie (adsl-69-209-62-211.dsl.chcgil.sbcglobal.net [69.209.62.211])
        by mx.google.com with ESMTPS id gx2sm2219776ibb.43.2011.05.01.22.15.10
        (version=SSLv3 cipher=OTHER);
        Sun, 01 May 2011 22:15:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkn5pxv5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172561>

Junio C Hamano wrote:

> Where is your unhappiness coming from?  Is this your argument?
>
>	'git help' allows distros' oversight with its -m and -i options;
>	it discourages distros to get their act together.

No, my discomfort was not on behalf of distros.  It wouldn't do
anything to help or hurt distros, since they would be installing to
/usr/share/man.

When I said "installers' mistakes", I specifically meant the user that
installs manual pages to ~/share/man without setting MANPATH to
include that.  I agreed that that's an unfortunate thing to happen to
anybody, but I didn't think git is the right place to fix it.  Because
it affects anyone else installing something to $HOME, and as a user I
wouldn't _expect_ git to fix it.

What my analysis was missing is that this is not only about the user
who runs "git help -m" as a fancy way of running "man git" and expects
it to work better (who I still have no sympathy for).  It is much more
about the user who runs

	git add --help

or chooses Help =E2=86=92 Manual in her porcelain, who certainly deserv=
es some
documentation whether her MANPATH is set correctly or not.

I also should have remembered v1.5.4-rc0~54 (Let git-help prefer
man-pages installed with this version of git, 2007-12-06), which is
about showing the manual in /opt/git-next/man in preference to a stale
manpage from /opt/git-master/man when running
"/opt/git-next/bin/git add --help".

So I was very confused indeed.  Sorry to waste your time, and thanks
for setting me straight.
