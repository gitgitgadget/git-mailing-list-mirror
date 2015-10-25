From: Tim Janik <timj@gnu.org>
Subject: fetch unshallow fails to honor dry-run
Date: Sun, 25 Oct 2015 10:16:00 +0100
Message-ID: <562C9DD0.5040109@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 25 10:16:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqHPX-0008Rn-Gy
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 10:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbbJYJQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 05:16:15 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:33362 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbJYJQO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 05:16:14 -0400
Received: by wijp11 with SMTP id p11so127687669wij.0
        for <git@vger.kernel.org>; Sun, 25 Oct 2015 02:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=zx+griGtwL5DXlh+Y/PVCiex4TRlpqcHpF4fLDy3Lig=;
        b=usfEYeHZLV08p6/k0wl7fE8xip0Bj8XjKLV29XYvTNYFU1NR7nMX1zt9Fcct1KM+96
         Kzj0up9ezaThzsHGegHTBm2L5IAUpMPzSucF/Iw8hJ65vFMBwRLkmSDDmugczpxPPlI3
         PKx8QO/oriv0MX+hLApkueeK8IGilvem8/5yhPJpDu+papnu0PvOZAieKltH5Qmqk1eQ
         Rasax86ghO5XqjXiw+QwFizJSZxUOL62ufuPWyimopnHPnWqOmFj/YNnuvTZY59u4DXb
         jLJp06sGeMpaQG6CKIO3VrAQT3RPVuIQwSyUlZvEuLG57fVLpN90J1DwoNRa7JPBaKPr
         LrWg==
X-Received: by 10.194.190.19 with SMTP id gm19mr16018386wjc.0.1445764573536;
        Sun, 25 Oct 2015 02:16:13 -0700 (PDT)
Received: from ?IPv6:2003:45:5c7d:4100:a519:4f30:5742:2077? (p200300455C7D4100A5194F3057422077.dip0.t-ipconnect.de. [2003:45:5c7d:4100:a519:4f30:5742:2077])
        by smtp.googlemail.com with ESMTPSA id ec16sm1746277wic.14.2015.10.25.02.16.12
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 25 Oct 2015 02:16:12 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280140>

Hey all,

git fetch --dry-run modifies the repository if --unshallow is passed:

$ git --version
git version 2.1.4
$ git fetch --dry-run --unshallow
remote: Counting objects: 30603, done.
remote: Compressing objects: 100% (6843/6843), done.
remote: Total 30603 (delta 24564), reused 29164 (delta 23386)
Receiving objects: 100% (30603/30603), 5.42 MiB | 0 bytes/s, done.
Resolving deltas: 100% (24564/24564), completed with 317 local objects.
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 0), reused 6 (delta 0)
Unpacking objects: 100% (7/7), done.

I actually tried --dry-run --unshallow in order to find a way to detect in a script if the current git repository is shallow or not.
Better suggestions to find this out are very welcome.


-- 
Yours sincerely,
Tim Janik

https://testbit.eu/timj/
Free software author and speaker.
