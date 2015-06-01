From: Vadim Kramer <vkokielov@gmail.com>
Subject: Git-Win: case insensitive names
Date: Mon, 1 Jun 2015 13:30:19 -0400
Message-ID: <CAFQnHJfK94wG_bpe3OFmd7CyZzLCQFq70QGoMAP8=PchdUVH9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 19:30:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzTXe-0004UN-8W
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 19:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753007AbbFARaV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 13:30:21 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:36195 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbbFARaV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 13:30:21 -0400
Received: by lbbqq2 with SMTP id qq2so89011523lbb.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=HiXgSlypC58mi9lg1a/DxP9J71zJnpjBIOsw+TBWoX4=;
        b=YdjBgzI1xdsZ2pMdar0vzPohDGpwWxZ7az6ZZ7LGabIDc7z3wMkyRZBmLV4oYJSf2n
         zbgvT6wYUB8pA9mdF5hbfN8ENijDMZZUKOn2aOMs5nuHSkIQnLQkOFgPSlUiI91nppOz
         aU7H/tBVA/khwV7KN+sDkmJCnvieLc5sYfcnXwvbyPC83K3MdMtlOLCwbWYD5tQ122U1
         VhDE/y4I+1Mml+2GdM4FITmkEfmWJViSODsleeRTOPlHqBZnl+dIKAxgdP8nCCgtUkQ8
         JlJNs9rY1Zxl1ZWOg2tc4BfapCQHkkp+HeHC2oV3EDt3ovmU9YQhkX/k/ODAq1dKzh4J
         nTcQ==
X-Received: by 10.112.140.137 with SMTP id rg9mr22202395lbb.101.1433179819911;
 Mon, 01 Jun 2015 10:30:19 -0700 (PDT)
Received: by 10.112.37.5 with HTTP; Mon, 1 Jun 2015 10:30:19 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270441>

Hi,

Just had to deal with a nasty cross-UNIX/Windows problem.

Two files in the repository were in the same direcory and had the same
name differing only by the case of some of the letters.  While
checking them out, git wantonly confused them (conflated them into
one) and got confused about them.

I know it's an outlandish situation.  Still, when git is in a
case-insensitive file system, it should at least check for this.

~v
