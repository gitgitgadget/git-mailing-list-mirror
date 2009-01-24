From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: refactor lock-related headers creation for
 curl  requests
Date: Fri, 23 Jan 2009 21:18:22 -0800
Message-ID: <7vy6x1nuxt.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0901231800t6943b01dwbca976d5e9f3397@mail.gmail.com>
 <alpine.DEB.1.00.0901240507070.13232@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 24 06:20:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQaw3-0005jU-3g
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 06:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbZAXFSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 00:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbZAXFSe
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 00:18:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:42881 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZAXFSe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 00:18:34 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6007A1D29B;
	Sat, 24 Jan 2009 00:18:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 189DC1D296; Sat,
 24 Jan 2009 00:18:23 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901240507070.13232@racer> (Johannes
 Schindelin's message of "Sat, 24 Jan 2009 05:11:21 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 717587D8-E9D6-11DD-9FCF-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106954>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sat, 24 Jan 2009, Ray Chuan wrote:
>
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Make that an Acked-by:
>
>> +	if(options & DAV_HEADER_IF) {
>> +		strbuf_addf(&buf, "If: (<%s>)", lock->token);
>> +		dav_headers = curl_slist_append(dav_headers, buf.buf);
>> +		strbuf_reset(&buf);
>
> BTW in case anyone is puzzled (like I was): curl_slist_append() takes a 
> "char *" as second parameter, but does not take custody of the buffer; 
> instead, it strdup()s it.  See
> http://cool.haxx.se/cvs.cgi/curl/lib/sendf.c?rev=1.155&content-type=text/vnd.viewcvs-markup
> for details.
>
> BTNW this should be mentioned in the commit message, too, to spare other 
> people the puzzlement.

Yeah, but your advice is too late --- I already lost a few minutes solving
my puzzlement with manpages.

Thanks, both.
