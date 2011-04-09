From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] New get_pathspec()
Date: Sat, 09 Apr 2011 14:41:25 -0700
Message-ID: <7vfwpryuey.fsf@alter.siamese.dyndns.org>
References: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 23:41:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8fuY-0008Lx-DB
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 23:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754436Ab1DIVli convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Apr 2011 17:41:38 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1DIVlh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Apr 2011 17:41:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7616550D6;
	Sat,  9 Apr 2011 17:43:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QMpDlRMSfWJa
	mZ/ufzVvcxE+ZVc=; b=vRAB8DYodFbLdUsmRzknL3Qs0sYMxo/ORHCht7OV8T/w
	svm1V5dfbcgXMj6KBAjY/lKmosQYIsPrXLvh0xbTAape0v9WhsesHoSiFgaHIwHL
	VpTF9fryi/dbCo1/J+/bKfL3jtzp8w99CVA345j6CoFIIS8rH1cSudyNIC6L1CI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AJDToP
	pzEC28ZkLwQ0SmYTe7avywxpib48Q1wcGTdN/zf6Rjl193bqgPh2zniiDM5TnuJc
	zo0hZwHRU7Xp9e48um92BOx0dP6xbXXXYHbYa5xHoKUwGdV8TT2eIFctJzPB3wve
	IOljeaAw55pOMrpHl0Im6qLikHpgYq/b1FQhQ=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4229D50D5;
	Sat,  9 Apr 2011 17:43:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E87C250D0; Sat,  9 Apr 2011
 17:43:23 -0400 (EDT)
In-Reply-To: <1302368060-23827-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 9 Apr
 2011 23:54:15 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 683CA6E6-62F2-11E0-AB17-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171209>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> [PATCH 1/5] Rename functions in preparation for get_pathspec() restru=
cture
>
>   I figure I cannot bring all commands to the new get_pathspec() at
>   once and remove the old one. So instead I rename the old one so tha=
t
>   we can have both implementations running in parallel.

Horribly bad move.  Keep the old one running under the same name, and k=
eep
the unconverted ones working the same way without new features.  Introd=
uce
a new infrastructure under a new API function name.

Otherwise you cannot merge in new calles that expect the old
get_pathspec() behaviour.
