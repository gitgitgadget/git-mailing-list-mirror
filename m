From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] added -C option to chdir() into another directory first
Date: Thu, 26 Feb 2009 13:50:37 -0800
Message-ID: <7viqmwrhoy.fsf@gitster.siamese.dyndns.org>
References: <1235679099-33994-1-git-send-email-kbrint@rufus.net>
 <7vr61lq6ky.fsf@gitster.siamese.dyndns.org>
 <20090226204423.GA34377@rufus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kevin brintnall <kbrint@rufus.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 22:52:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lco9f-0003WZ-CU
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 22:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757162AbZBZVur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 16:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759466AbZBZVup
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 16:50:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54074 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759460AbZBZVuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 16:50:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 724489D592;
	Thu, 26 Feb 2009 16:50:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 696309D591; Thu,
 26 Feb 2009 16:50:39 -0500 (EST)
In-Reply-To: <20090226204423.GA34377@rufus.net> (kevin brintnall's message of
 "Thu, 26 Feb 2009 14:44:23 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 83988486-044F-11DE-B795-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111602>

kevin brintnall <kbrint@rufus.net> writes:

> On Thu, Feb 26, 2009 at 12:35:57PM -0800, Junio C Hamano wrote:
>> kevin brintnall <kbrint@rufus.net> writes:
>> 
>> > This allows things like 'git -C /somewhere pull' without specifying both
>> > --work-tree and --git-dir.
>> 
>> Where should "git -C sub/dir apply this.patch" find the file "this.patch"?
>
> Good question..  It should probably come from the original $PWD.  Maybe we
> should have "-C $DIR" simulate "--work-tree=$DIR --git=dir=$DIR/.git" ?
>
>> More generally, when "git -C there cmd arg1 arg2 arg3..." is run, how
>> should the implementation of cmd learn what to prefix arg$N with?
>
> I envisioned these two as equivalent:
>
> 	git -C $DIR something
> 	cd $DIR ; git something

If that is the case then I really do not see the point, other than "there
are _some_ tools like 'tar' that do it".

Sure, there are some tools that do many other things.  So what?
