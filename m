From: Thiago Farina <tfransosi@gmail.com>
Subject: SSL_CTX leak?
Date: Thu, 27 Mar 2014 10:37:07 -0300
Message-ID: <CACnwZYdYYO2VXRnfyVD_uEeguYcBv-eFoYfawoCESDbcBVMhgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 27 14:37:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTAUd-0003C6-K3
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 14:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756775AbaC0NhI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 09:37:08 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60008 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438AbaC0NhH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 09:37:07 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so3743992qaj.7
        for <git@vger.kernel.org>; Thu, 27 Mar 2014 06:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=K0iEWCJ3uBaB+WR6ZVazRuDwZfLwDFJm4wW1bCSy+Jg=;
        b=qJHj9n0B3bcZITpRHIRdncbRu5YPTkifrju9MTNgXwqEVorjFCHrEV4ivCVVjwd7x0
         SFhubIDwZHoykLPerv7vMkMq5pjNoaLQ8qdWfw5yeqTqGQAUhRwBIa+CiFNReMU5JdFE
         D8q7UTK+pZe5EqdEBJgjulR3biLR9qehiYo7gSkWAFe6XwUruUUD9Z491Xihh9II9uG/
         YSmjEXYEa5hD+AV3kd7KisWHVPFWOfSEY1JJBclCvo6Sc2Ur3v8wNPgoCGMe4JNLY67y
         alPMOihMy7U5Y1nCFPYSs2qAci5itFduvL1FDlgodb/8FGrGor+uhuiL6aRtp5Wv6ybw
         HvRQ==
X-Received: by 10.224.123.7 with SMTP id n7mr2188901qar.18.1395927427154; Thu,
 27 Mar 2014 06:37:07 -0700 (PDT)
Received: by 10.224.195.138 with HTTP; Thu, 27 Mar 2014 06:37:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245276>

Hi,

Do we leak the context we allocate in imap-send.c:280 intentionally?

Regards,

--
Thiago Farina
