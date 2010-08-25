From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Fix 'git log' early pager startup error case
Date: Wed, 25 Aug 2010 09:00:55 +0200
Message-ID: <4C74BFA7.1090907@viscovery.net>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org> <20100825013625.GC10423@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?ISO-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>,
	Eric Blake <eblake@redhat.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:01:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo9zB-00018R-0v
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837Ab0HYHBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 03:01:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43765 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750881Ab0HYHBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 03:01:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Oo9yi-0007K7-1d; Wed, 25 Aug 2010 09:00:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B34A51660F;
	Wed, 25 Aug 2010 09:00:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <20100825013625.GC10423@burratino>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154428>

Am 8/25/2010 3:36, schrieb Jonathan Nieder:
> Mingw Git uses spawnvpe now, but Cygwin users might still suffer from
> fork() troubles.  I think it should be possible to work around that by
> using posix_spawn() from start_command() on such platforms (or
> someting similar).

Just FYI, posix_spawn() is not sufficiently capable for the demands of
start_command(): It doesn't allow to set a new CWD for the spawned process.

-- Hannes
