From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git $Id$ smudge filter
Date: Tue, 11 Mar 2014 14:54:26 -0700
Message-ID: <xmqqbnxco0z1.fsf@gitster.dls.corp.google.com>
References: <CAH_OBievh+7qe_warJD0_+O6V2=ES9Jjke1tAu4rL5BOKRHdTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:54:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNUdC-0002xT-3q
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755738AbaCKVyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:54:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43377 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755729AbaCKVy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:54:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0459B71EEC;
	Tue, 11 Mar 2014 17:54:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KzNO/LIgVLHw/Q+WAzacTtDoZeo=; b=SEr7Qp
	T0FV1+xmj6wrMlJs1LwS9uR1auaoeVDspyy5HnooT3cMccKDhEtlHclao/HWColk
	BgRUFWz5AuSFbzlTOljpFOhjjWkHkzyffgRUYND7arakQbGvlfd0Sj9zgWw+UI1y
	3BcGIDK3he3wB0iA8OELTELYdXGEGJFZm3PnU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7wDhhXuCs9HGfQ3puUNy9dAfggjCQjr
	B6bDLAW0JmeZiGvnAO81dRo1RhPmjWRzWdFQiIqCoewCpocZTg8lKvL7n/u8gEzy
	7GDj916o9Kee2HOBzCNRfC/BojNHr+R29LHQOVEznoGTKw1RVVh0LKp/662B9COB
	bY8d5NfCrIQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DF1B971EEB;
	Tue, 11 Mar 2014 17:54:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF8B371EE9;
	Tue, 11 Mar 2014 17:54:27 -0400 (EDT)
In-Reply-To: <CAH_OBievh+7qe_warJD0_+O6V2=ES9Jjke1tAu4rL5BOKRHdTQ@mail.gmail.com>
	(shawn wilson's message of "Tue, 11 Mar 2014 17:21:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B7B2B94A-A967-11E3-9DED-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243904>

shawn wilson <ag4ve.us@gmail.com> writes:

> Currently, I've got a perl script that modifies the Id line in a smudge filter:
> [filter "ident-line"]
>   smudge = /usr/local/bin/githook_ident-filter.pl %f
>
> The problem I've noticed with smudge filters is that it leaves the
> repo dirty. How do I fix this? I am basically trying to replicate the
> behavior of CVS or SVN $Id$ line here.

It somewhat smells fishy to have only smudge filter defined without
a corresponding clean filter, doesn't it?
