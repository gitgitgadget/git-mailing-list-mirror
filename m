From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Tue, 21 Aug 2007 08:04:14 +0200
Message-ID: <856439o23l.fsf@lola.goethe.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
	<86zm0mgicy.fsf@lola.quinscape.zz>
	<20070820184829.GA8617@glandium.org> <853ayeos82.fsf@lola.goethe.zz>
	<20070820205042.GB10173@glandium.org>
	<20070821013541.GC27913@spearce.org>
	<7vejhxproc.fsf@gitster.siamese.dyndns.org>
	<20070821053451.GA11153@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:04:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INMrF-0002ej-6l
	for gcvg-git@gmane.org; Tue, 21 Aug 2007 08:04:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758785AbXHUGEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Aug 2007 02:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756263AbXHUGEd
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Aug 2007 02:04:33 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:37590 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755384AbXHUGEb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2007 02:04:31 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id B43E831EF5F;
	Tue, 21 Aug 2007 08:04:30 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id A29F413EE73;
	Tue, 21 Aug 2007 08:04:30 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-028-007.pools.arcor-ip.net [84.61.28.7])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 31D083425E8;
	Tue, 21 Aug 2007 08:04:18 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id A8AA01C36605; Tue, 21 Aug 2007 08:04:14 +0200 (CEST)
In-Reply-To: <20070821053451.GA11153@glandium.org> (Mike Hommey's message of "Tue\, 21 Aug 2007 07\:34\:51 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4016/Tue Aug 21 01:40:52 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56278>

Mike Hommey <mh@glandium.org> writes:

> Anyways, that still doesn't say why all these permission bits are
> kept while only the executable bit matters, though it must be
> related to backwards compatibility of hashes.

It is not much that will in practice be retained.  Keeping the whole
kaboodle (including uid and gid) makes git suitable for archival
purposes on Posixy platforms.  The current code offers just a single
policy (suitable for distributed development) with regard to what it
maintains and stores (well, actually two: you can tell it to ignore
the execute bit from the file system), but it would be reasonably
straightforward to extend this with further policies.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
