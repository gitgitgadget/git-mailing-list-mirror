From: =?utf-8?b?w5h5c3RlaW4=?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] for-each-ref: add option to omit newlines
Date: Fri, 14 Feb 2014 23:03:21 +0000 (UTC)
Message-ID: <loom.20140215T000328-538@post.gmane.org>
References: <1392314429-15281-1-git-send-email-oystwa@gmail.com> <xmqq38jmlqo6.fsf@gitster.dls.corp.google.com> <loom.20140214T085928-630@post.gmane.org> <xmqq38jlk6a1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 15 00:03:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WERnR-0007Ts-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752885AbaBNXDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:03:46 -0500
Received: from plane.gmane.org ([80.91.229.3]:54237 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbaBNXDp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:03:45 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WERnM-0007Kd-A0
	for git@vger.kernel.org; Sat, 15 Feb 2014 00:03:44 +0100
Received: from 80.156.189.109.customer.cdi.no ([109.189.156.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 00:03:44 +0100
Received: from oystwa by 80.156.189.109.customer.cdi.no with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 00:03:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 109.189.156.80 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:26.0) Gecko/20100101 Firefox/26.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242156>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> I very well understand that.  All other commands that support "-z"
> to give you NUL terminated output do not consider that a downside.
> Why should for-each-ref be special?
> 

After I discovered log also has this there is nothing special about
for-each-ref any longer, so my patch as-is would only make things less
consistent. What is "special" is that they give you the option of
supplying a format string.

ls-files, diff and others print a specific list of items (paths, shas,
...) and there's no question about how they are presented other than the
delimiter between each item, to which a selection of either a newline or
a null byte is plenty.

With log, for-each-ref and rev-list (any others?) that sort of breaks
down. With the format string you're given the power to make the command
print basically anything you like, however you like; no longer only a
question of mere delimiters. It only makes sense then (to me, at least)
that the command does not meddle with the format the user has chosen.

Maybe it's all subjective... I'm okay with just leaving things as they
are. There are ways around it.
