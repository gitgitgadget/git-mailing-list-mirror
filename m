From: Mark Lodato <lodatom@gmail.com>
Subject: git apply --interactive
Date: Mon, 6 May 2013 22:08:38 -0400
Message-ID: <CAHREChgni3iiONUO28FoVbQzjAe83ysRRzuYC2jEqkgntV-BYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 07 04:09:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZXKy-0005qv-K8
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005Ab3EGCI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:08:59 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:44442 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756543Ab3EGCI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:08:59 -0400
Received: by mail-ve0-f175.google.com with SMTP id m1so51242ves.6
        for <git@vger.kernel.org>; Mon, 06 May 2013 19:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=xQP/yWNlFGVk30Xso5doy7qsMizOyH3XgGZ1R3oI2eU=;
        b=c2Lf7+faZsiMpGRkkaAXsaOQzEDDVEM+9XMe5UB6Ng1uSBcpR7um9y1i125vRaj6l4
         ZMmzWNMfuWtVq6w3uGk4RJAB7Pi1L5+KS6PIjZEa6F7cB05B7jswBs+ELxh8R+Zdsuxk
         hSY1or4kaCMraORap13WmMRHXNaj+x+JeoTJd5mH4NemlBGMCbEksM/YUg0lpvS4avwI
         vcpLWInVzDqIeNIKkXR5AeOmazvtFnOIKomi2Kjw7hL4Eknmo/sWnovk2+awxvyq0C58
         FaASPjhKr6eF1msZ6hzU2wO0Rcbc8oU3luUTvbcDv/rNOPp6w7k8S7o0KWD+sEpyLLmI
         AVjw==
X-Received: by 10.52.35.196 with SMTP id k4mr6713622vdj.77.1367892538413; Mon,
 06 May 2013 19:08:58 -0700 (PDT)
Received: by 10.52.23.172 with HTTP; Mon, 6 May 2013 19:08:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223522>

I'd love for "git apply" to have an equivalent to "git add -p".  (I'm
guessing it would be called --interactive since "git apply -p" is
taken and --patch would be confusing.)  Has anyone thought about this?

After taking a quick look at git-add--interactive.perl, it seems like
the main steps would be:
1) making sure the patch comes from a file and not stdin, since stdin
is required for the interactive input
2) collecting the input patch(es) and separating by output file
3) modifying parse_diff to accept these pre-split patches
4) coloring the patch

Mark
