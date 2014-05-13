From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 20:01:31 +0700
Message-ID: <CACsJy8BFEtXQc7mO1pvdeQ9GMofcW0H2uJF=E6yfN4SwQWgRbw@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
 <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:02:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkCLP-0001Xo-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 15:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759910AbaEMNCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 09:02:03 -0400
Received: from mail-qa0-f48.google.com ([209.85.216.48]:60515 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759478AbaEMNCC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 09:02:02 -0400
Received: by mail-qa0-f48.google.com with SMTP id i13so290758qae.35
        for <git@vger.kernel.org>; Tue, 13 May 2014 06:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TUqj1bjOhhXxqHHayxb5VmT6ZY8qbgkjx7aU3POr1dY=;
        b=D+PvryzrJF4RE7D4seo6x+K96/WkHaxJa+aepF+cTmLCeCH+o8W/rfpMJt/23Hs5+t
         JmDBBjlkRKWzWH1040osjfBTJGRRCZ2w4fAnLZlM6pI24Gg1osJxbLWHutD5rim3E+XR
         HOj9ThNJKDmNEhLA/rxsE3wt+HGdQmvmLxemesV81sw8B8QKtBJpZEYiJ3Z+OKhx9By/
         D6WGwoS4/3jhTYHt8Gb2A5GMiqrkm5nxy71k+MCHn3zRkyOCurJQReSJq22nVAKGqASU
         m9qDbuJ9ySiZqCNXqFbpeS/5YxkvHGdLbSGLAK65EUrpvSK2ITckGJI6Zd08dBffsnGm
         Lsag==
X-Received: by 10.229.70.196 with SMTP id e4mr22088078qcj.16.1399986121398;
 Tue, 13 May 2014 06:02:01 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 13 May 2014 06:01:31 -0700 (PDT)
In-Reply-To: <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248779>

What do you think is a good replacement for unix socket on Windows?
It's only used to refresh the cache in the daemon, no sensitive data
sent over, so security is not a problem. I'm thinking maybe just
TCP/IP server, but that's going to be a system-wide daemon.. Perhaps
the windows daemon could just monitor $GIT_DIR/index and refresh it?
-- 
Duy
