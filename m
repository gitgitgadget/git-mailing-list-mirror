From: Junio C Hamano <gitster@pobox.com>
Subject: Re: consistency problem on ZFS
Date: Sun, 28 Apr 2013 14:33:28 -0700
Message-ID: <7vk3nmpcgn.fsf@alter.siamese.dyndns.org>
References: <m2bo8yxyg2.fsf@jarvis.hodique.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Hodique <yann.hodique@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 28 23:33:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWZDz-0005UM-DX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 23:33:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753561Ab3D1Vdb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 17:33:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64816 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752108Ab3D1Vdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 17:33:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A8B361A4C6;
	Sun, 28 Apr 2013 21:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oaGeYqdjqlnf1NEreMsd9hmOaKU=; b=opD1u1
	jkjipLKo+dL1h89vm+zWmxVSJtNQwRSpQuurwSjt9lkhd8QydhQZ2a7Fk9GXr6Ge
	6cgy1FM8vzO0zlnJEDnGqibRBF1GCzRoVT7aPLn0dXIhwqTAFUh2Q/7pLBhAyc7f
	PWPE/2LY1q4ISjDiH6LIKyx6kpMGYlrK0AMzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ciCyPuwqb3Yy4nVLmmUwjkMRLLCavbwx
	rdkt0ngJQ7ZktgJjZf1LNVKese+yKkQ5znu7Jp54jR7sOLzmZBO40vBfhorjBZsR
	sVjSH2T2mP5LI18I3dnhLiCzH1GVLyV9/aP8+vJRAYVGv/fMEArfUUlAzGSm/6x/
	oOIdBC2B0V4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FA5B1A4C5;
	Sun, 28 Apr 2013 21:33:30 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14DF11A4C0;
	Sun, 28 Apr 2013 21:33:29 +0000 (UTC)
In-Reply-To: <m2bo8yxyg2.fsf@jarvis.hodique.info> (Yann Hodique's message of
	"Sun, 28 Apr 2013 20:11:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44FC5DB8-B04B-11E2-BC98-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222757>

Yann Hodique <yann.hodique@gmail.com> writes:

> $ git checkout next; git diff-files; git checkout next; git diff-files
> Already on 'next'
> :100644 100644 bd774cccaa14e061c3c26996567ee28f4f77ec80 0000000000000000000000000000000000000000 M	magit.el
> Already on 'next'
> $

If you run "git update-index --refresh" between the first "checkout"
and "diff-files", do you still see the issue?
