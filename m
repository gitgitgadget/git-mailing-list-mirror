From: Lars Schneider <larsxschneider@gmail.com>
Subject: Selectively clone Git submodules -- a useful feature?
Date: Thu, 18 Jun 2015 22:55:42 +0200
Message-ID: <162A5ADF-1FDD-432B-B5F8-672DF5B50EEC@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 22:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5gql-0002xW-Ll
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752334AbbFRUzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:55:48 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38400 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbbFRUzq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2015 16:55:46 -0400
Received: by wibdq8 with SMTP id dq8so604868wib.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=0d8neCvTVOhm8/MN/bvFiAqaf96n0FldrKlRX8Z0uXA=;
        b=ZpCbjUvZQ7wF9pFYDwLU8hPuuYTzORBAvZ5MGkyRjrx6OQXe+uKcioMC4KFVXHdCbT
         tNUjDvk5nM5ub8Z2nsJ3uJVE0xWo/FB4B6cyhIkjWApXMtNe3jUC/xjdPqdYYISwLKTo
         diYeNYCt8Adw+0NhKC44LEZ3M9M0AqbyhNOmUvFsEMz++KxkXY7IHNlTyCnWzkpHfPdz
         HSeE2oMaSMS+xxE31I8+EAMtc9KEq7PVfJPJ65r/v7PXl4ZcWJ/kCGKbtVYS4UMoW1oI
         TbAUV/3vuz7rA9bf/BSTdGzpAPMtvYDGYm1sknHu1TsRc3Q1wpFW9OCdsI6GYt3kA7CA
         GFKg==
X-Received: by 10.194.205.5 with SMTP id lc5mr19563040wjc.74.1434660945563;
        Thu, 18 Jun 2015 13:55:45 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-103-022-019.188.103.pools.vodafone-ip.de. [188.103.22.19])
        by mx.google.com with ESMTPSA id tl3sm13865230wjc.20.2015.06.18.13.55.43
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:55:44 -0700 (PDT)
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272073>

Hi,

AFAIK Git has two ways to clone a repository with respect to submodules:

(1) Plain clone of just the repository itself:
git clone git://github.com/foo/bar.git

(2) Recursive clone of the repository including all its submodules:
git clone --recursive git://github.com/foo/bar.git

I am working on a big cross platform project and on certain platforms I don't need certain submodules. AFAIK there is no way to selectively clone only a subset of the submodules with the standard command line interface. I wonder if something like an exclude pattern for submodules would be of general interest. I imagine a call like this after a plain "clone" operation:

git submodule update --init --recursive --exclude 3rdParty/Windows/*

or even:

git clone --recursive --exclude 3rdParty/Windows/* git://github.com/foo/bar.git

Please let me know what you think.


Thanks,
Lars


PS: I posted this question already on the Google Git group here:
https://groups.google.com/forum/?fromgroups=#!topic/git-users/jyKsd45d2MA

I am sorry, but I discovered this mailing list afterwards and I am not sure which one is the appropriate one. Please advise.


---
https://larsxschneider.github.io/