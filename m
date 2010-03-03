From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/3] Revert "git-svn: always initialize with 
	core.autocrlf=false"
Date: Wed, 3 Mar 2010 21:16:25 +0100
Message-ID: <40aa078e1003031216l5d164654ta8ff7ea6c8cf2162@mail.gmail.com>
References: <1267647023-2604-1-git-send-email-kusmabite@gmail.com>
	 <1267647023-2604-3-git-send-email-kusmabite@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: normalperson@yhbt.net, dpotapov@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 21:16:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmuzj-0007Y9-L5
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 21:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756555Ab0CCUQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 15:16:31 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:62602 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756552Ab0CCUQa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 15:16:30 -0500
Received: by ewy20 with SMTP id 20so1269752ewy.21
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 12:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Pa2lcU2052TTUcrqyz6qLiKvjhi23Ep447eIj9pY6tg=;
        b=KMduLVKgvf0WrlxXvr+GrXB8oDB/ltK3YpkUEjBCze7kyDCO03Z8SnnYaAIcREUf4U
         NiJeKdeUq5+NLZY0J8AhZ4q9/sJHm3o85j4Uricx/hReD0eDtjzc08S5Xg+NXJgD6IJz
         7qMuljy4Iu0h++OSR3YCXZ+MfD1DSeqdWd1Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=kLTxoAoPHRmL7IOr7735tX0RKoHLMgV+bqIavHXtAm3GaOvTJNYvdUmA6KduUAEEY7
         jw95Jmz/KxlMeJgiSnn26dijzwudLDgyxMgPLbVzy48j1JyYhzA4yUk5Mt9LBdHFm6xn
         D0CwN4EBkEwRUGNtsD1pDLhXdXzdDBbGrd8S0=
Received: by 10.216.165.67 with SMTP id d45mr1040391wel.28.1267647385991; Wed, 
	03 Mar 2010 12:16:25 -0800 (PST)
In-Reply-To: <1267647023-2604-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141472>

On Wed, Mar 3, 2010 at 9:10 PM, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> git-svn dcommit uses diff-tree (which does not apply CRLF conversion) to
> generate SVN commits, so there never were any CRLF conversion issues when
> commiting in the first place.
>

Uhm, this comment is slightly wrong. diff-tree is used to find out if
there's a change in a file at all. cat_blob(), which in turn uses "git
cat-file", is used to get the file contents.

Sorry for the noise.

-- 
Erik "kusma" Faye-Lund
