From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 02 Sep 2007 15:39:33 +0200
Message-ID: <46DABD15.4030208@fs.ei.tum.de>
References: <200709010925.27926.johannes.sixt@telecom.at>	<7vmyw6u5ca.fsf@gitster.siamese.dyndns.org>	<7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>	<85abs5v9q1.fsf@lola.goethe.zz> <7vfy1xr1lz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Kastrup <dak@gnu.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 15:40:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRpgM-0004hT-Jb
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 15:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910AbXIBNjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 09:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbXIBNjg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 09:39:36 -0400
Received: from stella.fs.ei.tum.de ([129.187.54.7]:42374 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbXIBNjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 09:39:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 33F66288AA;
	Sun,  2 Sep 2007 15:39:34 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 9+GFDMB0ONvQ; Sun,  2 Sep 2007 15:39:34 +0200 (CEST)
Received: from [128.178.149.21] (nslpc6.epfl.ch [128.178.149.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id D5968288A0;
	Sun,  2 Sep 2007 15:39:33 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.12 (X11/20070604)
In-Reply-To: <7vfy1xr1lz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57324>

Junio C Hamano wrote:
>> Just for the record: I believe that \{1,\} might be portable.
> 
> Yeah, I obviously looked at the page I quoted that describes
> what's in and what's not in BRE definition ;-)
> 
> But in practice, I do not recall ever seeing an older sed that
> did not understand one-or-more \+ *and* understood \{1,\}.  Do
> you?

Yes, BSD sed (at least DragonFly's, so probably as well FreeBSD-4 (dunno 
about later)):

chlamydia % echo 5ab123x | sed -e 's/[a-z]\+/AAA/' 

5ab123x
chlamydia % echo 5ab123x | sed -e 's/[a-z]\{1,\}/AAA/' 

5AAA123x
chlamydia % echo 5ab123x | sed -E -e 's/[a-z]+/AAA/' 

5AAA123x

cheers
   simon
