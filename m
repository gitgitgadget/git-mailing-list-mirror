From: "Dmitry Potapov" <dpotapov@gmail.com>
Subject: Re: Getting correct tree layout when importing svn repo into git
Date: Wed, 17 Sep 2008 03:20:26 +0400
Message-ID: <37fcd2780809161620v38d9ade0sc1a2715f79501c6f@mail.gmail.com>
References: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, michael.kerrisk@gmail.com
To: mtk.manpages@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 17 01:21:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfjrU-0006eC-Uw
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 01:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbYIPXU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 19:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbYIPXU2
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 19:20:28 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:39074 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbYIPXU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 19:20:28 -0400
Received: by py-out-1112.google.com with SMTP id p76so2171161pyb.10
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 16:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=B7O2J1/KZ2t1bUMnTTFVPFca3yITJMI5dZn2kRdc3HA=;
        b=NEvO1aVqIjE3V2AF+tA+qmMJJrClpk3BWGhI94C8b0mvwpfcqpVMXUTdRn1DVtALlo
         Wged6tjj2lMLY2QMZTn4SXcE8JXll0xfvxW0YasSlgXzf9nwq7hM0NOlh3ZqqSV3pYxi
         z7o8Qkd2kEfc/VvKCrPOIaPEDzEgwd7yM76Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=DwKK3jT1xLnUbAnvf2Q9hMXWVia5kAWE9uuOpw4VzHb7bn5UBgnlRDPYnKKVbr0yi6
         M8OGq8/dRzPIAt+b7/6wHzc8SGVU2DMlmtiG2GY2Vz9EK0xtzDeIAUKxUkU9lmnuBr40
         +iyNPnFMTuiU+dhTbN+C7Ji9D9gJoAtGW1lM4=
Received: by 10.142.194.1 with SMTP id r1mr168782wff.192.1221607226825;
        Tue, 16 Sep 2008 16:20:26 -0700 (PDT)
Received: by 10.142.106.16 with HTTP; Tue, 16 Sep 2008 16:20:26 -0700 (PDT)
In-Reply-To: <cfd18e0f0809161505g4c04bd88vaf4fd7c40f67b243@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96043>

On Wed, Sep 17, 2008 at 2:05 AM, Michael Kerrisk
<mtk.manpages@googlemail.com> wrote:
>
> I'm currently trying to import an svn repository, along with its tags,
> into git, and everything seems okay except that after the import I
> expect to have the following structure to my checked out repository:
>
>    [root-dir]
>        .git
>        <checked-out-files>
>
> But instead I end up with
>
>    [root-dir]
>        .git
>        man-pages               <-- name of my svn project
>            <checked-out-files>
>
> I've tried out a few different command-line flag settings but so far I
> haven't managed to get the desired layout.  I guess that I'm missing
> something trivial, but I haven't worked out what it is so far.
>
> The commands I'm using to do the import are:
>
> $ git svn init file:///home/mtk/man-pages-rep/ -t tags -T trunk -b branches

Probably, you want to run:

$ git svn init file:///home/mtk/man-pages-rep/ -t tags -T
trunk/man-pages -b branches

Dmitry
