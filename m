From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read_index_from(): catch out of order entries when reading an index file
Date: Fri, 29 Aug 2014 10:06:13 -0700
Message-ID: <xmqqsikf6xa2.fsf@gitster.dls.corp.google.com>
References: <CAPig+cS__Sw1gNj3Pz20OC51QBsuxBEXTzMStAerwfMuT2afQg@mail.gmail.com>
	<1409302481-4914-1-git-send-email-jsorianopastor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jaime Soriano Pastor <jsorianopastor@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 19:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPd6-0002LY-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 19:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753580AbaH2RGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 13:06:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61349 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbaH2RGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 13:06:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5B34E3334E;
	Fri, 29 Aug 2014 13:06:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=N7WuDyLeDcKHEHRrtjsCNHTD4jw=; b=iiKjcz
	caK8I6x7bR03eEOtBl+6VhRvHRneIGFpaHlUtw7yerHVPfGOXX5dY1gqAjxims8s
	etWOUkDX32NO5ifxdDaGvtEu0JLdjHiWeYz8X0Q0TQ9EXccPKGCmj9vp7zbvO0YI
	VE906y5x34Kfdi9dcwsbr1d5ly7yh4K437Z1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MG56WjgEHqRH8wfBXdjLQunHS0C+df3H
	Ws3rLQzjlWDQ/PljbdHbIJ81UaRpZ065qw9e1Evm5Oiasyrq6StcUhf3DSw7rQ08
	f4Z3ue1031OQRErCKr//wuZkXN8aK7S625PRkeMj+aG6VMdhqQU7vZ/cMjz5x/3t
	P63s/t8aZ/Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 525B13334D;
	Fri, 29 Aug 2014 13:06:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 26B473334B;
	Fri, 29 Aug 2014 13:06:15 -0400 (EDT)
In-Reply-To: <1409302481-4914-1-git-send-email-jsorianopastor@gmail.com>
	(Jaime Soriano Pastor's message of "Fri, 29 Aug 2014 10:54:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C902E194-2F9E-11E4-87E9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256165>

Thanks, both.
