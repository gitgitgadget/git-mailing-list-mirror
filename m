From: Orgad Shaneh <orgads@gmail.com>
Subject: Case rename not detected
Date: Tue, 5 May 2015 08:52:08 +0300
Message-ID: <CAGHpTBJuRCrg5jL7Anm9kxGJEf5cUmPzDToZG0UXeT_xNMWfsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 07:52:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpVmB-0007eC-2F
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 07:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbbEEFwL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 01:52:11 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36276 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbbEEFwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 01:52:09 -0400
Received: by lagv1 with SMTP id v1so119191881lag.3
        for <git@vger.kernel.org>; Mon, 04 May 2015 22:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=hufLhGb82IgQkcAjV25W9p8CMO+1eobuXiFE6roPtLo=;
        b=E76XKzg0PvBW71G0v2XJtSPkb+LmoubTxE2sVUBYidLq+lF5Ji+QXcqRsdW3cO+L0O
         2VTOpDCkQxlcncPZlydo95wYXEDSt3cqZaiFzp+Y0FvNHHmtZjNPVFKTYOvRO2whgaCr
         i1PTG8ZvF87Z7d9Cpl8BlXe3+T8/Df3rdozY59od14IAuDUJT2nuRF0pIF4u4PwkhS19
         0gyseUFWIOj1rWtPH/vIKzLuw5AqecqLeqURD6jCFjCUlUTCPMcE3ddpQXyG+aEOugRo
         olWNKYxs1YEFzbDsJHVJvONNzky1US8IK7fvIM1PBlvUFZQPZzcHYyNSRNmTGH+OI3QF
         Ds7g==
X-Received: by 10.112.170.70 with SMTP id ak6mr22540931lbc.42.1430805128163;
 Mon, 04 May 2015 22:52:08 -0700 (PDT)
Received: by 10.25.78.77 with HTTP; Mon, 4 May 2015 22:52:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268386>

Hi,

File case rename is not detected correctly on case-insensitive
filesystems. git mv does support it though.

Example:

git init
echo hello > foo
git add foo
git commit -m initial
mv foo Foo
git status # No changes
git add . -A # Doesn't add anything

- Orgad
