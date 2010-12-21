From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 'show' pretty %B without a diff
Date: Tue, 21 Dec 2010 12:04:59 -0600
Message-ID: <20101221180459.GA25812@burratino>
References: <20101220073842.GC10354@external.screwed.box>
 <7vmxo0ddbm.fsf@alter.siamese.dyndns.org>
 <20101220111214.GD10354@external.screwed.box>
 <7v4oa8cobn.fsf@alter.siamese.dyndns.org>
 <20101221104641.GA8600@external.screwed.box>
 <m38vzjl1yr.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Vereshagin <peter@vereshagin.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 21 19:05:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV6aZ-0000O4-J6
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 19:05:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843Ab0LUSF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 13:05:26 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:35362 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0LUSFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 13:05:25 -0500
Received: by fxm18 with SMTP id 18so4622504fxm.2
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=xBqP0vB7rbXzAlhwO3qmnWkpbd5kWWg37KeAkJoinSI=;
        b=oM2BB8e97ikRodpkKx58tRz1NpQbB90jIx0B67b8wH38nVMxMU4faFcU+UMLwlpiwv
         DDs4wPzHJnm4ZNBwC5IVWO831VHiiGXIUy8Pp12u9CoMOBbpP+r6Eg+TaIcJj/Nu45Rs
         7+lreBe0s2ssd9NsXSb7LEjsIj2j5Z3ZRozuY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OZnfPTbdpLDFJ5UZyc+BwuUR0VwNjcS83Y8LQ9yQ23sFxoONjyFpS8VqqNh/pzxHjJ
         Vs106Nr6OGqW0WOjVUePThY9oWwwZ8k3JD92qI7+GXj3NgYhqiQRqilSwAINBC5n0a+I
         V/rCWYFj1GZdZinM4XgGysv1iK5rPuZ3KR2iM=
Received: by 10.223.75.194 with SMTP id z2mr404698faj.38.1292954724547;
        Tue, 21 Dec 2010 10:05:24 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id n26sm1423154fam.13.2010.12.21.10.05.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 21 Dec 2010 10:05:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m38vzjl1yr.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164043>

Jakub Narebski wrote:

> I guess that `-s' should be present also in git-show manpage.

It is mentioned in the examples section since v1.7.3.3~42.  That
manpage needs a rework in general, though.

> There is also `git log -1` (or `git log -1 --no-walk` for paranoid).

Or even "git diff-tree -s --pretty=%B <commit>" if that is the intent.

As much as a person might dislike plumbing, plumbing is git's current
stable API.  Maybe the libgit2 project will come up with something
better[1].  Until then, I am happy to have some commands that avoid
user-friendliness niceties (like implied "HEAD") that would create
pitfalls when scripting.

Maybe it would be worth adding a plumbing example under the EXAMPLES
for each porcelain?  I can see that having to learn a second set of
commands might make life hard (like scripting in the bourne shell
when one is a csh user).

[1] I am pessimistic since that project has not made itself very
visible for feedback from the git list or submitted changes back to
git.  It would be great to be surprised.
