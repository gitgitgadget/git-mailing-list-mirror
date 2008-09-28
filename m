From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: Re: strange "git clone" behavior wrt an active branch
Date: Sun, 28 Sep 2008 09:23:47 -0400
Message-ID: <ee2a733e0809280623i30a9e298i30db2a84b8530d61@mail.gmail.com>
References: <ee2a733e0809280505n69f62e0fy89667c175bcc16c@mail.gmail.com>
	 <adf1fd3d0809280537k7adffe3dte9579fe70c7f990e@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Sep 28 15:25:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjwGh-0003dD-Fw
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 15:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbYI1NXu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Sep 2008 09:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbYI1NXu
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 09:23:50 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:52515 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbYI1NXt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Sep 2008 09:23:49 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1130345fgg.17
        for <git@vger.kernel.org>; Sun, 28 Sep 2008 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=4ZPFs8vB2Xc8F9yH0sOKz3Yqt7eBF30mBt3xgj5pBA0=;
        b=EpAGVx1P5XdsUiEhryX1ONuDY6lBGrITpUjTmqlzI6HeetD4Jh67oYgJ68RbrB897+
         RK8KjkbRM9OUXXroOXF5s68lB6c56hdD5czPc+P0jzcSAXvGFUSEuF5rxly6JG6LUbRo
         Ev5EDLv1Sana198WbRx9Q0E+LLGy8pR3ntUDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=lOu8VUatJCeGiYshRavpoDbQCAWAQT4dZ4Evcrs2NXBPf3XZ/EnWsYsPsn2IS5Iutc
         NpBGDBVljC4MHaKA9itNx9blyYfnOrhy2PdVKBqwPqIeGwepx6feWxNG57cDk7qNncTy
         CppEu4cDg46aIF00upjZqqGKP3OzkBOc6PzeA=
Received: by 10.187.188.15 with SMTP id q15mr418843fap.83.1222608227671;
        Sun, 28 Sep 2008 06:23:47 -0700 (PDT)
Received: by 10.187.193.16 with HTTP; Sun, 28 Sep 2008 06:23:47 -0700 (PDT)
In-Reply-To: <adf1fd3d0809280537k7adffe3dte9579fe70c7f990e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96965>

On 9/28/08, Santi B=E9jar <santi@agolina.net> wrote:
> On Sun, Sep 28, 2008 at 2:05 PM, Leo Razoumov <slonik.az@gmail.com> w=
rote:
>  > Hi All,
>  > I am using the latest stable version git-1.6.0.2.
>  >
>  > The man page for git-clone states explicitly that "git clone"
>  >
>  > " Clones a repository into a newly created directory, ...[snip]...
>  >  and creates and checks out an initial branch equal to the
>  >  cloned repository's currently active branch. "
>  >
>  > I noticed that while my active branch "My" happens to point to the
>  > same commit as the "master" the git clone will check out master
>  > instead of My (currently active branch). Is it a bug?
>  >
>
>
> Currently it is only guessed which is the active branch (with a
>  preference for the master branch as it is the default), as the curre=
nt
>  protocol does not allow tranfering the ref links:

This is quite unfortunate design decision. There can be any number of
local branches referring to the same commit. Without being able to
pick into .git/HEAD it is impossible to decide which of them is
"active".

--Leo--
