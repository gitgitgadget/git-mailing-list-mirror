From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] sending errors to stdout under $PAGER
Date: Sun, 17 Feb 2008 09:56:27 -0800
Message-ID: <7vd4qv1n78.fsf@gitster.siamese.dyndns.org>
References: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
 <20080217144854.56fcb98d.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Edgar Toernig <froese@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 17 18:57:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQnlj-0002QD-2s
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 18:57:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113AbYBQR4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 12:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYBQR4w
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 12:56:52 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:53757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbYBQR4v (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 12:56:51 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 256FA61DA;
	Sun, 17 Feb 2008 12:56:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 74A0061D9; Sun, 17 Feb 2008 12:56:45 -0500 (EST)
In-Reply-To: <20080217144854.56fcb98d.froese@gmx.de> (Edgar Toernig's message
 of "Sun, 17 Feb 2008 14:48:54 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74148>

Edgar Toernig <froese@gmx.de> writes:

> Junio C Hamano wrote:
>>
>> +	FILE *outto = (pager_in_use() ? stdout : stderr);
>> +
>>  	vsnprintf(msg, sizeof(msg), err, params);
>> -	fprintf(stderr, "%s%s\n", prefix, msg);
>> +	fprintf(outto, "%s%s\n", prefix, msg);
>>
>> What do people think?  Have I overlooked any downsides?
>
> Wouldn't it be better/safer to redirect stderr to the pager
> in the first place?
>
> So, instead of the current
>
> 	foo | less
> use
> 	foo 2>&1 | less

I like it.  Much nicer.  Thanks.
