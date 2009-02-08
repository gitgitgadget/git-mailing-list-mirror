From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] use lock token in non-URI form in start_put
Date: Sun, 8 Feb 2009 09:25:31 +0800
Message-ID: <be6fef0d0902071725i799b70efs9e36b45dc9c06246@mail.gmail.com>
References: <498DE0B9.6080603@gmail.com>
	 <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 08 02:27:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVySM-0003P9-U4
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 02:27:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752150AbZBHBZe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 20:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZBHBZd
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 20:25:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:58453 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbZBHBZb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 20:25:31 -0500
Received: by wa-out-1112.google.com with SMTP id v33so663460wah.21
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 17:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MkTbq2DYkO5Ng6N5PEuwFX27BZ7ftSmjTWrXDI/TH2w=;
        b=j43kAuyy3RcQQiL9TsEmmj27t7kGw9GzuSlFszDuANbF5GV2yIhcRfjkummegFmrH3
         U6mi7xLWe7V+//QLF03EqAdzIwjuO80/r4Ket4PY6IJRaomhxgEYAdQk3l/MfQqkeDNj
         EYiAkbSWtDSjqGD9X4RCJeOXzpVIsGWZrSdmg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=x6BME92k5hIWMlVkX+tl3d3d+WM9UqICbhQEkTPwhpqTb0nW8L+trVNqzlapjDsBaf
         D7zE9hU+0q93NktCuvnLT/x0yDc9z4l4rOV5JYZg9cyPNUKGEwdTX5vtKKsNhEGsBRr8
         vW4fhk6tb+R/z2gPk1gT+H4VCymz35cZbXMHQ=
Received: by 10.115.49.11 with SMTP id b11mr2426165wak.114.1234056331097; Sat, 
	07 Feb 2009 17:25:31 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902072114360.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108909>

Hi,

On Sun, Feb 8, 2009 at 4:20 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> If it is a prefix that happens to be part of the URI, but must not be used
> by the client code as a lock token, would it not be better to store the
> token in lock->token to begin with?

The URI form of the lock token is suitable for all other occurrences
lock token usage; that is, only start_put needs the non-URI form,
while the rest use the URI form.

That's why I only changed how start_put uses the lock token; changing
lock token just for the sake of start_put doesn't seem very effective
to me.

> This is unsafe.  What if lock->token does not contain a colon?  Even if it
> happens to be the case now, in your setup, it might change, or there might
> be mistakes in the server code.  We should always play it safe if we
> cannot control the other side's code.

Point noted. I'll try to think of something else.

-- 
Cheers,
Ray Chuan
