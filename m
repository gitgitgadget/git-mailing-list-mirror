From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Speedup bash completion loading
Date: Fri, 09 Oct 2009 17:57:44 -0700
Message-ID: <7vd44wdq0n.fsf@alter.siamese.dyndns.org>
References: <4e0a90ed0910051218oaa64b94jd12a6678934523ac@mail.gmail.com>
 <1254737039-10404-1-git-send-email-kirr@mns.spb.ru>
 <20091005152504.GE9261@spearce.org>
 <20091008132718.GA12161@tugrik.mns.mnsspb.ru>
 <20091008150206.GD9261@spearce.org>
 <20091009090958.GA4758@tugrik.mns.mnsspb.ru>
 <20091009144606.GT9261@spearce.org>
 <20091009152149.GA26171@tugrik.mns.mnsspb.ru>
 <20091009153936.GV9261@spearce.org>
 <20091009160856.GA26833@tugrik.mns.mnsspb.ru>
 <20091009161443.GX9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kirill Smelkov <kirr@mns.spb.ru>, Ted Pavlic <ted@tedpavlic.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLh-0005GI-Hr
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbZJJA6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934741AbZJJA6h
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:58:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62251 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934740AbZJJA6h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:58:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E0A8C71E61;
	Fri,  9 Oct 2009 20:57:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=n8Dj91jFqL8YX9GZE3by2zzG5zI=; b=YP2GrbUnjFCPT9q4pv3g17l
	heYxv/npDDWwywynMKb3Adi7G/8xvYE6UBfy/TtTyOTUhe11V+3sV8S822QmKW2R
	pPop5/ndKhaQFJgxb8U/+HPUhO19KVlJDhCUd0QTWbxQzy1WC7FCVjgkjkF0vr7t
	EeCMWGIB+an/NRzlCtMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=B3OLKEQXZPkDETuykwhzqgLcCpIdJZmuKG+jfOFsgHHIJ5rau
	xoY86Bt3ZUqDnMsL8sDXBTLJ+B8P0SEKfTNgMhOFSkVyrR0WWXuIaYw8PjVSpVvd
	Xk+3Wxv/oqOYz67MY7giLQt9IPcEdTOxfpyi3+lOiLPVM0/zWW7ks82o7I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id ABA0771E5F;
	Fri,  9 Oct 2009 20:57:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 40E0C71E5D; Fri,  9 Oct 2009
 20:57:45 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EFACC062-B537-11DE-B424-1000076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129868>

Thanks for this, and all the other acks and patches.
