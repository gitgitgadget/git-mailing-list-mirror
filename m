From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] Use test_config
Date: Wed, 27 Mar 2013 08:05:04 -0700
Message-ID: <7vmwtoq3xb.fsf@alter.siamese.dyndns.org>
References: <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <1363704914.6289.39.camel@test.quest-ce.net>
 <loom.20130321T212911-611@post.gmane.org>
 <cdc4f45e7520ce1fc48588c260214717@meuh.org>
 <1363946943-30269-1-git-send-email-ydroneaud@opteya.com>
 <7vvc8j8p9m.fsf@alter.siamese.dyndns.org>
 <cover.1364158574.git.ydroneaud@opteya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Droneaud <ydroneaud@opteya.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 16:05:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKrv2-0007Sj-7V
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 16:05:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751834Ab3C0PFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 11:05:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab3C0PFH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 11:05:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0102FABE4;
	Wed, 27 Mar 2013 11:05:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=qXUV+QOTxtFPSKLAlOMZz0UVOwk=; b=M23WoMNsVZA3JSSpgEOO
	F59lTPZI4jEQLH7UgHQlKnlwYYgschpX7uaer/rAo0nRqN1ogBClIl7BtuXzPmxc
	ReT/vOkfKnJW+yUVJ9Lg3besNtFTY03TJuGPk8RZIJtc9Zoerv4mW0XPd7P3KefS
	l8ghiGOvmD7b+9dd8djDYPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=w7PvGh5JFrMvOb3vxGV7Vz1eaietqz5VpD4KLI/Sevdb/o
	rCZMiSuEs7UKeYJsCYbxFEdB9G+e95qrjIAZ4fozE3ZbTblma8e9X5dwLFlaA/Sh
	j4rKbIAk6Qmyf4yKhTRfMBV/O1BGc6vOuatIbwK+63NbH+UOBGoqsomCBxElA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9949ABE3;
	Wed, 27 Mar 2013 11:05:06 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 511D9ABDF; Wed, 27 Mar 2013
 11:05:06 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5A5D9BA-96EF-11E2-9B91-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219255>

Yann Droneaud <ydroneaud@opteya.com> writes:

> Tested against master, 7b592fadf1e23b10b913e0771b9f711770597266

Is this because I suggested you to clean things up while you were
touching in a vicinity of something that could use this clean-up?

If so, please first clean _that_ script in a patch, and then add the
change you wanted to do in another patch, as a single two-patch
series, without touching anything else that is not related to that
change.  The patch to t7600 is the one that needs to become two
patches, one to clean up and the other to add tests for --no-ff.

The rest, as a separate "only cleaning up, doing nothing else"
series, are fine as a follow-up, but please make sure that they do
not touch anything in-flight (one easy way to check is to see "git
diff --name-only maint pu -- t/").  I would prefer to see "clean-up
only" changes that introduce unnecessary conflicts with other real
features and fixes held off until the dust settles.

> Yann Droneaud (15):
>   t4018: remove test_config implementation
>   t7810: remove test_config implementation
>   t7811: remove test_config implementation

We already have equivalents of these in-flight.

>   t7600: use test_config to set/unset git config variables

Needs to be split into two.
