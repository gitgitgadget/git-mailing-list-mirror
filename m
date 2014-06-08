From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5] Add an explicit GIT_DIR to the list of excludes
Date: Sun, 8 Jun 2014 17:17:58 +0700
Message-ID: <CACsJy8AyvkA20mD283=hWp7WFJXBu3-ViXHuS4jtMzz2hpBi2Q@mail.gmail.com>
References: <1401912909-29654-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 08 12:18:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtaBN-0001Cg-PU
	for gcvg-git-2@plane.gmane.org; Sun, 08 Jun 2014 12:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaFHKSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2014 06:18:30 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:46591 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaFHKS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2014 06:18:29 -0400
Received: by mail-qa0-f41.google.com with SMTP id dc16so6702982qab.28
        for <git@vger.kernel.org>; Sun, 08 Jun 2014 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1OsVX9vWHwh+HlfJIVY+7NfK98OgQmCoa+wv+JwYZQY=;
        b=UKOvgy/rHWayqlBhgXUeryt77xDGcFXLC3bVxHHBbfzVks4PpSN8I7/2iWymdJ29d0
         neJ1bClRuAe/aGutPwEHe4F2XH1alE/zYHXyTwA7EnB2EkqPrMw3jJIuaGYYQkC7Jr1Y
         4KUeeRsZLY8CRz0YpiBW7sF9xCkBvXaRKiDAMlT6TpLZpdpoZXJBrbJpOyIV1cBHykxs
         FuXol3x4mO3MkkuMEhOOiKM80c0SYBzZeeaEntb/qS4LGrcuTLYRXDEtny4EA6gYQIWu
         +SzVS40K90NRNImKl/rsQva/wuzLcPOSXm9ryqNhAT6rnG9try0dBCdM/PEuCtgD/MoN
         ORxA==
X-Received: by 10.140.80.67 with SMTP id b61mr22324881qgd.98.1402222708722;
 Sun, 08 Jun 2014 03:18:28 -0700 (PDT)
Received: by 10.96.66.129 with HTTP; Sun, 8 Jun 2014 03:17:58 -0700 (PDT)
In-Reply-To: <1401912909-29654-1-git-send-email-pasha.bolokhov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251053>

On Thu, Jun 5, 2014 at 3:15 AM, Pasha Bolokhov <pasha.bolokhov@gmail.com> wrote:
> +       /* only add it if GIT_DIR does not end with '.git' or '/.git' */
> +       if (len < 4 || strcmp(n_git + len - 4, ".git") ||
> +           (len > 4 && n_git[len - 5] != '/')) {

Hmm.. should we exclude "foobar.git" as well?
-- 
Duy
