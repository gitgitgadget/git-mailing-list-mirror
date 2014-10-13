From: Etienne Buira <etienne.buira@gmail.com>
Subject: Re: [PATCH v2] Handle atexit list internaly for unthreaded builds
Date: Mon, 13 Oct 2014 17:19:11 +0200
Message-ID: <1413213552-13769-1-git-send-email-etienne.buira@gmail.com>
References: <CACsJy8CbhS=dv3fHvyTv0b-jazh3XS+nswmz_0AsLeHqko794g@mail.gmail.com>
Cc: git@vger.kernel.org, etienne.buira@gmail.com
To: pclouds@gmail.com
X-From: git-owner@vger.kernel.org Mon Oct 13 17:19:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdhPb-000795-6p
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 17:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbaJMPTo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 11:19:44 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36597 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754382AbaJMPTn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 11:19:43 -0400
Received: by mail-wi0-f172.google.com with SMTP id n3so7665054wiv.17
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 08:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y8zvzynRO46U/4DIoNYo7377sSn+EfcWxEePNY/uyPw=;
        b=QZONPwtR8Kg/PaZH/e7UDi0w67Qr49HM5XmDjul15HZ8Yzc8xIZwd0Kodi6heuKcG+
         DWcoNbd7YCeWV8QlyxEQbfqImrDuSnMLAVIQ39N2erzsUs1HTe0MMR5zCHurmOBkmMWZ
         7vHoZAd03wW2n8NV/jjRIDzzB/z1lIIV96LODWOmYyn2fWxHVZ6BILuZM6WHjMD2HBts
         1hhiRqIfHnlFn2AYJET9iQhlqJrN4fIKCit+9GKmlDPdBAxd9EKRkRd1QDdY/mQQZUWz
         VwMCFPIco481VgU2q21tn8oljBk6MJlYEIyfV8LuY/uBFLXgBcX0EdZwAKxC9fznBg5b
         pZ5w==
X-Received: by 10.194.110.10 with SMTP id hw10mr3285399wjb.102.1413213581859;
        Mon, 13 Oct 2014 08:19:41 -0700 (PDT)
Received: from localhost.localdomain (sbr22-2-88-185-151-243.fbx.proxad.net. [88.185.151.243])
        by mx.google.com with ESMTPSA id wk5sm16996418wjb.12.2014.10.13.08.19.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Oct 2014 08:19:41 -0700 (PDT)
X-Mailer: git-send-email 2.0.4
In-Reply-To: <CACsJy8CbhS=dv3fHvyTv0b-jazh3XS+nswmz_0AsLeHqko794g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 2:56 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Oct 12, 2014 at 4:09 PM, Etienne Buira <etienne.buira@gmail.com> wrote:
> > Replace atexit()s calls with cmd_atexit that is atexit() on threaded
> > builds, but handles the callbacks list internally for unthreaded builds.
> 
> Maybe hide this in git-compat-util.h and "#define atexit(x)
> cmd_atexit(x)"?

Updated.

> cmd_ is usually for commands' "main" functions. Maybe
> rename it to git_atexit().

Indeed, renamed. Thank you.
