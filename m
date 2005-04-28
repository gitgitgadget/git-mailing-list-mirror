From: Kris Shannon <kris.shannon.kernel@gmail.com>
Subject: RT[2/3]: Rename/Code-movement Tracking
Date: Thu, 28 Apr 2005 23:34:15 +1000
Message-ID: <5d4799ae05042806344aa9d75f@mail.gmail.com>
References: <5d4799ae0504280559109cd00e@mail.gmail.com>
Reply-To: Kris Shannon <kris.shannon.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu Apr 28 15:29:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR94V-0003ua-G5
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbVD1NeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVD1NeT
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:34:19 -0400
Received: from zproxy.gmail.com ([64.233.162.205]:55828 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262127AbVD1NeP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:34:15 -0400
Received: by zproxy.gmail.com with SMTP id 13so468679nzp
        for <git@vger.kernel.org>; Thu, 28 Apr 2005 06:34:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IOngWKbk6td8XA1ZwczXoKAhly7rtu1hb+ZGqtpcFvu8QxaWmdp77xAFI0s1ZA2g/dw33LYzfI0Atq17CGpRkvb3QSZPavESbSB0stS7SSq6rRmLKH5WYKDyxU1Upg0XwVDiIzTuU5AWjNjxlUMmqB21tN7QNcQtKG3PV2+iYHw=
Received: by 10.36.59.18 with SMTP id h18mr96909nza;
        Thu, 28 Apr 2005 06:34:15 -0700 (PDT)
Received: by 10.36.4.16 with HTTP; Thu, 28 Apr 2005 06:34:15 -0700 (PDT)
To: GIT Mailing List <git@vger.kernel.org>
In-Reply-To: <5d4799ae0504280559109cd00e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

IMO adding a new object type tag (or tags) for tracking would fit the git model.

Call it "rename" for example (better yet think of a better name)
Let the contents be something along the lines of:

commit CHANGESET-SHA1
PARENT-TREE-SHA1 /old/path\0/new/path\0
PARENT-TREE-SHA1 /old/path/2\0/new/path/2\0
...

The exact details will depend on the renaming model and I don't care to
much at the moment what that turns out to be.

This new tag allows the rename data to be added on to commit's from people
like linus who don't care about rename.

It doesn't reduce security because any can happen to the rename object
and that will cover the whole commit (and those who sign the commit are
obviously not validating any rename information)

The rename objects can be used to assist in automatic merging but from my
experience I would agree with linus that if the right way to merge is not
really obvious then you probably need user input anyway.

-- 
Kris Shannon <kris.shannon.kernel@gmail.com>
