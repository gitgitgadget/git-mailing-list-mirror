From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 5/8] Fold all merge diff variants into an enum
Date: Mon, 08 Sep 2014 10:36:24 -0700
Message-ID: <xmqqr3zmnhev.fsf@gitster.dls.corp.google.com>
References: <cover.1409860234.git.tr@thomasrast.ch>
	<e95adf985efac162da72ac27220b904659dbb02d.1409860234.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:36:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR2rf-0001mA-D1
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 19:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676AbaIHRg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 13:36:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54383 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754635AbaIHRg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 13:36:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 84DDB36F3B;
	Mon,  8 Sep 2014 13:36:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNJsMuhzfhVOIdEaHPKOjzMkfsY=; b=VZEd2e
	kz7vsL1KAYGOkStWKniI94TZP+eADlbRACEoZIL6xHAtfpQI7ZFrKKwT9AnZehgd
	FuzUqOrCo941+3R4SH9TwF8jsywvX/e5Rh0+gIMumx5Bv51+sd6PPjrmna8/nm3/
	jF4HOdqKZOjK4VX1NHBgNN3sjIWkJBchzBWn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sIoKHwDLjHtfHu55fo0rkMNo2BNmENcB
	S8D6MZu4XrGO8hlfQn79KzwBClulIIz9KHDlDU0X8UB4hZrMZhiI5vEc8mcokAzc
	MQl6ANi5ZwL0hbSfoU/fLAeQYUryY9sTJgUk7s9ItVYCIYAmHnJa/5L2tUv0wnKH
	2mmFBKdDpWE=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7BBDC36F3A;
	Mon,  8 Sep 2014 13:36:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02C9C36F38;
	Mon,  8 Sep 2014 13:36:25 -0400 (EDT)
In-Reply-To: <e95adf985efac162da72ac27220b904659dbb02d.1409860234.git.tr@thomasrast.ch>
	(Thomas Rast's message of "Sat, 6 Sep 2014 19:57:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A87E73A6-377E-11E4-8BF4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256660>

Thomas Rast <tr@thomasrast.ch> writes:

> The four ways of displaying merge diffs,
>
> * none: no diff
> * -m: against each parent
> * -c: combined
> * --cc: combined-condensed
>
> were encoded in three flag bits in struct rev_info.  Fold them all
> into a single enum field that captures the variants.

Nice.  It also has a good side effect to spell "condensed" out,
instead of using a shorter "dense", and the end result matches what
the command line option calls it ;-).
