From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add -q option to "git rm" to suppress output when there aren't errors.
Date: Mon, 16 Apr 2007 09:54:43 +0200
Message-ID: <81b0412b0704160054gd31f5aak961de15dbcba3956@mail.gmail.com>
References: <20070416000408.GA19107@midwinter.com>
	 <7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
	 <4622C0AC.8090904@midwinter.com>
	 <7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Steven Grimm" <koreth@midwinter.com>, git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:54:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM2y-0008Fi-Qw
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbXDPHyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbXDPHyp
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:54:45 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:58082 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526AbXDPHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:54:45 -0400
Received: by an-out-0708.google.com with SMTP id b33so1639677ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 00:54:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tHJzPNvrbnU4FmWGQslWwczHwCHFfe1z3C59rp12z2FvOFQf24tDeWt/0mCJCiUdfA0uTSofKm1qUqaeeV+wEK1/UfnoFPAEl75lPl9/n3oFwsycGi2SE3ZjLDZw+IP0K4y4WKekZWqeDXcMck/FvYzvzLiri47JphDHM7gjp3E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hrFy2BSRiyt2VfqI3Rm3kgT/p4DwZDgs0+EclrtDmQHVL8XvWxlX0c83cMwymVfAdsyTPLD8FJiyWBwnIKSEPNh+LQan7XmeCIQu+b8EmTpUhgMyYt26MI5F4Uu1/XDL6WvV3wNn8rSx9edYflc9/Tj3ln6BShvmlPiPAUc+gnM=
Received: by 10.100.31.2 with SMTP id e2mr4280054ane.1176710083732;
        Mon, 16 Apr 2007 00:54:43 -0700 (PDT)
Received: by 10.100.86.14 with HTTP; Mon, 16 Apr 2007 00:54:43 -0700 (PDT)
In-Reply-To: <7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44611>

On 4/16/07, Junio C Hamano <junkio@cox.net> wrote:
> What does it have to do with anything?
>
> Saying "git rm --quiet foo" from the command line, wishing to
> supress the output, is very understandable.
>
> Saying "git rm --ignore-unmatch foo bar baz", wishing to remove
> bar (which exists) even when foo does not exist, is also very
> understandable.

How about doing what rm(1) does? Something like "rm -f"?
It returns 0 even if nothing given in command-line, but any
error (like permissions) is reported and the status is not 0.

It is often that it is not the commands output which is
annoying, but the _unwanted_ output. No one wants
to see "rm 'file'". No one besides people debugging
git-rm (you can't even use it for copy and paste of the filenames:
it has "rm"'s in the text).
