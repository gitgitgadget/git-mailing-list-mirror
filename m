From: Damien Diederen <dash@foobox.net>
Subject: Re: [PATCH 7/7] cvsserver: Use the user part of the email in log and annotate results
Date: Tue, 25 Mar 2008 14:58:22 +0100
Message-ID: <87myomykg1.fsf@keem.bcc>
References: <cover.1206393086.git.dash@foobox.net>
	<01e5947cde524f4eb97a86785d0e1f28e2d040e0.1206393086.git.dash@foobox.net>
	<20080325092621.GN25732@mail-vs.djpig.de>
	<b77c1dce0803250239o249a9059sbaafccf9ddea5e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Frank Lichtenheld" <frank@lichtenheld.de>,
	"Martin Langhoff" <martin@catalyst.net.nz>, git@vger.kernel.org,
	Damien Diederen <dash@foobox.net>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 14:59:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je9gG-0001zl-Pi
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 14:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753037AbYCYN6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 09:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752872AbYCYN6a
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 09:58:30 -0400
Received: from mail-in-11.arcor-online.net ([151.189.21.51]:48990 "EHLO
	mail-in-11.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751639AbYCYN63 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Mar 2008 09:58:29 -0400
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net [151.189.8.34])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id E3A38209264;
	Tue, 25 Mar 2008 14:58:27 +0100 (CET)
Received: from mail-in-14.arcor-online.net (mail-in-14.arcor-online.net [151.189.21.54])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id C4F9845C0FB;
	Tue, 25 Mar 2008 14:58:27 +0100 (CET)
Received: from keem.bcc (dslb-084-057-054-042.pools.arcor-ip.net [84.57.54.42])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 610141877FE;
	Tue, 25 Mar 2008 14:58:22 +0100 (CET)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.60 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92.1/6392/Tue Mar 25 13:44:02 2008 on mail-in-14.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78188>


Hi All,

"Rafael Garcia-Suarez" <rgarciasuarez@gmail.com> writes:
> On 25/03/2008, Frank Lichtenheld <frank@lichtenheld.de> wrote:
>> On Mon, Mar 24, 2008 at 11:50:55PM +0100, Damien Diederen wrote:
>>  > +# Generate a CVS author name from Git author information, by taking
>>  > +# the first eight characters of the user part of the email address.
>>  > +sub cvs_author
>>  > +{
>>  > +    my $author = shift;
>>  > +
>>  > +    $author =~ s/.*<([^>]+)\@[^>]+>$/$1/;
>>  > +    $author =~ s/^(.{8}).*/$1/;
>>
>> IMHO substr($author, 0, 8) would be easier to read here. (It is also
>>  much faster according to some quick benchmarks I just ran)
>
> While we're at nitpicking:
> Faster, shorter, and probably more robust if no @ appears in the email address:
>
> my $author_line = shift;
> (my $author) = $author_line =~ /<([^>@]{1,8})/;

Keep 'em coming :)

I agree with all suggestions so far; I will prepare a new series
addressing them (and including a minor documentation update) once the
thread has settled down a bit.

        Damien

-- 
http://foobox.net/~dash/
