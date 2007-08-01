From: David Kastrup <dak@gnu.org>
Subject: Re: Interpreting EDITOR/VISUAL environment variables.
Date: Wed, 01 Aug 2007 21:30:57 +0200
Message-ID: <85ir7zrr0u.fsf@lola.goethe.zz>
References: <86abtbnzpr.fsf@lola.quinscape.zz>
	<7vd4y75gcy.fsf@assigned-by-dhcp.cox.net>
	<20070801185042.GB30277@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Wed Aug 01 21:32:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGJvM-00016g-Ir
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 21:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761022AbXHATbt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 15:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759722AbXHATbt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 15:31:49 -0400
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:46837 "EHLO
	mail-in-09.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758896AbXHATbs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 15:31:48 -0400
Received: from mail-in-12-z2.arcor-online.net (mail-in-12-z2.arcor-online.net [151.189.8.29])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id D8B2F302836;
	Wed,  1 Aug 2007 21:31:44 +0200 (CEST)
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net [151.189.21.41])
	by mail-in-12-z2.arcor-online.net (Postfix) with ESMTP id C4A13279404;
	Wed,  1 Aug 2007 21:31:44 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-017.pools.arcor-ip.net [84.61.17.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 8A8651D3162;
	Wed,  1 Aug 2007 21:31:44 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7E8061C3E076; Wed,  1 Aug 2007 21:30:57 +0200 (CEST)
In-Reply-To: <20070801185042.GB30277@nan92-1-81-57-214-146.fbx.proxad.net> (Yann Dirson's message of "Wed\, 1 Aug 2007 20\:50\:42 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3846/Wed Aug  1 09:27:07 2007 on mail-in-01.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54470>

Yann Dirson <ydirson@altern.org> writes:

> On Wed, Aug 01, 2007 at 10:12:13AM -0700, Junio C Hamano wrote:
>> We recently normalized the script callers not to splice at all
>> (the scripts were hand-rolling "the VISUAL or EDITOR or vi" and
>> slightly differently).  It obviously has negative (i.e. setting
>> EDITOR to "emacsclient --alternate-editor vi" does not work) as
>> well as positive side (i.e. "/home/dak/My Programs/editor" would
>> work).
>
> And, indeed, --alternate-editor could be supplemented by another
> envvar to be able to work in our situation.

It is already.  But if git is pretty much alone in breaking a setup
that is working everywhere else, is having a workaround available
really a good excuse for not doing the right thing?

> Maybe the various emacsen vendors would be willing to integrate such
> a patch ?

Actually, it is a nuisance because nobody remembers this variable.  It
is called (looking in the Emacs manual, using the index to find
emacsclient, following a link after two pages to the invocation, going
down two pages again) ALTERNATE_EDITOR.  It does not even _mention_
Emacs or emacsclient in its name.  The "-a" option is easier to
remember.

So yes, emacsclient has an environment hook making it possible to work
around git's idiosyncratic behavior here.  But should it really be
necessary?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
