From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: turn on test-lint-shell-syntax by default
Date: Sun, 13 Jan 2013 09:32:07 -0800
Message-ID: <20130113173207.GC5973@elie.Belkin>
References: <201301120650.46479.tboegi@web.de>
 <7vvcb37xfe.fsf@alter.siamese.dyndns.org>
 <50F28BB5.9080607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Jan 13 18:32:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuRQA-00028i-8Y
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jan 2013 18:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751678Ab3AMRcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 12:32:14 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34690 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375Ab3AMRcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 12:32:13 -0500
Received: by mail-pa0-f47.google.com with SMTP id fa10so1820870pad.6
        for <git@vger.kernel.org>; Sun, 13 Jan 2013 09:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Um/zOPuiebom+Qhe5LoAxShuhDiBbrfHlivNxUFs01g=;
        b=yl1CrIlP282YkoYETK0Vd5FP0Hubjcp/zY+bdNH5mZ/EP8sHvqnMVa12vUeReT1EQE
         Qe5WU5/QvXmImPMu5v7CLMtWgX05wlHEKjI5V9s9ctzwD7MzDTpf51n1KVqrFtTzTUAX
         gRZCJ2Ja0MgK0aYHoVRHGF4X3XTJifLbEVo2mSGBoUNDZ4pqq013IUQP4DEfCKfVqpvx
         w/NPCPtE7IEWgNEgzChq2HmRfRNUw3cD1hgQXTrg56HgZiGdLc/7JicSZLBEYbvTx4F3
         LxxP7NXqd4O5rY32cwl5GTU0aIjcHbYB8aVfpyYa+fcO0xaKkNFkrWFou8svoPYCWPoI
         htEQ==
X-Received: by 10.66.86.101 with SMTP id o5mr225370906paz.15.1358098332969;
        Sun, 13 Jan 2013 09:32:12 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id ov4sm6620094pbb.45.2013.01.13.09.32.10
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 13 Jan 2013 09:32:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <50F28BB5.9080607@web.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213390>

Hi,

Torsten B=C3=B6gershausen wrote:

> -	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use typ=
e)';
> +	/^\s*[^#]\s*which\s+[-a-zA-Z0-9]+$/ and err 'which is not portable =
(please use type)';

Hmm.  Neither the old version nor the new one matches what seem to
be typical uses of 'which', based on a quick code search:

	if which sl >/dev/null 2>&1
	then
		sl -l
		...
	fi

or

	if test -x "$(which sl 2>/dev/null)"
	then
		sl -l
		...
	fi
