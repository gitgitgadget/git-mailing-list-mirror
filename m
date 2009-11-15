From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-pull.sh --rebase: overhaul error handling when no
 candidates are found
Date: Sun, 15 Nov 2009 01:08:26 -0800
Message-ID: <7vy6m8qho5.fsf@alter.siamese.dyndns.org>
References: <1257945756.26362.79.camel@heerbeest>
 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest> <20091112155310.7836c388@perceptron>
 <20091112150626.GA24848@coredump.intra.peff.net>
 <20091112170814.1858aba4@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Jan Nieuwenhuizen <janneke-list@xs4all.nl>,
	Tomas Carnecky <tom@dbservice.com>,
	git list <git@vger.kernel.org>
To: Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9b6G-0001fg-Ev
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbZKOJIg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Nov 2009 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZKOJIg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:08:36 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbZKOJIe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Nov 2009 04:08:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BDFF7F3E4;
	Sun, 15 Nov 2009 04:08:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=vdcxNhCivIv/5EWipdrp2MVOk
	OY=; b=JxyQ97fZEYVEeckOKRQeekPyeQWWOO/XQ1CBY7O12E4G1cDj+2wGLvpof
	GAs4PvwTLeZxMGBqszVMoUSVD+9BAubicRH43TdgIG7DjgyOFXcbG8TPfcsSNtNZ
	gP4nebHqa32A6Haggu7Z3/eZytXStBcBRf2n99oKDqS7GpZ3Lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=buohbo5Nyuo/pbNPIRM
	9G1/TtuwGTkPCqWYQuL4bSaptpTTM63KZTbOHHFEIt0ZMlcnQqLjlVj8HDKRWyRk
	djO0Octb6ickWHq2Zp36NRMKAiekUDv/GaVE5UR2rIwwGTBZQmy9ux47+oT6peXE
	8zUjkJeEtV86nKMgdh73FIW8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E4427F3E3;
	Sun, 15 Nov 2009 04:08:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 235017F3E2; Sun, 15 Nov
 2009 04:08:27 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7390617C-D1C6-11DE-B8C6-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132918>

Jan Kr=C3=BCger <jk@jk.gs> writes:

> So this still uses config file syntax, but the erroneous check for
> using the "rebase" setting is gone. Instead, if --rebase is in effect=
,
> include "rebase =3D true" in the sample config snippet.

Will queue.

I've been ill and didn't follow the discussion very closely, so perhaps
there may still some minor disagreements in the details I didn't catch?

Just in case, I'll queue it on 'pu' for now.

Thanks.
