From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Rename submodule.<name>.rebase to submodule.<name>.update
Date: Tue, 02 Jun 2009 19:33:57 -0700
Message-ID: <7v4ouydp0q.fsf@alter.siamese.dyndns.org>
References: <7v63fgpwyd.fsf@alter.siamese.dyndns.org>
	<1243983552-24810-2-git-send-email-johan@herland.net>
	<20090603001553.GB27149@dingo.bne.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, apenwarr@gmail.com,
	markus.heidelberg@web.de
To: Peter Hutterer <peter.hutterer@who-t.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 04:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBgIz-00044U-CA
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 04:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbZFCCd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 22:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751553AbZFCCd4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 22:33:56 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:61883 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbZFCCd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 22:33:56 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090603023359.CDQF2915.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Tue, 2 Jun 2009 22:33:59 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id zEZx1b00S4aMwMQ03EZxQa; Tue, 02 Jun 2009 22:33:57 -0400
X-Authority-Analysis: v=1.0 c=1 a=uY3uP2_bGEsA:10 a=UgwMKZTLJmoA:10
 a=D31QgfloAAAA:8 a=8ho0E_6Whw3Ua14VUIoA:9 a=B4k2XlHVEWPVT0-KsJcA:7
 a=5TQLyFPITqRFj65nO4qfdK5yq7YA:4 a=lsTnDmBBjUYA:10
X-CM-Score: 0.00
In-Reply-To: <20090603001553.GB27149@dingo.bne.redhat.com> (Peter Hutterer's message of "Wed\, 3 Jun 2009 10\:15\:54 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120577>

Peter Hutterer <peter.hutterer@who-t.net> writes:

> On Wed, Jun 03, 2009 at 12:59:11AM +0200, Johan Herland wrote:
> ...
>> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>> index acd16ac..cd8e861 100644
>> --- a/Documentation/git-submodule.txt
>> +++ b/Documentation/git-submodule.txt
>> @@ -116,7 +116,7 @@ update::
>>  	Update the registered submodules, i.e. clone missing submodules and
>>  	checkout the commit specified in the index of the containing repository.
>>  	This will make the submodules HEAD be detached unless '--rebase' is
>> -	specified or the key `submodule.$name.rebase` is set to `true`.
>> +	specified or the key `submodule.$name.update` is set to	`rebase`.
>>  +
>>  If the submodule is not yet initialized, and you just want to use the
>>  setting as stored in .gitmodules, you can automatically initialize the
> ...
> I noticed this patch still leaves the --rebase commandline flag. Shouldn't
> that be changed to --update=rebase for consistency?

If we were to add many more (I think --update=merge was mentioned, but do
we have any other plausibly useful modes of operations?) options, it would
make sense to support --update=rebase; my impression from the previous
discussion was that rebase would make sense for more people than other
modes would, so it also would make sense to keep --rebase as a shorthand,
rather than forcing everybody to say --update=rebase for the sake of
consistency.

You did not have to quote the whole patch to say what you wanted to say,
by the way.
