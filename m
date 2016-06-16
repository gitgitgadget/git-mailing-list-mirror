From: Chris Packham <judge.packham@gmail.com>
Subject: [bug] assertion in 2.8.4 triggering on old-ish worktree
Date: Thu, 16 Jun 2016 16:59:22 +1200
Message-ID: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 06:59:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDPOp-0001HU-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 06:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbcFPE7Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 00:59:24 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37877 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbcFPE7X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 00:59:23 -0400
Received: by mail-it0-f48.google.com with SMTP id e5so38236434ith.0
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 21:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=xiUFC/YV0tyfj27kvcokTpiD3Q1zGX7ArAKCrb4jJyA=;
        b=Vwu0xVwPXOrs5fY+ANrGlMqBzE7fJ12O42tIwb4W7tzV4cKFi2rQK/ct2FrVayWLmv
         o6fUcHe5zz1xqHEiYa//lbEphWxmUNosx8LnaeTHo43BkmJWIWp4pOIfjwuYdGnsz5+5
         wxcl+PXkHqez2DA0HeFjkebbOpdIJbD1NdX4poBwjvmqVW5kymiAXABK+Gge7Px5Vfb+
         9JCicsKSVZTSSRL/xgkBwh0lF2j9OjRMPPmooVHPSahsqIJ3Cyx/yMAejkMbW3ajii04
         Kr04L4z0MhEngRFW9AO7LfV4WpOKLhhOsvf/SXivfVevAi12oQ8KfswMilLE0EUvALS2
         u6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xiUFC/YV0tyfj27kvcokTpiD3Q1zGX7ArAKCrb4jJyA=;
        b=mSQoykzDNLj1oIA2oIYwhnLPF+MXNgXGGxPgu47cVHc284dpKs81bVFkAf1LZhLcVP
         HHlS3yDCHoKXnPgYOl0Y1XlFKKCSeUrXoNBadVVM5mXoGrge/dZVSJNC6I6IlP4ms/Rx
         L0WPOwA6+ehohrn6uvcGW0dQudWinYHnkEWrAPjVeqQ8RDZzem2Jm2I6/+aZSe3YpaYf
         ERHh4EAGjWJxyCi9PWQRJpuqEKccRNWiflIbwBts+xVnb5n+JrRsRt2eFqRtFf2pptUX
         Y8wlGeK5DLrXvt4vGEvBjRi8Agv+V8NjnBw80GRpap3LarCS/b+JlWrKdOQKSSba8hIe
         HfGA==
X-Gm-Message-State: ALyK8tJJMlLgk8ED+Qx2PpYAlusImVES/MT/fVYmRGx4wGp2BpPEWa+rSlducb3pmW1HdCy9TI9kPeqBQemiiA==
X-Received: by 10.36.1.198 with SMTP id 189mr23283999itk.40.1466053162616;
 Wed, 15 Jun 2016 21:59:22 -0700 (PDT)
Received: by 10.79.86.134 with HTTP; Wed, 15 Jun 2016 21:59:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297413>

Hi All,

I have the git-sh-prompt configured in my .bashrc today I visited an
old worktree that I haven't really touched in a few years (sorry can't
remember the git version I was using back then). I received the
following output when changing to the directory

git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
<= item->len && item->prefix <= item->len' failed.

I assume it's one of the git invocations in git-sh-prompt that's
hitting the assertion. Any thoughts on what might be triggering it?
Any debug I can gather?
