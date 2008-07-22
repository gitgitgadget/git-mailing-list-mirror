From: Jonathan Nieder <jrnieder@uchicago.edu>
Subject: Re: [PATCH] bring description of git diff
 --cc up to date
Date: Tue, 22 Jul 2008 11:19:47 -0500 (CDT)
Message-ID: <20080722111947.BIW29914@m4500-01.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Greaves <david@dgreaves.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 18:21:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLKcF-0007T7-AZ
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 18:21:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbYGVQUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 12:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbYGVQUa
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 12:20:30 -0400
Received: from smtp00.uchicago.edu ([128.135.12.76]:56412 "EHLO
	smtp00.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbYGVQU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 12:20:29 -0400
Received: from m4500-01.uchicago.edu (m4500-01.uchicago.edu [128.135.249.211])
	by smtp00.uchicago.edu (8.13.8/8.13.8) with ESMTP id m6MGJoUG011496;
	Tue, 22 Jul 2008 11:19:50 -0500
Received: (from m4500-01.uchicago.edu [128.135.249.213])
	by m4500-01.uchicago.edu (MOS 3.8.5-GA)
	with HTTP/1.1 id BIW29914 (AUTH jrnieder@uchicago.edu);
	Tue, 22 Jul 2008 11:19:47 -0500 (CDT)
X-Mailer: Mirapoint Webmail Direct 3.8.5-GA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89494>

Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@uchicago.edu> writes:
>
>> +	This flag implies the '-c' option and makes the patch output
>> +	even more compact by omitting uninteresting hunks.  A hunk is
>> +	considered interesting only if either (a) it shows changes from
>> +	all parents or (b) in an Octopus merge, it shows different changes
>> +	from at least three different parents.
>
> I am not sure where that "at lesta three different parents" comes from.
> It might be that what the logic does can be expressed that way, but that
> was not the guiding principle why the code does what it currently does.

Yes, exactly - this is what I meant in saying "my proposed text
does not suggest very strongly what --cc is intended to do".  I
haven't found any wording yet that both makes it clear what --cc
actually does and follows a thought process suggesting why.

Just to make sure I understand, here is what I think --cc does:

  - In a two-parent merge, it is exactly as Linus has been
    describing it.  A hunk is interesting if and only if
    it shows changes from both parents.

  - In a many-parent merge, the criterion is more stringent.
    As in the two-parent merge case, the hunk must show no
    changes from at least one of the parents, meaning that
    one of several alternatives for that portion of code
    was chosen by the code integrator (without mixing and
    matching or adding additional changes); but further, there
    must have been only two alternatives for that portion of
    code to choose between.  If there were three distinct
    alternatives, no matter what the code integrator does, the
    hunk will show up (because that is so rare and deserves
    attention).

Is that correct?

Thanks for the reading matter.  If it stimulates anyone reading
into coming up with a better description, they should please let
me know :)
