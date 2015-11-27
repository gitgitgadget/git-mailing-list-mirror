From: "Jack O'Connor" <oconnor663@gmail.com>
Subject: GIT_INDEX_FILE relative paths are relative to the work tree
Date: Fri, 27 Nov 2015 10:17:42 -0500
Message-ID: <CA+6di1=4GwDg1kksJiKrVtDYSy=Sk=opWcg0=Ekwf0-OoQ2X9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 27 16:18:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2Kmr-0006EU-Px
	for gcvg-git-2@plane.gmane.org; Fri, 27 Nov 2015 16:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754734AbbK0PSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2015 10:18:13 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36518 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224AbbK0PSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2015 10:18:12 -0500
Received: by vkay187 with SMTP id y187so70194907vka.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=r62BuOtBsnkzQrohQtPafqFKuDk/nBfPk+YmGgkCgI0=;
        b=cMpdSdwDVtXDNlqnwBBkkYbx+AY7UfSgm8w1YV921Ns9Z0fwsNEUuE4JNPvQdQv8H3
         fYXa2DWvzZOdPfkuXOyyEtPpmP06yGWHlmgiDw7hOIyjw1+ymo8xAXWEKfbTGqFoRdjM
         6u4Um+7gyqHG/cy+UxBU5BuxHnX4KhOnaLcPVCMxkhJmqWrz6aA8jOIDbGEZ1rncS0sm
         KBt7FKjfl0bOOinQ0mNRIl1IwBSoJ+/H/TZc+p4khylnTNlpYAlAh/RVucOyi1HZWh8G
         x6ZH5zjVIOmw2p0DjSlYpzJ4SmA15AenqryU5e5bVjOZORXfT/erM/5ZbfFqx4DqG8df
         Kr3A==
X-Received: by 10.31.5.15 with SMTP id 15mr6191799vkf.108.1448637491448; Fri,
 27 Nov 2015 07:18:11 -0800 (PST)
Received: by 10.31.186.132 with HTTP; Fri, 27 Nov 2015 07:17:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281777>

When I use a relative path in the GIT_INDEX_FILE environment variable,
git interprets that path relative to the the work tree. This can be
confusing if my cwd is some subdirectory of my project; in that case
an index file is created in the project root rather than in my cwd. It
can also be confusing if I'm using --git-dir and --work-tree, in which
case the path is interpreted relative to the latter.

Is this behavior intentional? If so, I think it would be worth
mentioning in the documentation for GIT_INDEX_FILE. But I can't think
of a case where I would ever want an index file to end up inside my
work tree.

This also comes up in http://stackoverflow.com/a/7645492/823869. Using
absolute paths is a workaround.
