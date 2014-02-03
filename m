From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] tree-diff: no need to manually verify that there is no mode change for a path
Date: Mon, 03 Feb 2014 15:12:37 -0800
Message-ID: <xmqqvbwvbxju.fsf@gitster.dls.corp.google.com>
References: <cover.1391430523.git.kirr@mns.spb.ru>
	<83f38f44dab9e07e99ad851f531e01cee52e7019.1391430523.git.kirr@mns.spb.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kirill Smelkov <kirr@mns.spb.ru>
X-From: git-owner@vger.kernel.org Tue Feb 04 00:12:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WASh4-0004LE-Pe
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 00:12:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbaBCXMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Feb 2014 18:12:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaBCXMm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Feb 2014 18:12:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B5E4269A5E;
	Mon,  3 Feb 2014 18:12:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2mro8Rr2bRG4QjaKWHMuKSYTxHY=; b=V9nEqs
	CVB3bKBFPeIexQBDDMwR+anODlpBCvzxVY4anN/cKnkgErKJgsg3d6g744QeQb/V
	Rfo6Gq4QvYr/xndUtY7DQaiMmuG6c56aCS1/pTtKdnVHaYod0PMFPEuuzxGZvp/l
	p67Gk3mMfAis2bHujMIn3/8wcBkMb6Leq/CrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mOJSXcvDrUgEPD9PLKNh1dof7uD8v0AT
	i7A5ywT0zW79SBs3ozwV1NUp+JOYGK7JEXhOjFadmdjoJQitvyIyIEJUK6Z9DCTZ
	APDTHzHzYk9pOE8jcG9uVNmQgKQk4r62J9E6Izbp4XkM36A1RezW4QQdibZYahn3
	Ma0ZKjLqO5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85F669A5D;
	Mon,  3 Feb 2014 18:12:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF70069A5A;
	Mon,  3 Feb 2014 18:12:39 -0500 (EST)
In-Reply-To: <83f38f44dab9e07e99ad851f531e01cee52e7019.1391430523.git.kirr@mns.spb.ru>
	(Kirill Smelkov's message of "Mon, 3 Feb 2014 16:47:17 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AD6F8EBE-8D28-11E3-8B08-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241491>

Kirill Smelkov <kirr@mns.spb.ru> writes:

> Because if there is, such two tree entries would never be compared as
> equal - the code in base_name_compare() explicitly compares modes, if
> there is a change for dir bit, even for equal paths, entries would
> compare as different.

OK.
