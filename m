From: Lance Fredrickson <lancethepants@gmail.com>
Subject: bug report: build issue with git 2.2.2 using uclibc toolchain
Date: Fri, 30 Jan 2015 08:55:20 -0700
Message-ID: <54CBA968.2040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 30 16:55:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHDur-0006vW-3U
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 16:55:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759645AbbA3PzZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 10:55:25 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:39380 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbbA3PzY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 10:55:24 -0500
Received: by mail-pa0-f42.google.com with SMTP id bj1so53865584pad.1
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 07:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=DJK0iEKE0+NYC+oKTcYBPl8AMhLfZDtBS3yY//2D6gM=;
        b=wPJlb6liTmNwrN2Vl9vLFPu5dGFfZ5C7NeDpyIctClbRLCLGI/cIqqVwFsYM+k1BII
         767KR3I2Tz5+OgFbTF2bJahvTvXjXKF6LKqaFhcoNgQ86uLPmKuWEV6ZSXa1fXB1p4vU
         X5hcQPyoOQcz2M0FJ4ernws8nX7Gzw2zoWJ5sypGTNi7CRTv8pF2DZOdQOjpLG+MYtjy
         t6vMj8gWOn/yj6COLLPyLwvpDnUunhUVFoj3JDaUPJW3M1hNxVPUaishHr2zbBaSFoij
         N7ftDYVHEB8MtS639c1RKmGstExKt14Q4JGXVJfvsbtOIi8wqFAfl/Iich6IO81ATv1o
         REtA==
X-Received: by 10.66.129.199 with SMTP id ny7mr9865244pab.82.1422633323978;
        Fri, 30 Jan 2015 07:55:23 -0800 (PST)
Received: from [10.0.0.155] ([70.103.142.130])
        by mx.google.com with ESMTPSA id l11sm11185353pdn.46.2015.01.30.07.55.22
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Jan 2015 07:55:23 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263181>

I've been keeping up-to-date versions of git built for an embedded 
mipsel architecture device running on uclibc.
2.2.1 and previous versions build fine, but 2.2.2 stops with an error.

The toolchain is an OpenWRT variant (entware) using gcc 4.6.4 and uclibc 
0.9.32, available at the following.
http://entware.wl500g.info/sources/

Here is the output of the build error.

CC builtin/grep.o
builtin/get-tar-commit-id.c: In function 'cmd_get_tar_commit_id':
builtin/get-tar-commit-id.c:31:12: error: dereferencing pointer to 
incomplete type
