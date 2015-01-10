From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Git::SVN: handle missing ref_id case correctly
Date: Sat, 10 Jan 2015 17:18:26 -0500
Message-ID: <CALkWK0mQCe_gUZCCnoZyNPCp=cubQcPAOSqAN0pzMA5eyYUdAQ@mail.gmail.com>
References: <1420900510-78522-1-git-send-email-artagnon@gmail.com>
 <CALkWK0=jEh06hZSmHim54BaP_KiC8hg-455STQphu17PSoQTqw@mail.gmail.com>
 <20150110221308.GA32253@dcvr.yhbt.net> <CALkWK0mXx5qQSNSC4ju8Bejy_XhewxDA+nwy1JCmodX3t-H+3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:19:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4NF-0002eI-L4
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754965AbbAJWTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:19:09 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:63739 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386AbbAJWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:19:07 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so6709427igb.1
        for <git@vger.kernel.org>; Sat, 10 Jan 2015 14:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7u8FOHnN6AZtp8n5d3OAybWBT6whlPlziqEIx2lMKnw=;
        b=m+401WY3pKNUncY/KN4zUarZNgmcrLeAxZ33hirEyc5ej6UlBIHh6SqXPAY0qY9YTm
         P6QkbTjhWZ6hrZULLzb3GpL/SW7CDWBRGbI7u+vzwomc/DaZm5fYDt76qcJ6jZKXgoY1
         iG3UQEMthNTXqFki8Ja/V63y+KecFH9qBAnuF+LlYLIMVexkMXshW2zrnzb1wqKvQUP3
         0KwV5iTwhBilBTFH/t/RSyVUF0rIOpZVgcMFMyu78Ica104Lze9TXY6Cb6/R8NZdc2uT
         ZEoScDqdPHJJcAuWhS00w4e/jIMIIXxBinqruTtUT5FK5fEC4Llwj3oCrzmvqSvn2bvF
         49FA==
X-Received: by 10.50.112.8 with SMTP id im8mr8979430igb.18.1420928346163; Sat,
 10 Jan 2015 14:19:06 -0800 (PST)
Received: by 10.107.3.75 with HTTP; Sat, 10 Jan 2015 14:18:26 -0800 (PST)
In-Reply-To: <CALkWK0mXx5qQSNSC4ju8Bejy_XhewxDA+nwy1JCmodX3t-H+3A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262277>

Ramkumar Ramachandra wrote:
>> It is functional, maybe someone will use GIT_SVN_ID=0 ?
>
> Right. Kindly drop the first hunk.

Amendment: there are actually many other places where variables are
checked without "defined", so I doubt we want to put up with the extra
ugliness to allow "0".
