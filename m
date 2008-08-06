From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Makefile: handle paths with spaces in the
 NO_PERL_MAKEMAKER section
Date: Wed, 06 Aug 2008 08:33:23 -0700
Message-ID: <7v7iaurwe4.fsf@gitster.siamese.dyndns.org>
References: <mLu74vNKfH1vFZlC7N_lRX3WekWReoVjWY42voUDUBUnAGVpDNYWndWqlaHoqVAkxOaCdYV6uDk@cipher.nrlssc.navy.mil> <osgPH47FO7h-zLUMqwCv-i9BWln2-_AK5T6TI-5mLGFjwAhJ4Bg_lw@cipher.nrlssc.navy.mil> <7v8wvbuit7.fsf@gitster.siamese.dyndns.org> <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Aug 06 17:34:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQl2C-0000lR-Lv
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 17:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756327AbYHFPdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 11:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758655AbYHFPde
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 11:33:34 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758659AbYHFPdb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 11:33:31 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E20764D9B6;
	Wed,  6 Aug 2008 11:33:28 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EC2634D9B3; Wed,  6 Aug 2008 11:33:25 -0400 (EDT)
In-Reply-To: <klGWkbWGpsUHZpuNwl9WvZs5UGGfYVAngWbiM3eippaejrXLNyLpRA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 06 Aug 2008 09:25:18 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 04B0FF86-63CD-11DD-8CF9-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91520>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> writes:
>> 
>>> Use double quotes to protect against paths which may contain spaces.
>>> ...
>>> +	echo '	mkdir -p "$(instdir_SQ)"' >> $@
>> 
>> Is this sufficient?  We seem to apply double-sq when writing shell
>> scriptlet in GIT-BUILD-OPTIONS from the main Makefile, and I suspect you
>> would need to do something similar.
>
> It seems to be sufficient. The double quotes survived into my perl.mak file
> and the two perl modules were installed correctly when I supplied a prefix
> with spaces. Is there something else to be concerned about?

I think the generic way GIT-BUILD-OPTIONS writing is done covers cases
where the installation directory has funnies other than whitespace, e.g. 
double quotes.  Is your 'echo "$(instdir_SQ)"' sufficient?
