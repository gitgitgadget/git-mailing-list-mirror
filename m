From: Junio C Hamano <gitster@pobox.com>
Subject: Re: quote in help code example
Date: Mon, 12 Oct 2009 14:06:35 -0700
Message-ID: <7v3a5oe2zo.fsf@alter.siamese.dyndns.org>
References: <20091012102926.GA3937@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 23:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxSDg-0002of-6O
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 23:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932988AbZJLVHZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 17:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbZJLVHY
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:07:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49473 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932509AbZJLVHW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 17:07:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CA8356674;
	Mon, 12 Oct 2009 17:06:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=OQcqqD1OWl+b0F6AUUeIP2WvC
	hw=; b=bxEzp7NfMOmwn1Wdnz2GCszNZjP9tavSHAf+KkrFMsNtnOS5aEh3/rdsA
	WHMIUKAdB6L0BbRfKjYTDA09dlBJQRv/XtTZJLu3KGEJOWO3qlKI2C7yrRjvHBMg
	HiA0mwfN8SeO68VanPSdA7uqmnvOwvpNFCeXuAeV0N/w/Tr7WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=EfWAUzT5fElm56szldu
	FMlxBdC2tu24Wmgzx/XM9008XLiOpeWeUT1HxME9zZa/23qN2aP2q5QpWscVCgIx
	0zIdZMfvtE8zH6qwQH/F24bKb+e3UEM4vKuIHVu1RCQztdk/I13MNobC5AS1BpXn
	SQvuF8QmZ/IowwmCsztc3ChM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F309156673;
	Mon, 12 Oct 2009 17:06:38 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 583D956672; Mon, 12 Oct
 2009 17:06:36 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2224359C-B773-11DE-B783-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130066>

bill lam <cbill.lam@gmail.com> writes:

> In git man, eg. git help filter-branch
> The code examples for command line or shell scripts inside .ft pairs
> use (smart?) quote instead of single quotes, like
>
>   .ft C
>    git filter-branch --tree-filter =C2=B4rm filename=C2=B4 HEAD
>    .ft
>
> Is this intentional or just some configuration problem during
> compiling.

I see these in Documentation/Makefile:
  #
  # For asciidoc ...
  #	-7.1.2,	no extra settings are needed.
  #	8.0-,	set ASCIIDOC8.
  #

  #
  # For docbook-xsl ...
  #	-1.68.1,	set ASCIIDOC_NO_ROFF? (based on changelog from 1.73.0)
  #	1.69.0,		no extra settings are needed?
  #	1.69.1-1.71.0,	set DOCBOOK_SUPPRESS_SP?
  #	1.71.1,		no extra settings are needed?
  #	1.72.0,		set DOCBOOK_XSL_172.
  #	1.73.0-,	set ASCIIDOC_NO_ROFF
  #

  #
  # If you had been using DOCBOOK_XSL_172 in an attempt to get rid
  # of 'the ".ft C" problem' in your generated manpages, and you
  # instead ended up with weird characters around callouts, try
  # using ASCIIDOC_NO_ROFF instead (it works fine with ASCIIDOC8).
