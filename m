From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git-users] Problem using detached worktrees with commands implemented in scripts
Date: Wed, 16 Oct 2013 16:08:19 -0700
Message-ID: <xmqqk3hc3jbw.fsf@gitster.dls.corp.google.com>
References: <201310162003.r9GK3UYj014414@freeze.ariadne.com>
	<xmqqeh7k51vg.fsf@gitster.dls.corp.google.com>
	<29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dale R. Worley" <worley@alum.mit.edu>, <git@vger.kernel.org>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu Oct 17 01:08:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWaCZ-000897-Ie
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 01:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760894Ab3JPXIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 19:08:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42103 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757467Ab3JPXIX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 19:08:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 84FB74B99B;
	Wed, 16 Oct 2013 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EIwF9JAWoHVb7MAIM0JHfH6+BRI=; b=WQ52Kq
	T7MovRyvUnWoxNw/5hB5i1o19evflJyZk98eqOMa5mU81P31nidXrj/Ye4qggLdF
	giCjLHIvf8B7ByoppPem71CRdrVgem0VqDo/47z6N0Vl1IUuWrf2cu++5pT4ozBf
	OOv6t4D01nqakmqTOreEngvfSAwr2zgXbw0g0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VeYQfglzNvs+y4XJBgkOVIzGgnuTN8Wr
	9ZoJ3gDwd6lNCcylaJ+8TffQZV/7WOHx3PpiNy6JIeVUfh7r1fVqNILDWp9Hrw0p
	n9Kvjj4Kr9T/6p/dy1cA2SUBaLyCcPbID1iHul+9Gmpylmei/fZkRW8f8KbW0aMp
	go9iv9DrHNI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 791F14B99A;
	Wed, 16 Oct 2013 23:08:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A21F34B996;
	Wed, 16 Oct 2013 23:08:21 +0000 (UTC)
In-Reply-To: <29AA597BEBC146B09E8B370949EC2CE9@PhilipOakley> (Philip Oakley's
	message of "Wed, 16 Oct 2013 23:39:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DA117D28-36B7-11E3-BE0A-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236282>

"Philip Oakley" <philipoakley@iee.org> writes:

> ... and the detection process for 'toplevel' may not work
> properly when in a separated work-tree environment.

Without GIT_WORK_TREE exported to point at the top-level, there is
nothing that lets us "detect" it, as the working tree does not have
".git" directory to tell us to stop, no?
