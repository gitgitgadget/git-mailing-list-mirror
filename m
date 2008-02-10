From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Improve git-help--browse browser support under OS X
Date: Sun, 10 Feb 2008 15:43:36 +0300
Message-ID: <20080210124336.GH30368@dpotapov.dyndns.org>
References: <1202505794-13409-1-git-send-email-jaysoffian+git@gmail.com> <20080209202020.GD30368@dpotapov.dyndns.org> <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 13:44:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOBXc-0005Ga-UI
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 13:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYBJMnn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 07:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbYBJMnn
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 07:43:43 -0500
Received: from mu-out-0910.google.com ([209.85.134.190]:21488 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617AbYBJMnm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 07:43:42 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4885991mue.5
        for <git@vger.kernel.org>; Sun, 10 Feb 2008 04:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=4UkwhxUKwU6KbUDkwY3SK6givUwdxLGcmaylVPenHr4=;
        b=DG0gKNZo0C8CgaajDjdFlCHjk3DrkonPeLN1x4q5VtSR7+Scwt+6k7tRhJyuwJIiseo+UZ3PJKZgprs51kJIRsHc3lHO55dUs3PBDMwkYIW2ZcJ32lGp/uRo992KYOrAe6qVNuaI1mtxtrvLypSGRSOM82TxcnxlhTeJN9aq/sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=yB6+/YWv39pAOq/uCaSepfOEtjQKjd68S4t4Mkd/ksVnYoTG19/qEGYI4O2HytUWNGdPcfIFG56SKIw0KY9wD2OdfsBWxftonIutCue+/fK83l6jYnS25hji3b6hZj/Uf3LRAcsd4r5QG4+pPup8LM8rdwTxS/Ilqjv/SzNnlgI=
Received: by 10.78.138.14 with SMTP id l14mr26650427hud.57.1202647420775;
        Sun, 10 Feb 2008 04:43:40 -0800 (PST)
Received: from localhost ( [85.140.168.246])
        by mx.google.com with ESMTPS id t10sm17173941muh.13.2008.02.10.04.43.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Feb 2008 04:43:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <76718490802091815s45c19113t938f5257aad3f46c@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73348>

On Sat, Feb 09, 2008 at 09:15:30PM -0500, Jay Soffian wrote:
> 
> I guess I'm confused by the criticism as I thought that's what I did.
> "open" is only added to the list of browsers to try if the
> SECURITYSESSIONID environment variable is set (indicating an OS X GUI
> login environment). I don't see how the change I made could adversely
> impact the users of other systems.

Would not be better to use uname instead like this

  if test "$(uname -s)" == "Darwin"; then
    ...
or in addition to SECURITYSESSIONID:

  if test -n "$SECURITYSESSIONID" -a "$(uname -s)" == "Darwin"; then
    ...
?

I think it would be more reliable and more importantly it makes the
code easier to understand, because it is clear now for everyone that
this is OS X specific.

BTW, should not it be mentioned in the documentation? Probably, in
the list of supported web browsers in git-help.txt.

Dmitry
