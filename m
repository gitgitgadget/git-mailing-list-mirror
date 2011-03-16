From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH 2/3] Name make_*_path functions more accurately
Date: Wed, 16 Mar 2011 12:29:52 -0400
Message-ID: <D7B7C57A-B4DB-4CDC-B079-77537D8E8EFD@silverinsanity.com>
References: <1300291579-25852-1-git-send-email-cmn@elego.de> <1300291579-25852-3-git-send-email-cmn@elego.de>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:30:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pztbm-0001K0-JW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 17:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1CPQ35 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Mar 2011 12:29:57 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60635 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab1CPQ34 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2011 12:29:56 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id A87891FFC193; Wed, 16 Mar 2011 16:29:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [129.21.60.132] (unknown [129.21.60.132])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C74CE1FFC191;
	Wed, 16 Mar 2011 16:29:50 +0000 (UTC)
In-Reply-To: <1300291579-25852-3-git-send-email-cmn@elego.de>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169169>


On Mar 16, 2011, at 12:06 PM, Carlos Mart=EDn Nieto wrote:

> Rename the make_*_path functions so it's clearer what they do, in
> particlar make clear what the differnce between make_absolute_path an=
d
> make_nonrelative_path is by renaming them real_path and absolute_path
> respectively. make_relative_path has an understandable name and is
> renamed to relative_path to maintain the name convention.
>=20
> Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>

I didn't try it, but it looks like 2/3 horribly breaks the code and 3/3=
 fixes it.  I personally (and I think others) prefer patches that are e=
ach useful on their own.  Especially since a code-breaking patch like t=
his makes bisecting harder.

I would suggest doing one of the following:

1) Squashing 2/3 and 3/3 so all the renaming occurs at once.
2) Adding wrappers from the old name to the new in 2/3 and removing the=
m in 3/3.

That said, I'm not sure the renaming is useful although the documentati=
on comments definitely are.

~~ Brian