From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Tue, 27 Nov 2007 09:49:04 +0100
Message-ID: <13E55438-D62B-4C92-892F-43773902E734@wincent.com>
References: <1196111891-18518-1-git-send-email-win@wincent.com> <474BD5CA.7050407@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, tsuna@lrde.epita.fr,
	Johannes.Schindelin@gmx.de, mcostalba@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 27 09:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iww8S-0001pC-SP
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 09:49:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbXK0ItX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2007 03:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbXK0ItW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 03:49:22 -0500
Received: from wincent.com ([72.3.236.74]:40978 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbXK0ItW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2007 03:49:22 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAR8n55e029927;
	Tue, 27 Nov 2007 02:49:06 -0600
In-Reply-To: <474BD5CA.7050407@viscovery.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66174>

El 27/11/2007, a las 9:31, Johannes Sixt escribi=F3:

> Wincent Colaiuta schrieb:
>> +		export _GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
>
> Isn't this a bashism? Should be:
>
> 		_GIT_CHERRY_PICK_HELP=3D"run 'git rebase --continue'"
> 		export _GIT_CHERRY_PICK_HELP
>
> (and the second instance of this as well, of course)

I wondered that myself before submitting the patch, but then saw that =20
the same pattern was used at other places as well:

git-clone.sh:

W=3D$(cd "$GIT_WORK_TREE" && pwd) && export GIT_WORK_TREE=3D"$W"

git-filter-branch.sh:

export GIT_INDEX_FILE=3D"$(pwd)/../index"
export GIT_COMMIT=3D$commit
export GIT_COMMIT=3D"$sha1"

git-quiltimport.sh:

export GIT_AUTHOR_NAME=3D$(sed -ne 's/Author: //p' "$tmp_info")
export GIT_AUTHOR_EMAIL=3D$(sed -ne 's/Email: //p' "$tmp_info")
export GIT_AUTHOR_DATE=3D$(sed -ne 's/Date: //p' "$tmp_info")
export SUBJECT=3D$(sed -ne 's/Subject: //p' "$tmp_info")

So if this is a problem, those sites will need to be changed as well.

Cheers,
Wincent
