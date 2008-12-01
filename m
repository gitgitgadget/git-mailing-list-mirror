From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Add 'sane' mode to 'git reset'
Date: Mon, 1 Dec 2008 12:44:52 -0500
Message-ID: <32541b130812010944k3dd825e4pfa8c270ecc75d539@mail.gmail.com>
References: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Dec 01 18:46:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7CqZ-0006Hh-Ik
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 18:46:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbYLARoy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 12:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYLARoy
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 12:44:54 -0500
Received: from yx-out-2324.google.com ([74.125.44.30]:49912 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177AbYLARoy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 12:44:54 -0500
Received: by yx-out-2324.google.com with SMTP id 8so988666yxm.1
        for <git@vger.kernel.org>; Mon, 01 Dec 2008 09:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=icZqrVu/ftYyiSIu2zhT65Wmv09vorinnG4H775Ru5Q=;
        b=HZgkOv5IzcHXrJYXoHB6b5nGPmzhFZyGA412kogFXRxoAd4C33NMhrGIbaQpY6xCpa
         4Evf30dMUqdwAXXgWMuNzzC8b3r8v9FDJqx/wIMedPKnEe6aQtuOqukG3kgzY8p/oBY6
         I6tX9iolKGwKx2f192l15/RkRtjMQrb6RBWdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TVVvI1v6WzglpI/7J6gZwkaAcQSVIiMEA2gXoLI9fEQ2gWWFeYm0es+Xnb/fXZkPqY
         HBWibt/kAV4EjASMr1Z/ZQTmcnsBvj+UrUu8BkaRicOPEw2AAQSD46MIvzDxpKPW5hGR
         0/WFKcucoWYXL1NkSyC5xE2+5IhCyMMBcKuy4=
Received: by 10.150.50.1 with SMTP id x1mr22137575ybx.249.1228153492781;
        Mon, 01 Dec 2008 09:44:52 -0800 (PST)
Received: by 10.150.98.19 with HTTP; Mon, 1 Dec 2008 09:44:52 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812010908120.3256@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102071>

On Mon, Dec 1, 2008 at 12:30 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> So add this kind of mode to "git reset", and since it's probably the
> sanest form of reset (it will not throw any state away), just call it
> that: "git reset --sane". It should probably be the default, but we likely
> cannot change the semantics of a regular "git reset", even though it is
> unlikely that very many people really use the current (insane) default
> mode of "--mixed" that only resets the index.

For reference, I advised someone just yesterday to use "git reset
HEAD^" to undo an accidental "commit -a" instead of just "commit".
Also, as far as I know, "git reset HEAD filename" is the only
recommended way to undo an accidental "git add".  (Which I do
sometimes when I meant to write "git add -p".)  Those two options are
pretty common, I think, and are also perfectly "sane".

How about calling it --merge instead?  That's really what it does:
merges the diffs from (your current index) to (the requested index)
into (your working tree and your index).

Or --keep, because it keeps your working tree changes.

Have fun,

Avery
