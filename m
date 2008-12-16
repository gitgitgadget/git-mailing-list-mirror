From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ignore
Date: Tue, 16 Dec 2008 15:08:20 -0800
Message-ID: <7viqpjra57.fsf@gitster.siamese.dyndns.org>
References: <21043430.post@talk.nabble.com>
 <alpine.LFD.2.00.0812161450010.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Power <mkwright@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 00:10:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCj2y-0007BV-UW
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 00:09:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbYLPXI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 18:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751810AbYLPXI3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 18:08:29 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbYLPXI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 18:08:29 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 56E6887DB9;
	Tue, 16 Dec 2008 18:08:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 47EF287DB8; Tue,
 16 Dec 2008 18:08:22 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.0812161450010.14014@localhost.localdomain>
 (Linus Torvalds's message of "Tue, 16 Dec 2008 14:53:07 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71C09332-CBC6-11DD-AC2F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103295>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, 16 Dec 2008, Max Power wrote:
>> 
>> So I understand how to use the .gitignore file to ignore specific
>> files/directories that I put in there... is there a way to ignore everything
>> BUT a given file extension? 
>
> Something like
>
> 	*
> 	!*.jpg
>
> to only save the jpegs in your pr0n collection?

Hmm, do people still keep p0rn collection in jpgs?  I somehow had an
impression that they moved to avis ;-)

> The first rule says "ignore everything". The second one says "don't 
> ignore *.jpg files".
>
> Untested. 

t3001-ls-files-others-exclude.sh has some tests but there is nothing that
explicitly tests overlapping patterns.  Perhaps it should (hint, hint...)

"man gitignore" documentation has an example to ignore all *.html files
but not foo.html using a similar construct, i.e.

	*.html
        !foo.html
