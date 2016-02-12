From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Fri, 12 Feb 2016 10:15:07 -0800
Message-ID: <xmqqa8n5vlqs.fsf@gitster.mtv.corp.google.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
	<xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
	<56BCAC69.8030909@drmicha.warpmail.net>
	<xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
	<20160211211509.GA14667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Dickson Wong <dicksonwong@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 19:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUIFU-0008F1-2K
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 19:15:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbcBLSPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 13:15:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50867 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751076AbcBLSPM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 13:15:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CDF1941A38;
	Fri, 12 Feb 2016 13:15:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZaC1rt1H9FXbTdElDpKUO+rJWs8=; b=M8sLs4
	z42mrFcVz8cieU2uCkHwRa42nO1bMBt21oDQ+oq+rKzQHUljxN0eRSKeLPw6mxkF
	VShb7DuAx1nNTKDYJXkX+D8Ull9hszu/o3zv+Fqpjla1UugFP26Fs3xCjhJ2X1sy
	KxZHodOYx52I7CPR8G6IBwUI2Hgd25AI7ffbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=viDqmhUavbxl9RVXU8Bn/FfDAel7+ECo
	F9l8s5cct4Zj8sbRz0Nek1baHIphwZ3wuP2bnFfKNxK+6LzV98hjNPcCYwf/sRUw
	NScaHRHOI8NKwTG3jyf7TBRanr0vXa6w2Jo6aHlP1Z0wDu1qljeIPn06Wl0W4dmb
	MYxHJc44hJw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B44FA41A31;
	Fri, 12 Feb 2016 13:15:10 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9698D41A2D;
	Fri, 12 Feb 2016 13:15:09 -0500 (EST)
In-Reply-To: <20160211211509.GA14667@gmail.com> (David Aguilar's message of
	"Thu, 11 Feb 2016 13:15:09 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D1A9ABE-D1B4-11E5-A3E0-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286061>

David Aguilar <davvid@gmail.com> writes:

> On Thu, Feb 11, 2016 at 08:03:57AM -0800, Junio C Hamano wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>> >> Does this mean that I should warn in the release notes that some
>> >> existing users might get their expectation broken but we are going
>> >> ahead anyway because we think most people read left to right and
>> >> then top down?  I am OK with saying that--I just wanted to make sure
>> >> we know that it is what we are doing.
>> >
>> > I would claim that anyone who notices the difference in buffer numbering
>> > would be positively surprised.
>> 
>> Thanks. I, being a non-user of vim, was wondering if people who had
>> their own user-defined commands (macros? and possibly short-cut keys
>> to invoke them) built around the old (and odd) numbering need to
>> adjust--in which case we may need to forewarn.
>> 
>> > In any case, the buffer numbering is not the same (it is local remote
>> > base merge) but it doesn't matter in this case because only one window
>> > is displayed, so there is no visual association.
>> 
>> OK, thanks.
>
> Sorry for not noticing this thread earlier.
> The change and the rationale sound good to me.
>
> FWIW,
>
> Acked-by: David Aguilar <davvid@gmail.com>

Thanks all.  Will merge to 'next' and then to 'master' shortly.
