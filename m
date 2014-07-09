From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/14] Add submodule test harness
Date: Wed, 09 Jul 2014 08:20:22 -0700
Message-ID: <xmqqion67e4p.fsf@gitster.dls.corp.google.com>
References: <539DD029.4030506@web.de> <53B41D42.2090805@web.de>
	<53B46425.3030000@web.de> <53B4F0AA.10809@web.de>
	<53B5C7AC.4040701@web.de>
	<xmqqsimddrq3.fsf@gitster.dls.corp.google.com>
	<53BAF7AF.4020901@web.de> <53BC47BD.1000705@web.de>
	<53BCDDE2.1080301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 17:20:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4tfm-00048I-CP
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 17:20:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755861AbaGIPUi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 11:20:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65359 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752523AbaGIPUc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jul 2014 11:20:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5593D26080;
	Wed,  9 Jul 2014 11:20:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TxHZZNLhWBio
	EpxRHpNZJcjoQ4c=; b=uEj+8yu8RiFDjkaNVFv5m8oKwo9Dyv9YTD/7CsJxvid+
	Xcgo90plOj6cKDMWiNbJVeIBJFiDGPd3PRv0ixteQIZSVXSN9Kqau/OYCyhuR1lr
	nZxpD1YPKu2XF0uprk/fTThAP0QtDlRV5qIWNXUeVvUqu2BJPU05y2qPej0nODU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PSM25U
	bB4+5kN5MySjUyGSrTDH1dxiSXZo8WZRkKWU2veu/en//l0akEQgmGGcZpTfXBpa
	lAivuZap5n1Bxd21mXdES9WeqbTJvw7n+xH2gIW+cbP3Q8vQdFdNF7r2Njg+Am/R
	zKp+UAWHOIo7HX1HNe7mRmHOFKzZcDothHEIE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C36322607E;
	Wed,  9 Jul 2014 11:20:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E76D626073;
	Wed,  9 Jul 2014 11:20:08 -0400 (EDT)
In-Reply-To: <53BCDDE2.1080301@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Wed, 09 Jul 2014 08:14:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8362851C-077C-11E4-93E3-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253130>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> A "brute force" approach could be to simply run the config file(s)
> through sort and compare them:
>
> sort <.git/modules/sub1/config >expect &&
> sort <sub1/.git/config >actual &&
> test_cmp expect actual &&

Or "git config --list" from these files, perhaps?
