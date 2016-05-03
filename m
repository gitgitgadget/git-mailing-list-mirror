From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] submodule deinit: lose requirement for giving '.'
Date: Tue, 03 May 2016 12:08:36 -0700
Message-ID: <xmqqzis7m023.fsf@gitster.mtv.corp.google.com>
References: <1462227844-10624-1-git-send-email-sbeller@google.com>
	<1462227844-10624-3-git-send-email-sbeller@google.com>
	<xmqqoa8nnjld.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaHmtRooJ7J6BknqWDkVFN0Bx3xngkEH0CnAp7Aaehnig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 21:08:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfgZ-0003KH-Ux
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 21:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbcECTIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 15:08:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752177AbcECTIj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 15:08:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F642180AB;
	Tue,  3 May 2016 15:08:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Iv4s7zhDDkHtQkI5AzWv6Yf8AU4=; b=WlEMfc
	ld2tuZqi5gPV6zH+0hbxdNkeRM7mg1CuDSEQy++smU77CGPb5WMU8TrgfnwB5bUC
	l7eEmgPs74K0205wsgyocdRys7XVAYuMmyHnP6KEkTUyHhpjKk7phBkrEQpKFBPF
	jxPOCikkp057Oyp9syxaFXyC9FrnCcAyZGieg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZNdU5D9ma+FIvlIsdEU3Z81M7eQQnPzs
	f4z16PuDuqHo4hw7esnou0my9vWYW07+Jl4yZ36ngq3AYI7NKsQVkgSxe9Lb7rXg
	nCHGzXsDvtOpyIdVMcOoveBAWCS1H/y6pKO/z3+A8cfkQGEUurtQWboVt1be5cm2
	uSTjOod9jns=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 57A82180AA;
	Tue,  3 May 2016 15:08:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0C57180A9;
	Tue,  3 May 2016 15:08:37 -0400 (EDT)
In-Reply-To: <CAGZ79kaHmtRooJ7J6BknqWDkVFN0Bx3xngkEH0CnAp7Aaehnig@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 11:07:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70BE53F4-1162-11E6-BD29-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293439>

On Tue, May 3, 2016 at 11:07 AM, Stefan Beller <sbeller@google.com> wrote:
>
> So maybe we want to add a check that no pathspec arguments are
> given when
> --all is given?

Yeah, I overlooked that case.  Just like "commit -a path" errors
out, we should.
