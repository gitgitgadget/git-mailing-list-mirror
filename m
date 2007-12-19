From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: kha/safe and kha/experimental updated
Date: Wed, 19 Dec 2007 14:59:20 +0000
Message-ID: <b0943d9e0712190659p6c4cb557jae5b21aa68de029d@mail.gmail.com>
References: <20071214105238.18066.23281.stgit@krank>
	 <b0943d9e0712170309n415dc6cs9d1c1f8a9c687bf8@mail.gmail.com>
	 <20071217224812.GA6342@diana.vm.bytemark.co.uk>
	 <20071218052115.GA13422@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 15:59:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J50Og-000283-JV
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 15:59:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbXLSO7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Dec 2007 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753320AbXLSO7W
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 09:59:22 -0500
Received: from py-out-1112.google.com ([64.233.166.180]:3356 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753266AbXLSO7W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Dec 2007 09:59:22 -0500
Received: by py-out-1112.google.com with SMTP id u77so5030101pyb.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=PPcjWmvAWPiuBv4U9aeQlNJ9JpAPm/sp17j3L6P+t1g=;
        b=YbBwycy9TSBKNZIwz9YHphNZOiuGQkXL5C5hOtbV3YZwlPeKGegYj16sTOKZfCjO+qVaswjiuwaISa5Dks8POzZrURx7NR0/Zg6UGa4rZ2Zrpd4vtEWAf1bwFNBErsbe3l7crsFS9pP/+eHlgQw8PCLPOXbw/WFZEYSu82UHK1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qc+yhDfAzdBDok8/D4d0mHQXMCapeQZLejCdiQ9Ete9pY7v9fQBy2QJwxIN7LEPFDY/cVSY3BiGBA4iWvT/ysH1tmb2KUAbp339EP0nMpWRJr453fwImEWt98y3L/2lo053MQ2MF1zLgUo91hBGfVhOo2jYS838hIMW4B3sMep4=
Received: by 10.140.126.14 with SMTP id y14mr5971303rvc.59.1198076360087;
        Wed, 19 Dec 2007 06:59:20 -0800 (PST)
Received: by 10.141.186.5 with HTTP; Wed, 19 Dec 2007 06:59:20 -0800 (PST)
In-Reply-To: <20071218052115.GA13422@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68913>

On 18/12/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>   git://repo.or.cz/stgit/kha.git safe
[...]
>       Ask git about unmerged files

This patch wrongly assumes that there is a stage 2 entry in the index.
Test t1202-push-undo.sh fails because a file is added, differently, in
both master and patch but it doesn't exist in ancestor (no stage 2).
Using stage 3 doesn't fix it either because a patch might remove a
file.

I fixed it by using a set to get the unique names.

--=20
Catalin
