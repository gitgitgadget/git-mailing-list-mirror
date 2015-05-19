From: Junio C Hamano <gitster@pobox.com>
Subject: Re: recovering from "unordered stage entries in index" error
Date: Tue, 19 May 2015 08:19:44 -0700
Message-ID: <CAPc5daUtrfWrVeKMdF5sAA5pt5owkyqoZ-b=BoO=Oms0rYF1ag@mail.gmail.com>
References: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "McHenry, Matt" <mmchenry@carnegielearning.com>
X-From: git-owner@vger.kernel.org Tue May 19 17:20:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YujJX-0005DP-Vo
	for gcvg-git-2@plane.gmane.org; Tue, 19 May 2015 17:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757031AbbESPUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 11:20:07 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:35937 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757025AbbESPUF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 11:20:05 -0400
Received: by obbkp3 with SMTP id kp3so14717643obb.3
        for <git@vger.kernel.org>; Tue, 19 May 2015 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=409+vBErEiq/LcwW8ov33X+wArxV1YUa8C8nClcCrPw=;
        b=Dw4pGb8aDaUO1pBeKYia/gvAhfL9fgtZTj1JFg72BJQ5xDaG1lDKBgFgyHwp+idkz7
         1Xgs52uioMhnEEaHCf8Igv1EWV95c8amG20KkxxQ0ftE5IpDGHo8+qykFzrLXFrwdIJB
         HzvhrugItmTJTugNt6a+Qyy5ybDXBheP6MDZYkd5dXJYcM3Fj8SOwEsBgRC3QqCzjxZ0
         EtYMXV1zxXMluj/YNnGT5iC+pQuEd/6SgIMLibaT2iyOHUnQyLU3MVO7rna41vRKd/UE
         g+rEAkuAYUYQ9V5JBQGaeYHdG7McH4bpNO0hZkILDubxHVPVxUeUrpFWB8RCA+7E2nlN
         v4hg==
X-Received: by 10.202.98.193 with SMTP id w184mr23342680oib.96.1432048804433;
 Tue, 19 May 2015 08:20:04 -0700 (PDT)
Received: by 10.202.197.18 with HTTP; Tue, 19 May 2015 08:19:44 -0700 (PDT)
In-Reply-To: <D377A9280DB18546A2471214D5CBB0E908599428C7@exchdb01>
X-Google-Sender-Auth: bB6-9h8TyPGIihCdkPD0ogv8DA0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269361>

On Tue, May 19, 2015 at 6:48 AM, McHenry, Matt
<mmchenry@carnegielearning.com> wrote:
>
>         I've just upgraded my git from 2.0.5 to 2.3.6, and I'm now unable to run 'git svn fetch' in one of my repositories:
>
> $ git svn fetch
> fatal: unordered stage entries in index
> write-tree: command returned error: 128

Are you by any chance using the split-index mode (which I think is
broken in 2.3.6)?
