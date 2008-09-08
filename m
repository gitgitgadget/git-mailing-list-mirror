From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t6023-merge-file: Work around non-portable sed usage
Date: Mon, 08 Sep 2008 12:26:32 -0700
Message-ID: <7vej3ufnh3.fsf@gitster.siamese.dyndns.org>
References: <1220898558-73783-1-git-send-email-arjen@yaph.org>
 <cNVNi0DglMtk8yH2LYJQdUZ7rfXlu4pff2TkbJj4KU6hnx-n_IQ3nw@cipher.nrlssc.navy.mil> <20080908192313.GB4148@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: arjen@yaph.org (Arjen Laarhoven)
X-From: git-owner@vger.kernel.org Mon Sep 08 21:28:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcmOv-00024u-RP
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:27:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168AbYIHT0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 15:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYIHT0q
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:26:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49924 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbYIHT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 15:26:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 279D479556;
	Mon,  8 Sep 2008 15:26:45 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5C16579554; Mon,  8 Sep 2008 15:26:34 -0400 (EDT)
In-Reply-To: <20080908192313.GB4148@regex.yaph.org> (Arjen Laarhoven's
 message of "Mon, 8 Sep 2008 21:23:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 12BB39EC-7DDC-11DD-BE2F-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95296>

arjen@yaph.org (Arjen Laarhoven) writes:

> On Mon, Sep 08, 2008 at 02:06:02PM -0500, Brandon Casey wrote:
> [...]
>> I was just encountering this myself.
>> 
>> sed can be fixed without the use of tr by replacing '\n' with an explicit newline like:
>> 
>> sed -e 's/deerit./&\
>> \
>> \
>> \
>> /' -e "s/locavit,/locavit;/" < new6.txt > new8.txt
>> 
>> Of course it doesn't fit on one line though.
>
> I don't think replacing 2 lines with 10 is a big win (not counting a
> possible comment explaining why it's necessary).  I'd rather replaced
> the thing with a Perl one-liner though, but that seems a bit frowned
> upon, correct?

Perl one-liner is Ok, so are pregenerated test vectors in separate
directory (i.e. ship with t/t6023/new6.txt file and refer to it from the
test as "$TEST_DIRECTORY/t6023/new6.txt"), but I think your original patch
to use % is perfectly fine for this one.
