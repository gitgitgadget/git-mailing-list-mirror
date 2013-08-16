From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] bash prompt: test the prompt with newline in repository
 path
Date: Fri, 16 Aug 2013 21:16:17 +0200
Message-ID: <520E7A81.5080302@kdbg.org>
References: <1376649395-24363-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?B?U1pFREVSIEfDoWJvcg==?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 00:45:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASll-0005NQ-2o
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab3HPWpN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Aug 2013 18:45:13 -0400
Received: from bsmtp5.bon.at ([195.3.86.187]:4581 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754330Ab3HPWpM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:45:12 -0400
Received: from bsmtp.bon.at (unknown [10.232.130.106])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 4DCC9CE002
	for <git@vger.kernel.org>; Fri, 16 Aug 2013 21:16:41 +0200 (CEST)
Received: from [10.72.208.214] (178.115.248.214.wireless.dyn.drei.com [178.115.248.214])
	by bsmtp.bon.at (Postfix) with ESMTP id B68191000B;
	Fri, 16 Aug 2013 21:16:21 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1376649395-24363-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232444>

Am 16.08.2013 12:36, schrieb SZEDER G=C3=A1bor:
> +repo_with_newline=3D'repo
> +with
> +newline'
> +
> +test_expect_success 'prompt - with newline in path' '

This test must be skipped when the filesystem does not support LF in fi=
le=20
names. Cf. the FUNNYNAMES prerequisite in t3600-rm.sh.

> +	printf " (master)" >expected &&
> +	git init "$repo_with_newline" &&
> +	test_when_finished "rm -rf \"$repo_with_newline\"" &&
> +	mkdir "$repo_with_newline"/subdir &&
> +	(
> +		cd "$repo_with_newline/subdir" &&
> +		__git_ps1 >"$actual"
> +	) &&
> +	test_cmp expected "$actual"
> +'

-- Hannes
