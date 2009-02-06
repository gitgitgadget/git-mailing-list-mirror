From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] Offer to print changes while running git-mergetool
Date: Fri, 6 Feb 2009 14:41:45 +0000
Message-ID: <57518fd10902060641pa789ffbjceccbf013864e0a5@mail.gmail.com>
References: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 15:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVRvH-0001zE-Qy
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 15:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZBFOlt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 09:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZBFOls
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 09:41:48 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:58911 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbZBFOls (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 09:41:48 -0500
Received: by fxm13 with SMTP id 13so1216421fxm.13
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 06:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=mWnBa7ANRyR281eqMqD/TdvpadscUHvIwe5zfDWX9d0=;
        b=GkITr7Ah24XkWP/Hb7euQKnGqe9SOkf1ljLoncUcaH5/DxcuNzYcOhwUACrNTHfhIF
         SEENBrcVokhHlKjwAxGvLunTjkAIiosEVm7cnkJGjVpc6QkOx3FXOgycILaOluQllVX6
         HTxVPqUnVT72IefuICqA7zBnGjWJPChgd0WdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=H11xcsdX7bzC/G01knfbAS7vNGMPDf476p5+r5b0uDqLc51eFTp4Wx8rFjJiC68xUD
         U+NFJXifVK95GpFu0yi8GgtM+W+W8goFadSNcRYuVgw8zimlLaJ8BABGlAguv89wr1V4
         K4F0o+oF5lH9emciRUKrv3/8eLFs6WlVijWss=
Received: by 10.223.111.71 with SMTP id r7mr1518448fap.59.1233931305516; Fri, 
	06 Feb 2009 06:41:45 -0800 (PST)
In-Reply-To: <1233930745-77930-1-git-send-email-jon.delStrother@bestbefore.tv>
X-Google-Sender-Auth: fd25cef1b714a7d8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108718>

On Fri, Feb 6, 2009 at 2:32 PM, Jonathan del Strother
<jon.delStrother@bestbefore.tv> wrote:
> Add a "Show changes" option to each prompt in mergetool. This prints the conflicted changes on the current file, using 'git log -p --merge <file>'

Just discovered that this doesn't work so well when resolving merges
resulting from "git stash apply" - it produces "fatal: --merge without
MERGE_HEAD".  Should git-stash be setting MERGE_HEAD in this case, or
should I be using something other than 'git log --merge' to cover
these sorts of cases?
