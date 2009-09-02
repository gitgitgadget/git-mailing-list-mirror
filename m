From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Make it easy to add unmerged files
Date: Wed, 02 Sep 2009 10:48:52 +0200
Message-ID: <87iqg120ln.fsf@wine.dyndns.org>
References: <4A9A92F4.2090209@chromecode.com> <87ws4l47k2.fsf@wine.dyndns.org>
	<4A9E0717.9040801@chromecode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin Nordholts <martin@chromecode.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 10:49:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MilWs-0002bQ-Ua
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 10:49:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755457AbZIBItB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 04:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755249AbZIBItB
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 04:49:01 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:53175 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755230AbZIBItA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 04:49:00 -0400
Received: from adsl-84-226-16-146.adslplus.ch ([84.226.16.146] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1MilWR-0007gf-IC; Wed, 02 Sep 2009 03:49:01 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id C4C1E1E73DE; Wed,  2 Sep 2009 10:48:52 +0200 (CEST)
In-Reply-To: <4A9E0717.9040801@chromecode.com> (Martin Nordholts's message of
	"Wed, 02 Sep 2009 07:48:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
X-Spam-Score: -3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127597>

Martin Nordholts <martin@chromecode.com> writes:

> On 08/30/2009 05:58 PM, Alexandre Julliard wrote:
>> Martin Nordholts <martin@chromecode.com> writes:
>> 
>>> (Resending as I managed to mangle the previous patch despite trying not to...)
>>>
>>> It is nice and easy to git-add ignored and unknown files in a
>>> git-status buffer. Make it equally easy to add unmerged files which is
>>> a common use case.
>> 
>> That's not quite what adding a file means in git.el, unmerged files are
>> considered added already, and marking them resolved is done through the
>> git-resolve-file command. Of course that was implemented before git
>> overloaded the meaning of git-add to mean git-update-index, so maybe we
>> should follow the trend and use git-add-file for all index updates. In
>> that case git-resolve-file should probably be removed.
>
> Since git instructs the user to use git-add for marking unmerged files
> as resolved ("After resolving the conflicts, mark the corrected paths
> with 'git add <paths>' or 'git rm <paths>' and commit the result.") and
> doesn't even mention git-update-index, I think we should change git.el
> accordingly.
>
> But why do we need to also remove and disable git-resolve-file from
> git.el? It doesn't hurt to keep that function and the keybinding, does
> it?

It doesn't hurt much, but having two keybindings for the same thing is a
bit wasteful since there aren't that many simple bindings available. If
we remove it, it opens the door to later reusing the 'R' key for
something else (a git-rename function would be the obvious choice).

-- 
Alexandre Julliard
julliard@winehq.org
