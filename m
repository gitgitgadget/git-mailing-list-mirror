From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: git rerere forget isn't working?
Date: Mon, 12 Jan 2015 08:20:27 -0600
Message-ID: <CAHd499C6opP_0RBGDS=h+1qhrr=7sD0w0hf_bpGWT-wPP4iJoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 15:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAfrB-0004nN-Gx
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 15:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503AbbALOU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 09:20:29 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:43368 "EHLO
	mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbALOU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 09:20:28 -0500
Received: by mail-oi0-f45.google.com with SMTP id x69so20584752oia.4
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 06:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=S1Elaz127f/JHJeVRPNGHCEcJefJYPFHLdBXWJEJwR0=;
        b=jLq7KS4cEo5fes3QWbVsUXSbvkze0kqtqLnpuCT+FHaDCusvcTkI+MSRRPfwFE6gC5
         vsztCRqUPkhAedN0AW6AZn8AAZ0Na3bYRKtKksV3Qc6zJIadEvDnFoaawlD8OnjnNVns
         JyY0SWLS3Plei+Q7HlYCtZFROX9Xhr/1hzHtW/DjarPnjErvV5POlSwojnUCQh6N8kE9
         MvORphYiP55AUDAn66NIXJqmwHhrvqTD1q8MLe8o4wRCh1T+iw9SK45RrZPYOX6D6+K+
         2y/pzI+O4HYglsYqLugtSuoHIIPJn4vdb32T0Q1lCieDyzEnEU/643w5gU0Of/EF0xu7
         kyRA==
X-Received: by 10.60.119.33 with SMTP id kr1mr3571911oeb.45.1421072427776;
 Mon, 12 Jan 2015 06:20:27 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.202.215.131 with HTTP; Mon, 12 Jan 2015 06:20:27 -0800 (PST)
X-Google-Sender-Auth: WP5KavMMHq23LFZrSwtzE2JxBX8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262285>

So I want a way to clear out the whole rerere cache (i.e. every
remembered conflict resolution). So I try this command:

$ git rerere forget .

It completes silently, I look at .git/rr-cache and there are still a
bunch of SHA1 directories in there. So I guess it didn't work. The
only way I can do this is to physically delete the .git/rr-cache
directory. I'd rather not do this, so is there a way to get this
command to work properly? I'm using git 2.1.0 on Windows.
