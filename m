From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git-submodule: New subcommand 'summary' (2) - hard work
Date: Sat, 12 Jan 2008 11:25:05 -0800
Message-ID: <7vve5ysv72.fsf@gitster.siamese.dyndns.org>
References: <f67f45eeb9648bb7e5adaf53544443b79643914e.1200122041.git.pkufranky@gmail.com>
	<62a73e734832ad67e89be706f1f8b3dbc30cfcf4.1200122041.git.pkufranky@gmail.com>
	<46dff0320801120312i7b22f13vb9fe2394b1f687a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 20:26:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDlzh-0003li-Ba
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 20:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbYALTZO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 14:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758907AbYALTZN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 14:25:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37737 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751066AbYALTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 14:25:12 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C96195481;
	Sat, 12 Jan 2008 14:25:10 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CE6A5480;
	Sat, 12 Jan 2008 14:25:07 -0500 (EST)
In-Reply-To: <46dff0320801120312i7b22f13vb9fe2394b1f687a9@mail.gmail.com>
	(Ping Yin's message of "Sat, 12 Jan 2008 19:12:00 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70352>

"Ping Yin" <pkufranky@gmail.com> writes:

>> +                       echo "* $name $sha1_src...$sha1_dst:"
>
> If it's a type change (head submodule but index blob, or the the
> reverse), $sha1_dst or $sha1_src will be the sha1 of the blob. It's
> inapprociate to be shown as if it's a commit in the submodule. May
> 00000000 should be shown instead of the blob sha1?

I do not think that adds much value.  When A or B is a
non-commit, you know that A...B notation does not apply, and
because it is probably a rare situation you would want to make
it even more clearer to the reader by using a different
notation.  Like

    echo "* $name have changed from submodule $sha1_src to blob $sha1_dst!!".

perhaps in red bold letter in larger font ;-)
