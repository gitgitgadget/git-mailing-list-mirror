From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Linux Kernel based project in git
Date: Tue, 2 Feb 2010 14:53:13 -0500
Message-ID: <32541b131002021153t53d19e32j56be356c219c5780@mail.gmail.com>
References: <9da7f2802f639777acfeb38eb1e3db90.squirrel@webmail.eisendle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: git@eisendle.net
X-From: git-owner@vger.kernel.org Tue Feb 02 20:53:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOod-0000mD-Rn
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475Ab0BBTxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:53:35 -0500
Received: from mail-yx0-f189.google.com ([209.85.210.189]:39839 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755991Ab0BBTxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:53:33 -0500
Received: by yxe27 with SMTP id 27so426071yxe.4
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=OWPU380Zo+13w0Egc8TUaF6Y0fyKlMghSxLxbR+fSs8=;
        b=J3rzthOA0IeTWXGNYEsacozfpolZ/rmkNmen07OFUF21UqN26mkOGXSTm5bG8PL5et
         BU2UbR9PMgDs15OM6VIw+cG3JZTMHHZ0+cQafXf2BINAO1JyqgeOkKmrhVlFRHnKSZng
         IF4SGa9uSD1D44VyDWTLXmTUVZZncpZ0gwM0M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=MzyPC2/i8GwOqsNw15bEWgr2xMxLlHwH2zpvq9zLooIbp9YJcX5yROJszc8g4fUc0B
         x0Mc4t7ktd8+RCcdwT/booD8l734EcqhMf9bIMbRILyJkNjaZhnzYG30R1xtKdnbOET/
         0PeLbPKkFtcauoOBJ12o9aSg677eAqVqACxYY=
Received: by 10.150.62.17 with SMTP id k17mr9357335yba.143.1265140413091; Tue, 
	02 Feb 2010 11:53:33 -0800 (PST)
In-Reply-To: <9da7f2802f639777acfeb38eb1e3db90.squirrel@webmail.eisendle.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138746>

On Tue, Feb 2, 2010 at 4:05 AM,  <git@eisendle.net> wrote:
> For release we always generate 3 patches:
> - BSP patch
> - USB patch (since USB part is an external patch comming from a 3rd party)
> - WiFi patch (same as for USB)
>
> So my question is:
> What's the best way for handling this inside the git repository?
>
> IMHO it would make sense to have 3 branches (BSP, USB, WiFi) each based on
> unmodified 2.6.22 Kernel. USB and WiFi branch is used for generating the
> patch and for applying possible fixes. BSP branch for actual BSP related
> feature development and fixes.
> The changes in these branches are merged into the master branch which is
> used for compiling/testing the whole BSP.

Are you planning to submit these patches upstream at any point?  If
not, it might be easiest to just jam them all together in one branch
and not look back.  Since it seems like they probably affect quite
different parts of the code, you could always extract a clean set of
patches *later* and submit those patches upstream.

But that's just my lazy advice :)  The disadvantage to maintaining
them in separate branches is that probably none of the three branches
will work on its own anyway, since you don't have a physical device
that only has the new USB device, or only the new WiFi device, or only
needs the BSP but doesn't have updated USB or WiFi.  Putting them in
separate branches is therefore a bit artificial and won't buy you
much.

Have fun,

Avery
