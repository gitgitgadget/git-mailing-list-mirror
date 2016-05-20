From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/4] pathspec: allow querying for attributes
Date: Fri, 20 May 2016 11:31:13 -0700
Message-ID: <xmqq4m9seg3y.fsf@gitster.mtv.corp.google.com>
References: <20160519232323.12775-1-sbeller@google.com>
	<20160519232323.12775-5-sbeller@google.com>
	<xmqqbn41hbeq.fsf@gitster.mtv.corp.google.com>
	<xmqqd1ogegtn.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZOmo6hh_trBJ_H5QRWgAxbP4JUu_KBUKeeKL1XsAwiOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 20:31:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3pCj-0000Fx-7G
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 20:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751759AbcETSbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 14:31:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62724 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751291AbcETSbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 14:31:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 784CF1DA98;
	Fri, 20 May 2016 14:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=970IRWTT6WmLKKK3MZitRYBhQ6U=; b=jEG1C0
	JfeD7gp0HDQlcWA+CCRDksuPOdg+a09wgfJAJK83gcRjoiLtn8VBEZ6L2sVHy1vy
	ExoWStuDIlzbTdROn8COkCosldXuqkwfY6wAXuPVTHjKxQublZQ9rDoc4O7SAegF
	XesP+FyXqGAgmfbTksXwMRJRDRIpERND0arsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R8AUUNGUZlX5k8L+rvPAe4DhWEVYTIX4
	sVvpMHVfJy+FYqx1CmWxU8MfUoTfYpSgDMazUHUdAqzwne5ZBYEG9JhyuHRHWqRL
	hAfKcuGlGxHCNoh+Fuw1E6Lm6lynz0ZzkSpElxZQjKbb//KEk/J3mP2/gAGakLY/
	/S9reuXHYTQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD001DA96;
	Fri, 20 May 2016 14:31:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CDFA01DA95;
	Fri, 20 May 2016 14:31:14 -0400 (EDT)
In-Reply-To: <CAGZ79kZOmo6hh_trBJ_H5QRWgAxbP4JUu_KBUKeeKL1XsAwiOQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 20 May 2016 11:21:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 08E7E48E-1EB9-11E6-8150-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295202>

Stefan Beller <sbeller@google.com> writes:

> I checked and it looks wrong. the "exclude" section is indented below
> the new attr section
> ...
> I can resend with your proposed fixes as well.

If you do so, please make sure that the way tests check for error
condition are consistent.  I personally do not think it adds any
value to grep for "fatal", but I do not mind if you adjusted them to
go the same test_i18ngrep route if you think it does (and if you
agree that grepping is not necessary, please do not forget to update
the tests you had that use test_i18ngrep).

Thanks.
