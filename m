From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Git for Windows fixes in preparation for 2.8.0
Date: Tue, 22 Mar 2016 10:50:43 -0700
Message-ID: <xmqqfuviieq4.fsf@gitster.mtv.corp.google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 18:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQSA-0000Vf-0i
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 18:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755585AbcCVRur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:50:47 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54827 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753479AbcCVRuq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:50:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE9C14EC1F;
	Tue, 22 Mar 2016 13:50:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PoZGvWHVkjbQLYUvjTURxeiVszk=; b=C4GfZV
	csl/Fq33/VUetdITatbCgxknCFZznRqNLZwztCJazrPKjEAM3kbEHK/epPekcVNo
	DuiaSuMxuDDrstLqeOZPBvuqNbvQM7PFPi9RiBIzys4OnkkC4+2PlIv6rXatb5yx
	qggnN51wRkpYMy+EZzPsahlEioDh+Cp/w+Hq4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ybS5myTT4lGMALIreggCu3cWduWuqubD
	LmbnI+INV0hWihvOs/ipy0WPp//uq+rvZdy1NvR0JhzXwKm1NlppgdjKb2wfjnZb
	kA9bBpZP4gNSCcQUAlGL2YePHBXFFyn4zyAwb8QqXTlLAt8RH3HNLjh8idYisAfP
	RjRRbwCNbDA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D60214EC1E;
	Tue, 22 Mar 2016 13:50:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3EFA44EC1C;
	Tue, 22 Mar 2016 13:50:44 -0400 (EDT)
In-Reply-To: <cover.1458668543.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Tue, 22 Mar 2016 18:42:34 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 99D656BA-F056-11E5-B4D8-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289531>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The t1300 and t9115 tests regressed on Windows. These patches fix that.

Thanks, it might be probably too late for 2.8.0 final to do
back-and-forth reviews, but lets see how it goes.


>
>
> Johannes Schindelin (4):
>   config --show-origin: report paths with forward slashes
>   Make t1300-repo-config resilient to being run via 'sh -x'
>   t1300: fix the new --show-origin tests on Windows
>   mingw: skip some tests in t9115 due to file name issues
>
>  compat/mingw.h                           |  6 ++++++
>  path.c                                   |  3 +++
>  t/t1300-repo-config.sh                   | 23 ++++++++++++++---------
>  t/t9115-git-svn-dcommit-funky-renames.sh |  4 ++--
>  4 files changed, 25 insertions(+), 11 deletions(-)
