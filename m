From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Makefile: Use $(sharedir)/gitweb for target
 'install-gitweb'
Date: Tue, 01 Jun 2010 21:31:13 -0700
Message-ID: <7vfx16qcmm.fsf@alter.siamese.dyndns.org>
References: <1275405080-17326-1-git-send-email-pavan.sss1991@gmail.com>
 <201006012150.02970.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 02 06:31:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJfc5-0000LU-W2
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 06:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137Ab0FBEb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 00:31:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751Ab0FBEb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 00:31:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 640F0B6DAC;
	Wed,  2 Jun 2010 00:31:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fo4hxZcT+WRMtsXQIw8qmahnEfM=; b=u51WKz
	q7QefBRIGJxi/IeXGdFeUfXUm2Zug+0Z192Bx2p93Audo6NuiZubrx/LZ97Demej
	DDNJpKMNo4VJOVuX9psuyEuqtjuSaEd3rPGd3iFN6pU9ydc/cbb7uSuqItu+h4B8
	0ro5TJbl1XPVS2SWgy4aKnLIAor8sgzUABnuU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lhhat6hg8e1FWEkQEON+4dD2RZ5Lbbu3
	LC7gBL/tKPppY29YctqUjB9qDDtvbt1plIiBMH8z/HucGL/a11ZVnW7zzn5KX1af
	GRnqB22nbhKtBX2kdGahTFPIFsWpfw0uoSAg8t+JaU1YPE7h9OF2om7vsjox+Jr6
	tiM9fTEMMBk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB47EB6DA8;
	Wed,  2 Jun 2010 00:31:21 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8654CB6D9B; Wed,  2 Jun
 2010 00:31:15 -0400 (EDT)
In-Reply-To: <201006012150.02970.jnareb@gmail.com> (Jakub Narebski's message
 of "Tue\, 1 Jun 2010 21\:50\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B243D8C4-6DFF-11DF-A9A6-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148193>

Jakub Narebski <jnareb@gmail.com> writes:

> On Tue, 1 June 2010, Pavan Kumar Sunkara wrote:
>
>> Export gitwebdir variable so that when user types the command
>> 'make install-gitweb', gitweb is installed in $(sharedir)/gitweb
>> rather than /var/www/cgi-bin. Now, $(sharedir)/gitweb is default
>> for both 'install' and 'install-gitweb' targets.
>> 
>> Remove 'gitwebdir=$(gitwebdir_SQ)' from gitweb part of 'install'
>> target which is unneccessary now.
>> 
>> Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
>
> For what it is worth:
>
> Acked-by: Jakub Narebski <jnareb@gmail.com>
>
> (But I have not tested it!)

I am wondering if we would also want to do something with this line

    gitwebdir ?= /var/www/cgi-bin

in gitweb/Makefile.  This is orthogonal to the patch under discussion
does, though.
