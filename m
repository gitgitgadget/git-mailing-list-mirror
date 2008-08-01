From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Fri, 01 Aug 2008 01:08:38 -0700
Message-ID: <7vbq0dtawp.fsf@gitster.siamese.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com>
 <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
 <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alexander Litvinov" <litvinov2004@gmail.com>, git@vger.kernel.org,
	"Eric Wong" <normalperson@yhbt.net>
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 10:10:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOphw-0006qT-By
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 10:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYHAIIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 04:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751581AbYHAIIu
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 04:08:50 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYHAIIs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 04:08:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 309E34909F;
	Fri,  1 Aug 2008 04:08:47 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 711634909D; Fri,  1 Aug 2008 04:08:42 -0400 (EDT)
In-Reply-To: <37fcd2780808010047t4ae20168y65103e90897dd3f8@mail.gmail.com>
 (Dmitry Potapov's message of "Fri, 1 Aug 2008 11:47:46 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1113C824-5FA1-11DD-A997-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91041>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

> On Fri, Aug 1, 2008 at 7:23 AM, Alexander Litvinov
> <litvinov2004@gmail.com> wrote:
>>
>> I dont think that disabling convertion is a good way. I really want to convert
>> my files.
>
> To being able to synchronize efficiently in both ways, you need to store
> files exactly as they were received from SVN then there will be no
> problem with applying binary delta patch. All CRLF conversion should be
> done on checkout and checkin from/to Git repository.

Ahh,... if that is the philosophy, perhaps we can teach --stdin-paths to
optionally open the file itself and use index_pipe() like --stdin codepath
does?
