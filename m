From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git stash while pending merge should not be allowed
Date: Fri, 07 Jun 2013 11:47:07 -0700
Message-ID: <7v1u8du5as.fsf@alter.siamese.dyndns.org>
References: <51B18331.6060302@coverity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Scott McPeak <smcpeak@coverity.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 20:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul1gx-0003R4-WF
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 20:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756300Ab3FGSrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 14:47:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64379 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755813Ab3FGSrK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 14:47:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BCC261AD;
	Fri,  7 Jun 2013 18:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n9bcCAaqToMz/mc5a3lBmC0TPAs=; b=KPqNDb
	FY+ZW/sWoViC2rUja3OWpNxQH6tEhpGa1fAGQLOFncKYr+6OY/2sOXa8BfN+LHyC
	5rUkseLVPLPR7e9XzwprOkFbNMcObZFVWnXKp4pxg+EY24ajHMZAdOGaKErgrbY9
	p1an3V8+DRsD7WqM34hvHPHfs2P9zL6EYXb+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=StOsbO4VGyclveZOts//Y4YKKhOITJyx
	IIRSBTBp7cDvlcOqOCaNIfjMfBgaSNfQV7U4cKkv7eWFdUtFf8YAw1RqXWGz9Ddd
	iALB/9FB0i9T3bM50qiiEJuJ4JRZbjiDBbQR+brn73n7UV2HbLKVN1usvsml20qN
	zB80ZsVAHt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9350261AC;
	Fri,  7 Jun 2013 18:47:09 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 45C30261AB;
	Fri,  7 Jun 2013 18:47:09 +0000 (UTC)
In-Reply-To: <51B18331.6060302@coverity.com> (Scott McPeak's message of "Thu,
	6 Jun 2013 23:52:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A87CFE6C-CFA2-11E2-9E62-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226667>

Scott McPeak <smcpeak@coverity.com> writes:

> I suggest that this problem could easily have been avoided if "git
> stash" refused to run with a pending merge (present MERGE_HEAD file),
> since this is crucial repository state that it does not save.  This
> seems similar to what "git cherry-pick" does.

Sounds senslbe.  What do we want to see happen in other states, in
which Git gives control back to the user asking for help before
moving forward (e.g. am, rebase, cherry-pick, revert)?
