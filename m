From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Revert "bash prompt: avoid command substitution when finalizing gitstring"
Date: Wed, 21 Aug 2013 18:27:21 -0700
Message-ID: <xmqq38q2sefa.fsf@gitster.dls.corp.google.com>
References: <1377118173-23405-1-git-send-email-bcasey@nvidia.com>
	<1377118173-23405-3-git-send-email-bcasey@nvidia.com>
	<xmqq7gfeu35g.fsf@gitster.dls.corp.google.com>
	<CA+sFfMc0BPo8pSLngi=bAWxYNT8xKFEOo77z3a12q+-Sq4qiiA@mail.gmail.com>
	<xmqq7gfesheu.fsf@gitster.dls.corp.google.com>
	<CA+sFfMfa422PF1inOOeTBRE7HRqL5zwCJNagx9Ya0i_LbpwQcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <bcasey@nvidia.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, szeder@ira.uka.de
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 03:27:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCJgP-00020z-QD
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 03:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3HVB1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 21:27:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752185Ab3HVB1Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 21:27:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0D7E2970C;
	Thu, 22 Aug 2013 01:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NHS5w6phLP2u4yZDdPLw0i2QFrY=; b=GwB3z4
	oBLt96Qk/YBdBakGrZEPAd1FNaeQ4sTJRA09AI49fuDE/dk+cONQAwHk++PI4Uy2
	SxZLThn4xor3PCy+KSjn0UNA12IJuxB9Vrf6k0/MemES3iVghnqGBDIeWARgOSDP
	zM4vP3qR2amG+e3p03kZXe2QhcXLHinSLkXAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F2jrde56zjGP2wCiChgdE0XHxczD+Su/
	zBOjY7sRJNXIUvsfkmc6ncFUcpZkTyHp9my2dhZJm7CWmMFKF4OIkekbJakDEJjP
	AWQOq8dyRHgFKkyZaIoGzwR4zNNLoANCvB8HFDlGVG0OODgAPjG6S8iASoJ8J45Y
	KFinVbK0Elg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A142970B;
	Thu, 22 Aug 2013 01:27:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2F06529705;
	Thu, 22 Aug 2013 01:27:23 +0000 (UTC)
In-Reply-To: <CA+sFfMfa422PF1inOOeTBRE7HRqL5zwCJNagx9Ya0i_LbpwQcg@mail.gmail.com>
	(Brandon Casey's message of "Wed, 21 Aug 2013 17:33:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEDFD5F6-0AC9-11E3-AD18-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232759>

Brandon Casey <drafnel@gmail.com> writes:

> Why is "${var-}" necessary?  Wouldn't that be equivalent to "${var}"
> or "$var"?

set -u
