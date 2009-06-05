From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 03/23] http*: cleanup slot->local after fclose
Date: Fri, 05 Jun 2009 13:43:53 -0700 (PDT)
Message-ID: <m3vdna5s3d.fsf@localhost.localdomain>
References: <20090606000133.33101b1e.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCgGg-0006rt-On
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 22:44:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbZFEUny (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 16:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbZFEUnx
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 16:43:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:15604 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZFEUnw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 16:43:52 -0400
Received: by fg-out-1718.google.com with SMTP id d23so329897fga.17
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zG8PWnCGINY1SsMBadaU7/JvuAJwScW3Xp3qxQgTJNY=;
        b=VMwiBBl1znW9b93hKaIhX/AtZWufMIx0wUFecWAAdyqjWqIUYvrtjPCmY+nqGu9FxK
         MO5lgOQMMCkZPOzDWbX1J6M1updEXvGoSrj+q3Rva0RZrulMMlkzM3zhceJ4xAPgTh4H
         Rv+Tn+jpV519vNR+I814p3faeWnctliwGoo6g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=Sp0Z5WswebfiqChHcHTTU6OXhp/yLFf+Ua7ljrSsle7qqBCtepjlXvPZjHn/bg0h1F
         CjVu4sN6oX2c1DcqfjGCYvW6QH8Wsf0PepuTEhwtCziNzwnwvGY3mNEgMRQDmgFqG8XB
         KDFstMxzOUju1iOAL7qTMI+ssWSGmD6kA/c0k=
Received: by 10.86.65.18 with SMTP id n18mr4340651fga.25.1244234633896;
        Fri, 05 Jun 2009 13:43:53 -0700 (PDT)
Received: from localhost.localdomain (abwo21.neoplus.adsl.tpnet.pl [83.8.238.21])
        by mx.google.com with ESMTPS id 12sm866127fgg.10.2009.06.05.13.43.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 13:43:53 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n55Khp0T024575;
	Fri, 5 Jun 2009 22:43:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n55Kho7i024572;
	Fri, 5 Jun 2009 22:43:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090606000133.33101b1e.rctay89@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120830>

Tay Ray Chuan <rctay89@gmail.com> writes:

> Set slot->local to NULL after doing a fclose on the FILE* pointer it
> points to. This prevents an invalid FILE* pointer from being passed to
> ftell() in http.c::run_active_slot().

You mean here passing FILE* pointer to a fclosed file to ftell()?

> 
> This issue was raised by Clemens Buchacher on 30th May:

Just in case: 30th May 2009?

> 
>   http://www.spinics.net/lists/git/msg104623.html
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

-- 
Jakub Narebski
Poland
ShadeHawk on #git
