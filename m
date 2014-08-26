From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Bug report: Author/Commit date in ISO 8601 format
Date: Tue, 26 Aug 2014 10:10:33 -0400
Organization: PD Inc
Message-ID: <F8DE5B94F596455FA56956B8A865EC73@black>
References: <53FC3768.3090905@arc-aachen.de> <20140826130610.GG29180@peff.net> <53FC894F.9060402@arc-aachen.de> <20140826133326.GA30887@peff.net>
Reply-To: "Jeff King" <peff@peff.net>,
	  "Oliver Busch" <oliver.busch@arc-aachen.de>,
	  <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "'Jeff King'" <peff@peff.net>,
	"'Oliver Busch'" <oliver.busch@arc-aachen.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 26 16:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMHSR-0001e7-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 16:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbaHZOKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 10:10:43 -0400
Received: from mail.pdinc.us ([67.90.184.27]:56109 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754945AbaHZOKm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Aug 2014 10:10:42 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s7QEAXUu018566;
	Tue, 26 Aug 2014 10:10:34 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140826133326.GA30887@peff.net>
Thread-Index: Ac/BMls4bLhxtMNnQ6etia22oFie/QAAp2Nw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255904>

> -----Original Message-----
> From: Jeff King
> Sent: Tuesday, August 26, 2014 9:33
> 
> On Tue, Aug 26, 2014 at 03:19:11PM +0200, Oliver Busch wrote:
> 
> > PS: As far as I understand it, there is no "optionality" of 
> the "T" as an
> > indicator for the start of the time part.
> 
> The standard says (and I am quoting from Wikipedia here, as I do not
> have it myself):
> 
>   4.3.2 NOTE: By mutual agreement of the partners in information
>   interchange, the character [T] may be omitted in applications where
>   there is no risk of confusing a date and time of day representation
>   with others defined in this International Standard.

>From ISO 8601:2004

4.3.2 Complete representations
The time elements of a date and time of day expression shall be written in the following sequence.
a) For calendar dates:
year - month - day of the month - time designator - hour - minute - second - zone designator
b) For ordinal dates:
year - day of the year - time designator - hour - minute - second - zone designator
c) For week dates:
year - week designator - week - day of the week - time designator - hour - minute - second - zone
designator

The zone designator is empty if use is made of local time in accordance with 4.2.2.2 through 4.2.2.4, it is the
UTC designator [Z] if use is made of UTC of day in accordance with 4.2.4 and it is the difference-component if
use is made of local time and the difference from UTC in accordance with 4.2.5.2.
The character [T] shall be used as time designator to indicate the start of the representation of the time of day
component in these expressions. The hyphen [-] and the colon [:] shall be used, in accordance with 4.4.4, as
separators within the date and time of day expressions, respectively, when required.

NOTE By mutual agreement of the partners in information interchange, the character [T] may be omitted in
applications where there is no risk of confusing a date and time of day representation with others defined in this
International Standard.

> 
> But I am not sure that "omitted" means "can be replaced with a space".
> And while you can define "by mutual agreement" as "git defines the
> format, so any consumers agree to it" that is not necessarily 
> useful to
> somebody who wants to feed the result to an iso8601 parser 
> that does not
> know or care about git (i.e., it shoves the conversion work onto the
> person in the middle).

Omitted /T?/ does not mean replaced with another character.

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
