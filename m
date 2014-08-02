From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v3 2/2] imap-send: create target mailbox if it is missing
Date: Sat, 02 Aug 2014 14:44:42 +0100
Message-ID: <53DCEB4A.1030009@ramsay1.demon.co.uk>
References: <alpine.LSU.2.00.1407312034410.25674@hermes-1.csi.cam.ac.uk>	<alpine.LSU.2.00.1408010915500.23775@hermes-1.csi.cam.ac.uk> <xmqqppgju9kj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Tony Finch <dot@dotat.at>
X-From: git-owner@vger.kernel.org Sat Aug 02 15:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDZcB-0001PT-FQ
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 15:44:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbaHBNor convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Aug 2014 09:44:47 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:47263 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752174AbaHBNoq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 09:44:46 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 6DE2B6F90A8;
	Sat,  2 Aug 2014 13:08:25 +0100 (BST)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 3A57C6F8F91;
	Sat,  2 Aug 2014 13:08:25 +0100 (BST)
Received: from [192.168.254.10] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Sat,  2 Aug 2014 13:08:24 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqppgju9kj.fsf@gitster.dls.corp.google.com>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254698>

On 01/08/14 23:30, Junio C Hamano wrote:
> Tony Finch <dot@dotat.at> writes:
>=20
>> Some MUAs delete their "drafts" folder when it is empty, so
>> git imap-send should be able to create it if necessary.
>=20
> Thanks for an update; queued.

BTW, this provokes a warning from gcc (v4.8.2) for me:

        CC imap-send.o
    imap-send.c:561:25: warning: =91issue_imap_cmd=92 defined but not u=
sed [-Wunused-function]
     static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
                             ^
It seems the change to get_cmd_result(), in commit 7ebac713, removes
the only remaining (two) calls to issue_imap_cmd().

HTH

ATB,
Ramsay Jones
