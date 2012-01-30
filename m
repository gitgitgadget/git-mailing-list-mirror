From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] completion: remove old code
Date: Mon, 30 Jan 2012 05:24:23 +0200
Message-ID: <CAMP44s1H6Db6Xq_iZseXppaTwpBCeu14ySgPfmoQnpELfywQ-Q@mail.gmail.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-3-git-send-email-felipe.contreras@gmail.com>
	<20120130023642.GA14986@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 04:24:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrhr3-0006IA-52
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 04:24:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181Ab2A3DY1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Jan 2012 22:24:27 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:48228 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753062Ab2A3DYZ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 22:24:25 -0500
Received: by lagu2 with SMTP id u2so1951708lag.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 19:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JdEOzPAxDT58pJPH6W/DU0QEbGTWk8Uh472gLr7EL4U=;
        b=dbsJTf8/3hlSa1fFwrOyq+wAtNEDBOELdKbhxOuJP2RBdLHdR/AaTyczqXeNpTY8DU
         M5M7rWtnNTV0tXq1/R6RaTgOV7CvGq9hJzPvOtE9i9vvuo0hHRbOviXsBnoyrsW8BPkI
         HQRlkqjEm/0HMCw59L7+8/Ym2ybnodSKIoJLM=
Received: by 10.152.106.227 with SMTP id gx3mr8092881lab.45.1327893863532;
 Sun, 29 Jan 2012 19:24:23 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Sun, 29 Jan 2012 19:24:23 -0800 (PST)
In-Reply-To: <20120130023642.GA14986@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189316>

On Mon, Jan 30, 2012 at 4:36 AM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>
>> We don't need to check for GIT_DIR/remotes, right? This was removed =
long
>> time ago.
>
> I don't follow. =C2=A0fetch, push, and remote still look in .git/remo=
tes
> like they always did, last time I checked.
>
> Perhaps you mean that /usr/share/git-core/templates/ no longer
> contains a remotes/ directory? =C2=A0That's true but not particularly
> relevant. =C2=A0A more relevant detail would be that very few people =
_use_
> the .git/remotes feature, though it is not obvious to me whether that
> justifies removing this code from the git-completion script that
> already works.

The problem is all the 'nullglob' stuff. It's *a lot* of code for this
feature that nobody uses.

OK, maybe some people use it, but most likely they are using an old
version of git, and thus an old version of the completion script.

Anyway, aren't there easier ways to get this? Perhaps first checking
if the directory exists, to avoid wasting cycles.

Something like:
  test -d "$d/remotes" && ls -1 "$d/remotes"

--=20
=46elipe Contreras
