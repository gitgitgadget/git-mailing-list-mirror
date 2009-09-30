From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to
 general mechanism
Date: Wed, 30 Sep 2009 03:00:19 -0500
Message-ID: <A32FCFC6-13E2-4A9D-88FB-01ED47FE88AA@pobox.com>
References: <op.uzv4dyuotdk399@sirnot.private>
 <op.u0xtfzjrtdk399@sirnot.ed.ac.uk> <20090929163414.GA25756@spearce.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nick Edelen <sirnot@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sam Vilain <sam@vilain.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>, Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Sep 30 10:02:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msu7M-0000ky-2M
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 10:00:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbZI3IAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 04:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbZI3IAp
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 04:00:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52428 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZI3IAp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 04:00:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3A76764917;
	Wed, 30 Sep 2009 04:00:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; s=sasl; bh=X23U
	qdhsWzMsvyepzBUFy54eYt4=; b=o6nUzO1TiniO+v63aFf09fUaopY+h12HXbIr
	W15VxT2iJGq0fJfkAJtB7zczuiNI/HP8eLs3AcFs0gnYY3PFdg1lar6+Utw+JFee
	Ma0dwmmE2XSbomD9BPcKplI+22qPJhqM+Whu0nK4nX5cHtZtcVuxg8sRqsF+6x7G
	rdHmqW4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=in-reply-to
	:references:mime-version:content-type:message-id:cc
	:content-transfer-encoding:from:subject:date:to; q=dns; s=sasl; b=
	D0biuwvUNes+niUHprdiinuRglQiPL883LcUDeDyuvprMlDOM+e4yVwmAp+fTgPP
	GETQCabjsI7npdoE90ATLuEG5enKFxim4V2rJlNrOGRib0Z0Xzjk9AWwXqi6lG8y
	qHCk2Edq2+ToOawybfuhJksAxx/FRn0uyd7JjrAh4jk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A8AD064916;
	Wed, 30 Sep 2009 04:00:38 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.42.120]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D6DCB648FE; Wed, 30 Sep 2009
 04:00:21 -0400 (EDT)
In-Reply-To: <20090929163414.GA25756@spearce.org>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 57716598-AD97-11DE-92E7-8B19076EA04E-07245699!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129333>

On 2009 Sep 29, at 11:34, Shawn O. Pearce wrote:
> Nick Edelen <sirnot@gmail.com> wrote:
>> diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
>> index 4c1766d..b36bc39 100644
>
> This doesn't apply against ne/rev-cache^, and I don't have the
> blobs in my repostiory.  So I'm dropping this patch and will wait
> for a resend of the series or something...

It appears that the patch suffers from "format=flowed" whitespace
mangling. This caused the context lines to have an extra leading
space character.

After running a ham-fisted "sed -e 's/^  / /'" over the patch,
'git am' was able to apply it to ne/rev-cache^ (d05c9be9fa) even
though one of the referenced blobs (6c96297; rev-cache.c) was missing.

-- 
Chris
