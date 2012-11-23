From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Completion must sort before using uniq
Date: Fri, 23 Nov 2012 13:15:59 +0100
Message-ID: <003b01cdc974$4cdd1900$e6974b00$@schmitz-digital.de>
References: <002201cdc952$00159c90$0040d5b0$@schmitz-digital.de> <CAFj1UpEMKq9zH3nbLwYrNZRmd52_KEcN5BBrzGg2jxCzd+fsbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <szeder@ira.uka.de>, <felipe.contreras@gmail.com>
To: "'Marc Khouzam'" <marc.khouzam@gmail.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 23 13:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbsBM-0000sQ-TG
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 13:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580Ab2KWMQR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 07:16:17 -0500
Received: from moutng.kundenserver.de ([212.227.17.8]:52394 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458Ab2KWMQR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 07:16:17 -0500
Received: from DualCore (dsdf-4db513fd.pool.mediaWays.net [77.181.19.253])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0LywdQ-1TFvWV0NN2-014Xwc; Fri, 23 Nov 2012 13:16:11 +0100
In-Reply-To: <CAFj1UpEMKq9zH3nbLwYrNZRmd52_KEcN5BBrzGg2jxCzd+fsbA@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHi9d0raPjCmP36XPHeqpAlu3F69wHEVUd4l77YenA=
Content-Language: de
X-Provags-ID: V02:K0:nAyDyXCAvCjt3076O+FMkj23o1fQJ3rGCyMxX20wJ9K
 5KmGZzhvjXu7oWCt8b6oQ6LyjxEZtA01GRSlHRUwh/cP8/7p19
 63IUa73ph+XCygupWhCzbswpdoBz4o/La2fgObrL3MqZwaB/aN
 ndyDY4ZWalxEsMlTybxywEc6u5/YvlKwZpGIHOifxIXOfvZ0aB
 EOBp5P6sZYi1Uycm3RI5akqtEAFN4mQhB1AEhBB9+rQBREj3et
 /PzWzxl436u9vUDPzb+2W1TegwYYcGQ714ke6ozsWRsIj0No34
 vUcY2YjAMJav3jImDJg32PAj+mFUGK43TQgdH4EEqLEc8rhq7h
 wfU2SgAT+zwRkjlR0mooHDfKHF3NVLhkQhA1OANnMF4vi3wlZP
 BrX5RGctXMcIQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210253>

Re-adding git@vger...

> From: Marc Khouzam [mailto:marc.khouzam@gmail.com]
> Sent: Friday, November 23, 2012 11:51 AM
> To: Joachim Schmitz
> Cc: szeder@ira.uka.de; felipe.contreras@gmail.com
> Subject: Re: [PATCH] Completion must sort before using uniq
> 
> On Fri, Nov 23, 2012 at 3:10 AM, Joachim Schmitz
> <jojo@schmitz-digital.de> wrote:
> > Marc Khouzam wrote:
> >> The uniq program only works with sorted input.  The man page states
> >> "uniq prints the unique lines in a sorted file".
> > ...
> >> --- a/contrib/completion/git-completion.bash
> >> +++ b/contrib/completion/git-completion.bash
> >> @@ -321,7 +321,7 @@ __git_refs ()
> >>                                if [[ "$ref" == "$cur"* ]]; then
> >>                                        echo "$ref"
> >>                                fi
> >> -                       done | uniq -u
> >> +                       done | sort | uniq -u
> >
> > Is 'sort -u' not universally available and sufficient here? It is POSIX
> > at least:
> > http://pubs.opengroup.org/onlinepubs/9699919799/utilities/sort.html
> 
> "-u Unique: suppress all but one in each set of lines having equal
> keys. If used with the -c option, check that there are no lines with
> duplicate keys, in addition to checking that the input file is
> sorted."
> 
> What the code aims to do is to only show lines that are not
> duplicated.  'sort -u' would still output one line for each duplicated
> one.  It seems 'sort -u' is the equivalent of 'sort | uniq' but won't
> replace 'sort | uniq -u'.

I can't see the difference and in fact don't understand uniq's -u option al all
Linux man pages say: "only print unique lines", but that is what uniq does by default anyway?!?

> Is 'sort | uniq -u' not POSIX?

It is. It is one process more though.

Bye, Jojo
