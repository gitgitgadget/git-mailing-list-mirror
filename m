From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http-push: refactor request url creation
Date: Sat, 31 Jan 2009 16:55:49 -0800
Message-ID: <7vmyd72cx6.fsf@gitster.siamese.dyndns.org>
References: <4983929B.2010901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 01:57:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTQeH-0004JF-CU
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 01:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676AbZBAAz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 19:55:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbZBAAz4
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 19:55:56 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33795 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbZBAAz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 19:55:56 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B9AD39564D;
	Sat, 31 Jan 2009 19:55:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7083B9564C; Sat,
 31 Jan 2009 19:55:51 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 14E69694-EFFB-11DD-A28B-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107957>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Currently, functions that deal with objects on the remote repository
> have to allocate and do strcpys to generate the URL.
>
> This patch saves them this trouble, by providing two functions,
> "append_remote_object_url" and "get_remote_object_url".
>
> Both generate a URL, with either the object's 2-digit hex directory
> (eg. /objects/a1/), or the complete object location (eg.
> /objects/a1/b2).
>
> However, they differ in that "append_remote_object_url" appends this
> URL to a strbuf, while "get_remote_object_url" wraps around the former
> and returns the URL directly in char*. Users usually would use
> "get_remote_object_url", but may find "append_remote_object_url"
> useful if they require further string operations on the URL.
>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
> Acked-by: Junio C Hamano <gitster@pobox.com>

Thanks, I'll queue this to 'pu' for now, but please stop randomly adding
"Acked-by" from other people, unless you conferred with them on the
exact version of your patch you are submitting.

If somebody said "The version that I reviewed looked sensible", it becomes
irrelevant after you changed your patch in response to people's comments,
exactly because what you are sending is different from what they reviewed.
It is up to them, not you, to see if the issues raised in their comments
are addressed in the new patch to their satisfaction.
