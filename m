From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Remove dependency on IO::String from Git.pm test
Date: Wed, 18 Jun 2008 07:46:22 -0700 (PDT)
Message-ID: <m37icmol6y.fsf@localhost.localdomain>
References: <1213796224-995-1-git-send-email-michael@ndrix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Michael Hendricks <michael@ndrix.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 16:47:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8ywT-0005EQ-RZ
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 16:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbYFROq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 10:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbYFROq0
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 10:46:26 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:23804 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbYFROq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 10:46:26 -0400
Received: by an-out-0708.google.com with SMTP id d40so67768and.103
        for <git@vger.kernel.org>; Wed, 18 Jun 2008 07:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=TLYbfz1UQdiDro9HLGDjcVPPuG/Bz16izvZGjFoScUQ=;
        b=s+oKd0B0NsDD3WmcFu/EDzwrCx260SOvMugoifvQhxfLPoVxV7DtPAghIzktbN41Z9
         EWS+lwL1qnQCmHuKbOFuetEVAocr0wgyoGSvtpyGm5fZJyyJA1P+OoluPRCI1FRX8t9v
         /9sPD+DuGeboW9FK9Y9Rq+eTTQeUSCmXAY+ps=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FFR9VowMK6xdpb0YGzEdxqo8RtFzj3J/vmhKP+6F12NElmLQeLOOiFwt+UjkSmOEfP
         XdrKyb9gH33pAgzVnzC83MFzXcqZdo2KY9JC1w+J7jhgrrjQWxZCMGfzAS4/xNYy7HQq
         CwzrJYjb5dUz699feBjYjupubIVBGGtW4stpw=
Received: by 10.100.215.5 with SMTP id n5mr1190123ang.6.1213800382882;
        Wed, 18 Jun 2008 07:46:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.188])
        by mx.google.com with ESMTPS id d24sm5989147and.24.2008.06.18.07.46.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Jun 2008 07:46:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5IEkHDn009517;
	Wed, 18 Jun 2008 16:46:17 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5IEkFTn009514;
	Wed, 18 Jun 2008 16:46:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213796224-995-1-git-send-email-michael@ndrix.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85381>

Michael Hendricks <michael@ndrix.org> writes:

> Instead of using IO::String to create an in-memory filehandle, use
> open() with a scalar reference as the filename.  This feature has been
> available since Perl 5.8.0 (which was released in 2002), so it should
> be available pretty much everywhere by now.

Besides if I understand correctly gitweb very much requires Perl >= 5.8
because of required Unicode support.

Nevertheless adding "use v5.8.0;" or "use 5.008_000;" would be I guess
good idea.


And best solution, although perhaps unnecessary, would be to check
for version >= 5.8, if older check for IO::String, and even if that
fails, simply skip those tests that require in-memory filehandle
(or use tempfile).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
