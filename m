From: Kevin <ikke@ikke.info>
Subject: Re: the ".git" folder
Date: Sun, 20 Apr 2014 14:58:57 +0200
Message-ID: <CAO54GHCQBDehPsneMW4Q8CTm+OJUhVpq_higzKDows4TgpJFOw@mail.gmail.com>
References: <7F780F951A13B047BB0CE5F6EA9069C121871366@hou150w8xmbx06.hou150.chevrontexaco.net>
 <CACsJy8CXADh_wrHeqf47FuBUiF8pq_xboUPnts6mP8iVj0F-Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "Miller, Hugh" <HughMiller@chevron.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 20 14:59:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbrL8-0003QN-SN
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 14:59:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbaDTM7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 08:59:19 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:59692 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755196AbaDTM7R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Apr 2014 08:59:17 -0400
Received: by mail-yk0-f169.google.com with SMTP id 142so2714584ykq.0
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=3Feutq3AWX8jIQ+Sp0boy/XLRfbZ9+EHgiEenpL2Rpc=;
        b=XJ/O1FdHPFO793kigngOrpiQEyJ9X/BVyl/E5M3s94GdTzNekt3JEQONGy+OhArGOW
         iWwcngNLbs48kzuqucKKdUiVIrKqz1Lt61ZU9UGw6G4gN3wh03Yp7cOr2ZXisNB3NmNV
         Z0q6Rj+WjyyQypxttjCZRkBn0j2gNLZnpL6V0sJzZKLr//N2/RREZYeZcp6eigD3B78h
         d8MaDRBUMw9wi+yq2XC6L3piTloWXFsfspT9U4gBke7KiTetdcn9oOuxheSuA5Ku//3K
         TH5OODooTbIVH04yVBAZE+tTQOxSjqhqBsNEVjAv3R8Q0lwMbKnEm4L62RXSvufQAulz
         L7Lw==
X-Received: by 10.236.197.68 with SMTP id s44mr312513yhn.109.1397998757303;
 Sun, 20 Apr 2014 05:59:17 -0700 (PDT)
Received: by 10.170.170.133 with HTTP; Sun, 20 Apr 2014 05:58:57 -0700 (PDT)
In-Reply-To: <CACsJy8CXADh_wrHeqf47FuBUiF8pq_xboUPnts6mP8iVj0F-Pg@mail.gmail.com>
X-Google-Sender-Auth: YxYBtBmZ2VUQ2tS7FG-oG_nQHC0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246549>

Another way, which wouldn't require environment variables or extra
parameters for each command is moving the .git directory, and replace
it with a file called .git, which has the path to the actual .git
directory.

Git submodules use this feature too.

On Sun, Apr 20, 2014 at 11:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sun, Apr 20, 2014 at 4:13 PM, Miller, Hugh <HughMiller@chevron.com> wrote:
>> Dear Community,
>>
>> Is there any way to use .git (e.g., a different set of "client" commands) that allows the .git folder to be placed in a location away from the actual files being versioned ? For example, can one set environment variables that let the software know where the .git folder is ?
>
> Try
>
> git --git-dir=<new .git location> --work-tree=<top work tree location>
> <some command>
>
> The reason of two arguments instead of one is because .git is also
> used to mark top work tree location, which is now lost after you move
> .git elsewhere. You could also set environment variables GIT_DIR and
> GIT_WORK_TREE, which have the same effect. "man git" for details.
> --
> Duy
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
