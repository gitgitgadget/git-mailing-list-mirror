From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 16:06:19 +0200
Message-ID: <vpqr6lpvzqc.fsf@bauges.imag.fr>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr>
	<7vps19jnm1.fsf@gitster.siamese.dyndns.org>
	<vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org>
	<Pine.LNX.4.64.0708271440500.28586@racer.site>
	<866431rser.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:06:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPfEq-0000zl-7v
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 16:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbXH0OGl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 10:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753725AbXH0OGk
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 10:06:40 -0400
Received: from imag.imag.fr ([129.88.30.1]:32944 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751536AbXH0OGk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 10:06:40 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l7RE6Joh024762
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 27 Aug 2007 16:06:19 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1IPfER-0004pn-6H; Mon, 27 Aug 2007 16:06:19 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1IPfER-0006a0-42; Mon, 27 Aug 2007 16:06:19 +0200
In-Reply-To: <866431rser.fsf@lola.quinscape.zz> (David Kastrup's message of "Mon\, 27 Aug 2007 15\:58\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 27 Aug 2007 16:06:20 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56841>

David Kastrup <dak@gnu.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> On Mon, 27 Aug 2007, Mike Hommey wrote:
>>
>>> BTW, wouldn't it be more efficient to store the odf files unzipped ?
>>
>> Efficient how?  Speed-wise: no.  Space-wise: yes.
>
> Huh?  At least the "Space-wise: yes" seems rather nonsensical.

I don't know enough about git delta-compression and OpenDocument, but
git has better chance to efficiently delta-compress different versions
of the document if they're not compressed themselves.

(but that's a necessary and not sufficient condition. line-based
delta-compression wouldn't work if the file is a one-line XML file for
example).

> "Speed-wise" is not as clear: it depends on the relation between
> memory/disk bandwidth and decompression speed.

Probably network operations would be faster, and checkout would be
slower. I wouldn't bet ;-).

-- 
Matthieu
