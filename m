From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Tue, 25 Mar 2014 10:46:32 -0700
Message-ID: <xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
	<20140325092215.GB3777@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Tue Mar 25 18:48:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSVSM-0004uD-0i
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 18:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474AbaCYRqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2014 13:46:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbaCYRqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 13:46:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6C6076ABE;
	Tue, 25 Mar 2014 13:46:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oDnYG/qzYuCI5g5hTraOfFYNP94=; b=dnNZ/5
	0Xa3FIfVBt7NAZ8ts5NKE03GaSAkBwtex9zE2t2FBHxjWQbryg5tiXcxAiQek+R0
	RbPvkVVpWtWWndZOoVB3J+tWm2g5bbG3oFhPWKea6IGNMo2WxKAjjLfy1DUigXdn
	yQwaOA0R+tKnlLMrXog30ctraM/v9cLymkEy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XlILEoHdSHzmqAc5DwJK7gyhpiRjzU8Z
	AFpQKARe4cIIr/D+AGrqEu7cw1k2IbaPhwnlXooWe5zASyAA4arW41ee2M7YE3s+
	mefhOjuN5hy3sYH2Dfdc5yr7hXj+RH/1WElYw8EmR5R+V+hMnPp75IGpvWH0TqtL
	NhNcoV86qiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2BBE76ABD;
	Tue, 25 Mar 2014 13:46:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2846C76ABA;
	Tue, 25 Mar 2014 13:46:35 -0400 (EDT)
In-Reply-To: <20140325092215.GB3777@mini.zxlink> (Kirill Smelkov's message of
	"Tue, 25 Mar 2014 13:22:15 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6897671E-B445-11E3-B617-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245142>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> What are the downsides of "__" prefix by the way?

Aren't these names reserved for compiler/runtime implementations?
