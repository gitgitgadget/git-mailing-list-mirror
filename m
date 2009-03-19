From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: Re: fatal: bad object HEAD
Date: Thu, 19 Mar 2009 18:24:51 +0100
Message-ID: <286817520903191024u7adecbebk30f6f064f38e615b@mail.gmail.com>
References: <286817520903190955n2e27abb6ydd52d9ddcffccbc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 18:27:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkM0e-0002cR-PZ
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 18:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752985AbZCSRYz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 13:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbZCSRYz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 13:24:55 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:60601 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbZCSRYy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 13:24:54 -0400
Received: by bwz17 with SMTP id 17so591497bwz.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 10:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=7B+D+lvTfuSfADlUGeBlhsJhXM1EM3PFHovHmV38PHw=;
        b=WkZwW9ETdOKPoSVVeHHlPuLFTo3He2TQZdUVCsA1zJp/AtPqpUcj8vY22RZbJ21yY6
         S903blCZoJpzrU5OKuj8DJvapMU+2jkzVhd2b5NBBLr5NlXwS6ZeNSvb603gYwqpU3NM
         8viQwFkxfe9nIOq+2o8ulnYylE2rXApGSoSvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=qzLck56NhpG6nJM15xxzjIX5ZpS60kYDC6p3v8o6GbyaMACzJWER0WIDYZqcywDuOQ
         tK2Njjr+Tj2VWLavRcj0f+XYYiSvo+K7+6e1nylE8sW8sPUBVnDcawWzBZTydad0K7rW
         DEgMm66r2flmJYScMfWvHzxXKoFQcs1G/I29I=
Received: by 10.204.60.194 with SMTP id q2mr899205bkh.150.1237483491112; Thu, 
	19 Mar 2009 10:24:51 -0700 (PDT)
In-Reply-To: <286817520903190955n2e27abb6ydd52d9ddcffccbc7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113795>

I tried

$ git fsck --verbose
Checking tree fe217057862c74e6c1a0cf12e39b941f967927b2
Checking blob fe56c41c028f320bb474ca9e0fe15baa2b0aa122
Checking blob fe7c85910717d546ee002bb64a9d1476a9451eed
error: refs/heads/branch_1 does not point to a valid object!
error: refs/heads/branch_2 does not point to a valid object!
error: refs/heads/branch_3 does not point to a valid object!
error: refs/heads/branch_4 does not point to a valid object!
error: refs/heads/master does not point to a valid object!
Checking reflog
3d7d1cf8f8edae21d90be9d84c21b5ac65ee94dc->9e53015709777b533717b25687295=
407f38f840e
Checking reflog
9e53015709777b533717b25687295407f38f840e->695e934882e78fb85b78649dea510=
9aa69855a88
=2E..

and deeper in the output there are 4 suspicious entries:
Checking reflog
0000000000000000000000000000000000000000->696bd2fc4a8554891976af42e65cc=
af9d12009ac
Checking reflog
0000000000000000000000000000000000000000->aff44ac2a61607dd95caadd896e2c=
ae51e4dfdcf
Checking reflog
0000000000000000000000000000000000000000->6f20af9bcc1f446116cc1af238cb8=
49ca1ccd385
Checking reflog
0000000000000000000000000000000000000000->696bd2fc4a8554891976af42e65cc=
af9d12009ac

I think here might the problem. Can anyone explain me what it means? th=
x a lot

Bost


On Thu, Mar 19, 2009 at 17:55, Rostislav Svoboda
<rostislav.svoboda@gmail.com> wrote:
> Hi people, I have a BIG trouble:
>
> $ git fsck
> error: refs/heads/branch_1 does not point to a valid object!
> error: refs/heads/branch_2 does not point to a valid object!
> error: refs/heads/branch_3 does not point to a valid object!
> error: refs/heads/master does not point to a valid object!
> (and quite many missing and dangling blobs)
>
> I use msysGit 1.6.1-preview20081227 and I did:
> $ git checkout master
> $ git gui
>
> here I got again and again that stupid error message
> 'file fname.ext has been modified but no changes detected' so I did
> $ git add fname.ext
> $ git branch branch_1 =A0 =A0(here I did a mistake. I wanted to do 'g=
it
> checkout branch_1' )
>
> And now is _everything_ seems to be lost... uaaaa :( What can I do no=
w?
> Any would be REALLY appreciated
>
> Bost
>
