From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-update-index.txt: Remove obsolete note
Date: Thu, 31 Mar 2011 14:41:09 -0700
Message-ID: <7v7hbfj7d6.fsf@alter.siamese.dyndns.org>
References: <4D9329C5.3060809@elegosoft.com>
 <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakob Pfender <jpfender@elegosoft.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, torvalds@osdl.org,
	spearce@spearce.org, johannes.schindelin@gmx.de, peff@peff.net,
	nico@fluxnic.net, barkalow@iabervon.org, chriscool@tuxfamily.org,
	jrnieder@gmail.com, raa.lkml@gmail.com,
	Matthieu.Moy@grenoble-inp.fr, Johannes Sixt <j.sixt@viscovery.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 23:41:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5Pcr-00018S-D1
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 23:41:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759013Ab1CaVlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 17:41:52 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab1CaVlv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 17:41:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EF8DF4F71;
	Thu, 31 Mar 2011 17:43:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HwPWvtDO/Qn4hzReyXdQsGB7LgY=; b=JZmOc0
	k8/bOqgPCE/rkugs/IRHzFJOkvSY6NTT1A0VWV2Agv9q+dwpy2Uf/07iVEH+ByPE
	xBJp9FIwWkyZjNknqnskH1kKrdjuq56UJTFjkyrTpSwJVw8becJaRfEo+K7zfSSh
	ktJcjaSVC6E4iktEVhznEhbD6jbx1yIrRTrtU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AyIJcTquOWGFh9Elw2HfTIQoHsqMIXNk
	pOkuZte+6M0S5090QP/0yOygtqEwaJRyFJjc8YVCZaSQEPyYFAA3fjSvSFDM4Ts3
	Ao/k6MDG8tdsP8Ofn7FHMnevnybVkcP5qEeYoYd07iGEM/FqxlIJ/wbFilg5+9UB
	ITeBx9GRcRU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0C1F84F68;
	Thu, 31 Mar 2011 17:43:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CD154F62; Thu, 31 Mar 2011
 17:43:00 -0400 (EDT)
In-Reply-To: <AANLkTik3nEE2mtpRVwuQxfoNZd8Ejpgc=T=GS_jEpXsB@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu, 31 Mar 2011 19:15:43 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E63C2D10-5BDF-11E0-B5BF-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170531>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Mar 30, 2011 at 8:01 PM, Jakob Pfender <jpfender@elegosoft.com> wrote:
>> 8dcf39 (Prevent bogus paths from being added to the index) introduced a
>> check for files beginning with '.', preventing path names such as
>> `./file`, `dir/./file` or `dir/../file` from being added. This was
>> reflected in the man page.
>>
>> d089eba (setup: sanitize absolute and funny paths in get_pathspec())
>> removed this check without reflecting the change in the man page.
>
> Sounds good.

When I first read it, however, I thought that the "removal" meant that the
rewrite made the code riskier by accepting nonsense, which turns out not
to be what the author meant.  It was more like "instead of rejecting,
accept these paths after normalizing", no?
