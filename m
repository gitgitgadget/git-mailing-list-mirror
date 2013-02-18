From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 04/10] pkt-line: change error message for oversized
 packet
Date: Mon, 18 Feb 2013 13:25:35 -0800
Message-ID: <7v1ucdb9gw.fsf@alter.siamese.dyndns.org>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092221.GD5096@sigill.intra.peff.net>
 <7vd2vyarjy.fsf@alter.siamese.dyndns.org>
 <20130218094959.GA16408@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 22:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7YDr-0002S5-Ix
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 22:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755329Ab3BRVZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 16:25:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42185 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754508Ab3BRVZi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 16:25:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D29F5B859;
	Mon, 18 Feb 2013 16:25:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kAlejLOMH4X6o9Ec+RRRpCIQGwU=; b=fKr6Io
	Jl3gZeSOBNpkHmh74rIdzCpt+uX1mRIYuAm7IdLkXVo1nHo0oZb7FFUGks6xaNN8
	TDllcd/b/jDXDsDDZrD+j7E4pfL8Na10xFjAlk4zYvmNZ0NDe+iVaEbDVoCvPp4D
	4UjJgZpc6NyeYZ0fAaM9tfMn+z57TydQKhzXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xr9x6QSXE/472RTZvGkR2l4B0JxPvlMD
	3E1dLfVT/rtKRNKoRjGWeNMLF+FPrYUZ60YvMYHSn2O0NqiKGqBBYjzAt1kT3d7N
	DjrNfUXUzDeOkUni1qP50XtCwic5Id79/8Yw5qeDWOhDg5Pxl8O7llMdeldItKKd
	aihqXkHtTKo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C79AEB858;
	Mon, 18 Feb 2013 16:25:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F91FB857; Mon, 18 Feb 2013
 16:25:37 -0500 (EST)
In-Reply-To: <20130218094959.GA16408@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 18 Feb 2013 04:49:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BCB1D98E-7A11-11E2-A2B6-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216534>

Jeff King <peff@peff.net> writes:

> But it's easy to do (1), and it starts the clock ticking for
> the 1000-byte readers to become obsolete.

Yup, I agree with that goal.
