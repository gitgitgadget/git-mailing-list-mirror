From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: git-mailinfo '-u' argument should be default.
Date: Tue, 09 Jan 2007 16:55:53 -0800
Message-ID: <7vejq3hf8m.fsf@assigned-by-dhcp.cox.net>
References: <1147452362.2794.452.camel@pmac.infradead.org>
	<1168351405.14763.347.camel@shinybook.infradead.org>
	<7vzm8skphz.fsf@assigned-by-dhcp.cox.net>
	<1168386544.14763.407.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:56:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Rl0-0007ri-FO
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbXAJAzz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbXAJAzz
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:55:55 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:50935 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932552AbXAJAzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:55:55 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070110005554.UCML18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Tue, 9 Jan 2007 19:55:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9Cv31W0131kojtg0000000; Tue, 09 Jan 2007 19:55:04 -0500
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1168386544.14763.407.camel@shinybook.infradead.org> (David
	Woodhouse's message of "Wed, 10 Jan 2007 07:49:04 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36450>

David Woodhouse <dwmw2@infradead.org> writes:

> On Tue, 2007-01-09 at 10:46 -0800, Junio C Hamano wrote:
>> I do not think you would want to make '-n' in the third point
>> sound so negative 
>
> No, I really _do_ want that.
>
>> and make people on projects that chose to use
>> legacy encoding for whatever reasons feel _dirty_. 
>
> ... but not that, because it wasn't aimed at them.
>
>>  If the natural language in project's log is limited and a legacy
>> encoding is sufficient, and if all the participants agree on a
>> legacy encoding to use...
> (...for git's own purely internal storage format).
>
> That's not the use case for the -n option. Their case is what the
> i18n.commitencoding configuration option exists for.

I think you missed a subtle difference.

For a project that is latin-1 only (or ISO-2022 only, for that
matter -- 'only' is the real keyword here), users did not have
to do anything, and happily kept using git, and that includes
that they did not have to set i18n.commitencoding to anything.

Defaulting to -u now means disrupt their established workflows
are disrupted by people coming from UTF-8 only world.  They now
are forced to set i18n.commitencoding to latin-1 and/or use -n.

When we inconvenience others by making changes to make our own
life easier, it is not a good idea to insult them at the same
time; rather, we should be asking forgiveness from them.
