From: Eris Belew <erisrenee@gmail.com>
Subject: Bug: Pathspec parsing on Windows fails when branch specified
Date: Wed, 20 Nov 2013 13:09:26 -0800
Message-ID: <CAM8h_A_zfX4U8hGxiw3_79zMZXmcTN3CPRUcrtsQTQdD4RaMhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 22:09:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjF1f-0007nl-Qd
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 22:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273Ab3KTVJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 16:09:28 -0500
Received: from mail-ve0-f180.google.com ([209.85.128.180]:54409 "EHLO
	mail-ve0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275Ab3KTVJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 16:09:27 -0500
Received: by mail-ve0-f180.google.com with SMTP id jz11so4118940veb.39
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 13:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LbxRP+YXi8aCnXYFnmDUes6qIcgajD7FIShB4lLb0Cw=;
        b=MU5wf6NZZ1DiNckKPfGqZrLCfiYAtOX28As9xAcDfHXoHN0t/tQzO36hVEgtJVxYk7
         6wvk3TkWz1NDML4fwMMy2ANnlQBe9ueiG7lsRpiYXxsNlu7CLJ9z+mB5y/29lraIpLah
         oVzJZnhsXOTdZpvFDBuE88R75aTJGxYtC4JoWJgwj4DgJIgsCli7YXTOn47vuh1SvtKJ
         RfYSxgEThy6YVySTsOtgQIp9ttrF/jcmGQ3o0JpHTtsBGGruCEJ+jSYI5dvE+4z5ObMO
         A4f9RkBNqtZ9xL1hT5HuHtitbLf7LQYLAL8G7KmofOlx1kJ8yrKa1et8nvhvNNqD3gtS
         6u/g==
X-Received: by 10.221.51.206 with SMTP id vj14mr2189598vcb.17.1384981766701;
 Wed, 20 Nov 2013 13:09:26 -0800 (PST)
Received: by 10.58.49.68 with HTTP; Wed, 20 Nov 2013 13:09:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238095>

System: Windows Server 2008 R2
Git: git version 1.8.4.msysgit.0
Shell: Powershell V3 (No third-party modules loaded)

Summary:
  When specifying a pathspec including a branch/commit, path separator
characters are not translated. Since tab-completion in windows shells (ex:
CMD, PowerShell, not unix-style shells running on windows) uses the windows
path separator, and other git commands work fine with the windows path
separator, the expected behavior would be to translate for me.

Reproduction:
    git diff BRANCH:path\to\file path\to\file

Result:
    fatal: Path 'path\to\file' does not exist in 'BRANCH'

Expected:
    Normal diff operation

Workaround:
    Manually convert pathspec. Examples of working command:
        git diff BRANCH:path/to/file path\to\otherfile
        git diff BRANCH:path/to/file path/to/otherfile


Thanks,

Eris
