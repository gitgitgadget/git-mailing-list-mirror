From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH nd/struct-pathspec] declare 1-bit bitfields to be
 unsigned
Date: Tue, 15 Mar 2011 22:38:54 -0700
Message-ID: <7vzkov8w0h.fsf@alter.siamese.dyndns.org>
References: <20110316024959.GA24932@elie> <20110316034232.GA26027@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 06:39:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzjRu-0002Bv-Ld
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1CPFjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:39:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1CPFjE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:39:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA07C2408;
	Wed, 16 Mar 2011 01:40:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=MkXcFE8Znsw64yJHHmm4Xi8+Oy0=; b=fpcAIj/LZDHdkqicWcA4
	rSQ+u1/1K64VdfSDKkxi5ZnHwR7TNf7H3D09KIPvOdj4JxLSYAZGhzvsHc0mv8mm
	dcDExjeFQDu55rZ7UCSKQuAyeKoKt6FZiH3V0+NRUxZDGi79Wi4hfDpAAAJ4UVCE
	2Iv0GUArHbQSHYJ+QODIiBg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=d1r+lr3ZCobz/Hsq16h3Gk3Y0JoTNS8RwndXNoqs8eTyzQ
	jO87cb0AblpkAcdKT1uE+vkzLtP+x1GO2OqIKc66cm56K5IREH88ynSPUAMgcMuy
	8qbV9MP0FaoSFJv8i/VhvaKj/HG6b4WxE/fSyFId1jHUhpH9jo+UQkVLAhSjs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B93B52407;
	Wed, 16 Mar 2011 01:40:32 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AB50923FC; Wed, 16 Mar 2011
 01:40:28 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8DC36F2-4F8F-11E0-AE09-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169106>

Jonathan Nieder <jrnieder@gmail.com> writes:

> As "gcc -pedantic" notices, a two's complement 1-bit signed integer
> cannot represent the value '1'.

Thanks; this is one of the things I try to be reasonably careful about
when I eyeball patches, but apparently I didn't spot it.

Perhaps I should start compiling with -Woverflow.
