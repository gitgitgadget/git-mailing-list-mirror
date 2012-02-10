From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ctype: implement islower/isupper macro
Date: Thu, 09 Feb 2012 18:17:16 -0800
Message-ID: <7vwr7vsa8j.fsf@alter.siamese.dyndns.org>
References: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com>
 <1328840011-19028-2-git-send-email-namhyung.kim@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 03:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvg39-0005AP-JT
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 03:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758767Ab2BJCRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 21:17:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63161 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754683Ab2BJCRT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 21:17:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1B3378C9;
	Thu,  9 Feb 2012 21:17:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=T50Eclw/LIGRHjXpnlG0cwvcWoQ=; b=kKNzk8
	T3DeM6M+qBdi+mqhuCxfdIHhk9ivxmYNCHqyGHkKVYG2J2dOCSr/XNg0v1L42qoc
	94GkzMb8EAO+gYoJ8RpkjfSdy8YGnJ3ctiu1zWS+BJEeOYmb6p2i9QxBQL2Uo6Q5
	4oFnInNWylE9dkJlJ1SWX8CYJqy+4KggjKOv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URGbDCZJu5FkMC2ZZd+HCn+KyN932cH+
	XX2+KDckuPOzLgbL/SIN8orQEB2VMc7z6Em05KJDVc+QaLbWg11gqZCq5YKkGQ6/
	6MJRAjBIOkZE7wNbxByrpy/aXOe5HOXklVS6JYjUtQs1akptnWfU6Ymukvt56EOb
	8Re0VAlrjVo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C908978C8;
	Thu,  9 Feb 2012 21:17:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BC6778C5; Thu,  9 Feb 2012
 21:17:18 -0500 (EST)
In-Reply-To: <1328840011-19028-2-git-send-email-namhyung.kim@lge.com>
 (Namhyung Kim's message of "Fri, 10 Feb 2012 11:13:31 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B3A3F08-538D-11E1-8004-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190368>

Namhyung Kim <namhyung.kim@lge.com> writes:

> The git-compat-util.h provides various ctype macros but lacks those two
> (along with others). Add them.

Isn't that because we do not use them ourselves? Uses in compat/ do not
count, and judging from the way it is used in compat/fnmatch/fnmatch.c,
the implementation of sane_iscase() might be overly protective.

What problem are you trying to solve?
