From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 05/26] Move "get_ack()" back to fetch-pack
Date: Wed, 28 Oct 2009 20:24:08 -0700
Message-ID: <7vljiudgrr.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-6-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 04:24:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3Lcg-0004gN-ES
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 04:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140AbZJ2DYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 23:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbZJ2DYQ
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 23:24:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbZJ2DYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 23:24:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 39D098979E;
	Wed, 28 Oct 2009 23:24:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i5D+fbFgRVwVWEDIpohEaxiLyI8=; b=J5tI0C
	Ua3iw+2u8pHpfW8D0CLoPd1atgHYIwdEpAZ8MTCCQoM5gqQqchWrlI0bswSj7tNE
	RgS3paNdtzGHRWtAp78HTEqALF4zb5/1hQsBN+9TOjimuMLmZEfukh5wq1Mh4JSG
	934toqx5olfaVPXVNUtKml5o4VkHETGePQYPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SosbVfoh+N5NkLszzY0ztNeWc75lVg87
	09cTxjbo7VjXK0tWoDv2fqR6VymzzfzpNZAkGOKeSoEm+luCLDBcH8LKGGqYl3bt
	KD5LOOCNhkpQzBeHhhUHjeIyyZEae5gR2L3yTfoJgXACc88jcS5/fWeM6Ir65q1W
	9iJpMBV0EZ8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B4CE89798;
	Wed, 28 Oct 2009 23:24:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E2B438978F; Wed, 28 Oct 2009
 23:24:14 -0400 (EDT)
In-Reply-To: <1256774448-7625-6-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Wed\, 28 Oct 2009 17\:00\:27 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8AA1D786-C43A-11DE-BE88-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131551>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In 41cb7488 Linus moved this function to connect.c for reuse inside
> of the git-clone-pack command.  That was 2005, but in 2006 Junio
> retired git-clone-pack in commit efc7fa53.  Since then the only
> caller has been fetch-pack.  Since this ACK/NAK exchange is only
> used by the fetch-pack/upload-pack protocol we should keep move
> it back to a private detail of fetch-pack.

Should we keep it there or should we move it?  which? ;-)
