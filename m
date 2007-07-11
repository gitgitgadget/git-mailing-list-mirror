From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Wed, 11 Jul 2007 14:26:07 -0700
Message-ID: <7vir8q4opc.fsf@assigned-by-dhcp.cox.net>
References: <1183053733.6108.0.camel@mattlaptop2>
	<7vir8w6inf.fsf@assigned-by-dhcp.cox.net>
	<200707111755.50018.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 23:26:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8jho-0007ny-IK
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 23:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224AbXGKV0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 17:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754142AbXGKV0L
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 17:26:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34396 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbXGKV0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 17:26:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070711212609.BEQL1358.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Wed, 11 Jul 2007 17:26:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id NMS71X00B1kojtg0000000; Wed, 11 Jul 2007 17:26:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52203>

Jakub Narebski <jnareb@gmail.com> writes:

> I'm not sure if we want to store whole 'application/x-gzip' or only
> 'x-gzip' part of mime type, and if we want to store compressor as
> '| gzip' or simply as 'gzip'.
>  
>> This however will break people's existing gitweb configuration,
>> so if we were to do this it should be post 1.5.3, I would say.
>
> This would break not only existing _gitweb_ configuration (when
> gitweb admin installs new gitweb it isn't that hard to correct
> gitweb config), but also git _repositories_ config: gitweb.snapshot
> no longer work as it worked before, for example neither 'gzip'
> nor 'bzip2' values work anymore ('zip' doesn't stop working).

I realized after seeing your other message on this patch that
this can be done while retaining backward compatibility, as you
suggested.  Matt, does Jakub's suggestion make sense to you?
