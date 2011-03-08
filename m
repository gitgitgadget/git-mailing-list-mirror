From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Honor HP C's noreturn attribute
Date: Tue, 08 Mar 2011 11:00:43 -0800
Message-ID: <7v4o7dfndw.fsf@alter.siamese.dyndns.org>
References: <32EABE0E-2447-4189-A3CE-05B68A5E18EF@nextsoft.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Michal Rokos <rokos@nextsoft.cz>
X-From: git-owner@vger.kernel.org Tue Mar 08 20:01:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px29S-0000GR-KL
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 20:00:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab1CHTAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 14:00:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65168 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088Ab1CHTAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 14:00:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3D8974DAB;
	Tue,  8 Mar 2011 14:02:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=edV/celElDxesDEvOXt1wCFN98g=; b=Qye3s92sGRLnCZXICNFS
	Uj7mm3AACnXH6DbGrLkUJUUxPQNpop9SObGboeXVTptH8IV47TKelPauDakaMchb
	t0EVanjWRDEvw8d1FImTBcM9QCjqKW9whPuq0nDtdp3OfrALdd34HV5VXvWwURD+
	6z9LRM5FdcsORVJ+vyRwyKs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=ZMENxlab3gzQOTL4RqZVWuLYoT3RCex3DMi7mZyQziRO7P
	7b2Q//DPh7tj2qWWWuVI6KZr8qseBpRbL4/jC9p8v6qnNL9tZXACCxM83GFKEJFC
	aN2LS5/qs7QTSbzcNaI49XelyvBFPv4TMk8bBc+LDtZBQJqtaW/s3aJWJiark=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1BDAA4DAA;
	Tue,  8 Mar 2011 14:02:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1EFC24DA9; Tue,  8 Mar 2011
 14:02:11 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 94CA0488-49B6-11E0-8B7C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168674>

Michal Rokos <rokos@nextsoft.cz> writes:

> HP C for Integrity servers (Itanium) gained support for noreturn
> attribute sometime in 2006. It was released in Compiler Version A.06.10
> and made available in July 2006.
>
> The __HP_cc define detects the HP C compiler version. Precede the
> __GNUC__ check so it works well when compiling with HP C using -Agcc
> option that enables partial support for the GNU C dialect. The -Agcc
> defines the __GNUC__ too.
>
> Signed-off-by: Michal Rokos <michal.rokos@nextsoft.cz>

We tend to prefer new code be appended at the end of if/elif/.../then/fi
cascade when there is no strong reason to do otherwise; your log message
clearly explains why this particular #if needs to come before the existing
one.

I love it when people write a very readable log message to explain why the
patch _has_ to be the way it is.  Very good job.

Except for the overlooooooooong lines in the message, which I line-wrapped
locally before applying, that is.

Thanks.
