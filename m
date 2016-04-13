From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Migrating away from SHA-1?
Date: Wed, 13 Apr 2016 08:51:12 +0700
Message-ID: <CACsJy8DmPw+cbohp-X55bp9NJSbUVN=tsABXoF5Xh-6PgPTbiA@mail.gmail.com>
References: <570D78CC.9030807@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:51:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9y8-0004hJ-PA
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:51:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758567AbcDMBvo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:51:44 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35029 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758554AbcDMBvo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:51:44 -0400
Received: by mail-lf0-f51.google.com with SMTP id c126so49773913lfb.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 18:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SyDJGh6J999+6PS7JRcFcpOGJSFWn4aeMO9q8q/MqOY=;
        b=w4rxWUQs5vU+pJNmBoJmnOQs81NupVmuzHknL5WK1yoVDrcOrh8whqbDJT9xJUnf/c
         zsgXAOWgvlIrIwxPr964+YGb4pOFs78k7CeNjoARZbIm0/s9P97MZ/JXcf5GJfNtZGE4
         fYAG61rGxusI9m6pLBkaj7FYuCiJ07YbHBOwxklnHQcJ+PE2UopIGsxXAPJqGC2QFIgG
         zbmm2/Hy0KzNkZSco7Jp9eEmLK4bnF7f+wytIma+gMI1PNb21XuXQ9211oxjcnKmn4MJ
         wOlGQgo42rnN9qcLsc5coIooQ+4T4v1eid8Aaft0CnlXOq8KhGg3xAuwI5xAY24nGk3L
         Xf2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SyDJGh6J999+6PS7JRcFcpOGJSFWn4aeMO9q8q/MqOY=;
        b=E1PQkw+fXeJTCdS+xym9FF5bRFHEGJrS2whV3qee48zLaGQ6wESHkCwMU3YERGdt/W
         SV+2DS9XEII+EIXCbqbdFGxgIIW0BD1TtjlE5klxkyZJvGMITnLBiEhzPKwH8GLc8mVq
         vEeJekXdv3T9FGo1R0pdi6pYTTOVyGgXnk2tsA7iGnDBVVAk87Hix0wHqywB5fg1FTnH
         AJd+MXpUxm7xIrKPBO8v6bdDOZmKQZoThMag2XFwoowej8k3yyrFP2uJToQqePVkQzdz
         bsL7MWZpGLR/fiztSJrs4OakCyDMJGMbXiY/o2FwVJvaYVGpmYnuVykJ/rnc2MJsuiVV
         P65A==
X-Gm-Message-State: AOPr4FXDGcRi25AElum3vokxGkrh0Lqa3WprDc6pjAFUslbUWVMrNvvTmGkFOiRgJg9NIfEX+JqQMXcQaqQIuQ==
X-Received: by 10.112.85.43 with SMTP id e11mr3014247lbz.80.1460512302319;
 Tue, 12 Apr 2016 18:51:42 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Tue, 12 Apr 2016 18:51:12 -0700 (PDT)
In-Reply-To: <570D78CC.9030807@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291364>

On Wed, Apr 13, 2016 at 5:38 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> OK, I'm going to open this can of worms...
>
> At what point do we migrate from SHA-1?

Brian Carlson has been slowly refactoring git code base, abstracting
SHA-1 away. Once that work is done, I think we can talk about moving
away from SHA-1. The process is slow because it likely causes
conflicts with in-flight topics. A quick grep shows we still have
about 300 SHA-1 references, so it'll be quite some time.
-- 
Duy
