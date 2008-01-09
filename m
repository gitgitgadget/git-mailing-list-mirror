From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git svn fetch segfaults
Date: Wed, 09 Jan 2008 12:14:19 -0800
Message-ID: <7v4pdmiwo4.fsf@gitster.siamese.dyndns.org>
References: <200801082325.45756.devurandom@gmx.net>
	<20080109003307.GS29972@genesis.frugalware.org>
	<200801091353.44630.devurandom@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Dennis Schridde <devurandom@gmx.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChKG-000700-Mq
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbYAIUO3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754167AbYAIUO3
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:14:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64969 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754156AbYAIUO2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:14:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 24E2E2B2C;
	Wed,  9 Jan 2008 15:14:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 878072B29;
	Wed,  9 Jan 2008 15:14:22 -0500 (EST)
In-Reply-To: <200801091353.44630.devurandom@gmx.net> (Dennis Schridde's
	message of "Wed, 9 Jan 2008 13:53:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70006>

Dennis Schridde <devurandom@gmx.net> writes:

> Am Mittwoch, 9. Januar 2008 01:33:07 schrieb Miklos Vajna:
>> On Tue, Jan 08, 2008 at 11:25:45PM +0100, Dennis Schridde 
> <devurandom@gmx.net> wrote:
>> > mkdir org.gna.warzone2100.git
>> > cd org.gna.warzone2100.git
>> > git --bare init
>> > git --bare svn init --use-svnsync-props --stdlayout
>> > file:///var/svn/warzone2100/
>> > git --bare svn fetch
>>
>> wget http://svn.kynes.de/warzone2100.bz2
>>
>> svnadmin create warzone2100 && bzcat warzone2100.bz2 | svnadmin load
>> warzone2100
>>
>> the rest is the same i get a segfault at the very same place.
>>
>> > If I do not specify --use-svnsync-prop to "git svn init", it gets past
>> > r13 in tags/1.10a.
>>
>> same.
>>
>> > I am using these versions:
>> > svn, version 1.4.6 (r28521)
>> > git version 1.5.4.rc2
>>
>> $ svn --version
>> svn, version 1.4.5 (r25188)
>>
>> $ git --version
>> git version 1.5.4.rc2.38.gd6da3
> Same with git version 1.5.3.7

Has anybody determined which executable is the segfaulting one?

If it is svn executable spawned by Perl that runs git-svn, or
libsvn shared object linked to Perl while running git-svn, I
suspect testing with different git versions will not be very
productive.
