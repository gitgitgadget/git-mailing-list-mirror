From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: Suggest commit:./file for path in subdir
Date: Thu, 31 Mar 2011 12:26:13 -0700
Message-ID: <7vsju3jdm2.fsf@alter.siamese.dyndns.org>
References: <4D94322A.8030409@drmicha.warpmail.net>
 <4ff35194dc52fa969049f555f8d9358cb7ba0c1a.1301562935.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:26:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5NVk-0006AT-Or
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253Ab1CaT0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 15:26:25 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759251Ab1CaT0X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 15:26:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 882623BA9;
	Thu, 31 Mar 2011 15:28:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=x9++ssbV8uisg43dNmkaKO5rv8Y=; b=bXpF9k
	rZ0v60vUUTWgVZZh2L8lU1kigBPBvfeGddHJIvZh21HEwZgr3cnhhPGLnauFoX8R
	LSy/uTzkkrzegqX9/olgFunBcpQM6oQWqbx5VJOn3FjL8hdGJzUplkM4DLcsQ8NZ
	eQ9xygeTndsVMPXyCHrtPfUTyrWI4CMQgiljY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jL8mWbDkYOzmCA2N7JqxNhjbpKieYrV2
	GPdHLynfoEfddyJiMIHT5pz8GqBN9gaL6S4PHeKv3n9+8F0aFQmuAI6r16JbejPV
	lcT8d0ZEiIAUz88pO2brs+LH+0CNi+ExsEfMjM8sMpvlJnoSbaUMgFtecpaaI58w
	59KaWxj9oXk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 537AC3BA5;
	Thu, 31 Mar 2011 15:28:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 38ED33BA4; Thu, 31 Mar 2011
 15:28:03 -0400 (EDT)
In-Reply-To: <4ff35194dc52fa969049f555f8d9358cb7ba0c1a.1301562935.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Thu, 31 Mar 2011 11:17:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 021719B8-5BCD-11E0-BCFA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170521>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Currently, the "Did you mean..." message suggests "commit:fullpath"
> only. Extend this to show the more convenient "commit:./file" form also.

If we were to do this, I suspect that with non-empty prefix we should only
show "./$file" form for brevity without aka.  This is a end-user facing
message and not meant to help scripts, no?
