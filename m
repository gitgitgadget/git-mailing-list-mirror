From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Thu, 23 Aug 2007 08:12:18 +0200
Message-ID: <85mywiixtp.fsf@lola.goethe.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr>
	<7v8x83i5ma.fsf@gitster.siamese.dyndns.org>
	<20070823060052.GA25153@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git discussion list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: martin f krafft <madduck@madduck.net>
X-From: git-owner@vger.kernel.org Thu Aug 23 08:12:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO5vb-0002U9-Qc
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 08:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbXHWGMV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 02:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbXHWGMV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 02:12:21 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:53192 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751123AbXHWGMU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Aug 2007 02:12:20 -0400
Received: from mail-in-07-z2.arcor-online.net (mail-in-07-z2.arcor-online.net [151.189.8.19])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 7131D1F593C;
	Thu, 23 Aug 2007 08:12:19 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-07-z2.arcor-online.net (Postfix) with ESMTP id 5DD6A2C6CB1;
	Thu, 23 Aug 2007 08:12:19 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-050-128.pools.arcor-ip.net [84.61.50.128])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 327A01F70CB;
	Thu, 23 Aug 2007 08:12:19 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B2E261C36605; Thu, 23 Aug 2007 08:12:18 +0200 (CEST)
In-Reply-To: <20070823060052.GA25153@piper.oerlikon.madduck.net> (martin f. krafft's message of "Thu\, 23 Aug 2007 08\:00\:52 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56459>

martin f krafft <madduck@madduck.net> writes:

> also sprach Junio C Hamano <gitster@pobox.com> [2007.08.23.0009 +0200]:
>> We deliberately chose not to use that space, and this default is
>> very unlikely to change.
>
> The downsides included change in SHA hash on mode change, as far as
> I can remember. Anything else?

The modes are recorded in patches and push/pull, so if you have
several people working with different permissions/umasks, you get
wagonloads of unnecessary patches and get your local permissions
messed up by other contributors.

For colloborative work, you _really_ don't want to have _personal_
preferences distributed.

Any patch offering to optionally track permissions must make very sure
that it retains the possibility to have permissions in the directory
policed to the values that are actually a property of the source files
rather than the personal work environment.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
