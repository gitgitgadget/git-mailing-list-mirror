From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: fold multiple entry "Cc:" and
 multiple single line "RCPT TO:"s
Date: Thu, 08 Oct 2009 23:50:07 -0700
Message-ID: <7vtyy95ae8.fsf@alter.siamese.dyndns.org>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
 <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
 <1254979690.2056.103.camel@Joe-Laptop.home>
 <7vy6nlhmw7.fsf@alter.siamese.dyndns.org>
 <1255021406.2056.122.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jay Soffian <jaysoffian@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 08:51:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mw9Jj-0005Ea-QH
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 08:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932692AbZJIGvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 02:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757171AbZJIGvA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 02:51:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565AbZJIGu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 02:50:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F15D70468;
	Fri,  9 Oct 2009 02:50:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1nW4K/eH0wjrdJGeQFYcBgTc17Y=; b=ZYoEih
	GttrhIh66EwrL89PYpdtHhtWt4RheZMoUxJmxrgRKxyru687ZYrYiGQL+emcwp+w
	O49WxXMd8AUYmqO0jEg/OYnAMKj3XqaQkjCuxbAMGL4QwVH2yM6ND4wZkyyeVTGD
	+PbwyvXTNC0CPuZJjUlXNX9d4L6hCfamNZOfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SCmlqgjbUqiPR8/9JydvH3i+fVs4YYq0
	2iNrq+vT6gSqOx4mX1fACpfEgBAZCul4PE06NPK1LrdV54gTrlh0cafs2F1dteEj
	cdHVAfg23dufiECP78KKzSaY/RxMFm96y5bC0CUehMK/1XGFdw+IUA9Q89WdaU6P
	cTNRlWpZ2rU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 05CC970467;
	Fri,  9 Oct 2009 02:50:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9926470465; Fri,  9 Oct 2009
 02:50:09 -0400 (EDT)
In-Reply-To: <1255021406.2056.122.camel@Joe-Laptop.home> (Joe Perches's
 message of "Thu\, 08 Oct 2009 10\:03\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FFA9CC3C-B49F-11DE-B3EC-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129743>

Joe Perches <joe@perches.com> writes:

> Some MTAs reject Cc: lines longer than 78 chars.
> Avoid this by using the same join as "To:" ",\n\t"
> so each subsequent Cc entry is on a new line.
>
> RCPT TO: should have a single entry per line.
> see: http://www.ietf.org/rfc/rfc2821.txt
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks.
