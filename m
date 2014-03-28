From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] patch-id: make it stable against hunk reordering
Date: Fri, 28 Mar 2014 11:20:41 -0700
Message-ID: <xmqq38i2b2x2.fsf@gitster.dls.corp.google.com>
References: <1396009159-2078-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 19:20:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTbOb-0003Go-GM
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 19:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbaC1SUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 14:20:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41979 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbaC1SUo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 14:20:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B105B76FD3;
	Fri, 28 Mar 2014 14:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rnuv9en2kUop7pKVVFpwt/hKNMs=; b=tUbiNq
	lflW0/j5nWZOGoEAUxQCzNOjI+exF6DWGT8o5xZaPfjFrllGAUMKqlhB6ayRJUww
	MsgLc98xY492LWnvNQSph7cIPfIdmGXm1Ex65Jjjm2pVimhl0ybpsHWw0/tiksB0
	DEso1fAuJZqKqemK1/8+BWuRMeYAI1+v9Ozbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hpnERYHgrGFDzVtBjQW/0R0s5zXGhUOb
	U0QdndxsWPnHFrTBLv2XrlLLBOC1Dlr5VYxys+PJYyPCaUEahsqBxQ1EGsysgtJg
	qR7ylf3uEJPwTPgNbtnpsg9BmmVEbcI2k8ofDaXweMH9RFxxxjGFQ7gHTuWFaVPl
	QAgYnk+V20E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D49476FD2;
	Fri, 28 Mar 2014 14:20:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD59F76FD1;
	Fri, 28 Mar 2014 14:20:42 -0400 (EDT)
In-Reply-To: <1396009159-2078-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Fri, 28 Mar 2014 14:30:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC6B55A6-B6A5-11E3-89F6-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245408>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Patch id changes if you reorder hunks in a diff.

Reording "files" is fine, and as we discussed, having multiple
patches that touch the same path is fine, but do not sound as if you
are allowing to reorder "hunks" inside a single patch that touch a
single file.

Thanks.
