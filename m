From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] glossary: define committish (a.k.a. commit-ish)
Date: Wed, 19 Jun 2013 20:25:21 -0700
Message-ID: <7vli65wjj2.fsf@alter.siamese.dyndns.org>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
	<1371607780-2966-3-git-send-email-rhansen@bbn.com>
	<7vhagu10ql.fsf@alter.siamese.dyndns.org> <51C203A1.4000404@bbn.com>
	<7vtxktyfo1.fsf@alter.siamese.dyndns.org> <51C22F77.8050004@bbn.com>
	<7vwqppwwwj.fsf@alter.siamese.dyndns.org> <51C2409F.1070801@bbn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Richard Hansen <rhansen@bbn.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 05:25:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpVV2-0006X9-Pe
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 05:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935548Ab3FTDZZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 23:25:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57833 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935522Ab3FTDZY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 23:25:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EE4B1F92B;
	Thu, 20 Jun 2013 03:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOdlh6aglqTf6ncTX9AW7yYTb1k=; b=oq/pYF
	BAjWS/SUiCeBoPk8MfnkKa2Nhyrr7b3P3mDIB9XS8c7/RUnKSsO8fUy8b348al+o
	BdEORqfvYJdaZ2F6bgNXSirUee65kKnPNX+HnIsKIIfbuS2U91jeSRaoaPv9ToZx
	o6TAzdltTKLlKwlDwI+SgShBIBt8RGoAG277w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=npWfulj0o0rPN4awr8nciVn02D7t3PKD
	2iHRP1Hp5VpxPYyG44tXDoiWFU34ORah2IZO+uSW0WJFIGtz5raNfU+8ciRukKrY
	iMdsrVT8eYEoTy3nAHJiRVXfiBbhc8ZmxXWTk/1QpvO8ZWEVS+E94aonm6lvm2qn
	qF2wQv4WXr0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95BAC1F92A;
	Thu, 20 Jun 2013 03:25:23 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F16591F925;
	Thu, 20 Jun 2013 03:25:22 +0000 (UTC)
In-Reply-To: <51C2409F.1070801@bbn.com> (Richard Hansen's message of "Wed, 19
	Jun 2013 19:37:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0ABC631E-D959-11E2-96C1-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228437>

Richard Hansen <rhansen@bbn.com> writes:

> On 2013-06-19 18:36, Junio C Hamano wrote:
>> Ahh.  If you had quoted [...] a few exchanges ago I would have
>> immediately understood what you were trying to say.
>
> Sorry about that, my bad.
>
>> In today's world (after packed-refs was introduced), probably
>> 
>> 	A name that begins with refs/ (e.g. refs/heads/master) that
>> 	can point at an object name.
>> 
>>         The namespace of refs is hierarchical and different
>>         subhierarchy is used for different purposes (e.g. the
>>         refs/heads/ hierarchy is used to represent local branches).
>> 
>> is an appropriate rewrite of the above.
>
> Some thoughts about the above definition:
>   * Aren't HEAD, FETCH_HEAD, ORIG_HEAD also refs?

That is a shade of gray.  "refs" are names we use as the starting
point to construct extended SHA-1 expressions to refer to objects,
and in that sense they are.  It would be complete to mention these
as special cases.

>   * That definition excludes symrefs.

True.  "... that can directly point at an object, or point at
another ref (the latter is called a symbolic ref)."

>   * It may be worthwhile to mention that refs are part of the
>     repository.
>   * Is a ref a name?  Or is it the binding of a name to an object/ref?

I am not particularly interested in pedantry, but I think in the way
we used the word "ref", it is a name.  "refs/heads/master" is the
full name of the ref and it can be abbreviated to 'master' when not
ambiguous.  And there is a mechanism to read what the the ref has to
learn the name of the object (*not* object/ref) it refers to (the
name of that mechanism being "ref resolution").

To a layperson, a ref is one of the ways you can name an object
with.
