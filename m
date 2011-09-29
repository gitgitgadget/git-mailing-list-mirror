From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: What's next for "signed push"?
Date: Thu, 29 Sep 2011 11:50:09 +0000 (UTC)
Message-ID: <loom.20110929T134216-159@post.gmane.org>
References: <20110928075054.GA13727@orbis-terrarum.net> <7v62kc1v7m.fsf@alter.siamese.dyndns.org> <7vfwjgui8s.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 13:50:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9F8L-0002Av-Ao
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 13:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab1I2Lu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 07:50:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:46508 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752715Ab1I2Lu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 07:50:28 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1R9F8D-00026n-QN
	for git@vger.kernel.org; Thu, 29 Sep 2011 13:50:26 +0200
Received: from dhcp249-230.yandex.net ([87.250.249.230])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:50:25 +0200
Received: from divanorama by dhcp249-230.yandex.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 13:50:25 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.250.249.230 (Opera/9.80 (X11; Linux x86_64; U; en) Presto/2.9.168 Version/11.51)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182392>

Junio C Hamano <gitster <at> pobox.com> writes:

>  - It also was hoped that pre-receive or pre-update hook on the receiving
>    end can be used to authenticate and authorize the push itself with the
>    approach by v3, but when the check happens, the signed-notes tree to be
>    used for verification is not connected to any ref in the refs/notes/
>    hierarchy yet (otherwise it won't be pre-* hook). The query interface
>    "git notes show" needs to be updated so that it takes not just a ref
>    via the GIT_NOTES_REF interface, which is defined to specify a ref
>    because some subcommands of "git notes" need to create a new commit and
>    update it, but a bare notes tree commit object name [*1*]. We may need
>    to update "git notes" (at least "show" subcommand) for the use of
>    receiving end; v3 is no longer a simpler "sender only" solution.
> 
> *1* I wouldn't be surprised if it already worked when you give the object
> name of the notes-tree commit to GIT_NOTES_REF when running "git show",
> but that is not really a documented interface and working by accident. The
> environment variable was designed to take a name of the ref.
There's also my old request for comments on refs/notes/ ([RFC] plumbing git-
notes, link below). Unexpected thing is that "refs/notes/commits^" is silently 
accepted, but notes aren't displayed at all.


http://thread.gmane.org/gmane.comp.version-control.git/178149
