From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 15:35:35 +0200
Message-ID: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 21 15:36:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfFkw-000253-7c
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 15:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031065AbXDUNfj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 09:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031058AbXDUNfi
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 09:35:38 -0400
Received: from an-out-0708.google.com ([209.85.132.247]:61922 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030866AbXDUNfh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 09:35:37 -0400
Received: by an-out-0708.google.com with SMTP id b33so1269100ana
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 06:35:35 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ggKgheSMyVR6pL7TsWI8AJaqRCi8eujG/y6NimeUdytBbWh8Ir2kfg3reS4pYpYjzMtv9MUNo2mD+Le91cAH4YysEtEnOuKQOvC2Y1U8e0pOki/SDsb6BIowZKLofwCm7urWYp7emS8fLZwDy1BfKL9DgkyWwingacIN9+BTmXE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=uu/m5DSNlnnnvLx5WYq3TjUo5TXVRmQ2xQw4pzh21VNTvdHsnnQLcK3qiugqazcLbEBK0EtttBQ9iMscIjdtotQzBAHU5UjGYZgDSZnHs+N662uIJiACqZN+8N8ZM6B4PsEJEzZMccJPVftJOO+ELY5kw8lOlYYCsuxpe5eCMpo=
Received: by 10.114.154.1 with SMTP id b1mr137677wae.1177162535415;
        Sat, 21 Apr 2007 06:35:35 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Sat, 21 Apr 2007 06:35:35 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45173>

Well, why to store always the full length SHA?

I know that looking at the code it is better then asking, but indeed
asking is better then guessing and in my case looking at the scary sha
low level code is almost like (bad) guessing.

We use 40 bytes to disambiguate two unlucky revisions or it is due to
UI concerns?

In case it is the former does this apply?

40bytes-sha1 + 40bytes-sha2 == 7**bytes-sha1 + 7bytes-sha2 + "a way to
disambiguate the two"*

(*)  as example calculating on the fly the full length sha in the
unlikely event it is needed,  or storing complete 40bytes sha when
needed.

(**) 7 is my lucky number ;-)

If in the packed tree truncated sha are stored, togheter of course
with corresponding revision data, does it is enough to keep the *same*
information of a complete pack?

For performance reasons, probably the inflating should be done only
when necessary, it means all git code should use shrinked sha-s,
leaving inflating as a remote and unlikely event. What are the real
walls about using small length sha everywhere in git code?

Ok. It's enough for collecting a long list of very bad answers. I
think I've done my day now!

Thanks for your *kind* reply
Marco
