From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 27/48] merge-recursive: Consolidate different
 update_stages functions
Date: Mon, 18 Jul 2011 16:39:36 -0700
Message-ID: <7v39i3cg5j.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-28-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 01:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QixPb-0003GU-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 01:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751828Ab1GRXjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 19:39:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751114Ab1GRXji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 19:39:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77E3741E4;
	Mon, 18 Jul 2011 19:39:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=lbV6p3aRrnx/4qx0rKXvHkSSb8I=; b=HLgxrahaGT6f5YoBnoU6
	G+cobouhlzuckU7LIkq/61TbfO3R72IVf8JTcTZyjelDdL8Rii1lo+1nlj9FjQvE
	yWFoXl56Kw4c8LDhXjF1cS75asNFbiHnMK7oZwST3vP4dyQXEHhhfYkElWNyTubN
	AIaKp+Zs5kgwNdx5MiTJSLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=vHokWoXUSZE8urnM4rX1g0xcffASBRc57Hh+v/gsj5cvrw
	ZEwBlS6BVQ9H3FmVLkNumbZUapiRvrjHtxyhTHkbSou/noCvixkinOvhVlmA8Gp4
	Q6sxoMxhm0ylF6lu6SK8/djdaPCtfR2v0flVbmK2jZGw1fRJ6Rd3ffxW3W6IU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6FE1B41E3;
	Mon, 18 Jul 2011 19:39:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 064F541E2; Mon, 18 Jul 2011
 19:39:37 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3352D3F8-B197-11E0-8C12-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177423>

Elijah Newren <newren@gmail.com> writes:

> We are only calling update_stages_options() one way really, so we can
> consolidate the slightly different variants into one and remove some
> parameters whose values are always the same.

Nice; I wonder if this can come much earlier in the series?
