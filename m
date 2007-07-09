From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Mon, 09 Jul 2007 16:48:29 -0700
Message-ID: <7vr6nht9yq.fsf@assigned-by-dhcp.cox.net>
References: <1183053733.6108.0.camel@mattlaptop2>
	<7v1wfi1rz6.fsf@assigned-by-dhcp.cox.net>
	<3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Matt McCutchen" <hashproduct@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 10 01:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I82y3-0007E4-1u
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 01:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758674AbXGIXsb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 19:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758670AbXGIXsb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 19:48:31 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33068 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758580AbXGIXsa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 19:48:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709234831.KOXD11062.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 19:48:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MboU1X00K1kojtg0000000; Mon, 09 Jul 2007 19:48:29 -0400
In-Reply-To: <3bbc18d20707091552l29fb81b6v34da9cef3ec0df58@mail.gmail.com>
	(Matt McCutchen's message of "Mon, 9 Jul 2007 18:52:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52026>

"Matt McCutchen" <hashproduct@gmail.com> writes:

> On 7/8/07, Junio C Hamano <gitster@pobox.com> wrote:
>> Matt McCutchen <hashproduct@gmail.com> writes:
>>
>> > -sub gitweb_have_snapshot {
>> > -     my ($ctype, $suffix, $command) = gitweb_check_feature('snapshot');
>> > -     my $have_snapshot = (defined $ctype && defined $suffix);
>> > -
>> > -     return $have_snapshot;
>>
>> Although you are removing this function, you still have a couple
>> of callers left in the code.
>
> OK, I will revise the patch, submit it and see if I can get it to
> appear as a reply to this thread.

Thanks.  For future reference, I caught it not by code
inspection, but by running one of the tests (t9500).

> Incidentally, when only one format
> is offered, would you prefer the snapshot link to appear as
> "_snapshot_" (the same as before) or "_snapshot (tgz)_" instead of the
> "snapshot (_tgz_)" that the current patch does?

When only one format is offerred by the site, it is not like the
end user has any choice, so "_snapshot_" is probably the most
appropriate from the screen real-estate point-of-view.

The end user _might_ complain "Geez, I cannot grok zip, I can
only expand tar.  I would not have clicked the link if it said
'snapshot (_zip_)', but the stupid gitweb said '_snapshot_' and
nothing else."  So in that sense, we are robbing one choice the
user has (i.e. "to decide not to click the link, based on the
format of the data that would be given"), but I do not think
that is something we would seriously want to worry about.
