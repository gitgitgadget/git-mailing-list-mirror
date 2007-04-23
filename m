From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: Re: adding file by absolute name -- problem
Date: Mon, 23 Apr 2007 13:30:28 +0300
Message-ID: <f36b08ee0704230330if89d417udefb8e50062d5a05@mail.gmail.com>
References: <f36b08ee0704230239i4892983q4feb4a1872a320ea@mail.gmail.com>
	 <Pine.LNX.4.64.0704231215370.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Mon Apr 23 12:30:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfvoW-0007XJ-JJ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 12:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbXDWKa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 06:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753967AbXDWKa3
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 06:30:29 -0400
Received: from wx-out-0506.google.com ([66.249.82.237]:13129 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbXDWKa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 06:30:29 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1732864wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 03:30:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U2TXT/aJehVJj+cXAzmZvqHX4Gs0UOstc7roOc3oYLfnqtNHelzJoVnBYqq6kbg2J3NYYjue7C+mCP/vNh6ELE0KjTr0LaaOLfTpGBDe2F5rjeTBDYeSh9UG10z4mfwPwx8VpaMysNX39may1aSx7B+lig4DQeguPVCeHit3b4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pDiCsqsM+QGezmLfwUAnG5ZmRWmXgKCXccU26LBRxk3euNjeLcUWphYc9IL4zdNBRm8iCdl2HoA3/TMIdYtJKJc3cVckKBwaQsqf9hlNPbJGEA0GhSe/ydLuioMYfm4G3OUQ/6YAZdOMUWBfCfIaBVUilQwgXIceXyjdoqKA9mA=
Received: by 10.90.89.5 with SMTP id m5mr741131agb.1177324228281;
        Mon, 23 Apr 2007 03:30:28 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 03:30:28 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0704231215370.8822@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45312>

On 4/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 23 Apr 2007, Yakov Lerner wrote:
>
> > When I give absolute pathname /a/b/repo/d to git add, it
> > mostly does not work. I get errors from git-add. Is it by design ?
>
> AFAICT it is by design. I fail to see why absolute paths should be
> supported, too. You are supposed to be _in_ the working directory when
> adding files...

Let's say I have $SRC that points to the dir of sources. Let's say
I am testing the software, somewhere under /tmp. I edit sources as
'vi $SRC/something' and I am not in $SRC. I could do 'make -C $SRC' and
I can do everything (incl checkins) without switching cwd back and
forth all the time.

CVS did not accept absolute pathnames, and SVN does. It is really convenient.
I felt perceptible added comfort when I switched from CVS to cvs in this aspect.
CVS's way of not accepting abs paths was not convenient.

But talking about implementation. How would I, generically,  go about
finding the base .git when absolute path is given ? Is dropping basenmes
one-by-one and checking for .git a good method ? Or just demand that GITDIR
be set when absolute name is given ?

Yakov
