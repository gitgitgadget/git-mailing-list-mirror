From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Large-scale configuration backup with GIT?
Date: Mon, 3 Sep 2007 12:35:17 +1200
Message-ID: <46a038f90709021735n3d82061eh6d8d35989075022f@mail.gmail.com>
References: <20070902201724.GB10567@lug-owl.de>
	 <7vd4x0pwjm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jan-Benedict Glaw" <jbglaw@lug-owl.de>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 02:35:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRzuX-0004bu-Ih
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 02:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbXICAfW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 20:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXICAfV
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 20:35:21 -0400
Received: from fk-out-0910.google.com ([209.85.128.188]:4512 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbXICAfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 20:35:21 -0400
Received: by fk-out-0910.google.com with SMTP id z23so1228517fkz
        for <git@vger.kernel.org>; Sun, 02 Sep 2007 17:35:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n08oIkjstAzD7fXPcrqu23yBSlRGGs1+kr8cn1XDElt7baqBoPYeHinkzEpfRNEN4z2rOADiTHed8VHZS5/5zfuO3/CZ9TdPUz0G9GXmFRVeEmcFMs5jsVEdtwLHCxyhZb/kS3X6ImQezNZ2q4j4TYmOwPxEYwxAOF6QEUlKk7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OpGNdKhshcDO1gh9l8AFeM/IDtRp2YbcMNYfqT67CE3JQODehLvjeKrFX976gB5ZVI69nfvbrwMmN/+hO8LadoS3hgj5u4yqDXOeL9r1wgd3Ef2Axwga3WXeKwXILLt+1bjTDm3S8jXh98s7G1iTdePYnunRuagii7jhPsBtj5E=
Received: by 10.82.174.20 with SMTP id w20mr2718876bue.1188779717189;
        Sun, 02 Sep 2007 17:35:17 -0700 (PDT)
Received: by 10.67.40.9 with HTTP; Sun, 2 Sep 2007 17:35:17 -0700 (PDT)
In-Reply-To: <7vd4x0pwjm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57418>

On 9/3/07, Junio C Hamano <gitster@pobox.com> wrote:
> This is something similar to what I and others in my group did
> long time before git was even invented.  I'd suggest you go in
> the opposite direction.

Agreed. The infrustructures.org crowd has been exploring this space
quite a bit, and developing tools like isconf that allow you to manage
a huge number of machines across various unixen.

And recently someone's integrated Debian APT with git tracking config
files (called IsiSetup http://www.isisetup.ch/ ). I haven't reviewed
it in detail, but it'd be first on my list.

> If you have 5 configurations, each of which have 20 machines
> that _should_ share that configuration (modulo obvious
> differences that come from hostname, IP address assignment,
> etc), then

Indeed. I ended up liking the makefile-stanzas approach it is
incredibly simple and flexible. Add debian/rpm packages, some of the
tools in the cfengine toolchain, git to track your
scripts/configuration and you are golden.

For the Windows side of things, see "Real Men Don't Click"
<http://isg.ee.ethz.ch/tools/realmen/> -- a bunch of unixy sysadmins
with the "infrastructures.org" background took on Windows
servers/desktops management -- and succeeded. PG-rated, fun for the
whole family. ;-)

HTH,



martin-who-survived-the-sysadmin-wars
