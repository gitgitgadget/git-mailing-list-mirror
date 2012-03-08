From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] rebase -i: new option --name-rev
Date: Thu, 08 Mar 2012 10:58:28 -0800
Message-ID: <7veht2ex7v.fsf@alter.siamese.dyndns.org>
References: <1331203358-28277-1-git-send-email-domq@google.com>
 <1331203358-28277-2-git-send-email-domq@google.com>
 <87399jnyxh.fsf@thomas.inf.ethz.ch>
 <CAJh6GrFKJw1506c6nOzh+EcNe7E_UM=NxV_yBPWx9BUCdpAvAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Dominique Quatravaux <domq@google.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 19:58:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5iXu-00023A-LJ
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 19:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492Ab2CHS6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 13:58:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35403 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756885Ab2CHS6b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 13:58:31 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCB1068B3;
	Thu,  8 Mar 2012 13:58:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NKLySQ6RPbAPKXahc9B4U76UCCE=; b=xNcW7K
	xzLORRnNA+Y7Oz03HSYwwaW2uSNKBGnBHDp73smQPCkiYpFgw+FFSWgEerNDNj1x
	WnS4TmadqBzSJd/l1NOk6qPm+Pg8PNLebEFESbJ+ZDrew2Ulo1hGRaLruUM791wd
	p0alhuLveM4hPabeqvrnmCZR253VHjSeZpKyg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LxWv5w1PAnIgYK2bV8QGEsIFkfdh9Eaq
	uHu/V4RP9QGLywvzLK5uMXO/yYaypD4cTbHVrc/d3h5gjNpDHa70FXu8wpQ0ABKa
	wxX7ywvx1bs3qhGeh8HV+X580DEq/F0ZvOZZsh2P6hxoE+BOsD9Cb+VwHXiVk4Dz
	v3EVG/cRBiQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D24AE68B2;
	Thu,  8 Mar 2012 13:58:30 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 567B568AC; Thu,  8 Mar 2012
 13:58:30 -0500 (EST)
In-Reply-To: <CAJh6GrFKJw1506c6nOzh+EcNe7E_UM=NxV_yBPWx9BUCdpAvAg@mail.gmail.com>
 (Dominique Quatravaux's message of "Thu, 8 Mar 2012 12:57:02 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2120B0C-6950-11E1-B341-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192630>

Dominique Quatravaux <domq@google.com> writes:

> On Thu, Mar 8, 2012 at 11:56 AM, Thomas Rast <trast@inf.ethz.ch> wrote:
>> On a general note: you are submitting a completely new feature touching
>> a heavily-used tool (and code path) during -rc0 time. As a rule of
>> thumb: Don't do that. If you do it, don't Cc Junio unless it's his area
>> of code.
>
> [- gitster]
> Sorry about that, I skimmed Junio's "What's cooking in git.git (Mar
> 2012, #03; Mon, 5)" and I thought I was in the "high value/damage
> ratio" category.

Well, these days, nothing that comes without prior discussion on
pain points before the feature freeze, be it from seasoned list
regulars or from people new to this list, can be of so high-value
that it cannot wait until the next cycle.

The only handful of exceptions I can think of are:

 (1) an obvious fix to a high-risk bug (new or old) that was
     recently discovered as a potential attack vector;

 (2) an obvious fix to a bug in a new feature added in the upcoming
     release; or

 (3) an obviously necessary tweak and adjustment to parts of the
     system related to a new feature added in the upcoming release.

(1) is called "security fix" and (2) is "brown paper bag fix".

I do not think of a good word to explain (3), but for example, if a
release candidate added a feature to "git merge" so that a signed
tag can be merged while recording the signature in the resulting
commit, but the feature did not trigger when the merge is made via
"git pull" because it unwrapped the fetched tag to a commit before
calling "git merge", an update to "git pull" and probably "git
fmt-merge-msg" that is used by "git pull" may have to be made after
we enter the soft feature freeze (-rc0) for the new feature in "git
merge" to be useful.
