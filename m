From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Re: File archiver using git
Date: Sun, 27 Aug 2006 20:40:20 -0400
Message-ID: <3bbc18d20608271740m63be7ae9qc49ec944f5131030@mail.gmail.com>
References: <3bbc18d20608270610o102968d2kd340d40843262dc5@mail.gmail.com>
	 <Pine.LNX.4.63.0608271528130.8018@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 02:40:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHVAz-0002ZQ-Hk
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 02:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWH1AkW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 20:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWH1AkW
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 20:40:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:24948 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751288AbWH1AkW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 20:40:22 -0400
Received: by ug-out-1314.google.com with SMTP id m3so1440602ugc
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 17:40:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VRNH8w/JAsK6t0ETjdgDjFjZGBCWWXohRAVikEBr1dmir36tBuXfD2QQ/SAoLQTb4Wy8cv+kPFOF1aesLfTyH4Jmtq7Hhsik7hU4GSP7gEXE++zeYMztl3T+d6NegJ8Y8T+guy5phKIrufa8GW/V3Ymzpof0RWKW3jYi36373t8=
Received: by 10.66.224.19 with SMTP id w19mr3404507ugg;
        Sun, 27 Aug 2006 17:40:20 -0700 (PDT)
Received: by 10.67.26.9 with HTTP; Sun, 27 Aug 2006 17:40:20 -0700 (PDT)
To: "Grzegorz Kulewski" <kangur@polcom.net>
In-Reply-To: <Pine.LNX.4.63.0608271528130.8018@alpha.polcom.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26133>

On 8/27/06, Grzegorz Kulewski <kangur@polcom.net> wrote:
> Does it (and GIT in general) work ok with file permisions, ownership, soft
> and hard links, named sockets, device files and similar "strange"
> filesystem objects? Do I need any options to GIT to make it work with
> them?

Git tracks data, not filesystems.  That means it doesn't handle any of
the things you mentioned except soft links.  It doesn't even handle
empty directories, though I don't accept the argument that they do not
constitute data.  If you want to capture a filesystem, I would
recommend running "find . -ls" to create a listing file from which
everything you mentioned can be reconstructed and then putting the
filesystem together with the listing file into git.

> Can I for example securely backup or even version-control /etc directory?

With the above technique, you can do both.  However, if you just want
to back up /etc, you might be better served by a backup tool.  For
example, I use rsnapshot ( http://www.rsnapshot.org/ ).

Matt
