From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH v2] Make git send-email accept $EDITOR with arguments
Date: Fri, 21 Dec 2007 22:07:58 +0100
Message-ID: <476C2B2E.1080801@isy.liu.se>
References: <20071220203211.GA12296@bit.office.eurotux.com> <1198237002-21470-1-git-send-email-hendeby@isy.liu.se> <20071221133412.GA15198@sigill.intra.peff.net> <476BDA5F.4070306@isy.liu.se> <20071221192359.GA10660@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010708010200070905070904"
Cc: luciano@eurotux.com, git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 21 22:08:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5p6d-0000KB-Ag
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 22:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbXLUVIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 16:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753378AbXLUVIG
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 16:08:06 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:47063 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbXLUVIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 16:08:04 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id BE83625A9C;
	Fri, 21 Dec 2007 22:08:01 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 02124-06; Fri, 21 Dec 2007 22:08:01 +0100 (MET)
Received: from [192.168.13.13] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id CA8B525A9B;
	Fri, 21 Dec 2007 22:08:00 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071221192359.GA10660@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69092>

This is a multi-part message in MIME format.
--------------010708010200070905070904
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 2007-12-21 20:23, Jeff King wrote:
> On Fri, Dec 21, 2007 at 04:23:11PM +0100, Gustaf Hendeby wrote:
> 
>>> If you are going to do it that way, I suspect you want to quotemeta
>>> $compose_filename.
>> Generally that would be true, but is that really necessary when I know
>> $compose_filename is defined as:
>>
>> my $compose_filename = ".msg.$$";
> 
> I know; it is just easier to see that it is correct with the quotemeta
> (and correct in the face of somebody changing the message later).
Point taken!

> 
>> Or, should I take it that you prefer the version using split?  I didn't
>> really feel good about the possibility of splitting paths with spaces
>> that came with that one though.
> 
> I am fine with using the shell. Though keep in mind that the two
> solutions will behave differently with
> 
>   EDITOR='foo; bar'
> 
> That is, system("$editor $message") will actually invoke the shell,
> whereas system(split(/ /, $editor), $message) will _just_ split on
> whitespace. We should do whatever is consistent with the rest of the git
> commands (off the top of my head, I don't know).

A quick look at the proposed solution to the similar problem with git
commit, using code now in git tag, it seems it uses a split like
solution, though taking " and ' quoting into consideration.  On the top
of my head I can't come up with any other commands using $EDITOR.  I'll
try to find some time the next couple of days to make a reasonable
equivalent solution here.

Thanks,
	Gustaf

--------------010708010200070905070904
Content-Type: text/x-vcard; charset=utf-8;
 name="hendeby.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="hendeby.vcf"

begin:vcard
fn:Gustaf Hendeby
n:Hendeby;Gustaf
org;quoted-printable:Link=C3=B6ping University;Department of Electrical Engineering
adr;quoted-printable:;;;Link=C3=B6ping;;SE-581 83;Sweden
email;internet:hendeby@isy.liu.se
title:PhD Student
tel;work:+46 (0)13 282226
tel;fax:+46 (0)13 282622
x-mozilla-html:FALSE
url:http://www.control.isy.liu.se/~hendeby
version:2.1
end:vcard


--------------010708010200070905070904--
