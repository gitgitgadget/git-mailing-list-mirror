From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 19:37:03 -0400
Message-ID: <51C2409F.1070801@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com> <1371607780-2966-3-git-send-email-rhansen@bbn.com> <7vhagu10ql.fsf@alter.siamese.dyndns.org> <51C203A1.4000404@bbn.com> <7vtxktyfo1.fsf@alter.siamese.dyndns.org> <51C22F77.8050004@bbn.com> <7vwqppwwwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 01:37:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpRwF-0005Dt-SS
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 01:37:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934543Ab3FSXhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 19:37:13 -0400
Received: from smtp.bbn.com ([128.33.1.81]:32024 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934170Ab3FSXhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 19:37:12 -0400
Received: from socket.bbn.com ([192.1.120.102]:39137)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1UpRvz-0001kc-M3; Wed, 19 Jun 2013 19:37:03 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 635163FF5E
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vwqppwwwj.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228433>

On 2013-06-19 18:36, Junio C Hamano wrote:
> Ahh.  If you had quoted [...] a few exchanges ago I would have
> immediately understood what you were trying to say.

Sorry about that, my bad.

> In today's world (after packed-refs was introduced), probably
> 
> 	A name that begins with refs/ (e.g. refs/heads/master) that
> 	can point at an object name.
> 
>         The namespace of refs is hierarchical and different
>         subhierarchy is used for different purposes (e.g. the
>         refs/heads/ hierarchy is used to represent local branches).
> 
> is an appropriate rewrite of the above.

Some thoughts about the above definition:
  * Aren't HEAD, FETCH_HEAD, ORIG_HEAD also refs?
  * That definition excludes symrefs.
  * It may be worthwhile to mention that refs are part of the
    repository.
  * Is a ref a name?  Or is it the binding of a name to an object/ref?

How about:

    ref
        A binding of a name to an object or other ref (in which case it
        is a symref).  Refs are stored in the repository.

        The ref namespace is hierarchical.  Different subhierarchies
        are used for different purposes (e.g. the refs/heads/ hierarchy
        is used to represent local branches).

> 
> If we also want to explain the implementation details of refs, then
> additionally at the end of the first paragraph, add:
> 
> 	... at an object name, by storing its 40-byte hex
> 	representation.  They are implemented as either a file in
> 	$GIT_DIR/refs/ directory (called "loose refs") or an entry
> 	in $GIT_DIR/packed-refs file (called "packed refs"); when a
> 	loose ref exists, a packed ref of the same name is ignored.

It would be good to document this somewhere, but I'm not sure the
glossary is the right place for it.  Maybe gitrepository-layout(5)?

-Richard
