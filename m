From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.4.3
Date: Wed, 06 Apr 2011 12:58:18 -0700
Message-ID: <7voc4ji23p.fsf@alter.siamese.dyndns.org>
References: <7v4o6fg29j.fsf@alter.siamese.dyndns.org>
 <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Arnaud Lacombe <lacombar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 21:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7Ys4-0004DM-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 21:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab1DFT62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2011 15:58:28 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44207 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455Ab1DFT61 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2011 15:58:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ADF5F47B7;
	Wed,  6 Apr 2011 16:00:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fGjK9fdwZYTOT1A1f2gf62D5op4=; b=bcFm+9
	orln16zVRlMEae7kVYfXhG1YruA0tZa3/Sg11KXTmXSKUlShNoSXbjho+ZhedPm4
	WgHM57aNHE9oRHqtGHkcdB/gcIQWjQmVkTHCOoZXeLXMqjO4LWbYa1XOyCwrgRZD
	g2mQQjJKyKxKIYaNY/FmaL0NDYSTj5nQuwZkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w8oNNWhkpP3aB120GrNkDbjCHEEXi0uy
	fc9F1soqFGgXNUAJr8EuRHW11v6JLI3j2aacHn27pvJEa1tl33x12/h8jFp9pWZl
	o0/aAOJNXX4bjGVeYZJq9sm+BUiqXaVu7P6+WuE66yaS82jP2/Pg/D1CCf6nV+ZV
	z92zkPEMDYQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8BBCD47B4;
	Wed,  6 Apr 2011 16:00:17 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D5AB47B1; Wed,  6 Apr 2011
 16:00:14 -0400 (EDT)
In-Reply-To: <BANLkTimh+--iRNEpr2XOFf4jXoVhmHUnoA@mail.gmail.com> (Arnaud
 Lacombe's message of "Wed, 6 Apr 2011 14:40:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E793AEE-6088-11E0-92D4-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171010>

Arnaud Lacombe <lacombar@gmail.com> writes:

> This commit introduces a regression when editing splithunks using "git
> add -p". Reverting the patch fix the regression.

Thanks for a report.  I don't have a time to look at this now; help from
"add -p" people would be appreciated.

I have a suspicion that the symptom may be a bug in "add -p" exposed by
the change; "add -p" which used to count the patch lines carefully itself,
but was modified to use 'apply --recount' in more recent versions.
