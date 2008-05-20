From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Tue, 20 May 2008 22:22:35 +0200
Message-ID: <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org>
	 <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org>
	 <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com>
	 <20080520201722.GF29038@spearce.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Dirk_S=FCsserott?=" <newsletter@dirk.my1.cc>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 20 22:23:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyYNA-0002bl-RX
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 22:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757809AbYETUWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 16:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755848AbYETUWi
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 16:22:38 -0400
Received: from rn-out-0910.google.com ([64.233.170.189]:56652 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbYETUWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 16:22:37 -0400
Received: by rn-out-0910.google.com with SMTP id k40so178252rnd.17
        for <git@vger.kernel.org>; Tue, 20 May 2008 13:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=qHxl43PbRWYj6u1JnoFlayKJQqMmOTiUWloQQO73u1g=;
        b=Rh644HtfTFY82BYQ6ccVDJ39YHJnOLZQsYpy3DBDwmPEklnQ4JSnRQ5oWthWwYbbmoHdQ7b6e5NXQXGYnKv7bt2Eya+QA10q7G9B39nNbf/EKnc7y1NPe0h94Xt6x0R1SoD9IE8pehdk6F8oKrH72aZ3/YjHqNMZ9xNDqjR28zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fQaPcaoW0fLpbGUjvCecwwmB6BqICA0M/cmkky8fZ1ylZvGgIQbp5nI+umWAw70Aa7WeSZoKKDKgp2r3smELsHqLY2wI2BGEYhLIgxJ+PhM7p5/MQRHSGZOsnKC4CSrsKamHSY7L/LXhSuuCHezFRhJw/O9ranW7KQngGrGn7IQ=
Received: by 10.142.214.5 with SMTP id m5mr3501785wfg.342.1211314956007;
        Tue, 20 May 2008 13:22:36 -0700 (PDT)
Received: by 10.143.33.6 with HTTP; Tue, 20 May 2008 13:22:35 -0700 (PDT)
In-Reply-To: <20080520201722.GF29038@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82498>

On Tue, May 20, 2008 at 10:17 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Yup.  Or even worse, a user thinking that the best way to create a
> new commit on the command line is the ugly sequence of:
>
>        git-write-tree
>        git-commit-tree ... -p ... <msg
>        git-update-ref HEAD ...
>

That would be awesome, no wait.. it wouldn't :P.

>> Even better of course would be to not only print the plumbing commands
>> but also the porcelain commands!
>
> That is probably difficult.  Some of the code internally is more
> about stringing the right sequence of plumbing together than it
> is about a particular user action.  I think it would take a bit of
> work to make it do this, and I just don't see a reason to do it.

The reason would be to make the switch from using git-gui only to
using the commandline too... the again, it'd be cutting your own hand
(or is it "throat" in English...) to make that transition easier.

> CVS clients that show CVS commands can easily do so, because they
> are directly executing the commands they show you.  This is likely
> also true of SVN commands.  But git-gui on Git, that's a whole
> different animal.

Ah, I didn't realise git-gui does stuff that you can't really do
through the regular porcelain. In that case it would indeed be
impossible to print the regular porcelain commands. I think the
'--trace' option should be advertised as 'debugging option' so that
the user can see what is going on in the case something goes wrong
perhaps?

-- 
Cheers,

Sverre Rabbelier
