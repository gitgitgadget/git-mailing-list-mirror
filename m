From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv1+eps] git-repack.txt: Clarify implications of -a for dumb 
	protocols
Date: Fri, 5 Jun 2009 12:14:15 -0700
Message-ID: <780e0a6b0906051214t76f2bf37u96cc0b8039f63d23@mail.gmail.com>
References: <200906031950.56974.lists@informa.tiker.net> <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net> 
	<780e0a6b0906041246k43d42af1xe623168c52ff7e4f@mail.gmail.com> 
	<4A28D470.5030403@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, lists@informa.tiker.net,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 05 21:14:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCesF-00079u-G5
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 21:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752030AbZFETOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 15:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbZFETOe
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 15:14:34 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:45324 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876AbZFETOd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 15:14:33 -0400
Received: by gxk10 with SMTP id 10so3127348gxk.13
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 12:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=z1bjtpa18TzkMmkIO+zkf3wxu0UBwjv8zWD33ejRIjI=;
        b=bFxxJQgkOtWC9UPOmmb96a9bnHEr5j9sQGbvkgA+Rk4zQ/DOdZwFA0uv8AknNa5C4k
         Cw/dI9HZ3GzaNVKYRTt5hu/6+fIAuck+B+/9Ju1+OiLgDokVSC/289orLUQguGXq9/Fi
         43Ufj210Vam1KmygsDF7cp54WkglaDePGnS1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=pCrFiItBz8JCpJ9s1Er446lEiOklVhp22kgCj4RpnzvaAx9T9xIVtnlMGhGMJreBY8
         JDiEx3R1i1ZOKtsxuETdFq/B2e4Eqx1Bf1NS8NhLcCjSwHc2vsaL2rDuXlQTm+zNZDSa
         JQtIk2cfhoweliq4TWjFSyC2RdrR/F+wtLgHw=
Received: by 10.100.41.9 with SMTP id o9mr4429334ano.155.1244229275279; Fri, 
	05 Jun 2009 12:14:35 -0700 (PDT)
In-Reply-To: <4A28D470.5030403@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120820>

On Fri, Jun 5, 2009 at 1:16 AM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> Stephen Boyd venit, vidit, dixit 04.06.2009 21:46:
>> Instead of adding this, why don't we just remove the part about dumb
>> protocols? So just say that it's especially useful for private
>> development. Then, if we really want to keep this performance note
>> just add it after the paragraph in one of those "+" things (What are
>> those called?)
>
> ...because "repack -a" hurts *badly* on even midsized repos when dumb
> protocols are used. On the other hand, using it isn't that much of an
> improvement in terms of pack size, unless you repack manually very often
> and, thus, produce many small packs. So, "gc --auto" users should be
> fine in any case (dumb or not - the protocol, that is...) as long as
> they don't use "-a".

Maybe I spoke wrongly. I'm suggesting something like

       Especially useful when packing a repository that is used
       for private development.  Use with '-d'.  This will clean up
       the objects that `git prune` leaves behind, but
       `git fsck --full` shows as dangling.
+
Note: Users fetching over dumb protocols will have to fetch the
whole pack in order to get any contained object, no matter how
many other objects in that pack they already have locally.

I think this Note part probably needs some work though.
