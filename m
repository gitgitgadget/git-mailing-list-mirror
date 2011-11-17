From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: squash consecutive slashes with p_value > 0
Date: Thu, 17 Nov 2011 10:07:27 -0800
Message-ID: <7vmxbumxls.fsf@alter.siamese.dyndns.org>
References: <20111116120403.GA10342@mal.justgohome.co.uk>
 <7v62ikq89h.fsf@alter.siamese.dyndns.org>
 <20111117150409.GB17472@mal.justgohome.co.uk>
 <7vr516myqh.fsf@alter.siamese.dyndns.org>
 <20111117175544.GC17472@mal.justgohome.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robie Basak <robie.basak@canonical.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 19:07:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RR6N5-0008NR-4D
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 19:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab1KQSHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Nov 2011 13:07:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751398Ab1KQSHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Nov 2011 13:07:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9F40622D;
	Thu, 17 Nov 2011 13:07:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BE/dge8CrS5W5Rx2rmjMmiGBVng=; b=aKBFrL
	PKg6IClV+/cTHfrg/GrhnEgsMQ3nW9puHQ9U3GZUPgLuuwDgeTO9L2PjaWeydnAs
	PReJwUtA5PQS0/aA+K4OcS0H8KgOCJ8TYzuY+EDUSc0DRkGpri1zFZzeEx0FbvhR
	Kd2ISLRwtNY5zePMDcupcJ6Ib3ObKiSKT9nTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GrKTDVIrxK1LmE5Y4a/a862nT7zgOglL
	YfcHJdQqR+jdX+djzJXwZJskq0RWkSQUHVnaHq7QqJpiRlNZU19MXfnpRk3u/970
	AZ6eHQkxY3fGmU0X4QZ0S5EheZGtlaetejsfdSvQ6ZeBO7l+8QlYnRhxXiJXTJwd
	NSlzJiLUc6E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A1A22622C;
	Thu, 17 Nov 2011 13:07:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 34CF3622B; Thu, 17 Nov 2011
 13:07:29 -0500 (EST)
In-Reply-To: <20111117175544.GC17472@mal.justgohome.co.uk> (Robie Basak's
 message of "Thu, 17 Nov 2011 17:55:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 033961E0-1147-11E1-BC32-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185603>

Robie Basak <robie.basak@canonical.com> writes:

> I'm now confused about what it will do (which is why I need to look at
> it again to make sure), but if it turns out to be easier to just handle
> that one boundary point, would you accept a patch that eliminates just
> that duplicate, on the basis that in Unix-land duplicate slashes are
> perfectly acceptable to be left lying around?

If that is the case, I would rather say we should even shoot for
simpler. Just tell the patch generator not to include unneeded double
slashes.
