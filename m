From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 2/3] grep: Fix two memory leaks
Date: Sat, 30 Jan 2010 09:45:53 -0600
Message-ID: <449c10961001300745m495986acw5f1cfe5c22f4ee1f@mail.gmail.com>
References: <1264866178-12048-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 16:46:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbFWK-00031w-4A
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 16:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752726Ab0A3Ppz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752626Ab0A3Ppy
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 10:45:54 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:40260 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752488Ab0A3Ppy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 10:45:54 -0500
Received: by pzk2 with SMTP id 2so2630107pzk.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=IOCBth99LLZ8ycYl81+e+tb+z02pesCYALsNMlm27NY=;
        b=W6FT3E7UVERUNIp8vIl2WSZy7aTOj1HJffgF+rGLG9DMDm25rqG51/DacXtvYm2ZG5
         RZY719F8cqE7CAqKbnxW86GVtnU90EW23USO+1QSn2bUBDnrssHXCSSd4pQcRATJunQP
         +3zzCJQs6JK9JHVWx7I430VgK4IToMVlnBRUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=JGKnlwwiQZRlNyrljH/Kbw+pE2PK4a6veYsVkjowH+aebh1WOzfBS3YmDOMDjt1b6V
         sR0sqBRQq8V2MqcDI3+9zKhnMEpY4NveufHjo0BHz0WxRDpURoZMsJwUPscr7FGVCUY7
         e3nr9jZ3zPji4TFOl0sKp5oOO0s17Ps6U9kWM=
Received: by 10.114.236.30 with SMTP id j30mr1528908wah.135.1264866353904; 
	Sat, 30 Jan 2010 07:45:53 -0800 (PST)
In-Reply-To: <1264866178-12048-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138478>

On Sat, Jan 30, 2010 at 9:42 AM, Dan McGee <dpmcgee@gmail.com> wrote:
> We duplicate the grep_opt structure when using grep threads, but didn't
> later free either the patterns attached to this new structure or the
> structure itself.
>
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>
> ---
> Found these with valgrind.

Ignore the misleading numbers in the subject, there isn't more to see
here...whoops.

-Dan
