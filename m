From: Keshav Kini <keshav.kini@gmail.com>
Subject: Re: [BUG?] inconsistent `git reflog show` output, possibly `git fsck` output
Date: Sat, 21 Sep 2013 21:38:26 -0500
Message-ID: <87mwn5y40t.fsf@gmail.com>
References: <871u4hzusr.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 22 04:38:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNZZM-0007sk-65
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 04:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752618Ab3IVCik (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 22:38:40 -0400
Received: from plane.gmane.org ([80.91.229.3]:48433 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557Ab3IVCij (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 22:38:39 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1VNZZG-0007rH-Bq
	for git@vger.kernel.org; Sun, 22 Sep 2013 04:38:38 +0200
Received: from cpe-72-179-6-119.austin.res.rr.com ([72.179.6.119])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 04:38:38 +0200
Received: from keshav.kini by cpe-72-179-6-119.austin.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Sep 2013 04:38:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-72-179-6-119.austin.res.rr.com
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Cancel-Lock: sha1:mFhZXsxNw7TCaOnqP0+N5+W7Z8Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235156>

Keshav Kini <keshav.kini@gmail.com> writes:
> For example, if `git
> reflog show HEAD` displayed this:
>
>     0123456 [stuff] foo
>     789abcd [stuff] bar
>     ef01234 [stuff] baz
>
> Then I would expect the reflog data file for HEAD to look something like
> this, where '.' represents an unknown hex digit:
>
>     789abcd................................. 0123456................................. [stuff]
>     ef01234................................. 789abcd................................. [stuff]
>     ........................................ ef01234................................. [stuff]

Sorry, that's backwards -- I would actually expect this:

    ........................................ ef01234................................. [stuff]
    ef01234................................. 789abcd................................. [stuff]
    789abcd................................. 0123456................................. [stuff]

-Keshav
