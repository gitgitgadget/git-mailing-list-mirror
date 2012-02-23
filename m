From: Wilfred Hughes <wilfred@potatolondon.com>
Subject: Submodule commits not show by git log
Date: Thu, 23 Feb 2012 16:49:23 +0000
Message-ID: <CAMJPRQz09EwnRcMssQDRb4Pj_HZmfuxrJC0Bw6Ka4sA5gfYkWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 23 17:49:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0brb-0000n4-2J
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 17:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981Ab2BWQtp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Feb 2012 11:49:45 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:53559 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752578Ab2BWQto convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2012 11:49:44 -0500
Received: by werb13 with SMTP id b13so889008wer.19
        for <git@vger.kernel.org>; Thu, 23 Feb 2012 08:49:43 -0800 (PST)
Received-SPF: pass (google.com: domain of wilfred@potatolondon.com designates 10.180.107.99 as permitted sender) client-ip=10.180.107.99;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of wilfred@potatolondon.com designates 10.180.107.99 as permitted sender) smtp.mail=wilfred@potatolondon.com; dkim=pass header.i=wilfred@potatolondon.com
Received: from mr.google.com ([10.180.107.99])
        by 10.180.107.99 with SMTP id hb3mr5214914wib.5.1330015783498 (num_hops = 1);
        Thu, 23 Feb 2012 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=potatolondon.com; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=aO/hSsov3CJBwGjZwCbKUAaYGILyv3g9ckCEJ6uyfkA=;
        b=I9d+QsgZyM5aMcKvyh2h5sc73AqWhukYD0eSI/tHTGIADx7uf/7tdayMDhgej5ADZU
         uYzWDIEEec7eczfI1UTTu1dY4U6Yb338jzlolV7KuhNu/2kTmWM4bBLu8AhLD+98bENO
         /Y6rdAUlZb4+Rm+I46w5XqK0/kJUji4oTzz0M=
Received: by 10.180.107.99 with SMTP id hb3mr4235617wib.5.1330015783360; Thu,
 23 Feb 2012 08:49:43 -0800 (PST)
Received: by 10.216.62.76 with HTTP; Thu, 23 Feb 2012 08:49:23 -0800 (PST)
X-Gm-Message-State: ALoCoQlZd1K4CZEkMzoGc7fqVQ2EmFckk6R01qRcDcmm54ai7hiIgVIKJHJYa3VeTxBJYLMwZ0Sc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191379>

Hi all,

I'm trying to track changes on a git submodule. `$ git log
path/to/submodule` is not showing any commits that changed the
submodule commit.

=46or example, in my repo I have a submodule at the path
=2E/memcache_utils that has had the commit referenced changed several
times. It's definitely a submodule:

$ git submodule

13eb087304b995705693d6f0927dec2d88dfadaf datastore_utils
(heads/master-2-g13eb087)
=C2=A07f5d6710b767a27f14e3e7bc009f026b3e5f0e74 memcache_utils (heads/ma=
ster)
=C2=A05877e2c2d82645fa44f121884291ee48cf24584d potatobase (5877e2c)

Yet the only commit shown is when there were files at that path:

$ git log memcache_utils
commit 2cbe65bf31901873b01331e95fec72724e7458eb
Author: [...]
Date:=C2=A0=C2=A0 Thu Jan 26 20:44:07 2012 +0000

=C2=A0=C2=A0=C2=A0 Experimenting with Paul G's port of cache-machine. I=
t should
really be a git submodule but just want to see how it works so have
taken a copy from [...]
$

Have I missed something? I've tried and failed to create a minimal
test case that demonstrates this behaviour. I can't see anything in
the man pages to suggest that I'm using git log incorrectly, and
Googling doesn't help.

Is this user error, a known bug, or a new one?

Many thanks
Wilfred
