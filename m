From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-send-email.perl: fold multiple entry "Cc:" and
 multiple single line "RCPT TO:"s
Date: Fri, 09 Oct 2009 17:57:26 -0700
Message-ID: <7vtyy8dq15.fsf@alter.siamese.dyndns.org>
References: <1254759898.1799.449.camel@Joe-Laptop.home>
 <7vd44yo4uz.fsf@alter.siamese.dyndns.org>
 <1254979690.2056.103.camel@Joe-Laptop.home>
 <7vy6nlhmw7.fsf@alter.siamese.dyndns.org>
 <1255021406.2056.122.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLf-0005GI-SW
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbZJJA6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934740AbZJJA6R
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934737AbZJJA6P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9311F52C24;
	Fri,  9 Oct 2009 20:57:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+BDKn5Dx0BAHnuSx7QG+r/I9go4=; b=x/Td9iKGyl+7WreKY1c//vh
	9hLodDTYhveWAiWpxMrsYr3mralOPJSwjUuEFS3xFj2j0zVS8lEhBjMGQIcYo+iR
	kmu3InCHXTOH5m6dSXFFEn7mFS0m24fKMraMAUHTODGxf9feKaJ/ajjgDqLY8VpE
	Qw5UmAzf1Czis0FCS52o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=deNSx6rgWacwqNYGtSXzmP3EqmuNunU6Wkp3ubhWUN8sBRhJH
	BEnbcXDlxMX/RjK/xX2PXhJtEpBlJ0g2+BjgEsAdiy2O1bSZHgBEUEFI57m3a0EE
	Cvel4lWpE+i+4ozGBhGOEuRaJXHVJ3so1NqceiTeDiGB9NmdYSbmtZMtEc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 66AB252C20;
	Fri,  9 Oct 2009 20:57:31 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B083352C1E; Fri,  9 Oct
 2009 20:57:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E395CE7C-B537-11DE-A745-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129864>

This breaks t9001 since it expects an old (and probably incorrect) RCPT TO:
lines.  I fixed them up.
