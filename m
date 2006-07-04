From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: qgit idea: interface for cherry-picking
Date: Tue, 4 Jul 2006 08:22:33 +0200
Message-ID: <e5bfff550607032322jdf3bc79l3f41c292ebb6d3f7@mail.gmail.com>
References: <e8954u$srh$1@sea.gmane.org>
	 <e5bfff550607021433l1987c32apf4453b52fc2f3e63@mail.gmail.com>
	 <e89eqj$npu$1@sea.gmane.org>
	 <e5bfff550607021504l6e7fc8b8ja61f20f630c0f3f@mail.gmail.com>
	 <e89iql$42a$1@sea.gmane.org>
	 <e5bfff550607022245s2ef160fu5ad30a822f06117d@mail.gmail.com>
	 <7vzmfrrxyp.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550607030418n6a46c0cdh1a95155e1feb4356@mail.gmail.com>
	 <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 04 08:22:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxeIv-0001d3-Ns
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 08:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWGDGWf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 02:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWGDGWf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 02:22:35 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:9234 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751279AbWGDGWe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jul 2006 02:22:34 -0400
Received: by py-out-1112.google.com with SMTP id n25so1574611pyg
        for <git@vger.kernel.org>; Mon, 03 Jul 2006 23:22:33 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FynPDiYnA3/lcNceGqEovU3Vecveg2xSOOsJZGp11D6+whQhp7CJWqgh6ER8RUAXb/QhODQnmoC5x546AX81NW04wItIPNAF35IB5ypNvZ29G8Y1bFfIwfC3RR/kTf6fx+ZCL7hAiWhD3nCjqXZCIYwBfR4aNWlX/mp+/fVEgUY=
Received: by 10.35.57.5 with SMTP id j5mr3704106pyk;
        Mon, 03 Jul 2006 23:22:33 -0700 (PDT)
Received: by 10.35.52.17 with HTTP; Mon, 3 Jul 2006 23:22:33 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vd5cmqwv3.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23256>

On 7/3/06, Junio C Hamano <junkio@cox.net> wrote:
>
> If you had a series of patches chosen inside your GUI and
> squash-apply them all, two full am with soft reset to the
> original state would be the easiest, if and only if both patch
> applications do not fail.  If patch A does not apply for
> whatever reason, you have to guide your user through the patch
> adjustment process before applying B, regardless of the reason
> why the patch application failed (either A did not apply
> cleanly, or you gave --fail to the command).
>
> The main question is what you would let your users do and how
> you would guide them through the process, when the application
> of an earlier patch in the series fails.  I think it is a
> secondary implementation detail which of "git-am", "git-am
> --fail" or "git-apply" to implement that process.
>

QGit is not supposed to be a GUI replacement of git UI. QGit only let
users quickly call some commonly used commands. The process of error
recovering, conflicts resolve and any other complication that could
involve more the one main flow of processing are outside the scope.
QGit simply leaves the job to native git tools any time there
something 'outside tha main flow'.

So in case a patch does not apply a message feedback is returned and
the process is terminated. All the not qgit generated intermediate
files are left at their places and is up to the user fix the things
up, possibly using native git commands.

QGit does not play magic. If something goes wrong it simply stops.

     Marco
