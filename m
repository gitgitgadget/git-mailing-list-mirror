From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Error logging for git over ssh?
Date: Tue, 14 Jan 2014 13:44:28 -0500
Message-ID: <CACPiFCKBK49Zm8oYcGMVfmsgRwDrPyzWcU7vM6DwJeQitBNsnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 14 19:44:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W38yr-0007Zt-Jg
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jan 2014 19:44:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaANSou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jan 2014 13:44:50 -0500
Received: from mail-wi0-f179.google.com ([209.85.212.179]:48478 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbaANSot (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jan 2014 13:44:49 -0500
Received: by mail-wi0-f179.google.com with SMTP id hr1so1123804wib.0
        for <git@vger.kernel.org>; Tue, 14 Jan 2014 10:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=BQgrXQtPgwzkFd2cgt/7/8e/3VdX5W++85waSYPlmAE=;
        b=C2dsWSbqrR3gOL+wvF6W7Nj6KG6IJmFaf9v9DwFXoap+hV1E/s2gK1RC6fy/9DcfdU
         2MTA09y+Ye6RMhboKWA48QE8phN235gJ4mkuJ9KeFmDDeXug0WzG1HtQ0qdF+B5XkG3/
         M/ptW0ISqekyYO3CxKvqWPP82nGeXStV35PdOYg0NFK+BGmefKLQAqZ/8jp5VBLTA3hz
         t/aMByEzlBhzM4bgIRe5Oo1u1uUScubudXxRByPt7peKwbKdVP5F7Uj8xtEvElhJC/To
         jI9SefjSjZp1d2dL5Q+EI7k8gHdjIxnD2EzuacwXIwkkAtHQor/CST8YyH2sa12FBUzE
         FmLw==
X-Received: by 10.180.39.43 with SMTP id m11mr21732551wik.8.1389725088308;
 Tue, 14 Jan 2014 10:44:48 -0800 (PST)
Received: by 10.216.64.66 with HTTP; Tue, 14 Jan 2014 10:44:28 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240405>

Diagnosing errors with git over ssh has historically required tooling
up for debugging or looking at things from the client side, because
git does not log anything on the server side.

It would be a boon to those running busy git servers to be able to
diagnose by looking at a log. It can be both old-fashioned, or very
modern (if you are using journald).

After digging around the mailing list, current git master and "what's
cooking", I fail to see anything. Is there a built-in way in modern
git to direct stderr on the server side to a logger or to a file? (I
see git-daemon has some support, but it does not handle git ssh
connections...)

Some common "use cases" I've had to debug the hard way:

 - a ref is not up to date and the server rejects non-FF pushes
 - perms issues over objects or refs
 - ENOSPC
 - refs have a stale .lock file

cheers,



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
