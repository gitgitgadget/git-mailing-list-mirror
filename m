From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] cvsimport - streamline temp index file creation and avoid creating empty tmpfiles
Date: Sat, 24 Jun 2006 23:16:04 +1200
Message-ID: <46a038f90606240416n563288f5q99a5ac81723776c3@mail.gmail.com>
References: <Pine.LNX.4.63.0606231811200.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <11511257501323-git-send-email-martin@catalyst.net.nz>
	 <Pine.LNX.4.63.0606241145280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <7vslluyika.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Martin Langhoff" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Sat Jun 24 13:16:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu67V-0001VI-Nw
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 13:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWFXLQG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 07:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWFXLQG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 07:16:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:4975 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932374AbWFXLQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 07:16:05 -0400
Received: by ug-out-1314.google.com with SMTP id a2so1407385ugf
        for <git@vger.kernel.org>; Sat, 24 Jun 2006 04:16:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fca36TUAiFUrTgQERPiqj9pAyCj9BKGq9ZLxGDnEBJU92yycKGanahW9avj7U6S1UAVfj3qxSOSGaqSnF/oGlHXq7Z15AMxxqagKhMj70OvKap45gpgY/iY4jDCz4l1pTbYwfLqpDWXIqcg402TD7vZrx1M5mllmMZ+qBfJ9XT4=
Received: by 10.78.151.3 with SMTP id y3mr1557415hud;
        Sat, 24 Jun 2006 04:16:04 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Sat, 24 Jun 2006 04:16:04 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vslluyika.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22502>

Johannes, Junio,

I've managed to repro the problem -- which was totally reproduceable,
I was just testing the wrong version of the script. The problem was
quite obvious: when running an incremental, the first head would not
get the index created properly. Even worse, when forking a new branch,
the index would be empty too.

Fixed both cases and posted separately. Thanks for the sharp eyes, and
sorry about the bug!


martin
