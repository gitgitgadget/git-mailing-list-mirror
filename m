From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 15:16:49 -0400
Message-ID: <51C203A1.4000404@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <7vhagu10ql.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 19 21:16:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpNsF-0006QF-T2
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 21:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935086Ab3FSTQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 15:16:51 -0400
Received: from smtp.bbn.com ([128.33.0.80]:64005 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935074Ab3FSTQv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 15:16:51 -0400
Received: from socket.bbn.com ([192.1.120.102]:40593)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpNsA-000CG2-AH; Wed, 19 Jun 2013 15:16:50 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 0B3783FF5E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vhagu10ql.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228414>

On 2013-06-19 13:14, Junio C Hamano wrote:
> <object-type>-ish does not have anything to do with a ref.  Even
> when an object is dangling in your object store without being
> reachable from any of your refs, it keeps its own "ish"-ness.

Ah, so your personal definition of "ref" matches my personal definition
of "ref", and this definition doesn't match gitglossary(7).  :)

> 
> "ish"-ness is a property of the object itself.
> 
>  * A commit object has a single top-level tree, and when a command
>    wants a tree object, you can often pass it a commit (historically
>    some commands were more strict and refused to work on a commit
>    when they wanted a tree).  In other words, a commit can be used
>    in place for a tree.  A commit object is a tree-ish.
> 
>  * A tag object, when it points (recursively) at a commit object,
>    can often be used in place for a commit object.  Such a tag
>    object is a commit-ish.
> 
>  * A tag object, when it points (recursively) at a tree object, can
>    often be used in place for a tree object.  Such a tag object is a
>    tree-ish.  Note that such a tag object cannot be a commit-ish.

I agree with all of this; the issue is the definition of "ref" in
gitglossary(7).  That definition should be fixed.  In the meantime, I'll
rework the patch series to avoid using the word "ref" when defining
committish and tree-ish.

-Richard
