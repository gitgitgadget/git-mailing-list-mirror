From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/4] tag: configure default tag sort via .gitconfig
Date: Tue, 15 Jul 2014 15:40:48 -0700
Message-ID: <xmqqbnsqtfdb.fsf@gitster.dls.corp.google.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 00:41:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7BPB-0002d3-0Y
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 00:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758230AbaGOWk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 18:40:57 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53293 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758146AbaGOWk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 18:40:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5AD8E294E5;
	Tue, 15 Jul 2014 18:40:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BWZqO8Qbt5/BA2nHAQ0/KKLJQ3I=; b=vjz+X4
	CpXn+J+I9uKVFSpkKE8lbuDA3v6a1ICPZvj0CzO9BPFon1VMv7FEKvrw+xufF2tF
	dG7qN/o/ZL9DO7g4CO1VLEXZ4Nw2o24ziL/8WUF6BTWAYLvPHn6qQzWMD1WJX528
	walvEP1rP5K9kmuSySb4tYUC4LXO/0MH8qkpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mwAoc6zJEMKtPJfTYl6Otb9N8x117kAq
	ufFp2yxs/yTxlYHJbDF8oxy9+C5wyU3+0w7+fSPnGEpcxYBYvA2FNCNKUGVwKLEz
	Bu3Stu12Bft5lztFPHrLVqgN1vZcX6wf80rwlV94ihKlN2rFlWyoCAoVo3kpcmDm
	borMAbqJVlc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4FEC9294E4;
	Tue, 15 Jul 2014 18:40:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A4DC294DF;
	Tue, 15 Jul 2014 18:40:32 -0400 (EDT)
In-Reply-To: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
	(Jacob Keller's message of "Tue, 15 Jul 2014 14:29:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 079B7C82-0C71-11E4-86CE-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253611>

Jacob Keller <jacob.e.keller@intel.com> writes:

> This patch series is hopefully the final version of a series of patches which
> updates git-tag to allow the .gitconfig variable 'tag.sort' to be used as the
> default sort parameter. This version uses a new set/pop error routine setup
> which enables correctly modifying the error routine to handle the config vs the
> command line.
>
> In addition, I split the patch such that all the changes to the original
> parse_opt_sort are shown, and the following patch which extracts this function
> is just a function extraction with no changes, making it easier to review the
> new changes. One other minor bug fix is included as well.
>
> Jacob Keller (4):
>   usage: make error functions a stack
>   tag: fix --sort tests to use cat<<-\EOF format
>   tag: update parsing to be more precise regarding errors
>   tag: support configuring --sort via .gitconfig

The first one looked somewhat tricky, but looked nice overall from a
cursory reading.

Thanks.
