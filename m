From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Convert resolve_ref+xstrdup to new resolve_refdup
 function
Date: Mon, 12 Dec 2011 00:13:09 -0800
Message-ID: <7v4nx68ay2.fsf@alter.siamese.dyndns.org>
References: <1323521631-24320-1-git-send-email-pclouds@gmail.com>
 <20111210131503.GI22035@elie.hsd1.il.comcast.net>
 <CACsJy8C0CJyHdtWJ5QVqX9ksHWgdBpm6XekQ+mZP4sxBVA_8vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tony Wang <wwwjfy@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:13:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra10f-0006G6-BE
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:13:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab1LLINN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:13:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751598Ab1LLINM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:13:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 845D52582;
	Mon, 12 Dec 2011 03:13:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SDy0dwManUCKkyPwo1KCsd2wblY=; b=K4EWI+
	ffDo8vMYonHnY9i3YWctCH7OSTgyi0wowmroTjYWdzcM+EULSTxI18pZYAs/CHdS
	8WqkTKJC4dWbOt9BpaOdL6/BjVotDDRi+tjVon5dEE/AyqMIPuibYlxhioma31kT
	Zx3+Kzzh5op9D0CZlAbfjWXXVtMiDle18dhE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HV0IqRXEDun7ievSsUIMswcWteXjHBqT
	YJOPp5kw0klX6owgZ7Sw5xpByHU9RERnW6MBBdAkpJ/x/MbSAkhN9hx1wBmJgMxC
	woRVj7cv/sXGevJlTU2J7X9s/d7qgFPzwHNhbn44fufAPaxBkDcsGEBVeJzMQMCy
	/TpEdf2Hekc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1C92581;
	Mon, 12 Dec 2011 03:13:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06ECD2580; Mon, 12 Dec 2011
 03:13:10 -0500 (EST)
In-Reply-To: <CACsJy8C0CJyHdtWJ5QVqX9ksHWgdBpm6XekQ+mZP4sxBVA_8vQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 10 Dec 2011 22:40:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 219D9542-2499-11E1-8E3C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186886>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> Yeah that slipped in. It should be part of c689332 (Convert many
> resolve_ref() calls to read_ref*() and ref_exists() - 2011-11-13). I
> guess either I missed it or it was a new call site after that patch.
> Split it out as a separate patch?

Yeah, I think it makes sense to split the unrelated part out and place it
early in the series. It seems that you will be updating patch 2 in the
series for __FILE__ anyway so it's not like adding a useless code churn to
do so.

Thanks.
