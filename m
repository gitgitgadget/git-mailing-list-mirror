From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-submodule - allow a relative path as the subproject url
Date: Mon, 24 Sep 2007 23:42:00 -0700
Message-ID: <7vy7ev5jrb.fsf@gitster.siamese.dyndns.org>
References: <11904936042891-git-send-email-mdl123@verizon.net>
	<1190600382-1648-1-git-send-email-mdl123@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Tue Sep 25 08:42:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ia47e-0001PX-H0
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 08:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbXIYGmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 02:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbXIYGmJ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 02:42:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58510 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbXIYGmI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 02:42:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id ECA181381DE;
	Tue, 25 Sep 2007 02:42:23 -0400 (EDT)
In-Reply-To: <1190600382-1648-1-git-send-email-mdl123@verizon.net> (Mark
	Levedahl's message of "Sun, 23 Sep 2007 22:19:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59097>

Mark Levedahl <mdl123@verizon.net> writes:

> This allows a subproject's location to be specified and stored as relative
> to the parent project's location (e.g., ./foo, or ../foo). This url is
> stored in .gitmodules as given. It is resolved into an absolute url by
> appending it to the parent project's url when the information is written
> to .git/config (i.e., during submodule add for the originator, and
> submodule init for a downstream recipient). This allows cloning of the
> project to work "as expected" if the project is hosted on a different
> server than when the subprojects were added.
>
> Signed-off-by: Mark Levedahl <mdl123@verizon.net>

I like the idea here.  If you maintain and serve a set related
projects you need to give the users a single URL (per where the
user is and how to reach the server).

> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 2c48936..d421677 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -21,6 +21,9 @@ add::
>  	repository is cloned at the specified path, added to the
>  	changeset and registered in .gitmodules.   If no path is
>  	specified, the path is deduced from the repository specification.
> +        If the repository url begins with ./ or ../, it is stored as
> +        given but resolved as a relative path from the main project's
> +        url when cloning.

Tabs vs spaces?  Will fix up while applying.

Thanks.
