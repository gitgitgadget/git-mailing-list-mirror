From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH 0/2] Improve Git performance on big trees
Date: Thu, 14 Jan 2010 16:21:39 +0100
Message-ID: <46a038f91001140721j5acb766cxfd777570d6edfca4@mail.gmail.com>
References: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 16:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVRWj-0008SA-6I
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 16:22:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755077Ab0ANPWL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 10:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815Ab0ANPWK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 10:22:10 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:52157 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754808Ab0ANPWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 10:22:09 -0500
Received: by ewy1 with SMTP id 1so4096ewy.28
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 07:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=raBswQCSozAex/QFNzsjduSubIL2uzm4YEGWKE5tkcI=;
        b=tiVW71CxAvQjfIcmhJwez3oDStuz6xF0nxmqLARNZWNS6D8p8DrxW4idSwOrLxEAi7
         OUCC+6HTi020AAarKUSYo5hkMYwqfzrpXS+0W0YO9FoMxTxWjWBZfv90gkrJ08HoMreq
         4QyiDqc59AtqXIdA7XpSEk9ayX5rf8XEab2Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bKj5gX4xSOy6QlGfjqyDbqnG64F1wKxfeEdv/NK1IGnzHg3lwPoypOPSnDzGT7p6uU
         5oRGV9iWP6O1XHiScf9BRBBBjsU1xseToSm41kwQrQz3SfB6a6xpkvB4ax93Ou9xQfHl
         PswhZccpW5FhAI+fDBCOpFCsTgjUBLauvGQqA=
Received: by 10.213.2.82 with SMTP id 18mr931036ebi.58.1263482499906; Thu, 14 
	Jan 2010 07:21:39 -0800 (PST)
In-Reply-To: <1263481341-28401-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137001>

2010/1/14 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>=
:
> Almost 1 sec for "git rm foo" still seems too long though,
> probably due to writing a 9MB index.

One of the main issues there is that the Gentoo dir tree seems to be
very flat. The kernel tree is huge, but much deeper, and does not have
a huge top-level directory -- and git handles it fairly well.

Perhaps the Gentoo tree can be rearranged to be more nested? If your
devs strongly prefer a flat view of it, that could be arranged with
symlinks.

Alternatively, each port can be in its own repo, and you can make a
"top level repo" using git submodules -- this is what Fedora/RH is
exploring at the moment.

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
