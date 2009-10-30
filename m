From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Changed timestamp behavior of options -c/-C/--amend
Date: Fri, 30 Oct 2009 14:58:33 -0700
Message-ID: <7viqdwilx2.fsf@alter.siamese.dyndns.org>
References: <1256931394-9338-1-git-send-email-erick.mattos@gmail.com>
 <7vljisk1m7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erick Mattos <erick.mattos@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 22:58:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3zUc-0004hQ-9J
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 22:58:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932943AbZJ3V6g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 17:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbZJ3V6g
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 17:58:36 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40917 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932903AbZJ3V6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 17:58:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B48A6D324;
	Fri, 30 Oct 2009 17:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JbFlULyRdhgjBfEE4QI46GJept8=; b=hO/8LA
	VOg57M3/HcVpaLyMZqXeddUnlCgChezWpLXaB3qvVO5isrkgWOtK0B+8/mTEC7Rw
	VlgcKsLXSNgWy90OBnNr1uz/QmOHhyHxELxMJuhLkYlZYY8DnGv4WV2F4iOU7hzm
	M4bqevWGgKFhJ4XmtAI6UIqeGaP0/zvJrY23Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sL4aLeA/CqWofBsYJmSDGtCHltuoQe9S
	o+h7wU0Nlve4EUIa2nMZI1jRdFw6Mle0D2+gHEP1k7WaKCc57tmCv9KNoB3TRYDy
	fjGMJqOJY5ccz/VSKyiomwdVFXCm75wCnOh3Lq/+BS62xtZgMmZ//TgP79486I+l
	LqoE2so5zZU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D500D6D322;
	Fri, 30 Oct 2009 17:58:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D5AF56D31D; Fri, 30 Oct
 2009 17:58:34 -0400 (EDT)
In-Reply-To: <7vljisk1m7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 30 Oct 2009 14\:34\:08 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6128F216-C59F-11DE-8A18-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131762>

Junio C Hamano <gitster@pobox.com> writes:

> ...
> I agree that the issue the patch addresses is worth improving, and I think
> it is sensible to default to reuse the timestamp for -C and not to reuse
> for --amend.  I am not sure about -c myself, but it probably shouldn't
> reuse the timestamp by default.

So after realizing that this was about "author" timestamp, I am rescinding
this comment about the change of the default for -c and --amend.

But everything else still stands.  IOW, I still (1) do think the issue is
worth addressing (thanks Erick), (2) the log message can be improved, and
(3) --(old|new)-timestamp should be --[no-]reuse-timestamp.
